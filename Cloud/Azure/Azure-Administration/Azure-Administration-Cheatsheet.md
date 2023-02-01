
# Azure Administration Cheatsheet

- Access the portal at https://portal.azure.com/ -  great for performing single tasks
- Cloud Shell on the `>_` Icon; Temporary Host - per-session, per-user basis
	- Has Requirements to use! - `Show Advanced Settings -> provide require fields -> Create Storage`

## Resources

Azure Resource Manager provides a consistent management layer to perform tasks through Azure PowerShell, Azure CLI, Azure portal, REST API, and client SDKs.

#### Create Resources

Create a Disk
`Search: Disk -> Create- > Basics -> Encryption -> Networking -> Advanced -> Tags -> Review + create` Considerations:
- SKUs
- Size, IOPs and cost
- Tags

Wait for deployment, `Go to resource` 

##### Create a Resource Group

`Resource Groups -> Create` - Add tags for QoL 

#### Administrating a Resource

`Resources -> Resource Group -> Deployments -> $DeploymentName 

###### Administrating a Resource Group

`Resource Groups -> $ResourceGroup -> Settings` 
- Deployments - Redeploy, delete
- Security - Microsoft Defender for the Cloud
- Policies - Assign Policies Initiatives
- Properties - Copy and paste Properties
- Locks - Apply locks on resources

#### Moving Resources

Moving Resources - there are end cases - [see Documentation for more]([Move resources to a new subscription or resource group - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-resource-group-and-subscription)):
-   If you're using Azure Stack Hub, you can't move resources between groups.
-   [App Services move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/app-service-move-limitations)
-   [Azure DevOps Services move guidance](https://learn.microsoft.com/en-us/azure/devops/organizations/billing/change-azure-subscription?toc=/azure/azure-resource-manager/toc.json)
-   [Classic deployment model move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/classic-model-move-limitations) - Classic Compute, Classic Storage, Classic Virtual Networks, and Cloud Services
-   [Networking move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/networking-move-limitations)
-   [Recovery Services move guidance](https://learn.microsoft.com/en-us/azure/backup/backup-azure-move-recovery-services-vault?toc=/azure/azure-resource-manager/toc.json)
-   [Virtual Machines move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
-   To move an Azure subscription to a new management group, see [Move subscriptions](https://learn.microsoft.com/en-us/azure/governance/management-groups/manage#move-subscriptions).

[ResourcesOperationsExtensions.MoveResources Method (Microsoft.Azure.Management.ResourceManager) - Azure for .NET Developers | Microsoft Learn](https://learn.microsoft.com/en-us/dotnet/api/microsoft.azure.management.resourcemanager.resourcesoperationsextensions.moveresources?view=azure-dotnet)

`Resource Groups -> $Src -> Tick $Resource -> Move -> Move to another resource group`

## ARM & Bicep Templates

Upload, Download and Modify a Template
`Resources -> Resource Group -> Deployments -> $DeploymentName -> Template` 
- Download and Input for uploading

Create a Custom Template
`Search "Custom template" -> Deploy Custom Template -> Build your own template in the editor`
- `Edit Template`
- `Edit Parameters` - file named parameters 
- `Load file` to upload - file named template
- `Project, Instance details` - can be modified 

## Storage Accounts

Create in Azure Software Development Kit SDK or Portal `Storage Account -> Share Access signature`.

Create Storage Account `Search -> Storage Accounts`, provide name, location, redundancy 

Configure Azure Storage Encryption:
`Storage accounts -> $storage_accounts -> Encryption`

Create a Azure Files Share
`Storage Account -> $storage_account -> File Shares`
- open port 445 - check firewall
- enable - `Secure tranfer required`

File mounting can be done on-demand with the `mount` command or on-boot (persistent) by creating an entry in /etc/fstab.


Setup File Sync `Azure File Sync -> Create` - Marketplace - not default, but covered in AZ 104

Create file share snapshots
`Storage Account -> $storage_account -> File Shares -> $file_share -> Snapshots

