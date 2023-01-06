
# Azure Administrator Cheatsheet

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


#### Create a Storage Account
Create in Azure Software Development Kit SDK or Portal `Storage Account -> Share Access signature`.

Create Storage Account `Search -> Storage Accounts`, provide name, location, redundancy 

Create File Share in a Storage Account `$StorageAccount` 

Setup File Sync `Azure File Sync -> Create` - 

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
Assign roles
`Management Groups -> Access Control (IAM) -> Add -> Search <role keyword> ->  + Select members`



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


## Powershell

Always update the Powershell - older versions are very unsafe, if possible remove old powershell. See [[Useful_Powershell]] and [[Basic_Powershell]] repectively. [[Microsoft-Visual-Studios]] requires `Connect-AzAccount`
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
