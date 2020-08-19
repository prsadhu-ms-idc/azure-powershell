
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
.Synopsis
The operation to initiate test migration of the item.
.Description
The operation to initiate test migration of the item.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.ITestMigrateInput
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.IMigrateIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IMigrationItem
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMigrateIdentity>: Identity Parameter
  [AlertSettingName <String>]: The name of the email notification configuration.
  [EventName <String>]: The name of the Azure Site Recovery event.
  [FabricName <String>]: Fabric name.
  [Id <String>]: Resource identity path
  [JobName <String>]: Job identifier
  [LogicalNetworkName <String>]: Logical network name.
  [MappingName <String>]: Protection Container mapping name.
  [MigrationItemName <String>]: Migration item name.
  [MigrationRecoveryPointName <String>]: The migration recovery point name.
  [NetworkMappingName <String>]: Network mapping name.
  [NetworkName <String>]: Primary network name.
  [PolicyName <String>]: Replication policy name.
  [ProtectableItemName <String>]: Protectable item name.
  [ProtectionContainerName <String>]: Protection container name.
  [ProviderName <String>]: Recovery services provider name
  [RecoveryPlanName <String>]: Name of the recovery plan.
  [RecoveryPointName <String>]: The recovery point name.
  [ReplicatedProtectedItemName <String>]: Replication protected item name.
  [ReplicationProtectedItemName <String>]: The name of the protected item on which the agent is to be updated.
  [ResourceGroupName <String>]: The name of the resource group where the recovery services vault is present.
  [ResourceName <String>]: The name of the recovery services vault.
  [StorageClassificationMappingName <String>]: Storage classification mapping name.
  [StorageClassificationName <String>]: Storage classification name.
  [SubscriptionId <String>]: The subscription Id.
  [VCenterName <String>]: vCenter name.

TESTMIGRATEINPUT <ITestMigrateInput>: Input for test migrate.
  ProviderSpecificDetailInstanceType <String>: The class type.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.migrate/test-azmigratereplicationmigrationitemmigrate
#>
function Test-AzMigrateReplicationMigrationItemMigrate {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IMigrationItem])]
[CmdletBinding(DefaultParameterSetName='TestExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Test', Mandatory)]
    [Parameter(ParameterSetName='TestExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [System.String]
    # Fabric name.
    ${FabricName},

    [Parameter(ParameterSetName='Test', Mandatory)]
    [Parameter(ParameterSetName='TestExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [System.String]
    # Migration item name.
    ${MigrationItemName},

    [Parameter(ParameterSetName='Test', Mandatory)]
    [Parameter(ParameterSetName='TestExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [System.String]
    # Protection container name.
    ${ProtectionContainerName},

    [Parameter(ParameterSetName='Test', Mandatory)]
    [Parameter(ParameterSetName='TestExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [System.String]
    # The name of the resource group where the recovery services vault is present.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Test', Mandatory)]
    [Parameter(ParameterSetName='TestExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [System.String]
    # The name of the recovery services vault.
    ${ResourceName},

    [Parameter(ParameterSetName='Test')]
    [Parameter(ParameterSetName='TestExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The subscription Id.
    ${SubscriptionId},

    [Parameter(ParameterSetName='TestViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='TestViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.IMigrateIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Test', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='TestViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.ITestMigrateInput]
    # Input for test migrate.
    # To construct, see NOTES section for TESTMIGRATEINPUT properties and create a hash table.
    ${TestMigrateInput},

    [Parameter(ParameterSetName='TestExpanded', Mandatory)]
    [Parameter(ParameterSetName='TestViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Body')]
    [System.String]
    # The class type.
    ${ProviderSpecificDetailInstanceType},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Test = 'Az.Migrate.private\Test-AzMigrateReplicationMigrationItemMigrate_Test';
            TestExpanded = 'Az.Migrate.private\Test-AzMigrateReplicationMigrationItemMigrate_TestExpanded';
            TestViaIdentity = 'Az.Migrate.private\Test-AzMigrateReplicationMigrationItemMigrate_TestViaIdentity';
            TestViaIdentityExpanded = 'Az.Migrate.private\Test-AzMigrateReplicationMigrationItemMigrate_TestViaIdentityExpanded';
        }
        if (('Test', 'TestExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}
