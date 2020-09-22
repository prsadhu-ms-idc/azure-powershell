@{
  GUID = 'aa66b0fe-a524-4f80-94dc-2f3aa487df53'
  RootModule = './Az.Migrate.psm1'
  ModuleVersion = '0.1.0'
  CompatiblePSEditions = 'Core', 'Desktop'
  Author = 'Microsoft Corporation'
  CompanyName = 'Microsoft Corporation'
  Copyright = 'Microsoft Corporation. All rights reserved.'
  Description = 'Microsoft Azure PowerShell: Migrate cmdlets'
  PowerShellVersion = '5.1'
  DotNetFrameworkVersion = '4.7.2'
  RequiredAssemblies = './bin/Az.Migrate.private.dll'
  FormatsToProcess = './Az.Migrate.format.ps1xml'
  FunctionsToExport = 'Get-AzMigrateJob', 'Get-AzMigrateMachine', 'Get-AzMigrateProject', 'Get-AzMigrateReplicationPolicy', 'Get-AzMigrateReplicationProtectionContainerMapping', 'Get-AzMigrateRunAsAccount', 'Get-AzMigrateServerReplication', 'Get-AzMigrateSite', 'Get-AzMigrateSolution', 'Initialize-AzMigrateReplicationInfrastructure', 'Invoke-AzMigrateCleanupSolutionData', 'New-AzMigrateDiskMapping', 'New-AzMigrateProject', 'New-AzMigrateReplicationPolicy', 'New-AzMigrateReplicationProtectionContainerMapping', 'New-AzMigrateServerReplication', 'New-AzMigrateSite', 'Remove-AzMigrateProject', 'Remove-AzMigrateReplicationPolicy', 'Remove-AzMigrateReplicationProtectionContainerMapping', 'Remove-AzMigrateServerReplication', 'Remove-AzMigrateSite', 'Restart-AzMigrateServerReplication', 'Set-AzMigrateServerReplication', 'Set-AzMigrateSite', 'Start-AzMigrateMachine', 'Start-AzMigrateServerMigration', 'Start-AzMigrateTestMigration', 'Start-AzMigrateTestMigrationCleanup', 'Stop-AzMigrateMachine', 'Update-AzMigrateProject', 'Update-AzMigrateProjectSummary', 'Update-AzMigrateReplicationProtectionContainerMapping', 'Update-AzMigrateSite', 'Update-AzMigrateSolution', '*'
  AliasesToExport = '*'
  PrivateData = @{
    PSData = @{
      Tags = 'Azure', 'ResourceManager', 'ARM', 'PSModule', 'Migrate'
      LicenseUri = 'https://aka.ms/azps-license'
      ProjectUri = 'https://github.com/Azure/azure-powershell'
      ReleaseNotes = ''
    }
  }
}
