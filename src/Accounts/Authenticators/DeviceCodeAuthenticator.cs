// ----------------------------------------------------------------------------------
//
// Copyright Microsoft Corporation
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ----------------------------------------------------------------------------------

using System;
using System.Collections.Concurrent;
using System.Runtime.CompilerServices;
using System.Threading;
using System.Threading.Tasks;

using Azure.Core;
using Azure.Identity;

using Hyak.Common;
using Microsoft.Azure.Commands.Common.Authentication;
using Microsoft.Azure.Commands.Common.Authentication.Abstractions;
using Microsoft.Azure.Commands.ResourceManager.Common;
using Microsoft.Azure.Management.Internal.ResourceManager.Version2018_05_01.Models;
using Microsoft.Azure.Management.WebSites.Version2016_09_01.Models;
//using Microsoft.Identity.Client;

namespace Microsoft.Azure.PowerShell.Authenticators
{
    public class DeviceCodeAuthenticator : DelegatingAuthenticator
    {
        //private DeviceCodeCredential DeviceCodeCredential { get; set; }
        //private AuthenticationRecord AuthenticationRecord { get; set; }

        private bool EnablePersistenceCache { get; set; }

        private ConcurrentDictionary<string, DeviceCodeCredential> UserCredentialMap = new ConcurrentDictionary<string, DeviceCodeCredential>();

        public DeviceCodeAuthenticator(bool enablePersistentCache = true)
        {
            EnablePersistenceCache = enablePersistentCache;
        }

        public override Task<IAccessToken> Authenticate(AuthenticationParameters parameters, CancellationToken cancellationToken)
        {
            var deviceCodeParameters = parameters as DeviceCodeParameters;
            var authenticationClientFactory = parameters.AuthenticationClientFactory;
            var onPremise = parameters.Environment.OnPremise;
            var resource = parameters.Environment.GetEndpoint(parameters.ResourceId) ?? parameters.ResourceId;
            var scopes = AuthenticationHelpers.GetScope(onPremise, resource);
            var clientId = AuthenticationHelpers.PowerShellClientId;
            var authority = onPremise ?
                                parameters.Environment.ActiveDirectoryAuthority :
                                AuthenticationHelpers.GetAuthority(parameters.Environment, parameters.TenantId);

            TokenRequestContext requestContext = new TokenRequestContext(scopes);

            DeviceCodeCredential codeCredential = null;
            if(!string.IsNullOrEmpty(deviceCodeParameters.UserId))
            {
                if (!UserCredentialMap.TryGetValue(deviceCodeParameters.UserId, out codeCredential))
                {
                    //MsalPublicApplication 
                    DeviceCodeCredentialOptions options = new DeviceCodeCredentialOptions()
                    {
                        ClientId = clientId,
                        TenantId = parameters.TenantId,
                        EnablePersistentCache = EnablePersistenceCache,
                        AllowUnencryptedCache = true,
                        AuthenticationRecord = new AuthenticationRecord(
                            deviceCodeParameters.UserId,
                            authority: null,
                            homeAccountId: null,
                            tenantId: parameters.TenantId,
                            clientId: clientId)
                    };
                    codeCredential = new DeviceCodeCredential(DeviceCodeFunc, options);
                }
                var tokenTask = codeCredential.GetTokenAsync(requestContext, cancellationToken);
                return MsalAccessToken.GetAccessTokenAsync(tokenTask, parameters.TenantId, deviceCodeParameters.UserId);
            }
            else//first time login
            {
                DeviceCodeCredentialOptions options = new DeviceCodeCredentialOptions()
                {
                    ClientId = clientId,
                    TenantId = parameters.TenantId,
                    EnablePersistentCache = EnablePersistenceCache,
                    AllowUnencryptedCache = true,
                };
                codeCredential = new DeviceCodeCredential(DeviceCodeFunc, options);
                var authTask = codeCredential.AuthenticateAsync(cancellationToken);
                return MsalAccessToken.GetAccessTokenAsync(
                    authTask,
                    () => codeCredential.GetTokenAsync(requestContext, cancellationToken),
                    (AuthenticationRecord record) => { UserCredentialMap[record.Username] = codeCredential ; });
            }

            //TracingAdapter.Information(string.Format("[DeviceCodeAuthenticator] Creating IPublicClientApplication - ClientId: '{0}', Authority: '{1}', UseAdfs: '{2}'", clientId, authority, onPremise));
            //var publicClient = authenticationClientFactory.CreatePublicClient(clientId: clientId, authority: authority, useAdfs: onPremise);
            //TracingAdapter.Information(string.Format("[DeviceCodeAuthenticator] Calling AcquireTokenWithDeviceCode - Scopes: '{0}'", string.Join(",", scopes)));
            //var response = GetResponseAsync(publicClient, scopes, cancellationToken);
            //cancellationToken.ThrowIfCancellationRequested();
            //return AuthenticationResultToken.GetAccessTokenAsync(response);
        }

        private Task DeviceCodeFunc(DeviceCodeInfo info, CancellationToken cancellation)
        {
            WriteWarning(info.Message);
            return Task.CompletedTask;
        }

        //private static async Task<AuthenticationRecord> GetAuthenticationRecordAsync(Task)
        //{

        //}

        //public async Task<AuthenticationResult> GetResponseAsync(IPublicClientApplication client, string[] scopes, CancellationToken cancellationToken)
        //{
        //    return await client.AcquireTokenWithDeviceCode(scopes, deviceCodeResult =>
        //    {
        //        WriteWarning(deviceCodeResult?.Message);
        //        return Task.FromResult(0);
        //    }).ExecuteAsync(cancellationToken);
        //}

        public override bool CanAuthenticate(AuthenticationParameters parameters)
        {
            return (parameters as DeviceCodeParameters) != null;
        }

        private void WriteWarning(string message)
        {
            EventHandler<StreamEventArgs> writeWarningEvent;
            if (AzureSession.Instance.TryGetComponent("WriteWarning", out writeWarningEvent))
            {
                writeWarningEvent(this, new StreamEventArgs() { Message = message });
            }
        }
    }
}
