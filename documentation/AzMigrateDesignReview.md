## Guidelines

- Do your cmdlets comply with the design guidelines outlined in the [PowerShell Design Guidelines document](https://github.com/Azure/azure-powershell/tree/master/documentation/development-docs/design-guidelines)?

    - ` Yes `

## Service Release Details

- Is this an Embargoed Preview, A Public Preview, or a General Release?

    - ` General Release `

- What is the expected service release date?

    - `September 30 2020`

## Contact Information

- Main developer contacts (emails + github aliases)

    - `prachetos.sadhukhan@microsoft.com(prsadhu-ms-idc),Kunal.Chaturvedi@microsoft.com(kuchatur-ms)`

- PM contact (email + github alias) 

    - `rahugup@microsoft.com(rahulg1190)`

- Other people who should attend a design review (email)

    - `lshai@microsoft.com,krprasa@microsoft.com,bsiva@microsoft.com`

## High Level Scenarios

- Describe how your feature is intended to be used by customers.

    - Azure Migrate PowerShell cmdlets for the VMware to Azure scenario will enable IT Pro administrators to automate their migration factories and make it easy to perform repetitive migration activities (as most of the migration activities are done in stages). It will also enable at scale automation support for customers (currently limited due to portal constraints), a repetitive ask from our customers.  The focus will be on allowing end to end scenario enablement for VMware to Azure scenario by giving more power to the user without exposing the additional complexity inherent in Azure Migrate’s migration architecture.  
        - Enable IT Pros to achieve to automate VMware to Azure agentless migration scenario 
        - Will allow scripting of Azure Migrate migration operations for scale deployments 
        - Equip power users to unleash Azure Migrate’s full potential through simplified customization 
        - Ensure future extensibility in accordance with Azure Migrate migration roadmap 


- Piping scenarios / how these cmdlets are used with existing cmdlets

    - `Yes`

- Sample of end-to-end usage

    - `{ SAMPLE USAGE HERE }`

### New Cmdlet
# Initialize-AzMigrateReplicationInfrastructure

## SYNOPSIS
Initializes the replication infrastructure.

## SYNTAX

```
Initialize-AzMigrateReplicationInfrastructure -ProjectName <String> -ResourceGroupName <String> -TargetRegion
 -Vmwareagentless [-SubscriptionId <String>] [-DefaultProfile <PSObject>] [-AsJob] [-NoWait] [-PassThru]
 [-Confirm] [-WhatIf] [<CommonParameters>]
```

## DESCRIPTION
The Initialize-AzMigrateReplicationInfrastructure deploys and configures the replication infrastructure used for server migration in the Azure Migrate project Resource Group.

## EXAMPLES

### Example 1: {{ Add title here }}
```powershell
PS C:\> Initialize-AzMigrateReplicationInfrastructure -ProjectName DemoMGP -ResourceGroupName DemoRG -TargetRegion centraluseuap
-Vmwareagentless
```

Initializes the replication infrastructure

## PARAMETERS

### -AsJob
Run the command as a job

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultProfile
The credentials, account, tenant, and subscription used for communication with Azure.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases: AzureRMContext, AzureCredential

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoWait
Run the command asynchronously

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns true when the command succeeds

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProjectName
Specifies the name of the Azure Migrate project to be used for server migration.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
Specifies the Resource Group of the Azure Migrate Project in the current subscription.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubscriptionId
Azure Subscription ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-AzContext).Subscription.Id
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetRegion
Specifies the target Azure region for server migrations.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Vmwareagentless
Specifies the server migration scenario for which the replication infrastructure needs to be initialized.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean

## NOTES

ALIASES

## RELATED LINKS

---
external help file:
Module Name: Az.Migrate
online version: https://docs.microsoft.com/en-us/powershell/module/az.migrate/new-azmigrateserverreplication
schema: 2.0.0
---

# New-AzMigrateServerReplication

## SYNOPSIS
Starts replication for the specified server.

## SYNTAX

