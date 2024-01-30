# Azure PowerShell Module

[Azure AD deprecation](https://learn.microsoft.com/en-us/powershell/module/azuread/?view=azureadps-2.0) occurred in July 2023 but does not mean that these features or issues will not disappear, therefore authorial I retain all of the previous [[Azure-Administration-Cheatsheet]] scripting - just in case it become HACKABLE - historically PowerShell has long been a massive security issue in and of itself for a very, very long time.

PowerShell Cmdlet Logic
```powershell
Get-Az # Retrieve information
New-Az # Create Azure X
Update-Az # Update Azure X
Add-Az # Add X to Existing Azure Y
Move-Az # Move Az X to Y
Export-Az # Capture to a template
Import-Az # Import config
Remove-Az # Remove..
Select-Az # Select != Get; Choose X
Invoke-Az # Contruct and Perform X
Clear-Az # Clear settable values
Set-Az # Opposite of Clear, Set values
```

[Azure AD deprecation](https://learn.microsoft.com/en-us/powershell/module/azuread/?view=azureadps-2.0): *"Azure AD PowerShell is planned for deprecation. For more details on the deprecation plans, see the [deprecation update](https://techcommunity.microsoft.com/t5/azure-active-directory-identity/azure-ad-change-management-simplified/ba-p/2967456). You can start trying [Microsoft Graph PowerShell](https://learn.microsoft.com/en-us/powershell/microsoftgraph/overview) to interact with Azure AD as you would in Azure AD PowerShell. In addition, Microsoft Graph PowerShell allows you access to all Microsoft Graph APIs and is available on PowerShell 7. For answers to frequent migration queries, see the [migration FAQ](https://learn.microsoft.com/en-us/powershell/azure/active-directory/migration-faq?view=azureadps-2.0)."*

Always update the PowerShell - older versions are very unsafe, if possible remove old PowerShell. See [[PowerShell]] and [[Basic_Powershell]] respectively. [[Microsoft-Visual-Studios]] requires `Connect-AzAccount`

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

Useful commands
```powershell
# Connect to Azure
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
# Test connection to another VM or resource
Test-NetConnection -ComputerName $ip -Port 3389 -InformationLevel 'Detailed'
```

General Azure aaS Commands for Data
```powershell
Get-AzVMSize # VM sizes 
```

Disk creation, retrieval, attachment and updating in powershell 
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
# Add to a VM
Add-AzVMDataDisk -VM $VMname -Name $diskName -CreateOPtion Attach -ManagedDisks
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

Custom Script Extension automatically launch and execute virtual machine customization tasks after initial machine configuration - timesout after 90 minutes
```powershell
Set-AzVmCustomScriptExtension -FileUri https://scriptstore.blob.core.windows.net/scripts/Install_IIS.ps1 -Run "PowerShell.exe" -VmName vmName -ResourceGroupName resourceGroup -Location "location"
```

Desired State Configuration - create specific configuration with scripts 
```powershell
configuration IISInstall # configuration script block
{
   Node "localhost" # Which VMs are configured
   { 
      WindowsFeature IIS # The resourcce block  
      {
         Ensure = "Present" # indicate if Role or Feature
         Name = "Web-Server" 
      }
   }
}
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

NetworkWatcher
```powershell
# Create a new NetworkWatcher
New-AzNetworkWatcher `
  -Name NetworkWatcher_eastus `
  -ResourceGroupName NetworkWatcherRG
```

Retrieve a Network Watcher instance with [Get-AzNetworkWatcher](https://learn.microsoft.com/en-us/powershell/module/az.network/get-aznetworkwatcher)
```powershell
$nw = Get-AzResource `
  | Where {$_.ResourceType -eq "Microsoft.Network/networkWatchers" -and $_.Location -eq "EastUS" }
$networkWatcher = Get-AzNetworkWatcher `
  -Name $nw.Name `
  -ResourceGroupName $nw.ResourceGroupName
```

Retrieve a topology
```powershell
Get-AzNetworkWatcherTopology `
  -NetworkWatcher $networkWatcher `
  -TargetResourceGroupName $rGroup
```

User Defined Route
```
New-AzRouteConfig -Name "StorageRoute" -AddressPrefix "Storage" -NextHopType "VirtualAppliance" -NextHopIpAddress "10.0.100.4"
```

Load Balancer
```powershell;
$Location = $(Get-AzureRmResourceGroup -ResourceGroupName [sandbox resource group name]).Location
# Create a public IP address 
$publicIP = New-AzPublicIpAddress `
  -ResourceGroupName $rGroup `
  -Location $Location `
  -AllocationMethod "Static" `
  -Name "myPublicIP"
# Create Front-end IP
$frontendIP = New-AzLoadBalancerFrontendIpConfig `
  -Name "myFrontEnd" `
  -PublicIpAddress $publicIP
# Create a back-end address pool
$backendPool = New-AzLoadBalancerBackendAddressPoolConfig -Name "myBackEndPool"
# Allow Load Balancer to monitor backend pool
$probe = New-AzLoadBalancerProbeConfig `
  -Name "myHealthProbe" `
  -Protocol http `
  -Port 80 `
  -IntervalInSeconds 5 `
  -ProbeCount 2 `
  -RequestPath "/"
# Create a rule for the Load Balancer
$lbrule = New-AzLoadBalancerRuleConfig `
  -Name "myLoadBalancerRule" `
  -FrontendIpConfiguration $frontendIP `
  -BackendAddressPool $backendPool `
  -Protocol Tcp `
  -FrontendPort 80 `
  -BackendPort 80 `
  -Probe $probe
# Create Load Balancer
$lb = New-AzLoadBalancer `
  -ResourceGroupName $rGroup `
  -Name 'MyLoadBalancer' `
  -Location $Location `
  -FrontendIpConfiguration $frontendIP `
  -BackendAddressPool $backendPool `
  -Probe $probe `
  -LoadBalancingRule $lbrule
# Connect the VMs to the back-end pool 
$nic1 = Get-AzNetworkInterface -ResourceGroupName $rGroup -Name "webNic1"
$nic2 = Get-AzNetworkInterface -ResourceGroupName $rGroup -Name "webNic2"
# Update the network interfaces 
$nic1.IpConfigurations[0].LoadBalancerBackendAddressPools = $backendPool
$nic2.IpConfigurations[0].LoadBalancerBackendAddressPools = $backendPool

Set-AzNetworkInterface -NetworkInterface $nic1 -AsJob
Set-AzNetworkInterface -NetworkInterface $nic2 -AsJob
# Get pulic IP of the Load Balancer and URL for website
Write-Host http://$($(Get-AzPublicIPAddress `
  -ResourceGroupName [sandbox resource group name] `
  -Name "myPublicIP").IpAddress)
```

Source IP affininty load balancer
```powershell
$lb = Get-AzLoadBalancer -Name MyLb -ResourceGroupName MyResourceGroup
$lb.LoadBalancingRules[0].LoadDistribution = 'sourceIp'
Set-AzLoadBalancer -LoadBalancer $lb
```

Move a Resource 
```powershell
$vm = Get-AzResource
Move-AzResource 
```

[Azure DNS](https://learn.microsoft.com/en-us/powershell/module/az.dns/new-azdnsrecordset?view=azps-9.4.0)
```powershell
# Config
# New DNS Root record
New-AzDnsRecordConfig
# Add DNS Record 
Add-AzDnsRecordConfig

# Set
Get-AzDnsRecordSet
New-AzDnsRecordSet
Remove-AzDnsRecordSet
Set-AzDnsRecordSet

# Make Application is accessible for Azure DNS
# "A" is IPv4 address
# -name is the Record name: @ Represent the Root domain 
New-AzDnsRecordConfig -Name "@" -RecordType "A" -ZoneName "$newDomainNameHere" -ResourceGroupName $rGroup -DnsRecords (New-AzDnsRecordConfig -IPv4Address "10.10.10.10")
# You need TXT record to verify custom domain
New-AzDnsRecordSet -ZoneName "$newDomainNameHere" -ResourceGroupName $rGroup -Name "@" -RecordType "TXT" -TTL 600 -DnsRecord(New-AzDnsRecordConfig -Value "application.azure.websites.net")

# When IP address changes for custom DNS you must update the "A" record
$RecordSet = Get-AzDnsRecordSet -ResourceGroupName MyResourceGroup -ZoneName myzone.com -Name www -RecordType A
Add-AzDnsRecordConfig -RecordSet $RecordSet -Ipv4Address 172.16.0.0
Add-AzDnsRecordConfig -RecordSet $RecordSet -Ipv4Address 172.31.255.255
Set-AzDnsRecordSet -RecordSet $RecordSet
# These cmdlets can also be piped:
Get-AzDnsRecordSet -ResourceGroupName MyResourceGroup -ZoneName myzone.com -Name www -RecordType A | Add-AzDnsRecordConfig -Ipv4Address 172.16.0.0 | Add-AzDnsRecordConfig -Ipv4Address 172.31.255.255 | Set-AzDnsRecordSet
```
