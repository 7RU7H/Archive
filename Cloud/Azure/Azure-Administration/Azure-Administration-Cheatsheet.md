
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

Create a Resource Group
`Resource Groups -> Create` - Add tags for QoL 

Administrating a Resource
`Resources -> Resource Group -> Deployments -> $DeploymentName 

Administrating a Resource Group
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

## Azure VMs

Create a VM
`Azure services -> Create resource -> Search (resource - Windows Server)`
Provide configurations for Basic, Disks, Networking (**BEWARE** Azure creates default - it is non trivial to change after creation - CHECK! - Address space and Subnets!), Managemnt, Advanced; Next:
1. Create an NSG
2. Create inbound traffic rule 
3. Attached data disks - best practice on App data storage not temp or C:

Connect to a VM via RDP
`Search All Resources -> $name -> Connect -> select RDP`

## Storage Accounts

Create in Azure Software Development Kit SDK or Portal `Storage Account -> Share Access signature`.

Create Storage Account `Search -> Storage Accounts`, provide name, location, redundancy 

Configure Azure Storage Encryption:
`Storage accounts -> $storage_accounts -> EncBootstrap web applications
```bash
# C#
# Install dotnet
wget -q -O - https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh | bash -s -- --version 6.0.404
export PATH="~/.dotnet:$PATH"
echo "export PATH=~/.dotnet:\$PATH" >> ~/.bashrc
# create a ASP.NET Core MVC application
dotnet new mvc --name $webappName
cd $webappName/
dotnet run

# Java - with maven-archetype-webapp template
cd ~
mvn archetype:generate -DgroupId=example.demo -DartifactId=$webappName -DinteractiveMode=false -DarchetypeArtifactId=maven-archetype-webapp -DarchetypeVersion=1.4
cd $webappName
mvn package
# the result will be .war file to be deploy

# Node.js
mkdir $path/$WebApp
cd $WebApp
npm init -y
# start Web App
npm start
# Python - with flask
python3 -m venv venv 
source venv/bin/activate
pip install flask
mkdir $path/$WebApp
cd $WebApp
# Add applications to requirements.txt
pip freeze > requirements.txt
# Test
export FLASK_APP=application.py
flask run
# Adding code to source control with git
git init
git add .
git commit -m "Initial commit"
```

Deploying a WebApp
```bash
# C# 
cd $webappName
# Publish to build and zip to package
dontnet publish -o pub
cd pub
zip -r site.zip *
# Deply with the az cli
az webapp deployment source config-zip \
    --src site.zip \
    --resource-group $rgName \
    --name $appName

# Java
# CLI credentials required
az webapp deployment user set --user-name <username> --password <password>
# WAR deploy
cd $webappName/target
curl -v -X POST -u <username>:<password> https://<your-app-name>.scm.azurewebsites.net/api/wardeploy --data-binary @$webappName.war

# Node.js
export APPNAME=$(az webapp list --query [0].name --output tsv)
export APPRG=$(az webapp list --query [0].resourceGroup --output tsv)
export APPPLAN=$(az appservice plan list --query [0].name --output tsv)
export APPSKU=$(az appservice plan list --query [0].sku.name --output tsv)
export APPLOCATION=$(az appservice plan list --query [0].location --output tsv)

az webapp up --name $APPNAME --resource-group $APPRG --plan $APPPLAN --sku $APPSKU --location "$APPLOCATION"

# Python 
export APPNAME=$(az webapp list --query [0].name --output tsv)
export APPRG=$(az webapp list --query [0].resourceGroup --output tsv)
export APPPLAN=$(az appservice plan list --query [0].name --output tsv)
export APPSKU=$(az appservice plan list --query [0].sku.name --output tsv)
export APPLOCATION=$(az appservice plan list --query [0].location --output tsv)

cd path/$webappName
az webapp up --name $APPNAME --resource-group $APPRG --plan $APPPLAN --sku $APPSKU --location "$APPLOCATION"
```


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

Bootstrap web applications
```bash
# C#
# Install dotnet
wget -q -O - https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh | bash -s -- --version 6.0.404
export PATH="~/.dotnet:$PATH"
echo "export PATH=~/.dotnet:\$PATH" >> ~/.bashrc
# create a ASP.NET Core MVC application
dotnet new mvc --name $webappName
cd $webappName/
dotnet run

# Java - with maven-archetype-webapp template
cd ~
mvn archetype:generate -DgroupId=example.demo -DartifactId=$webappName -DinteractiveMode=false -DarchetypeArtifactId=maven-archetype-webapp -DarchetypeVersion=1.4
cd $webappName
mvn package
# the result will be .war file to be deploy

# Node.js
mkdir $path/$WebApp
cd $WebApp
npm init -y
# start Web App
npm start
# Python - with flask
python3 -m venv venv 
source venv/bin/activate
pip install flask
mkdir $path/$WebApp
cd $WebApp
# Add applications to requirements.txt
pip freeze > requirements.txt
# Test
export FLASK_APP=application.py
flask run
# Adding code to source control with git
git init
git add .
git commit -m "Initial commit"
```

