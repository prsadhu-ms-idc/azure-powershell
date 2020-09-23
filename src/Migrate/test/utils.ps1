function RandomString([bool]$allChars, [int32]$len) {
    if ($allChars) {
        return -join ((33..126) | Get-Random -Count $len | % {[char]$_})
    } else {
        return -join ((48..57) + (97..122) | Get-Random -Count $len | % {[char]$_})
    }
}
$env = @{}
function setupEnv() {
    # Preload subscriptionId and tenant from context, which will be used in test
    # as default. You could change them if needed.
    $env.SubscriptionId = (Get-AzContext).Subscription.Id
    $env.Tenant = (Get-AzContext).Tenant.Id
    # For any resources you created for test, you should add it to $env here.
    $env.srsSubscriptionId = "7c943c1b-5122-4097-90c8-861411bdd574"
    $env.srsTenant = "72f988bf-86f1-41af-91ab-2d7cd011db47"
    $env.srsResourceGroup = "azmigratepwshtestasr13072020"
    $env.srsProjectName = "AzMigrateTestProjectPWSH"
    $env.srsMachineName = "bcdr-vcenter-fareast-corp-micro-cfcc5a24-a40e-56b9-a6af-e206c9ca4f93_50063baa-9806-d6d6-7e09-c0ae87309b4f"
    $env.srsMachineId = "/Subscriptions/7c943c1b-5122-4097-90c8-861411bdd574/resourceGroups/azmigratepwshtestasr13072020/providers/Microsoft.RecoveryServices/vaults/AzMigrateTestProjectPWSH02aarsvault/replicationFabrics/AzMigratePWSHTc8d1replicationfabric/replicationProtectionContainers/AzMigratePWSHTc8d1replicationcontainer/replicationMigrationItems/bcdr-vcenter-fareast-corp-micro-cfcc5a24-a40e-56b9-a6af-e206c9ca4f93_50063baa-9806-d6d6-7e09-c0ae87309b4f"
    $env.srsTestNetworkId = "/subscriptions/7c943c1b-5122-4097-90c8-861411bdd574/resourceGroups/AzMigratePWSHtargetRG/providers/Microsoft.Network/virtualNetworks/AzMigrateTargetNetwork"
    $env.srsJobId = "/Subscriptions/7c943c1b-5122-4097-90c8-861411bdd574/resourceGroups/azmigratepwshtestasr13072020/providers/Microsoft.RecoveryServices/vaults/AzMigrateTestProjectPWSH02aarsvault/replicationJobs/997e2a92-5afe-49c7-a81a-89660aec9b7b"
    $env.srsJobName = "997e2a92-5afe-49c7-a81a-89660aec9b7b"
    $env.srsProjectId = "/subscriptions/7c943c1b-5122-4097-90c8-861411bdd574/resourceGroups/azmigratepwshtestasr13072020/providers/Microsoft.Migrate/MigrateProjects/AzMigrateTestProjectPWSH"
    $env.srsResourceGroupId = "/subscriptions/7c943c1b-5122-4097-90c8-861411bdd574/resourceGroups/azmigratepwshtestasr13072020"
    $env.srsVaultName = "AzMigrateTestProjectPWSH02aarsvault"
    $env.srsProtectionContainerName = "AzMigratePWSHTc8d1replicationcontainer"
    $env.srsFabricName = "AzMigratePWSHTc8d1replicationfabric"
    $env.srsPolicyName = "migrateAzMigratePWSHTc8d1sitepolicy"
    $env.srsMappingName = "containermapping"
    $env.srsProviderName = "AzMigratePWSHTc8d1dra"
    $env.srsTestPolicy = "samplePolicyabc123"
    

    $env.migSubscriptionId = "31be0ff4-c932-4cb3-8efc-efa411d79280"
    $env.migResourceGroup = "BugBashAVSVMware"
    $env.migProjectName = "BugBashAVSVMware"
    $env.migSolutionName = "Servers-Migration-ServerMigration"
    $env.migSiteName = "BBVMwareAVScbbcsite"
    $env.migVMwareMachineName = "10-150-8-52-b090bef3-b733-5e34-bc8f-eb6f2701432a_50098b08-5701-4c58-f6ad-1daf127a8ed9"
    $env.migRunAsAccountName = "b090bef3-b733-5e34-bc8f-eb6f2701432a"

    $envFile = 'env.json'
    if ($TestMode -eq 'live') {
        $envFile = 'localEnv.json'
    }
    set-content -Path (Join-Path $PSScriptRoot $envFile) -Value (ConvertTo-Json $env)
}
function cleanupEnv() {
    # Clean resources you create for testing
}

