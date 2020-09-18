$loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
if (-Not (Test-Path -Path $loadEnvPath)) {
    $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
}
. ($loadEnvPath)
$TestRecordingFile = Join-Path $PSScriptRoot 'Get-AzMigrateRunAsAccount.Recording.json'
$currentPath = $PSScriptRoot
while(-not $mockingPath) {
    $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
    $currentPath = Split-Path -Path $currentPath -Parent
}
. ($mockingPath | Select-Object -First 1).FullName

Describe 'Get-AzMigrateRunAsAccount' {
    It 'List' {
        $runAsAccounts = Get-AzMigrateRunAsAccount -ResourceGroupName $env.migResourceGroup -SiteName $env.migSiteName -SubscriptionId $env.migSubscriptionId       
        $runAsAccounts.Count | Should -BeGreaterOrEqual 1 
    }

    It 'Get' {
        $runAsAccount = Get-AzMigrateRunAsAccount -AccountName $env.migRunAsAccountName -ResourceGroupName $env.migResourceGroup -SiteName $env.migSiteName -SubscriptionId $env.migSubscriptionId       
        $runAsAccount.Name | Should -Be $env.migRunAsAccountName
    }

    It 'GetViaIdentity' {
        $runAsAccount1 = Get-AzMigrateRunAsAccount -AccountName $env.migRunAsAccountName -ResourceGroupName $env.migResourceGroup -SiteName $env.migSiteName -SubscriptionId $env.migSubscriptionId       
        $runAsAccount2 = Get-AzMigrateRunAsAccount -InputObject $runAsAccount1
        $runAsAccount2.Name | Should -Be $env.migRunAsAccountName
    }
}