Deploying a WebApp
```bash
# C# 
cd $webappName
# Publish to build and zip to package
dontnet publish -o pub
cd pub
zip -r site.zip *
# Deply with the az cli
az webapp deployment source config-zip \
    --src site.zip \
    --resource-group $rgName \
    --name $appName

# Java
# CLI credentials required
az webapp deployment user set --user-name <username> --password <password>
# WAR deploy
cd $webappName/target
curl -v -X POST -u <username>:<password> https://<your-app-name>.scm.azurewebsites.net/api/wardeploy --data-binary @$webappName.war

# Node.js
export APPNAME=$(az webapp list --query [0].name --output tsv)
export APPRG=$(az webapp list --query [0].resourceGroup --output tsv)
export APPPLAN=$(az appservice plan list --query [0].name --output tsv)
export APPSKU=$(az appservice plan list --query [0].sku.name --output tsv)
export APPLOCATION=$(az appservice plan list --query [0].location --output tsv)

az webapp up --name $APPNAME --resource-group $APPRG --plan $APPPLAN --sku $APPSKU --location "$APPLOCATION"

# Python 
export APPNAME=$(az webapp list --query [0].name --output tsv)
export APPRG=$(az webapp list --query [0].resourceGroup --output tsv)
export APPPLAN=$(az appservice plan list --query [0].name --output tsv)
export APPSKU=$(az appservice plan list --query [0].sku.name --output tsv)
export APPLOCATION=$(az appservice plan list --query [0].location --output tsv)

cd path/$webappName
az webapp up --name $APPNAME --resource-group $APPRG --plan $APPPLAN --sku $APPSKU --location "$APPLOCATION"
```


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
New-AzRoleDefi
VPN Gateway requires: - subnet, dns server and VPN device 
`Search -> Virtual Network Gateways -> + Create`
Select:
- VPN or ExressRoute
- Gateway type
	- Route-based - uses routes in the IP forwarding or routing table to direct packets into their corresponding tunnel interfaces
	- Policy-based -  encrypt and direct packets through IPsec tunnels based on the IPsec policies - configured with the combinations of address prefixes between your on-premises network and the Azure virtual network
- SKU, Generation (bytes per second), Names, RG, Vnet

Local Network Gateways - to represent the on-premises site that you want to connect to a virtual network
`Search -> Local Network Gateways -> + Create`
- (Advanced) Border Gateway Protocol (BGP) - routability and reachable protocol -  requires - the minimum prefix you need to declare is the host address of your BGP Peer IP address on your VPN device.

