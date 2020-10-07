
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
Requires: 
Az.Resources
Az.KeyVault
Az.ServiceBus
Az.Migrate
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
        Import-Module -Name Az.Migrate
    
        Set-PSDebug -Step; foreach ($i in 1..3) {$i}

        # Get/Set SubscriptionId
        if(($SubscriptionId -eq $null) -or ($SubscriptionId -eq "")){
            $context = Get-AzContext
            $SubscriptionId = $context.Subscription.Id
            if(($SubscriptionId -eq $null) -or ($SubscriptionId -eq "")){
                throw "Please login to Azure to select a subscription."
            }
        }else{
            Select-AzSubscription -SubscriptionId $SubscriptionId
        }
        Write-Host "Using Subscription Id: ", $SubscriptionId
     
        # Validate target region
        $availableRegions = Get-AzLocation
        $targetRegionObject = $null
        foreach($location in $availableRegions){
            if ($location.Location -eq $TargetRegion){
                $targetRegionObject = $location
                break
            }
        }
        if ($targetRegionObject -eq $null){
            throw "Please input a valid target region." 
        }

        Write-Host "Selected Target Region: ", $TargetRegion
        
        try{
            Get-AzResourceGroup -Name $ResourceGroupName
        }catch{
            if($Error[0].Exception -match "Provided resource group does not exist"){
                Write-Host "Creating Resource Group ", $ResourceGroupName
                New-AzResourceGroup -Name $ResourceGroupName -Location $TargetRegion
                Write-Host $ResourceGroupName, " created."
            }else{
                throw
            }
        }
        Write-Host "Select resource group : ", $ResourceGroupName

        # Hash code source code
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

        # Get all appliances and sites in the project
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
            # Storage account
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
            if(!$lsaStorageAccount){
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

            # Service bus namespace
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
            if(!$serviceBusAccount){
                New-AzResource -ResourceGroupName $ResourceGroupName -Location $TargetRegion -Properties  $ServiceBusProperties -ResourceName $ServiceBusNamespace -ResourceType  $ServiceBusType -ApiVersion $ServiceBusApiVersion -Kind  $ServieBusKind -Sku  $ServiceBusSku -Tag $ResourceTag
                Write-Host $LogStringCreated, $ServiceBusNamespace
            }else{
                Write-Host $ServiceBusNamespace, $LogStringSkipping
            }
           
            # Key vault
            $KeyVaultName = $MigratePrefix + "kv" + $hash
            $KeyVaultType = "Microsoft.KeyVault/vaults"
            $KeyVaultApiVersion = "2016-10-01"
            $KeyVaultKind = "KeyVault"
            
            $existingKeyVaultAccount =  Get-AzResource -ResourceGroupName $ResourceGroupName -Name $KeyVaultName
            if($existingKeyVaultAccount){
                Write-Host $KeyVaultName, $LogStringSkipping
            }else{
                $tenantID = $context.Tenant.TenantId 

                $KeyVaultPermissions = @{
                    keys=@("Get","List","Create","Update","Delete");
                    secrets=@("Get","Set","List","Delete");
                    certificates=@("Get","List");
                    storage= @("get","list","delete","set","update","regeneratekey","getsas",
                    "listsas","deletesas","setsas","recover","backup","restore","purge")
                }

                $CloudEnvironMent = $context.Environment.Name
                $HyperVManagerAppId = "b8340c3b-9267-498f-b21a-15d5547fd85e"
                if($CloudEnvironMent -eq "AzureUSGovernment"){
                    $HyperVManagerAppId = "AFAE2AF7-62E0-4AA4-8F66-B11F74F56326"
                }
                $hyperVManagerObject = Get-AzADServicePrincipal -ApplicationID $HyperVManagerAppId
                $userObject =  Get-AzADUser -UserPrincipalName $context.Subscription.ExtendedProperties.Account
                $accessPolicies = @()
                $userAccessPolicy = @{
                    "tenantId" = $tenantID;
                    "objectId" =  $userObject.Id;
                    "permissions" = $KeyVaultPermissions
                }
                $hyperVAccessPolicy = @{
                    "tenantId" = $tenantID;
                    "objectId" = $hyperVManagerObject.Id;
                    "permissions" = $KeyVaultPermissions
                }
                $accessPolicies += $userAccessPolicy
                $accessPolicies += $hyperVAccessPolicy
                $projectRSPObject = Get-AzMigrateReplicationRecoveryServicesProvider -ResourceGroupName $ResourceGroupName -ResourceName $VaultName
                foreach ($projectRSP in $projectRSPObject) {
                    $projectAccessPolicy = @{
                        "tenantId" = $tenantID;
                        "objectId" =  $projectRSP.ResourceAccessIdentityDetailObjectId;
                        "permissions" = $KeyVaultPermissions
                    }
                    $accessPolicies += $projectAccessPolicy
                }
                $keyVaultProperties = @{
                    sku = @{
                        family = "A";
                        name = "standard"
                    };
                    tenantId = ;
                    enabledForDeployment = $true;
                    enabledForDiskEncryption = $true;
                    enabledForTemplateDeployment = $true;
                    accessPolicies = $accessPolicies
                }

                New-AzResource -ResourceGroupName $ResourceGroupName -Location $TargetRegion -Properties  $keyVaultProperties -ResourceName $KeyVaultName -ResourceType  $KeyVaultType -ApiVersion $KeyVaultApiVersion -Kind $KeyVaultKind -Tag $ResourceTag
                Write-Host $LogStringCreated, $KeyVaultName
            }

            # Locks
            $CommonLockName = $ProjectName + "lock"

            try{
                Get-AzResourceLock -LockName $CommonLockName -ResourceName $LogStorageAcName -ResourceType $StorageType -ResourceGroupName $ResourceGroupName
                Write-Host $CommonLockName, " for ", $LogStorageAcName, $LogStringSkipping
            }catch{
                if($Error[0].Exception -match 'LockNotFound'){
                    New-AzResourceLock -LockLevel CanNotDelete -LockName $CommonLockName -ResourceName $LogStorageAcName -ResourceType $StorageType -ResourceGroupName $ResourceGroupName
                    Write-Host $LogStringCreated, $CommonLockName, " for ", $LogStorageAcName
                }else{
                    throw
                }
            }
            try{
                Get-AzResourceLock -LockName $CommonLockName -ResourceName $GateWayStorageAcName -ResourceType $StorageType -ResourceGroupName $ResourceGroupName
                Write-Host $CommonLockName, " for ", $LogStorageAcName, $LogStringSkipping
            }catch{
                if($Error[0].Exception -match 'LockNotFound'){
                    New-AzResourceLock -LockLevel CanNotDelete -LockName $CommonLockName -ResourceName $GateWayStorageAcName -ResourceType $StorageType -ResourceGroupName $ResourceGroupName
                    Write-Host $LogStringCreated, $CommonLockName, " for ", $GateWayStorageAcName
                }else{
                    throw
                }
            }
            try{
                Get-AzResourceLock -LockName $CommonLockName -ResourceName $ServiceBusNamespace -ResourceType $ServiceBusType -ResourceGroupName $ResourceGroupName
                Write-Host $CommonLockName, " for ", $ServiceBusNamespace, $LogStringSkipping
            }catch{
                if($Error[0].Exception -match 'LockNotFound'){
                    New-AzResourceLock -LockLevel CanNotDelete -LockName $CommonLockName -ResourceName $ServiceBusNamespace -ResourceType $ServiceBusType -ResourceGroupName $ResourceGroupName
                    Write-Host $LogStringCreated, $CommonLockName, " for ", $ServiceBusNamespace
                }else{
                    throw
                }
            }
            try{
                Get-AzResourceLock -LockName $CommonLockName -ResourceName $KeyVaultName -ResourceType $KeyVaultType -ResourceGroupName $ResourceGroupName
                Write-Host $CommonLockName, " for ", $KeyVaultName, $LogStringSkipping
            }catch{
                if($Error[0].Exception -match 'LockNotFound'){
                    New-AzResourceLock -LockLevel CanNotDelete -LockName $CommonLockName -ResourceName $KeyVaultName -ResourceType $KeyVaultType -ResourceGroupName $ResourceGroupName
                    Write-Host $LogStringCreated, $CommonLockName, " for ", $KeyVaultName
                }else{
                    throw
                }
            }

            # Intermediate phase
            # RoleAssignments
            
            $kvspnid = (Get-AzADServicePrincipal -DisplayName "Azure Key Vault" )[0].Id
            $gwyStorageAccount = Get-AzResource -ResourceName $GateWayStorageAcName -ResourceGroupName $ResourceGroupName
            $lsaStorageAccount = Get-AzResource -ResourceName $LogStorageAcName -ResourceGroupName $ResourceGroupName
            $lsaRoleAssignments = Get-AzRoleAssignment -ObjectId $kvspnid -Scope $gwyStorageAccount.Id
            $gwyRoleAssignments = Get-AzRoleAssignment -ObjectId $kvspnid -Scope $lsaStorageAccount.Id
            if(!$lsaRoleAssignments){
                New-AzRoleAssignment -ObjectId $kvspnid -Scope $lsaStorageAccount.Id
                Write-Host $LogStringCreated, "RoleAssignment", " for ", $LogStorageAcName
            }else{
                Write-Host "RoleAssignment", " for ", $LogStorageAcName, $LogStringSkipping
            }
            if(!$gwyRoleAssignments){
                New-AzRoleAssignment -ObjectId $kvspnid -Scope $gwyStorageAccount.Id
                Write-Host $LogStringCreated, "RoleAssignment", " for ", $GateWayStorageAcName
            }else{
                Write-Host "RoleAssignment", " for ", $GateWayStorageAcName, $LogStringSkipping
            }

            # SA. SAS definition
            $managedLsaAccount = $null
            $managedGwyAccount = $null
            try{ $managedLsaAccount =  Get-AzKeyVaultManagedStorageAccount -VaultName $KeyVaultName -Name $LogStorageAcName }catch{}
            try{ $managedGwyAccount =  Get-AzKeyVaultManagedStorageAccount -VaultName $KeyVaultName -Name $GateWayStorageAcName }catch{}

            $gatewayStorageAccountSasSecretName = "gwySas"
            $cacheStorageAccountSasSecretName = "cacheSas"
            $managedLsaAccountSASAccount = $null
            $managedGwyAccountSASAccount = $null
            $regenerationPeriod = [System.Timespan]::FromDays(30)
            try{ $managedLsaAccountSASAccount = Get-AzKeyVaultManagedStorageSasDefinition -VaultName $KeyVaultName -AccountName $LogStorageAcName -Name $cacheStorageAccountSasSecretName }catch{}
            try{ $managedGwyAccountSASAccount = Get-AzKeyVaultManagedStorageSasDefinition -VaultName $KeyVaultName -AccountName $GateWayStorageAcName -Name $gatewayStorageAccountSasSecretName }catch{}
            if(!$managedLsaAccount){
                Add-AzKeyVaultManagedStorageAccount -VaultName $KeyVaultName -AccountName $LogStorageAcName -AccountResourceId  $lsaStorageAccount.Id  -ActiveKeyName 'Key2' -RegenerationPeriod $regenerationPeriod
                Write-Host $LogStringCreated, "VaultManagedStorageAccount", " for ", $LogStorageAcName
            }else{
                Write-Host "VaultManagedStorageAccount", " for ", $LogStorageAcName, $LogStringSkipping
            }
            if(!$managedGwyAccount){
                Add-AzKeyVaultManagedStorageAccount -VaultName $KeyVaultName -AccountName $GateWayStorageAcName -AccountResourceId  $gwyStorageAccount.Id  -ActiveKeyName 'Key2' -RegenerationPeriod $regenerationPeriod
                Write-Host $LogStringCreated, "VaultManagedStorageAccount", " for ", $GateWayStorageAcName
            }else{
                Write-Host "VaultManagedStorageAccount", " for ", $GateWayStorageAcName, $LogStringSkipping
            }
            if(!$managedLsaAccountSASAccount){
                Set-AzKeyVaultManagedStorageSasDefinition -AccountName $LogStorageAcName -VaultName $KeyVaultName -Name $cacheStorageAccountSasSecretName -SasType 'account' -ValidityPeriod $regenerationPeriod
                Write-Host $LogStringCreated, "ManagedStorageSasDefinition", " for ", $LogStorageAcName
            }else{
                Write-Host "ManagedStorageSasDefinition", " for ", $LogStorageAcName, $LogStringSkipping
            }
            if(!$managedGwyAccountSASAccount){
                Set-AzKeyVaultManagedStorageSasDefinition -AccountName $GateWayStorageAcName -VaultName $KeyVaultName -Name $gatewayStorageAccountSasSecretName -SasType 'account' -ValidityPeriod $regenerationPeriod
                Write-Host $LogStringCreated, "ManagedStorageSasDefinition", " for ", $GateWayStorageAcName
            }else{
                Write-Host "ManagedStorageSasDefinition", " for ", $GateWayStorageAcName, $LogStringSkipping
            }
            
            # Phase 2
            # Policy
            $policyName = "migrate" + $SiteName + "policy"
            $existingPolicyObject = Get-AzMigrateReplicationPolicy -PolicyName $policyName -ResourceGroupName $ResourceGroupName -ResourceName $VaultName
            if(!$existingPolicyObject){
                $providerSpecificPolicy = [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.VMwareCbtPolicyCreationInput]::new()
                $providerSpecificPolicy.AppConsistentFrequencyInMinute = 240
                $providerSpecificPolicy.InstanceType = "VMwareCbt"
                $providerSpecificPolicy.RecoveryPointHistoryInMinute = 4320
                $providerSpecificPolicy.CrashConsistentFrequencyInMinute = 60
                $existingPolicyObject = New-AzMigrateReplicationPolicy -PolicyName $policyName -ResourceGroupName $ResourceGroupName -ResourceName $VaultName -ProviderSpecificInput $providerSpecificPolicy
                Write-Host $LogStringCreated, $policyName
            }else{
                Write-Host $policyName, $LogStringSkipping
            }

            # Policy-container mapping
            $mappingName = "containermapping"
            $serviceBusConnString = "ServiceBusConnectionString"
            $allFabrics = Get-AzMigrateReplicationFabric -ResourceGroupName $ResourceGroupName -ResourceName $VaultName
            foreach($fabric in $allFabrics){
                if($fabric.Name -match $applianceName){
                    $peContainers = Get-AzMigrateReplicationProtectionContainer -FabricName $fabric.Name -ResourceGroupName $ResourceGroupName -ResourceName $VaultName
                    foreach ($peContainer in $peContainers) {
                        if($peContainer.Name -match $applianceName){
                            $existingMapping = Get-AzMigrateReplicationProtectionContainerMapping -ResourceGroupName $ResourceGroupName -ResourceName $VaultName -FabricName $fabric.Name -ProtectionContainerName $peContainer.Name -MappingName $mappingName
                            if($existingMapping){
                                Write-Host $mappingName, " for ", $applianceName, $LogStringSkipping
                            }else{
                                $keyVaultAccountDetails = Get-AzKeyVault -ResourceGroupName $ResourceGroupName -Name $KeyVaultName
                                $gwyStorageAccount = Get-AzResource -ResourceGroupName $ResourceGroupName -ResourceName $GateWayStorageAcName
                                $providerSpecificInput = [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.VMwareCbtContainerMappingInput]::new()
                                $providerSpecificInput.InstanceType = "VMwareCbt"
                                $providerSpecificInput.KeyVaultId = $keyVaultAccountDetails.ResourceId
                                $providerSpecificInput.KeyVaultUri = $keyVaultAccountDetails.VaultUri
                                $providerSpecificInput.ServiceBusConnectionStringSecretName = $serviceBusConnString
                                $providerSpecificInput.StorageAccountId = $gwyStorageAccount.Id
                                $providerSpecificInput.StorageAccountSasSecretName = $GateWayStorageAcName + "-gwySas"
                                $providerSpecificInput.TargetLocation = $TargetRegion
                                New-AzMigrateReplicationProtectionContainerMapping -FabricName $fabric.Name -MappingName $mappingName -ProtectionContainerName $peContainer.Name -ResourceGroupName $ResourceGroupName -ResourceName $VaultName -PolicyId $existingPolicyObject.Id -ProviderSpecificInput $providerSpecificInput -TargetProtectionContainerId  "Microsoft Azure"
                                Write-Host $LogStringCreated, $mappingName, " for ", $applianceName
                            }
                        }
                    }
                }
            }

            # ServiceBusConnectionString
            $serviceBusSecretObject = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $serviceBusConnString
            if($serviceBusSecretObject){
                Write-Host $serviceBusConnString, " for ", $applianceName, $LogStringSkipping
            }else{
                $serviceBusRootKey = Get-AzServiceBusKey -ResourceGroupName $ResourceGroupName -Namespace $ServiceBusNamespace -Name "RootManageSharedAccessKey"
                $secret = ConvertTo-SecureString -String $serviceBusRootKey.PrimaryConnectionString -AsPlainText -Force
                Set-AzKeyVaultSecret -VaultName $KeyVaultName -Name $serviceBusConnString -SecretValue $secret
                Write-Host $LogStringCreated, $serviceBusConnString, " for ", $applianceName
            }   
        }

        return $true
}

