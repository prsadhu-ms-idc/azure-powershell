
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
The Initialize-AzMigrateReplicationInfrastructure deploys and configures the replication infrastructure used for server migration in the Azure Migrate project Resource Group.
#>

param(
    [Parameter(Mandatory)]
    [System.String]
    # Specifies the Resource Group of the Azure Migrate Project in the current subscription.
    ${ResourceGroupName},

    [Parameter(Mandatory)]
    [System.String]
    # Specifies the name of the Azure Migrate project to be used for server migration.
    ${ProjectName},

    [Parameter(Mandatory)]
    [System.Management.Automation.SwitchParameter]
    # Specifies the server migration scenario for which the replication infrastructure needs to be initialized.
    ${Vmwareagentless},

    [Parameter(Mandatory)]
    [System.String]
    # Specifies the target Azure region for server migrations.
    ${TargetRegion},

    [Parameter()]
    [System.String]
    # Azure Subscription ID.
    ${SubscriptionId}
)

process {
    
        Set-PSDebug -Step; foreach ($i in 1..3) {$i}
        if(($SubscriptionId -eq $null) -or ($SubscriptionId -eq "")){
            Write-Host "Retrieving Subscription Id from Az Context"
            $context = Get-AzContext
            $SubscriptionId = $context.Subscription.Id
            Write-Host "Using Subscription Id: ", $SubscriptionId
            if(($SubscriptionId -eq $null) -or ($SubscriptionId -eq "")){
                throw "Please login to Azure to select a subscription."
            }
        }
     
        $availableRegions = Get-AzLocation
        $targetRegionObject = $null
        foreach($location in $availableRegions){
            if ($location.Location -eq $TargetRegion){
                $targetRegionObject = $location
                break
            }
        }
        if ($targetRegionObject -eq $null){
            throw "Please input a valid target region" 
        }

        Write-Host "Selected Target Region: ", $targetRegionObject

        $Source = @"
using System;
public class HashFunctions
{
public static int hashForArtifact(String artifact)
{
    int hash = 0;
    int al = artifact.Length;
    int tl = 0;
    char[] ac = artifact.ToCharArray();
    while (tl < al)
    {
        hash = ((hash << 5) - hash) + ac[tl++] | 0;
    }
    return Math.Abs(hash);
}
}
"@
        Add-Type -TypeDefinition $Source -Language CSharp 

        $solution = Get-AzMigrateSolution -MigrateProjectName $ProjectName -ResourceGroupName $ResourceGroupName -Name "Servers-Migration-ServerMigration"
        $VaultName = $solution.DetailExtendedDetail.AdditionalProperties.vaultId.Split("/")[8]
        $applianceObj =  ConvertFrom-Json $solution.DetailExtendedDetail.AdditionalProperties.applianceNameToSiteIdMapV2
        
        $LogStringCreated = "Created : "
        $LogStringSkipping = " already exists."
        foreach($eachApp in $applianceObj){
            $SiteName = $eachApp.SiteId.Split("/")[8]
            $applianceName = $eachApp.ApplianceName
            $HashCodeInput = $SiteName + $TargetRegion
            $hash = [HashFunctions]::hashForArtifact($HashCodeInput) 

            Write-Host "Initiating Artifact Creation for Appliance: ", $applianceName

            # Phase 1

            $MigratePrefix = "migrate"            
            $LogStorageAcName = $MigratePrefix + "lsa" + $hash
            $GateWayStorageAcName = $MigratePrefix + "gwsa" + $hash
            $StorageType = "Microsoft.Storage/storageAccounts"
            $StorageApiVersion = "2017-10-01" 
            $LogStorageProperties =  @{
                encryption=@{
                    services=@{
                        blob=@{enabled=$true};
                        file=@{enabled=$true};
                        table=@{enabled=$true};
                        queue=@{enabled=$true}
                        };
                    keySource="Microsoft.Storage"
                };
                supportsHttpsTrafficOnly=$true
                }
            $ResourceTag =  @{"Migrate Project"=$ProjectName}
            $StorageSku = @{name="Standard_LRS"}
            $ResourceKind = "Storage"
            
            $lsaStorageAccount = Get-AzResource -ResourceGroupName $ResourceGroupName -Name $LogStorageAcName
            if(!$LogStorageAcName){
                New-AzResource -ResourceGroupName $ResourceGroupName -Location $TargetRegion -Properties  $LogStorageProperties -ResourceName $LogStorageAcName -ResourceType  $StorageType -ApiVersion $StorageApiVersion -Kind  $ResourceKind -Sku  $StorageSku -Tag $ResourceTag
                Write-Host $LogStringCreated, $LogStorageAcName
            }else{
                Write-Host $LogStorageAcName, $LogStringSkipping
            }

            $gwyStorageAccount = Get-AzResource -ResourceGroupName $ResourceGroupName -Name $GateWayStorageAcName
            if(!$gwyStorageAccount){
                New-AzResource -ResourceGroupName $ResourceGroupName -Location $TargetRegion -Properties  $LogStorageProperties -ResourceName $GateWayStorageAcName -ResourceType  $StorageType -ApiVersion $StorageApiVersion -Kind  $ResourceKind -Sku  $StorageSku -Tag $ResourceTag
                Write-Host $LogStringCreated, $GateWayStorageAcName
            }else{
                Write-Host $GateWayStorageAcName, $LogStringSkipping
            }

            $ServiceBusNamespace = $MigratePrefix + "sbns" + $hash
            $ServiceBusType = "Microsoft.ServiceBus/namespaces"
            $ServiceBusApiVersion = "2017-04-01"
            $ServiceBusSku = @{
                    name = "Standard";
                    tier = "Standard"
            }
            $ServiceBusProperties = @{}
            $ServieBusKind = "ServiceBusNameSpace"
    
            $serviceBusAccount = Get-AzResource -ResourceGroupName $ResourceGroupName -Name $ServiceBusNamespace
            if(!$ServiceBusNamespace){
                New-AzResource -ResourceGroupName $ResourceGroupName -Location $TargetRegion -Properties  $ServiceBusProperties -ResourceName $ServiceBusNamespace -ResourceType  $ServiceBusType -ApiVersion $ServiceBusApiVersion -Kind  $ServieBusKind -Sku  $ServiceBusSku -Tag $ResourceTag
                Write-Host $LogStringCreated, $ServiceBusNamespace
            }else{
                Write-Host $ServiceBusNamespace, $LogStringSkipping
            }
           
            $KeyVaultName = $MigratePrefix + "kv" + $hash
            $KeyVaultType = "Microsoft.KeyVault/vaults"
            $KeyVaultApiVersion = "2016-10-01"
            $KeyVaultKind = "KeyVault"
            $keyVaultSKu = @{
                family = "A";
                name = "standard"
            }
            
            $keyVaultTenantID = $context.Tenant.TenantId 
            
            $KeyVaultKeys =@("Get","List","Create","Update","Delete")
            $KeyVaultSecrets = @("Get","Set","List","Delete")
            $KeyVaultCertificates = @("Get","List")
            $KeyVaultStorage = @("get","list","delete","set","update","regeneratekey","getsas",
            "listsas","deletesas","setsas","recover","backup","restore","purge")
            $KeyVaultPermissions = @{keys=$KeyVaultKeys;secrets=$KeyVaultSecrets;
                certificates=$KeyVaultCertificates;storage=$KeyVaultStorage}
            $CloudEnvironMent = $context.Environment.Name
            $HyperVManagerAppId = "b8340c3b-9267-498f-b21a-15d5547fd85e"
            if($CloudEnvironMent -eq "AzureUSGovernment"){
                $HyperVManagerAppId = "AFAE2AF7-62E0-4AA4-8F66-B11F74F56326"
            }



            # Intermediate phase

            # Phase 2
            
        }
     
        
       
       
      

       

       

       
        
       
    
}

