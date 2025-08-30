# Azure Hacking

This is collection of resources and some explanations as to attacks against Azure  


TIL; Azure AD Connect is Hybrid Cloud an some organisation want the same passwords for account on and off premises. Synchronisation occur between the Cloud and On-Premise where if an attack can reach the server that synchronizes between Azure and Organization credential can be decrypted as that seerver will host mcrypt.dll - located on the server `C:\Program Files\Microsoft Azure AD Sync\Bin\mcrypt.dll`. The keys and encrypted data can be stored with xml in [[MSSQL]]

[VBscrub's blog](https://vbscrub.com/2020/01/14/azure-ad-connect-database-exploit-priv-esc/), references a talk by [Dirk jan](https://www.youtube.com/watch?v=JEIR5oGCwdg), author of [Bloodhound.py](https://github.com/dirkjanm) 

- Mitigations:
	- [MS Connect PTA security](https://docs.microsoft.com/en-us/azure/active-directory/hybrid/how-to-connect-pta-security-deep-dive) 


Adam Chester's Blog on Azure Privilege Escalation [Azure AD Connect for Red Teamers](https://blog.xpnsec.com/azuread-connect-for-redteam/)


#### Alert and Action Group for the Creation of NSGs

Given that [Private Endpoints](https://learn.microsoft.com/en-us/azure/backup/private-endpoints-overview) inside AD require NSG to allow external network connectivity of any kind and an Organisation Private Endpoints are going to be target for data exfiltration.

- Consider an Alert and Action Group for that Alert for creation or modification tof NSGs
- Consider Principle of Least Privilege for NSG and Network controls of Vnets containing Private Endpoints

Consider the bypassability of if compromise the second order chain of exfiltration: 
- VM extracts data from excessive access to private endpoint and then another form of  Data Exfiltration - see: [[Data-Exfiltration-Defined]]


Create Action Groups - collection of notification preferences
`Search -> Alerts -> Action Groups`
- SMS - 5 Minute cooldown  

## Passwords in CLI 

When create containers for Container Registries (Azure Docker Image management) admin-account with username and password can be enabled for an Azure Container Registry.
```bash
# Deployment of Azure container
az container create \
    --resource-group $acrResourceGroup \
    --name $name \
    --image $ACR_NAME.azurecr.io/$imageName:$version \
    --registry-login-server $ACR_NAME.azurecr.io \
    --ip-address Public \
    --location $region \
    --registry-username $adminUsername \
    --registry-password $adminPassword 
```

Remediation: Azure service principals are the recommended authentication method providing granular access to container images in Azure Container Registry
## References

[Private endpoints overview - Azure Backup | Microsoft Learn](https://learn.microsoft.com/en-us/azure/backup/private-endpoints-overview)