Azure File Sync agent:
```powershell
Microsoft.StorageSync
```

Deploying a Azure File Sync:
1. Deploy Storage Sync Services
2. Prepare Windwos Server(s)
3. Install Azure File Sync agent
4. Register Windows Server(s)

Create Container for Blob Storage
`Azure Storage accounts -> + Container -> Name and Change "Public Access Level"`

Use Azure Blob Storage lifecycle management policy rules to:
`Storage Account -> $storage_account -> Lifecycle Management`
- Rule-based run scheduling
- Rule-based condition to containers or a subset of blobs
- Delete blobs 
- Transition Storage tier 

Create a Stored Access Policy for a Container
`Storage Accounts -> $storage_account -> Container -> Access Policy`

AZcopy is installed by default on the CloudShell
```powershell
azcopy copy [source] [destination] [flags]
azcopy copy $localpath $remotepath # upload
azcopy copy $remotepath $localpath # download
azcopy login # create URI to login
# Supports wildcard include and exclude
azcopy copy [source] [destination] --include
azcopy copy [source] [destination] --exclude 
```

URL for Azure remote container: `Home -> Storage Accounts -> $ContainerName -> Properties` - must be globally unique

Create a SAS:
`Storage Accounts -> $storage_account -> search SAS`configure and `Generate SAS and connection string`. Used for:
- Connection strings
- SAS Token
- Blob service SAS URL
- Queue service SAS URL
- Table service SAS URL

Con be done from `$resource`

URI Format with parametres explained
```powershell
https://myaccount.blob.core.windows.net/$containerName/file.txt
?sv= # Storage services version
&ss # Storage service
&sip # IP range
&spr # Protocol
&st # Start Time
&se # Expiration Time
&sr # Storage Resource - b for blob, q for queue 
&sp # permissions  r, wr
&sig # SHA256 hash - the signature
```

Storage access
**Container service** - `//`**`mystorageaccount`**`.blob.core.windows.net`
**Table service** - `//`**`mystorageaccount`**`.table.core.windows.net` 
**Queue service** - `//`**`mystorageaccount`**`.queue.core.windows.net`
**File service** - `//`**`mystorageaccount`**`.file.core.windows.net`
**Blob Access** - `//`**`mystorageaccount`**`.blob.core.windows.net/`**`mycontainer`**`/`**`myblob`**.

Configure Custom Domains - Either:
- Direct mapping - create a `CNAME` record
- Intermediary domain mapping (when domain is already in use) - prepend `asverify` to subdomain it permit Azure to recognize your custom domain thereby using a intermediary domain to validate the domain.

#### Secure Storage endpoints

`Storage Accounts -> $storage_account -> Networking Firewalls and virtual networks`; restrict access:
- Enabled from all networks
- Enabled from selected virtual networks and IP address
- Disabled

## Management Groups - Azure Policies

Policy Creation:
1. Policy Defintions -  [list of built-in definitions](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies)
2. Initiative definition - [Azure Policy initiative definition structure](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/initiative-definition-structure) and  [list of built-in initiatives](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-initiatives)
3. Scope the initiative definition 
4. Detirmine Compliance