### ByIdDefaultUser (Default)
```
New-AzMigrateServerReplication -DiskType <DiskAccountType> -LicenseType <LicenseType> -OSDiskID <String>
 -TargetNetworkId <String> -TargetResourceGroupId <String> -TargetSubnetName <String>
 -TargetSubscriptionId <String> -TargetVMName <String> -TargetVMSize <String> -VMwareMachineId <String>
 [-PerformAutoResync <String>] [-SubscriptionId <String>] [-TargetAvailabilitySet <String>]
 [-TargetAvailabilityZone <String>] [-TargetBootDiagnosticsStorageAccount <String>]
 [-DefaultProfile <PSObject>] [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### ByIdPowerUser
```
New-AzMigrateServerReplication -DisksToInclude <IVMwareCbtDiskInput[]> -LicenseType <LicenseType>
 -PerformAutoResync <String> -TargetNetworkId <String> -TargetResourceGroupId <String>
 -TargetSubnetName <String> -TargetSubscriptionId <String> -TargetVMName <String> -TargetVMSize <String>
 -VMwareMachineId <String> [-SubscriptionId <String>] [-TargetAvailabilitySet <String>]
 [-TargetAvailabilityZone <String>] [-TargetBootDiagnosticsStorageAccount <String>]
 [-DefaultProfile <PSObject>] [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### ByNameDefaultUser
```
New-AzMigrateServerReplication -DiskType <DiskAccountType> -LicenseType <LicenseType> -MachineName <String>
 -OSDiskID <String> -ProjectName <String> -ResourceGroupName <String> -TargetNetworkId <String>
 -TargetResourceGroupId <String> -TargetSubnetName <String> -TargetSubscriptionId <String>
 -TargetVMName <String> -TargetVMSize <String> [-PerformAutoResync <String>] [-SubscriptionId <String>]
 [-TargetAvailabilitySet <String>] [-TargetAvailabilityZone <String>]
 [-TargetBootDiagnosticsStorageAccount <String>] [-VMWarerunasaccountID <String>] [-DefaultProfile <PSObject>]
 [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### ByNamePowerUser
```
New-AzMigrateServerReplication -DisksToInclude <IVMwareCbtDiskInput[]> -LicenseType <LicenseType>
 -MachineName <String> -PerformAutoResync <String> -ProjectName <String> -ResourceGroupName <String>
 -TargetNetworkId <String> -TargetResourceGroupId <String> -TargetSubnetName <String>
 -TargetSubscriptionId <String> -TargetVMName <String> -TargetVMSize <String> [-SubscriptionId <String>]
 [-TargetAvailabilitySet <String>] [-TargetAvailabilityZone <String>]
 [-TargetBootDiagnosticsStorageAccount <String>] [-VMWarerunasaccountID <String>] [-DefaultProfile <PSObject>]
 [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

## DESCRIPTION
The New-AzMigrateServerReplication cmdlet starts the replication for a particular discovered server in the Azure Migrate project.

## EXAMPLES

### Example 1: Power User
```powershell
PS C:\> [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IVMwareCbtDiskInput[]]$DisksToInclude = @()
PS C:\> $OSDisk = New-AzMigrateDiskMapping -DiskID '6000C299-343d-7bcd-c05e-a94bd63316dd' -DiskType 'Standard_LRS' -IsOSDisk 'true'
PS C:\> $DataDisk = New-AzMigrateDiskMapping -DiskID '7000C299-343d-7bcd-c05e-a94bd63316dd' -DiskType 'Standard_LRS' -IsOSDisk 'false'
PS C:\> $DisksToInclude += $OSDisk
PS C:\> $DisksToInclude += $DataDisk

{{ Add output here }}
```

{{ Add description here }}

### Example 2: {{ Add title here }}
```powershell
PS C:\> {{ Add code here }}

{{ Add output here }}
```

{{ Add description here }}

## PARAMETERS

### -AsJob
Run the command as a job

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultProfile
The credentials, account, tenant, and subscription used for communication with Azure.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases: AzureRMContext, AzureCredential

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisksToInclude
Specifies the disks on the source server to be included for replication.
To construct, see NOTES section for DISKSTOINCLUDE properties and create a hash table.

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IVMwareCbtDiskInput[]
Parameter Sets: ByIdPowerUser, ByNamePowerUser
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DiskType
Specifies the type of disks to be used for the Azure VM.

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.Migrate.Support.DiskAccountType
Parameter Sets: ByIdDefaultUser, ByNameDefaultUser
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LicenseType
Specifies if Azure Hybrid benefit is applicable for the source server to be migrated.

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.Migrate.Support.LicenseType
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MachineName
Specifies the discovered machine name of the discovered server to be migrated.

```yaml
Type: System.String
Parameter Sets: ByNameDefaultUser, ByNamePowerUser
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoWait
Run the command asynchronously

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OSDiskID
Specifies the Operating System disk for the source server to be migrated.

```yaml
Type: System.String
Parameter Sets: ByIdDefaultUser, ByNameDefaultUser
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PerformAutoResync
Specifies if replication be auto-repaired in case change tracking is lost for the source server under replication.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProjectName
Specifies the migrate project name of the discovered server to be migrated.

```yaml
Type: System.String
Parameter Sets: ByNameDefaultUser, ByNamePowerUser
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
Specifies the resource group of the discovered server to be migrated.

```yaml
Type: System.String
Parameter Sets: ByNameDefaultUser, ByNamePowerUser
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubscriptionId
Azure Subscription ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-AzContext).Subscription.Id
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetAvailabilitySet
Specifies the Availability Set to be used for VM creationSpecifies the Availability Set to be used for VM creation.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetAvailabilityZone
Specifies the Availability Zone to be used for VM creation.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetBootDiagnosticsStorageAccount
Specifies the storage account to be used for boot diagnostics.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetNetworkId
Specifies the Virtual Network id within the destination Azure subscription to which the server needs to be migrated.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetResourceGroupId
Specifies the Resource Group id within the destination Azure subscription to which the server needs to be migrated.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetSubnetName
Specifies the Subnet name within the destination Virtual Netowk to which the server needs to be migrated.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetSubscriptionId
Specifies the destination Azure subscription id to which the server needs to be migrated.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetVMName
Specifies the name of the Azure VM to be created.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetVMSize
Specifies the SKU of the Azure VM to be created.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VMwareMachineId
Specifies the machine ID of the discovered server to be migrated.

```yaml
Type: System.String
Parameter Sets: ByIdDefaultUser, ByIdPowerUser
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VMWarerunasaccountID
Account id.

```yaml
Type: System.String
Parameter Sets: ByNameDefaultUser, ByNamePowerUser
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IMigrationItem

## NOTES

ALIASES

COMPLEX PARAMETER PROPERTIES

To create the parameters described below, please use the New-AzMigrateDiskMapping cmdlet.

DISKSTOINCLUDE <IVMwareCbtDiskInput[]>: Specifies the disks on the source server to be included for replication.


## RELATED LINKS

