namespace Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110
{
    using static Microsoft.Azure.PowerShell.Cmdlets.Migrate.Runtime.Extensions;

    /// <summary>Policy update properties.</summary>
    public partial class UpdatePolicyInputProperties :
        Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IUpdatePolicyInputProperties,
        Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IUpdatePolicyInputPropertiesInternal
    {

        /// <summary>Internal Acessors for ReplicationProviderSetting</summary>
        Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IPolicyProviderSpecificInput Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IUpdatePolicyInputPropertiesInternal.ReplicationProviderSetting { get => (this._replicationProviderSetting = this._replicationProviderSetting ?? new Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.PolicyProviderSpecificInput()); set { {_replicationProviderSetting = value;} } }

        /// <summary>Backing field for <see cref="ReplicationProviderSetting" /> property.</summary>
        private Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IPolicyProviderSpecificInput _replicationProviderSetting;

        /// <summary>The ReplicationProviderSettings.</summary>
        [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Origin(Microsoft.Azure.PowerShell.Cmdlets.Migrate.PropertyOrigin.Owned)]
        internal Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IPolicyProviderSpecificInput ReplicationProviderSetting { get => (this._replicationProviderSetting = this._replicationProviderSetting ?? new Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.PolicyProviderSpecificInput()); set => this._replicationProviderSetting = value; }

        /// <summary>The class type.</summary>
        [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Origin(Microsoft.Azure.PowerShell.Cmdlets.Migrate.PropertyOrigin.Inlined)]
        public string ReplicationProviderSettingInstanceType { get => ((Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IPolicyProviderSpecificInputInternal)ReplicationProviderSetting).InstanceType; set => ((Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IPolicyProviderSpecificInputInternal)ReplicationProviderSetting).InstanceType = value; }

        /// <summary>Creates an new <see cref="UpdatePolicyInputProperties" /> instance.</summary>
        public UpdatePolicyInputProperties()
        {

        }
    }
    /// Policy update properties.
    public partial interface IUpdatePolicyInputProperties :
        Microsoft.Azure.PowerShell.Cmdlets.Migrate.Runtime.IJsonSerializable
    {
        /// <summary>The class type.</summary>
        [Microsoft.Azure.PowerShell.Cmdlets.Migrate.Runtime.Info(
        Required = false,
        ReadOnly = false,
        Description = @"The class type.",
        SerializedName = @"instanceType",
        PossibleTypes = new [] { typeof(string) })]
        string ReplicationProviderSettingInstanceType { get; set; }

    }
    /// Policy update properties.
    internal partial interface IUpdatePolicyInputPropertiesInternal

    {
        /// <summary>The ReplicationProviderSettings.</summary>
        Microsoft.Azure.PowerShell.Cmdlets.Migrate.Models.Api20180110.IPolicyProviderSpecificInput ReplicationProviderSetting { get; set; }
        /// <summary>The class type.</summary>
        string ReplicationProviderSettingInstanceType { get; set; }

    }
}