Policy definitions can also be imported into Azure Policy from [GitHub](https://github.com/Azure/azure-policy/tree/master/samples)
Initiative Definitions are good at ANY scale of organization, do not skip.

To view compliance across a scope:
`Overview -> Policies - Compliance` 

**Policy Assignment takes 10-30 minutes - Blueprints are useful**

Polices Management:
`Policies -> Compliance` - Assign polices, initatives
`Policies -> Remediation` - Policies to remediate and Remediation tasks
Policies Authoring:
`Policies -> Definitions` - Policies and Initiative definitions - export definitions
`Policies -> Assignments` - Assign Policies and Initiatives
`Policies -> Examptions` - Scope, Category - To create a new exemption - go to `assignment` or the `compliance`.

Apply a policy by tag
`Policies -> Definitions -> Category -> Tags -> Require a tag.. -> Assign -> Scop -> subscription and resource group`

Assignment of a policy - and various assignment configuration and management:
`Policies -> Assignments -> Assignment Name's ellipsis -> Right click` - This menu will show: Edit, delete, duplicate assignment; view definition and compliance; create excemptions.

Inheritance is made in the: 
`Policies -> Assignments -> Assign`

## Cost management

Management
`Search Cost Management -> Cost Management`
From here for:
`Cost Alerts`,  `Cost Analysis`, `Budgets`

## RBAC and Role Management

Implement management groups 
`Search Management groups -> Management groups`
Setup Azure AD permissions for Implementing Management Groups
`Search Azure ->  Azure Active Directory -> Properties -> Access management for Azure Resources` - Refresh in `Management Groups`
From `Management Groups` - Requires Management group ID and Display name
Create a `Management Group`
`Search Management groups -> Management groups -> <insert Management group ID and Display name> 
Add a management group to a subscription
`Search Management groups -> Management groups -> $Management_group -> Subscriptions`  - Subscription ID is in `Overview`

Custom RBAC role creation:
`Upload a $customRole.json file`  - replace fields reqiure prior to upload!
`Open CloudCLI` to upload
```powershell
New-AzRoleDefinition -InputFile $file
```

Assign roles **at scope** - `Subscription,Resource group, Resource`
`Management Groups -> Access Control (IAM) -> Add -> Search <role keyword> ->  + Select members`
Assign can be done via Resource Group of Admin Scoping in fields
`Resource Groups -> Access Control (IAM) -> Add (role, co-adminstrator, custom) role -> Search`
`Remove` to remove!
`Activty Log` to find all role (de-)assignments

## Azure AD 

Manage Tenants
`Search Azure AD -> Manage tenants`
Create a Tenant
`All Services -> Azure AD -> Manage Tenants -> Create`
Configure Tenant
`Create a Tenant -> Configuration -> Name -> Review and CReate -> Create`

License Management
`Search Azure AD -> Azure AD -> Licenses`
To assign a license
`All Products -> Assign`

Customize Azure AD organization branding
`Search Azure AD -> Azure AD -> Azure Active Directory -> Manage -> Company Branding -> Configure`

#### Create a Users, Groups and Manage Them  

Remember that you filter be tenant!

Azure AD 
`Overview -> Users -> Create`

Creation User
`Search Users -> New Users -> New user`
Invite User - For Temporary Guest users use: `Azure AD B2B`
`Search Users -> New Users -> Invite`
Configure guest users:
- add to `Groups`
- Access to apps `Manage -> Enterprise applications -> Docusign` (or whatever Digital signing software) 

Edit User settings
`Search Azure AD -> Azure AD -> User Settings`
User Management
`Search Azure AD -> Azure AD -> Users`
Create/Invite
`Search Azure AD -> Azure AD -> Users -> New Users -> New user`
Assign Roles
``Search Azure AD -> Users -> Assigned Roles`
Enable Account
`Users -> $username -> Settings -> [Tick/Untick] Account enabled`
Guest user can be added with Creating and then Inviting
`Search Azure AD -> Azure AD -> Users -> New Users -> New user`
`Overview -> Users -> New User -> Invite External`
- remember to add to groups and anything else.

Bulk additions, deletion and invitation use a .cvs with SOME of the fields
Name | Username | Initial Password | Block Sign in | Firstname | Lastname 
--- | --- | --- | ---
John Doe | jdoe | password123! | No | John | Doe

Bulk Operations
`Search -> Users -> Bulk operations -> Create/invite/delete` 

Manage Groups
`Search Groups - > Groups -> New group/Download groups
Create Group
`Search Azure AD -> Groups -> New Group`
- `Membership type* -> Assign/Dynamic(User/Device)`
To make a dynamic group dynamic:
- `Add Dynamic Query Rule-> Select a Property, Operator and Value`
Deleted Groups
`Search Groups - > Groups -> Deleted groups`

#### Authenication and Authorization

Configure SSPR
`Azure Active Directory -> Passwords -> Properties - SSPR enabled (None/Selectec/All)`
Futher configuration of SSPR
`Authenicatin Mehtods, Registration, Notification and Customise Helpdesk link`

Enabling various types of MFA per user, bulk assignment is in the per-user MFA window 
`Users -> Per-user MFA`
Additional options - Where the important stuff is
`Per-Users MFA -> Server Settings` (Not obvious - displays as `users server settings`)
Remember to `enforce`! 

Password reset
`Overview -> Password Reset`
Properties - Self Service password resets
Authenication Methods
Registation - Require users to register when signing in
Notifiications - Notification when and on resets
Customization - Customize Helpdesk link
On-Premise Integration - As stated
Administrator Policy - Admin password reset policy.

## Azure Virtual Networking

Create Virtual Networks and Manage
`Search "Virtual Networks" -> Virtual Networks (-> Create)`
- Azure Fiewall, Bastion and other require a subnet!

Create Subnets
`Search "Virtual Networks" -> Virtual Networks -> $VN -> Subnets -> + Subnets/Gateway subnet`
Remember to: plan IP addresses - they can be `private` or  `public`, `static` or `dynamic` and Azure reserves five IP addresses:
- 192.168.1.0 - Identifier for the Virtual Network
- 192.168.1.1 - Azure Default Gateway
- 192.168.1.2 - Azure DNS address 
- 192.168.1.3 - Azure DNS address
- 192.168.1.255 - virtual network broadcast address

Consideration :
- Service requirements
- Avaliability requirements - static IPs for DNS and DCs, TLS/SSL certs linked to an IP
- Network virtual appliances
- Service Endpoints
- Network Security Groups
- Private links
- VMs do not manage there IPs

Create and manage public IPs
`Search "Public IP Address -> Pulic IP addresses" ` then with `+ Create` provide the options `IP version, SKU, Tier, Name, Assignment, Routing`


#### NSG Workflow

Overview of NSGs
`Search -> Network Security Groups`

Create an NSG
`Search -> Network Security Groups -> + Create` - Source, Destination, Service, Priority
Associate NSG with a Subnet or NSG
`$NSG -> Settings -> Network Interfaces, Subnets`

Add RDP to a VM Allowing and Disallowing the connection with NSG
`$VM -> Connect -> Configure if required then goto -> Networking -> Either:`
- `Inbound port rules Tab -> add inbound port rule -> Configure`  
- `Outbound port rules Tab -> add outbound port rule -> Configure`

####  Azure DNS

Create DNS zones
`Search -> DNS zones`

To delegate your domain to Azure DNS:
1.  Identify your DNS name server - for each zone Azure DNS allocated DNS server from each pool and authoritative `NS` (or _Name server_) records in your DNS zone.
	1. Find with Azure Portal
2.  Update your parent domain  - each registar has their own DNS management tools
	1.  Go to your registrar's (third-party domain registrar, company where domain was registered) DNS management page.
	2.  Find the existing `NS` records for your parent domain.
	3.  Replace the existing `NS` records with the `NS` records created for your domain by Azure DNS.
		-  Remember to include a trailing period `..` at the end of the address
		- Always copy **all** DNS name server `NS` records for your domain to the parent domain 
3.  Delegate subdomains (optional)
	1.  Go to the parent DNS zone for your domain in the Azure portal.
	2.  Find the existing `NS` records for your parent domain.
	3.  Create new `NS` records for your child DNS zone (subdomain).

Create record set or Child zone
`Search -> DNS zones -> Search $DNSzone -> + Record Set | + Child Zone 

Common pattern - name resolution for multiple networks, where one is focused on registration and the other resolution.
`Vnet1 = Registration <-> Azure Private DNS zone records <-> Vnet2 = Resolution`



## AzCopy 

AZcopy is installed by default on the CloudShell
```powershell
azcopy copy $localpath $remotepath # upload
azcopy copy $remotepath $localpath # download
azcopy login # create URI to login
```

URL for Azure remote container: `Home -> Storage Accounts -> $ContainerName -> Properties`

Create a SAS for container `Home -> Storage Accounts -> $ContainerName -> Shared Access Signature` configure and `Generate SAS and connection string`. It will generate connections trings for: 
- Connection strings
- SAS Token
- Blob service SAS URL
- Queue service SAS URL
- Take service SAS URL

## Azure CLI

Variables in Bash `Variable` and in Powershell `$Variable`; `export $v` and `set $v` for current session environment variable creation.

```powershell
-Az # Azure Module ships backwards compatible with -AzureRM 
az --version
# Connect to Azure
az login
az $command --help
# Find Azure stuff related to string, command
az find $word
az find "az vm" 
```

Create and Administrate a Resource Group
```powershell
az group create --name $name --location $location
# List all groups and table format - more concise
az group list
az group list --output table 
# Query 
$rgName = "ResourceGroupName"
az group list --query "[?name == '$rgName']"
```

Create and Administrate a VM
```powershell
New-AzVm # Create a new VM inside your Azure Subscription
# Use the az module to restart a machine 
az vm restart -g $ResourceGroup -n $VmName
```

Create a Resource Group
```powershell
$templateFile="{provide-the-path-to-the-template-file}"
az deployment group create \
  --name blanktemplate \
  --resource-group myResourceGroup \
  --template-file $templateFile \
  --parameters $x=$y
```

Deploy Resource Group with Template
```powershell
templateFile="{provide-the-path-to-the-template-file}"
az deployment group create \
  --name blanktemplate \
  --resource-group myResourceGroup \
  --template-file $templateFile \
  --parameters $x=$y
```

Create and Adminstrate a Service Plan
```powershell
# Create a Service Plan
az appservice plan create --name $AZURE_APP_PLAN --resource-group $RESOURCE_GROUP --location $AZURE_REGION --sku FREE
# Verify 
az appservice plan list --output table
```

Create and Administrate a Webapp
```powershell
az webapp create --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --plan $AZURE_APP_PLAN
# Verify
az webapp list --output table
curl $AZURE_WEB_APP.azurewebsites.net
```

Deploy code from Github
```powershell
az webapp deployment source config --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration
```

Create Azure AD objects 
```powershell
# Create a new user
az ad user create
# Delete a user
az ad user delete
```

Azure RBAC with az role, use [az role definition list](https://learn.microsoft.com/en-us/cli/azure/role/definition#az-role-definition-list).
```powershell
az role definition list
# by name like "Contributor"
az role definition list --name {roleName}
# name and description of all available role definition
az role definition list --output json --query '[].{roleName:roleName, description:description}'
# list all builtin roles
az role definition list --custom-role-only false --output json --query '[].{roleName:roleName, description:description, roleType:roleType}'
# output to json the Contributor Actions, NotActions
az role definition list --name "Contributor" --output json --query '[].{actions:permissions[0].actions, notActions:permissions[0].notActions}'

```
[List Azure role definitions - Azure RBAC | Microsoft Learn](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-definitions-list)

Create Storage Account
```powershell
az storage account create --name $storageName --access-tier hot --kind StorageV2 --resource-group $resourceGroup
```

Obtain connection string to storage account
```powershell
az storage account show-connection-string --name $storageName
# Copy the AccountKey=$base64string ; remember to include the ==
```

Create a container
```powershell
az storage container create --name $containerName --account-name $storageName 
--public-access off
```

Upload to a blob
```powershell
az storage blob upload-batch --source sas --destination $containerName --acount-name $storageName --pattern *.ext # wildcard extensions!
```

Create a Stored Access Policy for a Container
```powershell
# perm can be : <(a)dd, (c)reate, (d)elete, (l)ist, (r)ead, or (w)rite>
az storage container policy create -name $polcyName --container-name $container --start $startTime-UTC --expiry $expiryTime-UTC --permissions $perm --account-key $storageAccountKey --account $storageName
```


## Powershell

Always update the Powershell - older versions are very unsafe, if possible remove old powershell. See [[Useful_Powershell]] and [[Basic_Powershell]] repectively. [[Microsoft-Visual-Studios]] requires `Connect-AzAccount`

```powershell
Add-AzAccount # Login to Azure
Get-AzLocation | select Location
```

```powershell
$PSVersionTable.PSVersion
pwsh -ver
dotnet tool install --global PowerShell # Install
.\yourScript.ps1 "Parameters"
import yourScript.ps1
$adminCredential = Get-Credential # See useful_powershell for the Red-Team way
# Show EVERYTHING in a directory
ls -hidden 
# Open builtin editor
# Right Click or [Ctrl +] S (Save) Q (Quit)
code ".hiddenyourScript.ps1"  
Get-Help -Name $cmdlet -Detailed
# Change execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# Install and update Az module to current user 
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery
Update-Module -Name Az

```


```powershell
# Useful commands
Connect-AzAccount
# Set a default Subscription 
$context = Get-AzSubscription -SubscriptionId {Your subscription ID}
Set-AzContext $context

Set-AzContext -Subscription '00000000-0000-0000-0000-000000000000'
# Consider piping with  `| Format-Table`
Get-AzResourceGroup
# Create a resource group 
New-AzResourceGroup -Name <name> -Location <location>
# Verify Resources
Get-AzResource
Get-AzResource -ResourceGroupName $rgName
```

General Azure aaS Commands for Data
```powershell
Get-AzVMSize # VM sizes 
```

Disk creation, retrieval and updating in powershell 
```powershell
# Consider Naming Conventions
$diskname = ""
# Get the resource group
$rgName = Get-AzResourceGroup -Name
# Create a Diskconfiguration for a NewAzDisk
$diskConfig = New-AzDiskConfig -Location $location -CreateOption Empty -DiskSizeGB 32 -Sku $Skuname
# Make a new disk with the variables created above - consider naming convention
NewAzDisk -ResourceGroupName $rgName -DiskName $diskname -Disk $diskConfig  
# Retrieve a Azure Disk
Get-AzDisk -ResourceGroupName $rgName -Name $diskname
# Retrieve Sku
(Get-AzDisk -ResourceGroupName $rgName -Name $diskname).Sku
# Update 
New-AzDiskUpdateConfig -DiskSizeGB 64 -Sku Premium_LRS | Update-AzDisk -ResourceGroupName $rgName -DiskName $diskname
```

Resource Group Creation and Administration
```powershell
New-AzResourceGroup `
  -Name {name of your resource group} `
  -Location "{location}"
```

Resource Group Deployment with Template
```powershell
$templateFile = "{provide-the-path-to-the-template-file}"
New-AzResourceGroupDeployment `
  -Name blanktemplate `
  -ResourceGroupName myResourceGroup `
  -TemplateFile $templateFile
```

VM Creation and Adminstration
```powershell
# Get the resource group
$rgName = Get-AzResourceGroup -Name
# Create VM
New-AzVm -ResourceGroupName $rgName -Name $machineName -Credential (Get-Credential) -Location $location -Image $image -OpenPorts $sshOrrdp
# Adminstration Commands
Remove
Start-AzVM
Stop-AzVM
Restart-AzVM
Update-AzVM

Get-AzResource -ResourceGroupName $vm.ResourceGroupName | Format-Table
# Get-VM for object usage
$vm = Get-AzVM -Name $machineName -ResourceGroupName $rgName
# Query OS Disk info
$vm.StorageProfile.OsDisk

# Update a property
$vm.HardwareProfile.vmSize = "Standard_DS3_v2"
Update-AzVM -Name $machineName -ResourceGroupName $rgName
# Stop VM
Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
# Delete VM
Remove-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
# Delete the Network Interface
$vm | Remove-AzNetworkInterface –Force
# Delete manage Os disks and storage account
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force
# Delete The Virtual Network
Get-AzVirtualNetwork -ResourceGroupName $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
# Delete the Security Group
Get-AzNetworkSecurityGroup -ResourceGroupName $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
# Delete Public IP
Get-AzPublicIpAddress -ResourceGroupName $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force
```

Requires [[Microsoft-Visual-Studios]] 
```powershell
Get-AzSubscription
$context = Get-AzSubscription -SubscriptionId {Your subscription ID}
Set-AzContext $context
$rgName = "ResourceGroupName"
Set-AzDefault -ResourceGroupName 
# Deploy the template, also for updating the same deployment
$templateFile="azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="NamingConventionsApply-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -$ConsiderParameters
# Go to: Resource Group -> $rgName -> Overview -> "Deployments x Succeeded" -> Select $template
```

Create Azure AD objects 
```powershell
# Create a new user
New-AzureADUser
# Remove a user
Remove-AzADUser 
```

Bulk Create Azure AD objects :
```powershell
$invitations = import-csv c:\bulkinvite\invitations.csv

$messageInfo = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo

$messageInfo.customizedMessageBody = "Hello. You are invited to the Contoso organization."

foreach ($email in $invitations)
   {New-AzureADMSInvitation `
      -InvitedUserEmailAddress $email.InvitedUserEmailAddress `
      -InvitedUserDisplayName $email.Name `
      -InviteRedirectUrl https://myapps.microsoft.com `
      -InvitedUserMessageInfo $messageInfo `
      -SendInvitationMessage $true
   }
```

Azure RBAC 
```powershell
# List all Azure Roles
Get-AzRoleDefinition | FT Name, Description
# Filter by name and convert to json
Get-AzRoleDefinition <role_name> | ConvertTo-Json
# Get Actions and NotActions Properties, with piped or class dot property
Get-AzRoleDefinition <role_name> | FL Actions, NotActions
(Get-AzRoleDefinition <role_name>).Actions
``` 

Azure Storage Tables
```powershell
# Create new table
New-AzStorageTable -Name $tableName –Context $ctx
# create a object to perform table operations
$storageTable = Get-AzStorageTable –Name $tableName –Context $ctx
# Get the manditory CloudTable, will create a table if non-existent
$cloudTable = $storageTable.CloudTable
# table entries - entityOne/Two are fields 
Add-AzTableRow -table $cloudTable -partitionKey $partitionKey -rowKey ("CA") -property @{"entityOne"="data";"entityTwo"=1}
# Query the table; for specifics use: -columnName "" -value "" -operator $op
Get-AzTableRow -table $cloudTable | ft
# Delete a table
Remove-AzStorageTable –Name $tableName –Context $ctx
```
## Bash

Disk creation, retrieval and updating in Bash
```bash
RGNAME=''
LOCATION=$(az group show --name $RGNAME --query location --out tsv)
DISKNAME=''
az group show --name $RGNAME
az disk create --resource-group $RGNAME --name $DISKNAME --size-gb 32 --sku 'Standard_LRS' 
# Retrieve Disk properties
az disk show --resource-group $RGNAME --name $DISKNAME # --query for specific
# Update 
az disk update --resource-group $RGNAME --name $DISKNAME # --Whatever-changes-by-flag!
```


## References

[Offical Microsoft Material for Az104](https://learn.microsoft.com/)
[John Savill's Microsoft Azure Master Class Part 6 - Networking](https://www.youtube.com/watch?v=K8ePZdLfU7M&t=3511s)
