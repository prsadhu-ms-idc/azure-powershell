$loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
if (-Not (Test-Path -Path $loadEnvPath)) {
    $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
}
. ($loadEnvPath)
$TestRecordingFile = Join-Path $PSScriptRoot 'Get-AzStaticWebAppBuildFunctionAppSetting.Recording.json'
$currentPath = $PSScriptRoot
while(-not $mockingPath) {
    $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
    $currentPath = Split-Path -Path $currentPath -Parent
}
. ($mockingPath | Select-Object -First 1).FullName

Describe 'Get-AzStaticWebAppBuildFunctionAppSetting' {
    It 'List' {
      # NOTE: This API is not allowed when using user provided functions.
      $settingList = Get-AzStaticWebAppBuildFunctionAppSetting -ResourceGroupName $env.resourceGroup -Name $env.staticweb01 -EnvironmentName 'default'
      $settingList.Count | Should -BeGreaterOrEqual 1
    }
}
