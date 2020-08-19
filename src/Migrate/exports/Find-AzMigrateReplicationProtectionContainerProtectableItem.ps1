
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
The operation to a add a protectable item to a protection container(Add physical server.)
.Description
The operation to a add a protectable item to a protection container(Add physical server.)
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IDiscoverProtectableItemRequest
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.IMigrateIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IProtectionContainer
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

DISCOVERPROTECTABLEITEMREQUEST <IDiscoverProtectableItemRequest>: Request to add a physical machine as a protectable item in a container.
  [FriendlyName <String>]: The friendly name of the physical machine.
  [IPAddress <String>]: The IP address of the physical machine to be discovered.
  [OSType <String>]: The OS type on the physical machine.

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
.Link
https://docs.microsoft.com/en-us/powershell/module/az.migrate/find-azmigratereplicationprotectioncontainerprotectableitem
#>
function Find-AzMigrateReplicationProtectionContainerProtectableItem {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IProtectionContainer])]
[CmdletBinding(DefaultParameterSetName='DiscoverExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Discover', Mandatory)]
    [Parameter(ParameterSetName='DiscoverExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [System.String]
    # The name of the fabric.
    ${FabricName},

    [Parameter(ParameterSetName='Discover', Mandatory)]
    [Parameter(ParameterSetName='DiscoverExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [System.String]
    # The name of the protection container.
    ${ProtectionContainerName},

    [Parameter(ParameterSetName='Discover', Mandatory)]
    [Parameter(ParameterSetName='DiscoverExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [System.String]
    # The name of the resource group where the recovery services vault is present.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Discover', Mandatory)]
    [Parameter(ParameterSetName='DiscoverExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [System.String]
    # The name of the recovery services vault.
    ${ResourceName},

    [Parameter(ParameterSetName='Discover')]
    [Parameter(ParameterSetName='DiscoverExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The subscription Id.
    ${SubscriptionId},

    [Parameter(ParameterSetName='DiscoverViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='DiscoverViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.IMigrateIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Discover', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='DiscoverViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IDiscoverProtectableItemRequest]
    # Request to add a physical machine as a protectable item in a container.
    # To construct, see NOTES section for DISCOVERPROTECTABLEITEMREQUEST properties and create a hash table.
    ${DiscoverProtectableItemRequest},

    [Parameter(ParameterSetName='DiscoverExpanded')]
    [Parameter(ParameterSetName='DiscoverViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Body')]
    [System.String]
    # The friendly name of the physical machine.
    ${FriendlyName},

    [Parameter(ParameterSetName='DiscoverExpanded')]
    [Parameter(ParameterSetName='DiscoverViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Body')]
    [System.String]
    # The IP address of the physical machine to be discovered.
    ${IPAddress},

    [Parameter(ParameterSetName='DiscoverExpanded')]
    [Parameter(ParameterSetName='DiscoverViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Category('Body')]
    [System.String]
    # The OS type on the physical machine.
    ${OSType},

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
            Discover = 'Az.Migrate.private\Find-AzMigrateReplicationProtectionContainerProtectableItem_Discover';
            DiscoverExpanded = 'Az.Migrate.private\Find-AzMigrateReplicationProtectionContainerProtectableItem_DiscoverExpanded';
            DiscoverViaIdentity = 'Az.Migrate.private\Find-AzMigrateReplicationProtectionContainerProtectableItem_DiscoverViaIdentity';
            DiscoverViaIdentityExpanded = 'Az.Migrate.private\Find-AzMigrateReplicationProtectionContainerProtectableItem_DiscoverViaIdentityExpanded';
        }
        if (('Discover', 'DiscoverExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
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