On-Premise VPN devices: shared key and public IP address of your VPN gateway
- Configuration scripts are available for some devices - [Download VPN device configuration scripts for S2S VPN connections](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-download-vpndevicescript) to find a downloadable script for your VPN device.
nition -InputFile $file
```

Assign roles **at scope** - `Subscription,Resource group, Resource`
`Management Groups -> Access Control (IAM) -> Add -> Search <role keyword> ->  + Select members`
Assign can be done via Reso
VPN Gateway requires: - subnet, dns server and VPN device 
`Search -> Virtual Network Gateways -> + Create`
Select:
- VPN or ExressRoute
- Gateway type
	- Route-based - uses routes in the IP forwarding or routing table to direct packets into their corresponding tunnel interfaces
	- Policy-based -  encrypt and direct packets through IPsec tunnels based on the IPsec policies - configured with the combinations of address prefixes between your on-premises network and the Azure virtual network
- SKU, Generation (bytes per second), Names, RG, Vnet

Local Network Gateways - to represent the on-premises site that you want to connect to a virtual network
`Search -> Local Network Gateways -> + Create`
- (Advanced) Border Gateway Protocol (BGP) - routability and reachable protocol -  requires - the minimum prefix you need to declare is the host address of your BGP Peer IP address on your VPN device.

On-Premise VPN devices: shared key and public IP address of your VPN gateway
- Configuration scripts are available for some devices - [Download VPN device configuration scripts for S2S VPN connections](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-download-vpndevicescript) to find a downloadable script for your VPN device.
urce Group of Admin Scoping in fields
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

Address spaces - Review IP Schema Implementation
By CIDR 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
Routable address over the internet: 215.11.0.0 to 215.11.255.255

View a Network Typology by subscription, Resource Group and Vnet
`Search -> Network Watcher -> Topology`

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

Implement Virtual Networking
`Search -> Virtual Network -> $Vnet (With Subnet, VMs, DNSm, NSGs, etc configured)` in the `Private DNS Zone -> Virtual Network Link -> + Add - provide a Link name, Vnet` 

Router Configuration:
- NIC level:
	- Enable IP forwarding or Run command:
```powershell
# Routing VM - Lab example!
# You should probably not allow alot of these features
Install-WindowsFeature RemoteAccess -IncludeManagementTools
Install-WindowsFeature -Name Routing  -IncludeManagementTools  -IncludeAllSubFeature
Install-WindowsFeature -Name "RSAT-RemoteAccess-Powershell"
Install-RemoteAccess -VpnType RoutingOnly
Get-NetAdapter | Set-NetIPInterface -Forwarding Enabled
```
- Route Table
	- `+ Create`, 
	- `Subnet -> + Associate` with a subnet
	- `Routes -> + Add`

Vm Script - `$VM -> Run Command`
```powershell
# Admin remote access work station
Install-WindowsFeature RemoteAccess -IncludeManagementTools
Install-WindowsFeature -Name Routing  -IncludeManagementTools  -IncludeAllSubFeature
Install-WindowsFeature -Name "RSAT-RemoteAccess-Powershell"
```

#### Load Balancers

Load Balancers Workflows by Type and important information:
`Search -> Load Balancers` and `+ Create` a type:
- Application Gateway - Region layer 7 load balancer - Application Gateway Configuration
	- Routing Methods
		- Path-based routing: sends requests with different URL paths to different pools of back-end servers.
		- Multi-site routing:  configures more than one web application on the same application gateway instance.
	- Optional Firewall checks (Recommended)
		- OWASP defines a set of generic rules for detecting attacks. These rules are referred to as the Core Rule Set (CRS)
	- Traffic Redirection
	- Rewrite HTTP Headers
	- Custom Error pages instead of default error pages - highly advised Attacker need error pages
- Front Door - Global Layer 7 load balancer 
- Load Balancer - Layer 4 for internal and public configurations
	- SKU options: Basic, Standard, and Gateway 
- Traffic Manager - DNs-based traffic load balancer
Manage:
`Search -> Load Balancers -> $loadBalancer`:
- Front-end IP configuration 
- Back-end pools: `+ Add -> $name & $Vnet`
- Health probes: `+ Add -> $name & Protocol, Port and Interval`
- Load-balancing rules (can be used in combination with NAT rules) - requires a frontend, backend, and health probe; define a rule:
	- IPv4 or 6
	- Frontend IP address
	- Backend pool or Backend port
	- Health probe
	- Session persistence: None (default), Client IP, Client IP and Protocol

1. `Create a Resource -> Load Balancer` - options:
2. `Basic: SKU, Type ( Public | Internal ) and Tier (Regional | Global )`. 
3. `Configure front-end IP configuration -> Add (Consider assignment*)`  
4. `Configure back-end IP configuration -> Select backend pool VMS`  
5. `Inbound Rules -> Add`

Add session persistence to a load balancer
`Search Load Balancers -> Load Blancers -> $LB -> Edit -> Sessions persistence dropdown -> None, Client IP, Client IP and Protocol`

- RDP Desktop Gateway + Load Balancer = must be Source IP affinity LB
- Media upload + Load Balancer = must be Source IP affinity LB

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

#### VPN Gateways

VPN Gateway requires: - subnet, dns server and VPN device 
`Search -> Virtual Network Gateways -> + Create`
Select:
- VPN or ExressRoute
- Gateway type
	- Route-based - uses routes in the IP forwarding or routing table to direct packets into their corresponding tunnel interfaces
	- Policy-based -  encrypt and direct packets through IPsec tunnels based on the IPsec policies - configured with the combinations of address prefixes between your on-premises network and the Azure virtual network
- SKU, Generation (bytes per second), Names, RG, Vnet

Local Network Gateways - to represent the on-premises site that you want to connect to a virtual network
`Search -> Local Network Gateways -> + Create`
- (Advanced) Border Gateway Protocol (BGP) - routability and reachable protocol -  requires - the minimum prefix you need to declare is the host address of your BGP Peer IP address on your VPN device.

On-Premise VPN devices: shared key and public IP address of your VPN gateway
- Configuration scripts are available for some devices - [Download VPN device configuration scripts for S2S VPN connections](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-download-vpndevicescript) to find a downloadable script for your VPN device.

#### Virtual Network Peering

Vnet Peering - requires account with `(Classic) Network Contributor` role
`Search -> Virtual Networks -> $Vnet -> SEttings -> Peering -> Add(peering)` 
- Create in hub, not peers; make NSG rules!
- One Gateway to Transit them All - vnet-to-vnet, site-to-site and point-to-site
- Vnets must have resources, the first must be made with [[Azure-Administration-Azure-Resource-Manager]], the second is referred to as the remote network
-  [Permissions](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering?tabs=peering-portal#permissions)
- Extending Peering 
	- Hub and spoke network - Central hub for VPN gateway, spoke Vnets
	- User-defined route (UDR): either a hop to/from VM IP address or VPN Gateway
	- Service chaining: define UDRs from Vnet to a network virtual appliance or VPN

## VM Scale Sets

Create and Manage VM Scale Sets
`Search -> Virtual machine scale sets` 
- Size = Price; Azure Spot - discount unused pool ; image = OS, arch = x86 or arm64
- Orchestration mode:
	- Uniform - for large scale stateless workloads with indetical instances - department workstation
	- Flexible - high availability at scale with identical or multiple instances - any configuration to the scale set.
- Advanced tab to enable beyond 100 instances; spreading for optimal spreading of allocation Implement Virtual Networking
`Search -> Virtual Network -> $Vnet (With Subnet, VMs, DNSm, NSGs, etc configured)` in the `Private DNS Zone -> Virtual Network Link -> + Add - provide a Link name, Vnet` 
 - Configure Scaling in the `Scaling` tab; 
	 - Policy - min/max number of instances; manula or autoscaling 
	 - Scale in - CPU threshold, decrease of instances
	 - Scale out - CPU threshold, duration, increase of instances
	 - Scale-In policy - default, newest, oldest vms

Size Scaling
`Virtual Machines -> $VM -> Size -> Resize by select new size`
Disk Scaling
`Virtual Machines -> $VM -> Disks -> + Create and Attach a new disk -> provide a name and size (GiB)` 

Register resource providers
```powershell
Register-AzResourceProvider -ProviderNamespace $RP
```

Deploy a zone-resilient Azure VM scale set with Portal
`Search -> Virtual machine scale sets -> + Create -> Provide: Name, Resource Group and Zones! - Orchestration mode!, Image,Size` - Add to or Create a Vnet; configure NIC NSG and consider `Load balancer`; Scaling; Management `Monitoring: managed or custom` - do not disable; `Advanced - Spreading and Beyond 100 instances;`

Upgrading VM scale sets
Load a script with Script with Custom Script Extension
`Search -> VM scale sets -> Instances -> Select instances -> Upgrade` - check with Load balancer Frontend IP: `Search -> Load Balancers -> $LoadBalancer -> Frontend IP configuration -> Copy address` 

`Search -> VM scale sets -> Scaling -> Manual Scaling or Custom autoscale`
if Custom:
- Configure the Default auto created scale condition 
	- Add rules!!!
	- Scale  mode - metric or instance count
	- Instance limits
	- Schedule
Test with:
```powershell
# This is the microsoft way.. - test if you need a while loop..
# Note is this just a way to increase costs in the cli?
# "Sorry boss I spent X dollars on a web request"
$pip (Get-AzPublicIpAddress -ResourceGroupName $rgName -Name $lbpipName).IpAddress
while ($true) { Invoke-WebRequest -Uri "http://$pip" }
```

Custom Script Extension - Container with a custom IIS webserver
- Storage Account with scripts, container for webserver
`VMs -> $Container -> Extensions + Add -> Custom Script Extension -> Upload scripts from Storage Account `

Export Template, custom template for mass use
`VMs -> $CustomVm -> Export Template`

## Azure App Services

Create a Azure App Service
`Search -> App Services + Create`
Basics 
- Resource Group
- Publish: Code, Docker Container or Static Web App
- Runtime stack
Deployment 
- Github actions - continuous deployment!
- Devlopment slots are live apps with their own hostnames - ``
Networking - Public access and network injection toggles
Monitoring - Insights
Tags - TAGS TAGS TAGS!

Create a staging deployment slot and configure deployment 
`App Services -> $App -> Deployment Slots -> + Add Slot`
Then
`$App -> Deplyment Centre -> Select a Source -> Save`

Scale up/out Azure App Services
`Search -> App Services -> Manual scale / Custom Autoscale`
- For Custom Autoscale:
	- Minimum instance count
	- Maximum instance count
	- Adequate scale margin
	- Scale rule combinations
	- Metric statistics
	- Default instance count
	- Notifications

Deploy Code to a Azure App Service configure to deploy git source code.
```powershell
Set-Location-Path $pathToSourceCode
git remote add $Repository $AzureAppServiceDeployURL.git 
git push $Repository $Branch
# Authenicate
```

Deployment Swaps
`Search -> App Services -> $App -> Deployment Slots -> Swap`
Select Source and Target

Create a Custom Domain for Azure App Service
`Search -> App Services -> Custom Domains`
- `Search -> Domain Names` and reserve directly in the Azure portal
- Create DNS records
- Enable

Backup Azure App Service (App configuration settings, File content, connected Databases)- requires:
- Standard or Premium tier App Service plan 
- Storage Container - [[Azure-Administration-Storage-Accounts]]
Provide the in `App Services -> $App -> Backup `

## Azure Automation

Create Automation Account
`Search Automation Accounts -> Automation Accounts -> + Create

