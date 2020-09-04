## Guidelines

- Do your cmdlets comply with the design guidelines outlined in the [PowerShell Design Guidelines document](https://github.com/Azure/azure-powershell/tree/master/documentation/development-docs/design-guidelines)?

    - ` Yes `

## Service Release Details

- Is this an Embargoed Preview, A Public Preview, or a General Release?

    - ` Public Preview `

- What is the expected service release date?

    - `September 30 2020`

## Contact Information

- Main developer contacts (emails + github aliases)

    - `prachetos.sadhukhan@microsoft.com(prsadhu-ms-idc),Kunal.Chaturvedi@microsoft.com(kuchatur-ms)`

- PM contact (email + github alias) 

    - `rahugup@microsoft.com`

- Other people who should attend a design review (email)

    - `lshai@microsoft.com,krprasa@microsoft.com`

## High Level Scenarios

- Describe how your feature is intended to be used by customers.

    - Azure Migrate PowerShell cmdlets for the VMware to Azure scenario will enable IT Pro administrators to automate their migration factories and make it easy to perform repetitive migration activities (as most of the migration activities are done in stages). It will also enable at scale automation support for customers (currently limited due to portal constraints), a repetitive ask from our customers.  The focus will be on allowing end to end scenario enablement for VMware to Azure scenario by giving more power to the user without exposing the additional complexity inherent in Azure Migrate’s migration architecture.  
        - Enable IT Pros to achieve to automate VMware to Azure agentless migration scenario 
        - Will allow scripting of Azure Migrate migration operations for scale deployments 
        - Equip power users to unleash Azure Migrate’s full potential through simplified customization 
        - Ensure future extensibility in accordance with Azure Migrate migration roadmap 


- Piping scenarios / how these cmdlets are used with existing cmdlets

    - `NO`

- Sample of end-to-end usage

    - `{ SAMPLE USAGE HERE }`

## Syntax changes

This should include PowerShell-help style syntax descriptions of all new and changed cmdlets, similar to the syntax portion of PowerShell help (or markdown help), for example:

### New Cmdlet
---
external help file:
Module Name: Az.Migrate
online version: https://docs.microsoft.com/en-us/powershell/module/az.migrate/initialize-azmigratereplicationinfrastructure
schema: 2.0.0
---

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
PS C:\> {{ Add code here }}

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





