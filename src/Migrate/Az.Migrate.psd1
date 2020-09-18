@{
  GUID = 'e4ba8cdf-c526-4c8f-9a70-2fd8b1666610'
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
  FunctionsToExport = 'Get-AzMigrateMachine', 'Get-AzMigrateProject', 'Get-AzMigrateRunAsAccount', 'Get-AzMigrateSite', 'Get-AzMigrateSolution', 'New-AzMigrateProject', 'Remove-AzMigrateProject', '*'
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