Compile DSC script 
`Search Automation Accounts -> Automation Accounts -> $AutomationAccount -> State configuration (DSC) -> Configurations -> Select DSC script -> Compile -> Yes`

Register VMs with your Azure Automation Account
`Search Automation Accounts -> Automation Accounts -> $AutomationAccount -> State configuration (DSC) -> Nodes + Add -> Configure settings -> Comfirm`

Push is simple powershell include in the Powershell
Pulling a configuration for lots of nodes - also included in the Powershell section
1. Set up a DSC and create a DSC configuration
2. Upload DSC script to Azure Automation account - create if required
3. Add required modules, compile configuration
4. Register VM
5. On VM Install DSC VM extension
6. Install WMF
7. LCM applies the desired state -
	1. Poll Pull Server 
	2. Download
	3. Compare
	4. Update

## Containerisation

Deploy a Docker Container using Azure Container Instances
`Search -> Container Instances -> + Create`
- Basic - Resource Group 
- Networking - DNS name label
- Advanced - Restart policy

## AKS

Check if registered
`Search -> Subscriptions -> $Subscription -> Resource Providers `

`Search -> Kubernetes Services -> + Create (either): + Create a Kubernetes cluster | + Add a Kubernetes cluster with Azure Arc`
Basic: 
- Avaliability Zones - (consider full removal for high avaliability)
- Scale method: Manual or Autoscale
- Node Count: 1 - 5 
Node pools - configure here
Acces - RBAC and AKS-managed Azure AD 
Networking
Integrations - Container Monitoring

Add Node pools 
`Search -> Kubernetes Services -> $KubernetesService -> Node Pools `

Scale Node pool deployed 
`Search -> Kubernetes Services -> $KubernetesService -> Node Pools -> $NodePool -> Scale Node pool` - configure and apply.

Check the bash section  for CLI deployment and scaling.

## Azure Backup
Backup Center
`Search -> Backup Center`:
- `+ Backup`
- `<- Restore`
- `+ Policy`
- `+ Vault`

Backup Workflows
1. Create a Recovery Services Vault - choose LRS/GRS
2. Define a backup policy - when and retention length of data snapshots
3. Backup VMs, etc..

Create a Recovery Service Vault
`Search -> Recovery Services vaults -> + Create`
- Multi-select for backup "What you want to backup" options

Configure replication of recover Service Vault
`$Backup -> Properties -> Backup Configuration -> Update `
- Choose: `Geo-redundant | Locally redundant | Zone redundant`

Implement System Center Data Protection Manager (DPM) and or Microsoft Azure Backup Server (MABS)
- First [deploy the System Center DPM protection agent](https://learn.microsoft.com/en-us/system-center/dpm/deploy-dpm-protection-agent)
- Then [install the DPM protection agent (for MABS)](https://learn.microsoft.com/en-us/azure/backup/backup-azure-microsoft-azure-backup#install-and-update-the-data-protection-manager-protection-agent)
- Any machines that you want to back up must be added to a [System Center DPM _protection group_](https://learn.microsoft.com/en-us/system-center/dpm/create-dpm-protection-groups).

Backup 
`$Backup -> Overview -> + Backup -> Select Workload and What to backup -> Configure:
- Policy Sub type - How many per day, Operation tier (x-y days) Resilience Level 
- Backup Policy - Default, Custom and
	- `Create a new policy`
		- Backup schedule
		- Instant Restore -  Retain instant recovery snapshots for X days
		- Retention Range
- `Add` - Add a Resource
- Check `$Backup -> Protected items -> Backup items -> $resourcetype`

Backup a resource
`$Backup -> Protected items -> Backup items -> $resourcetype -> $resource -> View Details -> Backup Now`

Backup File/Folder 
`Search Virtual Machines -> $VM -> Connect` - Connect to machine - 
`Log into Azure Portal -> Recovery Services vaults -> $rsv -> + Backup -> Workload: On-Premise (regardless) -> Backup: Files and folders -> Prepare Infrastructure:`
- Download the Agent for Windows Server or Window Client
- Installation Setup Wiazrd
- Download the Vault Credentials

Restore or File Recovery VM
`Search Recovery Services Vaults -> $rsv -> Backup items -> Azure Virutal Machines -> $VM -> Restore VM / File Recovery`

Recovery Files:
Locally
`Microsoft Azure Backup Application- > Recover Data -> Select Mode, Volume and Data `
Virtual Snapshots:
`Search Recovery Services Vaults -> $rsv -> Backup items -> $AzureVM -> View Details -> File Recovery -> Download Excutable -> Open IaaSVMILRExeForWindows.exe -> copy and paste Password to run Script into IaaSVMILRExeForWindows.exe`, then
On Host open `cmd.exe` with [robocopy]((https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy):
```powershell
# Copy from the mounted virtual snapshosts
# Consider permissions!
robocopy G:\File\Path\To\Dir C:\File\Path\To\Dir $file /r:1 /w:1 
```
Then `Unmount Disks`

Azure Recovery Services soft delete 
`Search Recovery Services Vaults -> $rsv -> Backup items -> Azure Backup Agent -> View Details -> $ComputerName -> Delete -> Type the Server name* & Provide Reason & Add comment for professionalism & Tick and Delete`

Stop Backup and Deal witht Data retention
`Search Recovery Services Vaults -> $rsv -> Backup items -> Azure Virtual Machine -> View Details -> Stop Backup`, then pick to:
- Retain Backup Data 
- Delete Backup Data
	- Type the name of the backup item* ; add a Reason and comment  

Undelete Backup that has Backup Disabled 
`Search Recovery Services Vaults -> $rsv -> Backup items -> $Backup -> Undelete`

Delete Backup Data Backup
`Search Recovery Services Vaults -> $rsv -> Backup items -> $Backup -> Delete backup data`

## Azure Monitor

Access Azure Monitor
`Search -> Monitor`
Access Network Monitor 
`Search -> Network Watcher`

Register the Microsoft.Insights and Microsoft.AlertsManagement resource providers 
```powershell
Register-AzResourceProvider -ProviderNamespace Microsoft.Insights
Register-AzResourceProvider -ProviderNamespace Microsoft.AlertsManagement
```

Metrics 
`Search -> Monitor -> Metrics -> Select a Scope (Tree View)`

Create an (metric) Alert 
`Search -> Monitor -> Alerts -> Create
`Search -> Monitor -> Metrics -> New Alert Rule
- Select scope, filter times..., then configure

Log Analytics Querying - Has drop down listing of useful input!
`Search -> Monitor -> Logs -> Select a scope -> (Tables | Queries | Functions | Filters)  -> Run Query`
- You can click to collapse the left panel

Create and Configure Log Analytics workspaces
`Search Log Analytics workspaces -> Log Analytics workspaces -> Create`
`Search Automation Accounts -> Create -> $LAWrGroup` - check [supported mappings](https://learn.microsoft.com/en-us/azure/automation/how-to/region-mappings) then `$AutomationAccount -> Inventory -> Select Log Analytics workspace -> $LAW & Enable` then `Update Management -> Enable`

Configure VM for Log Analytics
`Search -> Virtual Machines -> $VM -> (Metrics - for default Monitoring) Diagnostic settings -> Select a Diagnostics storage account & Enable guest-level monitoring` then configure: 
- Performance Counters
- Logs
- Crash dumps Sinks 
- Agent
Then `$VM -> Logs -> Enable -> chooose a Log Analytucs Workspace -> Enable `

KGL Log queries 
- Schema 
- Filter
- Explorer

```sql
// Syntax
// Count by Rows:
$Table | count 

// Count by Column:
$Table 
| count

// Control Commands 
.create table Logs (Level:string, Text:string)


// Queries - I will use row queries for space, unless it is required
$table | count
$table | top 3 by event severity duration
$table | where StartTime between (datetime(2007-11-01) .. datetime(2007-12-01))
$table | where $Column == "Something" 

// Top most security events by time generated
SecurityEvents 
	| take 10 by TimeGenerated

// In the last 24 hours records of "Clicked Schedule Button"
AppEvents 
    | where TimeGenerated > ago(24h)
    | where Name == "Clicked Schedule Button"

# Heartbeat data source reports the health of all computers that report to LA Workspace
Heartbeat | summarize arg_max(TimeGenerated, *) by ComputerIP

// Aggregate content by specifications using using summarize 
$table | summarize count(), avg(severity) by $column, $column

// Create a Column Chart from $event 
$table | where isnotempty($event) | summarize event_count=count() by $event | top 10 by event_count | render columnchart

// Chat CPU usage trends by computer
InsightsMetrics
| where TimeGenerated > ago(1h)
| where Origin == "vm.azm.ms"
| where Namespace == "Processor"
| where Name == "UtilizationPercentage"
summarize avg(Val) by bin(TimeGenerated, 5m), Computer
render timechart
```

Onboard virtual machines to Azure Monitor VM Insights
`Monitor -> Monitoring -> Insights -> Select Enable & Refresh`; avaliable Graphs:
- Logical Disk Performance
- CPU Utilization
- Available Memory
- Logical Disk IOPS
- Logical Disk MB/s
- Logical Disk Latency (ms)
- Max Logical Disk Used %
- Bytes Sent Rate
- Bytes Received Rate


- Automate remote network monitoring with packet capture - from triggering alerts
	-  `Network Watcher -> PAcket capture`
- Network Security Group Flow Logs (NSG Flow Logs) for network traffic pattern collection
- Diagnose VPN issues
	- `Network Watcher -> VPN troubleshoot
- Visual Network Typology 
	- `Network Watcher -> Topology`
- Connection Troubleshoot -  suite of networking tools and capabilities to3 troubleshoots network performance and connectivity issues in Azure.
	 - `Network Watcher -> Connection troubleshoot`
- Verify IP flow -  IP Flow Verify quickly diagnose connectivity issues from or to the internet and from or to the on-premises environment.
	- `Network Watcher -> Ip flow verify`
- Next Hop - determine if traffic is being directed to the intended destination by showing the next hop'
	- `Network Watcher -> Next Hop`

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

Full actual documentation:
- [Azure CLI overview](https://learn.microsoft.com/en-us/cli/azure/)
- [Azure CLI command reference](https://learn.microsoft.com/en-us/cli/azure/reference-index)

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

Cloud Config Example - cloud-init.txt
```yaml
#cloud-config
package_upgrade: true
packages:
   - inetutils-traceroute
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

Azure VM command with subcommand for managing VMs
```bash 
# VM Subcommands:
az vm create
--no-wait # can be used in a script to not wait and create next VM 
# Open a specific network port for inbound traffic
az vm open-port 
az vm open-port --port  80 --resource-group $rg --name $name
# Deallocate a VM
az vm deallocate 
# details of a VM
az vm show 
az vm show  --resource-group $rg --name $name
# Update a property of a virtual machine
az vm update 
# Start, Stop, Delete, Restart VM
az vm start 
az vm stop 
az vm restart
az vm delete
# List active VMs
az vm list 
az vm list --output table
# List the IP address by -n name
az vm list-ip-addresses -n SampleVM -o table

# List avaliable images
# filter with:
--publisher
--sku
--offer
az vm image list --output table
# Show all Microsoft images 
az vm image list --publisher Microsoft --output table --all
# All Wordpress images
az vm image list --sku Wordpress --output table --all
# Location specific images
az vm image list --location eastus --output table
# List Sizes of VM, can also be filtered
az vm list-sizes --location eastus --output table
# Private and Public flags
--public-ip-address 10.10.10.10
--private-ip-address 10.10.10.10
--public-ip-address-allocation 'dynamic' # or 'static' 
--public-ip-address-dns-name $DNSname
```

Create a VM
```bash
# Returns a response in JSON
az vm create \
  --resource-group $resource_group_name \
  --location westus \
  --name SampleVM \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys \
  --verbose \ 
  --size "Standard_DS2_v2"  
```

Resize a VM
```bash
# List options avaliable
az vm list-vm-resize-options \
    --resource-group $resource_group_name \
    --name SampleVM \
    --output table
# Rezie
az vm resize \
    --resource-group $resource_group_name \
    --name SampleVM \
    --size Standard_D2s_v3
```

You can add filters with [JMESPath.org](http://jmespath.org/) an industry-standard query language built around JSON objects. `$identifier[?subsetObject != '0'].[names]`
```bash
az vm show \
    --resource-group $resource_group_name \
    --name SampleVM \
	--query "networkProfile.networkInterfaces[].id" -o tsv
# More Useful Queries
--query "osProfile.adminUsername"
--query hardwareProfile.vmSize
```

Verifying a stopped VM by querying PowerState
```bash
az vm get-instance-view \
    --name SampleVM \
    --resource-group $resource_group_name \
    --query "instanceView.statuses[?starts_with(code, 'PowerState/')].displayStatus" -o tsv
```

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

AKS deployment
```bash
# Access AZK cluster, then show connectivity
RGROUP='azResourceGroup'
AKS_CLUSTER='azCluster'
az aks get-credentials --resource-group $RGOUP --name $AKS_CLUSTER
kubectl get nodes
# Deploy an nginx image
kubectl create deployment nginx-deployment --image=nginx
kubectl get pods
kubectl get deployment
# Expose the http port to internet
kubectl expose deployment nginx-deployment --port=80 --type=LoadBalancer
# Display provisioning and IP
kubectl get service
```

Scale a AKS cluster
```bash
kubectl scale --replicas=2 deployment/nginx-deployment
kubectl get pods

# Scale by node 
az aks scale --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER --node-count 2
kubectl get nodes

# Scale by pods
kubectl scale --replicas=10 deployment/nginx-deployment
kubectl get pods

kubectl get pod -o=custom-columns=NODE:.spec.nodeName,POD:.metadata.name
# Delete deploymen
kubectl delete deplyment ngnix-deployment
```

Create a Vnet with Subnets 
```powershell
# Create Vnet
az network vnet create \
    --resource-group $rGroup \
    --name CoreServicesVnet \
    --address-prefixes 10.20.0.0/16 \
    --location westus
# Creat Subnets with address prfixes
az network vnet subnet create \
    --resource-group $rGroup \
    --vnet-name CoreServicesVnet \
    --name GatewaySubnet \
    --address-prefixes 10.20.0.0/27

az network vnet subnet create \
    --resource-group $rGroup \
    --vnet-name CoreServicesVnet \
    --name SharedServicesSubnet \
    --address-prefixes 10.20.10.0/24

az network vnet subnet create \
    --resource-group $rGroup \
    --vnet-name CoreServicesVnet \
    --name DatabaseSubnet \
    --address-prefixes 10.20.20.0/24

az network vnet subnet create \
    --resource-group $rGroup \
    --vnet-name CoreServicesVnet \
    --name PublicWebServiceSubnet \
    --address-prefixes 10.20.30.0/24
# List the subnets
az network vnet subnet list \
    --resource-group $rGroup \
    --vnet-name CoreServicesVnet \
    --output table
```

Query Vnet are Provisioned
```powershell
az network vnet list --query "[?contains(provisioningState, 'Succeeded')]" --output table
```

Create peering between two Vnets
```powershell
# Forward and Reverseing Peering is required
# Initial Forward Peering
az network vnet peering create \
    --name SalesVNet-To-MarketingVNet \
    --remote-vnet MarketingVNet \
    --resource-group $rgNameSales \
    --vnet-name SalesVNet \
    --allow-vnet-access
# Reverse peering between the inital Vnet Peering
az network vnet peering create \
    --name MarketingVNet-To-SalesVNet \
    --remote-vnet SalesVNet \
    --resource-group $rgNameMarketing \
    --vnet-name MarketingVNet \
    --allow-vnet-access

# Query Connection
az network vnet peering list \
    --resource-group $rgName \
    --vnet-name $VnetName \
    --query "[].{Name:name, Resource:resourceGroup, PeeringState:peeringState, AllowVnetAccess:allowVirtualNetworkAccess}"\
    --output table

# Check Effective Routes
az network nic show-effective-route-table \
    --resource-group $rgNameSales \
    --name SalesVMVMNic \
    --output table
    
# Ceck Effective Routes From the Reverse Peering
az network nic show-effective-route-table \ 
--resource-group $rgNameMarketing \ 
--name MarketingVMVMNic \ 
--output table
```

Azure CLI view network typology
```powershell
# A Configuration
az network watcher configure \
  --resource-group $rGroup \
  --location eastus \
  --enabled true
# Show a typology for a resource group
az network watcher show-topology --resource-group $rGroup
```

Create a Route Table and a Custom Route - Prvate Subnets, IP forwarding
```powershell
# Create a Route Table
az network route-table create \
        --name publictable \
        --resource-group $rGroup \
        --disable-bgp-route-propagation false
# Create a Custom Route		
az network route-table route create \
        --route-table-name publictable \
        --resource-group $rGroup \
        --name productionsubnet \
        --address-prefix 10.0.1.0/24 \
        --next-hop-type VirtualAppliance \
        --next-hop-ip-address 10.0.2.4		
# Associate Route Table with publicsubnet
az network vnet subnet update \
        --name publicsubnet \
        --vnet-name vnet \
        --resource-group $rGroup \
        --route-table publictable
```

Deploy a Network Virtual Appliance, Enable IP forwarding 
```powershell
# Create NVA
az vm create \
    --resource-group $rGroup \
    --name nva \
    --vnet-name vnet \
    --subnet dmzsubnet \
    --image UbuntuLTS \
    --admin-username azureuser \
    --admin-password <password>
# Query the ID of NVA NIC
NICID=$(az vm nic list \
    --resource-group $rGroup \
    --vm-name nva \
    --query "[].{id:id}" --output tsv)
# Query the name of NVA NIC
NICNAME=$(az vm nic show \
    --resource-group $rGroup \
    --vm-name nva \
    --nic $NICID \
    --query "{name:name}" --output tsv)
# # Enable IP forwarding for the appliance
az network nic update --name $NICNAME \
    --resource-group $rGroup \
    --ip-forwarding true
# Enable IP forwarding in the appliance
NVAIP="$(az vm list-ip-addresses \
    --resource-group $rGroup  \
    --name nva \
    --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
    --output tsv)"
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

Send HTTP requests with `Get-AzWebApp`
```powershell
$webapp = Get-AzWebApp -ResourceGroupName $rgName
Invoke-WebRequest -Uri $webapp.DefaultHostName
# Send infinite request to test with while loop and powershell code blocks
while ($true) { Invoke-WebRequest -Uri $webapp.DefaultHostName }
```

Load Balancer
```bash
az network public-ip create \
  --resource-group $rGroup \
  --allocation-method Static \
  --name myPublicIP

az network lb create \
  --resource-group $rGroup \
  --name myLoadBalancer \
  --public-ip-address myPublicIP \
  --frontend-ip-name myFrontEndPool \
  --backend-pool-name myBackEndPool

az network lb probe create \
  --resource-group $rGroup \
  --lb-name myLoadBalancer \
  --name myHealthProbe \
  --protocol tcp \
  --port 80

az network lb rule create \
  --resource-group $rGroup \
  --lb-name myLoadBalancer \
  --name myHTTPRule \
  --protocol tcp \
  --frontend-port 80 \
  --backend-port 80 \
  --frontend-ip-name myFrontEndPool \
  --backend-pool-name myBackEndPool \
  --probe-name myHealthProbe

# Connect the VMs to the back-end pool and update NIC
az network nic ip-config update \
  --resource-group $rGroup \
  --nic-name webNic1 \
  --name ipconfig1 \
  --lb-name myLoadBalancer \
  --lb-address-pools myBackEndPool

az network nic ip-config update \
  --resource-group $rGroup \
  --nic-name webNic2 \
  --name ipconfig1 \
  --lb-name myLoadBalancer \
  --lb-address-pools myBackEndPool
# Get pulic IP of the Load Balancer and URL for website
echo http://$(az network public-ip show \
                --resource-group [sandbox resource group name] \
                --name myPublicIP \
                --query ipAddress \
                --output tsv)
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

Extensions help in task automation
Custom Script Extension to run scripts - timesout after 90 minutes
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

## References

[Offical Microsoft Material for Az104](https://learn.microsoft.com/)
[John Savill's Microsoft Azure Master Class Part 6 - Networking](https://www.youtube.com/watch?v=K8ePZdLfU7M&t=3511s)
