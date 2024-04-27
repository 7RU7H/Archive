
- Access the portal at https://portal.azure.com/ -  great for performing single tasks
- Cloud Shell on the `>_` Icon; Temporary Host - per-session, per-user basis
	- Has Requirements to use! - `Show Advanced Settings -> provide required fields -> Create Storage`

[Interactive map Resource Map](https://infrastructuremap.microsoft.com/explore) - Use 2D for fast load times
[Azure Cross Replication Regions](https://learn.microsoft.com/en-us/azure/reliability/cross-region-replication-azure)
[Azure subscription limits and quotas - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits)
[Pricing Calculator](https://azure.microsoft.com/en-gb/pricing/calculator/)
[Total Cost of Ownership Calculator](https://azure.microsoft.com/en-gb/pricing/tco/calculator/)
[Understand Subscription and Service limits](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits)

1. Subscriptions and Microsoft Entra ID Tenant
1. Management Groups and Subscriptions - Context
1. Resource Group - Everything exists in resource group, no nesting allowed, not a boundary of access


PowerShell Cmdlet Logic 
```powershell
# Microsoft Graph Module
Get-Mg # Retrieve information
New-Mg # Create Mgure X
Update-Mg # Update Mgure X
Add-Mg # Add X to Existing Mgure Y
Move-Mg # Move Mg X to Y
Export-Mg # Capture to a template
Import-Mg # Import config
Remove-Mg # Remove..
Select-Mg # Select != Get; Choose X
Invoke-Mg # Contruct and Perform X
Clear-Mg # Clear settable values
Set-Mg # Opposite of Clear, Set values
# Deprecated Zure Powershell Module
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

Know your Azure Agents and Extensions:
- Agents and Extension disambiguation
	-  Extensions
		-  Virtual machine extensions:
			- Small applications that automate the tasks of creating, maintaining, and removing virtual machines.
		- Azure Custom Script Extension
			- is used for post-deployment configuration, software installation, or any other configuration or management task.
		- Desired State Configuration (DSC) 
			- is a management platform to manage an IT and development infrastructure with configuration as code.
		- Azure VMAccess extension
			- acts as a KVM switch that allows you to access the console to reset access to Linux or perform disk-level maintenance.
	- Agents
		- Azure Monitor Agent - Collects monitoring data 
			- Will replace the both Log Analytics Agent and Azure diagnostic at some point:
				- (LEGACY - here for disambiguation) Azure Diagnostic Extension - Enables customers to receive extra data from guest OSes and Workload on Azure resource
			- Log Analytics agent - Collects logs and performance data for Azure Resources
				- for Linux as part of a solution to collect JSON output
		- Dependency Agent 
			- Collects discovered data about certain processes to maps all dependencies between virtual machines and any external process dependencies.
## Azure Policies

Governance is about enforcement of rules and ensuring proper functioning to standards. 
Azure Policy  != Azure Roles && RBAC
- [[Azure-Administration-Azure-Policies]] - Policies  - WHAT? - ensures compliance of resources and does not set permissions
- [[Azure-Administration-Azure-Roles-And-RBAC]] - WHO?
	- Azure Roles the object (that is an implementation of Azure Roles) each a type of Roles like Owner, Contributor, Reader...  
	- RBAC controls access to resources - Manages User actions at different scopes 
	- A Role has:
		- Assignment, Scope, Role Definitions, Security Principle (Object: `user`, `group` or `application`)
- Budget - HOW MUCH?
 
- [[Azure-Administration-Azure-Policies]] 
	- Policy Definitions - Defined in a .[[JSON]] to describe business rules to control access to resources
	- Policy Assignment - Scope of a policy can affect
	- Policy Parameters - Values passed into Policy definition so Polices are more flexible for re-use
	- Initiative Definitions - A collection of Policy definitions, assignable to enforce compliance 

Policy Creation:
1. Policy Definitions - [list of built-in definitions](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies)
	- Policy definitions can also be imported into Azure Policy from [GitHub](https://github.com/Azure/azure-policy/tree/master/samples)
2. Initiative definition - [Azure Policy initiative definition structure](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/initiative-definition-structure) and  [list of built-in initiatives](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-initiatives)
	- Initiative Definitions are good at ANY scale of organisation, do not skip.
3. Scope the initiative definition 
4. Determine Compliance


To view compliance across a scope:
`Overview -> Policies - Compliance` 

**Policy Assignment take 10-30 minutes for Azure to implement - Blueprints are useful**

Polices Management:
`Policies -> Compliance` - Assign polices, initiatives
`Policies -> Remediation` - Policies to remediate and Remediation tasks
Policies Authoring:
`Policies -> Definitions` - Policies and Initiative definitions - export definitions
`Policies -> Assignments` - Assign Policies and Initiatives
`Policies -> Exemptions` - Scope, Category - To create a new exemption - go to `assignment` or the `compliance`.

Apply a policy by tag
`Policies -> Definitions -> Category -> Tags -> Require a tag.. -> Assign -> Scop -> subscription and resource group`

Assignment of a policy - and various assignment configuration and management:
`Policies -> Assignments -> Assignment Name's ellipsis -> Right click` - This menu will show: Edit, delete, duplicate assignment; view definition and compliance; create exemptions.

Inheritance is made in the: 
`Policies -> Assignments -> Assign`

POSIX-compliant-ACL requires Hierarchical Namespace 

## Cost management

Cost Management Dashboard
`Search Cost Management -> Cost Management`
From here for:
`Cost Alerts`,  `Cost Analysis`, `Budgets`

## RBAC and Azure Roles 

Azure RBAC is the authorisation system built on ARM that implement access management over the four Fundamental Azure Roles Owner, Contributor, Reader, User Access Administration. Therefore:
Azure Policy  != Azure Roles && RBAC
- [[Azure-Administration-Azure-Policies]] - Policies - WHAT? - ensures compliance of resources and does not restrict access
- [[Azure-Administration-Azure-Roles-And-RBAC]] - WHO?
	- Azure Roles the object (that is an implementation of Azure Roles) each a type of Roles like Owner, Contributor, Reader...  
	- RBAC controls access to resources - Manages User actions at different scopes 
	- A Role has:
		- Assignment, Scope, Role Definitions, Security Principle(Object: `user`, `group` or `application`))
		- RBAC is the permissions that Role has!
- Budget - HOW MUCH? 

[Role for task by Principle of Least Privilege](https://learn.microsoft.com/en-us/azure/active-directory/roles/delegate-by-task); TLDR:
- Apps - Application Administrator
- B2C - only Global Admins:
	- Configure B2B external collaboration settings
	- Create B2C applications
	- **Microsoft Entra ID B2C Global Administrators do not have the same permissions as Microsoft Entra ID Global Administrators -  make sure you are in the  Microsoft Entra ID B2C directory!!!**
	- B2B users will have  `user@myorgdomain.com#EXT#domain.com` have `#EXT#` appended 
- Device - Cloud Device Administrator 
- Global Admin configure control plane settings
	- Required: - exclude combined: BEWARE the combined! i.e Reset guest user invite
		- Manage user settings - Enterprise apps
		- Delete all existing app passwords generated by the selected users - MFA
		- Manage Settings and Terms of Use - Organisational Relationships
		- All but read all configurations and password reset properties - Password resets
		- Configure Authentication methods - Authentication methods
		- Create VPN connectivity certificates - Conditional Access
		- Temporary (except themselves) Configure and manage authentication method policy - Temporary Access pass
	- Not required do X
		- If Provisioning - Hybrid Identity Administrator!
		- Configuring at Y level Contributor
		- Reading - Readers
		- Group - Groups Level Roles
		- If Identity Protect - Security Roles
		- If MFA - Authentication Roles 
		- Privileged Role - Privileged Role Administrator
		- Users  - User Admin
		- Support - Service Support Admin plus relevant service 
	- Do not use with 
		- Entitlement
		- Licenses and Billing: relevant
- Important:
	- The only Role containing the term Elevated [Storage File Data Smb Share Elevated Contributor](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#storage-file-data-smb-share-elevated-contributor). 
	- Password Administrator != Helpdesk Administrator!
		- On-premise Helpdesk Administrator can perform password resets

Implement management groups 
`Search Management groups -> Management groups`
Setup Microsoft Entra ID permissions for Implementing Management Groups
`Search Azure ->  Microsoft Entra ID -> Properties -> Access management for Azure Resources` - Refresh in `Management Groups`
From `Management Groups` - Requires Management group ID and Display name
Create a `Management Group`
`Search Management groups -> Management groups -> <insert Management group ID and Display name> 
Add a management group to a subscription
`Search Management groups -> Management groups -> $Management_group -> Subscriptions`  - Subscription ID is in `Overview`

Custom RBAC role creation:
`Upload a $customRole.json file`  - replace fields required prior to upload!
`Open CloudCLI` to upload or use AzCLI or PowerShell

Assign roles **at scope** - `Subscription, Resource group, Resource`
`Management Groups -> Access Control (IAM) -> Add -> Search <role keyword> ->  + Select members`
Assign can be done via Resource Group of Admin Scoping in fields
`Resource Groups -> Access Control (IAM) -> Add (role, co-adminstrator, custom) role -> Search`
`Remove` to remove!
`Activty Log` to find all role (de-)assignments

Levels:
`Microsoft.Authorization/*/` `read`
`Microsoft.Support/*`

Create Azure Service Bus -  brokered messaging communication model - `App/Service (Msg Sender) -> (SB namespace) Queue -> Service/App (Msg Receiver)` 
`All Services -> Integration -> Service Bus`, configure:
- Create namespace for queue, select (RG, Sub, Location, Pricing Tier) 
Important - Service Bus = event-driven

## Microsoft Entra ID 

Important Distinctions:
- Microsoft Entra ID Directory Domain Services provides managed domain services
- Microsoft Entra ID Connect is Hybrid Service to connect on-premise to Azure Account
	- Writeback (Cloud and On-Premise Syncing) is required for the required data to Synchronise between cloud and on-premise.

Manage Tenants
`Search Microsoft Entra ID -> Manage tenants`
Create a Tenant
`All Services -> Microsoft Entra ID -> Manage Tenants -> Create`
Configure Tenant
`Create a Tenant -> Configuration -> Name -> Review and Create -> Create`

License Management
`Search Microsoft Entra ID -> Microsoft Entra ID -> Licenses`
To assign a license
`All Products -> Assign`

Customise Microsoft Entra ID organisation branding
`Search Microsoft Entra ID -> Microsoft Entra ID -> Microsoft Entra ID -> Manage -> Company Branding -> Configure`

#### Create a Users, Groups and Manage Them  

- Remember that you filter by tenant!
- Tiering from Global Admins to lesser Admins in Azure, Azure AD, AD and Host machine
	- Ownership and Role - [Microsoft Entra ID builtin Roles](https://learn.microsoft.com/en-us/azure/active-directory/roles/permissions-reference)
		- What can be owned? - think CRUD
			- Users, Groups, Devices, Resources, Authentication, Policy, Services, Configuration
				- External or Internal relative to X
				- Context - Dynamic Devices or Guest User are temporary therefore think PoLP
	- The assign machine to user the default Admin is that Use - most likely requires change
- Microsoft Entra ID Registered != Microsoft Entra ID Joined 
- Access policy! 

Microsoft Entra ID 
`Overview -> Users -> Create`

Creation User
`Search Users -> New Users -> New user`
Invite User - For Temporary Guest users use: `Microsoft Entra ID B2B`
`Search Users -> New Users -> Invite`
Configure guest users:
- Add to `Groups`
- Access to apps `Manage -> Enterprise applications -> Docusign` (or whatever Digital signing software) 
- Guest users have `user@myorgdomain.com#EXT#domain.com` have `#EXT#` appended 

Edit User settings
`Search Microsoft Entra ID -> Microsoft Entra ID -> User Settings`
User Management
`Search Microsoft Entra ID -> Microsoft Entra ID -> Users`
Create/Invite
`Search Microsoft Entra ID -> Microsoft Entra ID -> Users -> New Users -> New user`
Assign Roles
`Search Microsoft Entra ID -> Users -> Assigned Roles`
Enable Account
`Users -> $username -> Settings -> [Tick/Untick] Account enabled`

Temporary Guest users use: `Microsoft Entra ID B2B`, Guest user can be added with Creating and then Inviting
`Search Microsoft Entra ID -> Microsoft Entra ID -> Users -> New Users -> New user`
`Overview -> Users -> New User -> Invite External`
- Remember to add to groups and anything else.

Bulk additions, deletion and invitation use a .cvs with SOME of the fields

Name | Username | Initial Password | Block Sign in | Firstname | Lastname 
--- | --- | --- | ---
John Doe | jdoe | password123! | No | John | Doe

Bulk Operations
`Search -> Users -> Bulk operations -> Create/Invite/Delete` 

Manage Groups
`Search Groups - > Groups -> New group/Download groups
Create Group
`Search Microsoft Entra ID -> Groups -> New Group`
- `Membership type* -> Assign/Dynamic(User/Device)`
To make a dynamic group dynamic:
- `Add Dynamic Query Rule -> Select a Property, Operator and Value`
Deleted Groups
`Search Groups - > Groups -> Deleted groups`

#### Authentication and Authorisation

Configure SSPR (self-service-password-reset)
`Microsoft Entra ID -> Passwords -> Properties - SSPR enabled (None/Selectec/All)`
Further configuration of SSPR
`Authentication Methods, Registration, Notification and Customise Helpdesk link`
- Requires Premium Microsoft Entra ID P1

Enabling various types of MFA per user, bulk assignment is in the per-user MFA window 
`Users -> Per-user MFA`
Additional options - Where the important stuff is
`Per-Users MFA -> Server Settings` (Not obvious - displays as `users server settings`)
Remember to `enforce`! 

Password reset
`Overview -> Password Reset`
Properties - Self Service password resets
Authentication Methods
Registration - Require users to register when signing in
Notifications - Notification when and on resets
Customisation - Customise Helpdesk link
On-Premise Integration - As stated
Administrator Policy - Admin password reset policy.

## Azure Virtual Networking

Address spaces - Review IP Schema Implementation
By CIDR 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
Routable address over the internet: 215.11.0.0 to 215.11.255.255
Azure Makes System routes by default
[Network Limits](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits?toc=%2Fazure%2Fvirtual-network%2Ftoc.json#networking-limits)

- Important:
	- Address range overlaps restricts various connectivity potentials - see  [[IPv4-Subnet-Masks-Dictionary]]:
		- 10.11.0.0/17 overlaps with 10.11.0.0/25 latter two octets /17 - 128.0, and /24 255.0 overlap
		- 192.168.16.0/22 does not overlap with 10.11.0.0/17
	- Cross region connection use a gateway, NIC in Region A != connect to Region B, but can span resource groups in different regions.
	- 5 Addresses are taken by Azure per (256 addresses of IPv4)
		- `192.82.1.0` Identifies the VNet
		- `192.82.1.1` Gateway
		- `192.82.1.2-3` Azure maps Azure DNS IP addresses to the virtual network space
		- `192.82.1.255` Broadcast
	- Add either to New Subnet or new Address space - understand the differences
	- [Design IP Addressing is non-trivial](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-ip-addressing)
	- Don't use the following address ranges:
		- `224.0.0.0/4` (multicast)
	       - `255.255.255.255/32` (broadcast)
		- `127.0.0.0/8` (loopback)
	       - `169.254.0.0/16` (link-local)
		- `168.63.129.16/32` (internal DNS)

View a Network Typology by Subscription, Resource Group and VNet
`Search -> Network Watcher -> Topology`

Create Virtual Networks and Manage
`Search "Virtual Networks" -> Virtual Networks (-> Create)`
- Azure Firewall, Bastion and other require a Subnet!

Create Subnets
`Search "Virtual Networks" -> Virtual Networks -> $VN -> Subnets -> + Subnets/Gateway subnet`
Remember to: plan IP addresses - they can be `private` or  `public`, `static` or `dynamic` and 

- Implement Azure Bastion
	- Subnet required 
	- `Search -> $VNet -> Bastion`

View a Network Typology by Subscription, Resource Group and VNet
`Search -> Network Watcher -> Topology`

IP Forwarding: 
- Beware
	- Use case
	- NSGs - Vnet, Subnet, NIC

Consideration:
- Service requirements
- Availability requirements - static IPs for DNS and DCs, TLS/SSL certs linked to an IP
- Network virtual appliances
- Service Endpoints - Secure Endpoints from externals
	- VMs in a VNet need Service endpoints enabled to acces Storage Accouts 
- Network Security Groups
- Azure Private Links enables you to access Azure PaaS Services and Azure hosted customer-owned/partner services over a [private endpoint](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview)
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

[User Defined Routes]((https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview) - limited! Use for connecting together:
- Virtual network gateway
- Virtual network
- Internet
- Network virtual appliance (NVA)

Configure user-defined network routes
- `Search -> Route tables`

[Private Link Service](https://learn.microsoft.com/en-us/azure/private-link/create-private-link-service-portal?tabs=dynamic-ip) (connect private behind a Load balancer to a service or resource) - Requires: Internal Load balancer, VNets and reverse subnet
`Private Link Center -> Private Links`; add Basics; 
- Outbound settings
	- Load Balancer and its FE IP
	- Source NAT Vnet, Subnet
	- Enable [TCP proxy V2](https://arsenvlad.medium.com/tcp-proxy-protocol-v2-with-azure-private-link-service-deep-dive-64f8db9586cf) - **[if you need a source IP of service consumers!](https://learn.microsoft.com/en-us/azure/private-link/private-link-service-overview#getting-connection-information-using-tcp-proxy-v2)**
		- [For source IP address for your Private Link service, an explicit disable setting](https://learn.microsoft.com/en-us/azure/private-link/disable-private-link-service-network-policy?tabs=private-link-network-policy-powershell)) `privateLinkServiceNetworkPolicies` is required on the subnet
	- Private IP address settings - Dynamic or Static
- Access Security 

[Create a Private Endpoints](https://learn.microsoft.com/en-us/azure/private-link/create-private-endpoint-portal?tabs=dynamic-ip) - Requires:  Premium V2-tier and an Active Subscription, Vnet and Private Endpoint.
`Private Link Center -> Private Endpoints:`
- Resource: 
	- Connect in my directory or 
	- Resource-type, Resource 
	- Connect with Resource ID or Alias
- Vnet configuration`:
	- Beware of Dynamic | Static IP allocation
	- Beware Private Endpoint DNS if required!

#### Load Balancers

Load Balancers Workflows by Type and important information:
`Search -> Load Balancers` and `+ Create` a type:
- Basic 
	- Requires Resources in the same Availability/Scale set
- Standard 
	- Requires resource in the same VNet
- Application Gateway - Regional Layer 7 Load balancer - Application Gateway Configuration
	- Routing Methods
		- Path-based routing: sends requests with different URL paths to different pools of back-end servers.
			- `/` = Path
		- Multi-site routing: configures more than one web application on the same application gateway instance
			- Multi-site listeners are if the URL is different
	- Optional Firewall checks (Recommended)
		- OWASP defines a set of generic rules for detecting attacks. These rules are referred to as the Core Rule Set (CRS)
	- Traffic Redirection
	- Rewrite HTTP Headers 
	- Custom Error pages instead of default error pages - highly advised Attacker needs error pages
- Front Door - Global Layer 7 Load Balancer - Application Delivery Network (ADN) as a service 
- Load Balancer - Layer 4 for internal and public configurations
	- SKU options: Basic, Standard, and Gateway 
- Traffic Manager - DNS-based traffic Load Balancer
 
 - Manage Load Balancers: `Search -> Load Balancers -> $loadBalancer`; [Components](https://learn.microsoft.com/en-us/azure/load-balancer/components):
	- Front-end IP configuration
		- Public or Private IP
	- Back-end pools: `+ Add -> $name & $VNet`
	- Health probes: `+ Add -> $name & Protocol, Port and Interval`
	- Load-balancing rules (can be used in combination with NAT rules) - requires a Frontend, Backend, and health probe; define a rule:
		- IPv4 or 6
		- Frontend IP address
		- Backend pool or Backend port
		- Health probe
		- Session persistence: None (default), Client IP, Client IP and Protocol
1. `Create a Resource -> Load Balancer` - options:
2. `Basic: SKU, Type ( Public | Internal ) and Tier (Regional | Global )`. 
3. `Configure front-end IP configuration -> Add (Consider assignment)`  
4. `Configure back-end IP configuration -> Select backend pool VMS`  
5. `Inbound Rules -> Add`
	- NAT Rules on LB is for FE to BE pool! 

Add session persistence to a load balancer
`Search Load Balancers -> Load Blancers -> $LB -> Edit -> Sessions persistence dropdown -> None, Client IP, Client IP and Protocol`

- RDP Desktop Gateway + Load Balancer = must be Source IP affinity LB
- Media upload + Load Balancer = must be Source IP affinity LB

#### NSG Workflow

2 NIC + 1 VNET = Application Security Group

Overview of NSGs
`Search -> Network Security Groups`
- Inbound precedence: `Vnet -> NIC`
- Outbound precedence `NIC -> Vnet`

Create an NSG
`Search -> Network Security Groups -> + Create` - Source, Destination, Service, Priority
Associate NSG with a Subnet or NSG
`$NSG -> Settings -> Network Interfaces, Subnets`

Add RDP to a VM Allowing and Disallowing the connection with NSG
`$VM -> Connect -> Configure if required then goto -> Networking -> Either:`
- `Inbound port rules Tab -> add inbound port rule -> Configure`  
- `Outbound port rules Tab -> add outbound port rule -> Configure`

#### Azure DNS

[Overview of Azure DNS alias records](https://learn.microsoft.com/en-us/azure/dns/dns-alias) are qualifications on a DNS record set. They reference Azure resources from a DNS zone in Azure. An alias record set is supported for the following record types in an Azure DNS zone:
- A, AAAA, CNAME
- [Create A Alias Record](https://learn.microsoft.com/en-us/azure/dns/tutorial-alias-rr):
- `Search DNS Zone -> $DNSzone -> + Record Set -> Add record set (Name, Type,, Alias record set (Yes I No), Alias Type (Azure resource | Zone record set)` referencing either a set or resource
	- Points to directly to an Azure Resource instead of IP or hostname to avoid dangling domains 
	- Updates DNS record automatically set when IP addresses change
	- Used for:
		- Hosts load-balanced application at zone apex with a Traffic Manager profile
		- Points to Azure Content Delivery Network endpoints
		- A public IP resource
		- A front door profile

Create DNS zones
`Search -> DNS zones`

To delegate your domain to Azure DNS:
1. Identify your DNS name server - for each zone Azure DNS allocated DNS server from each pool and authoritative `NS` (or _Name server_) records in your DNS zone.
	1. Find with Azure Portal
2. Update your parent domain - each registrar has their own DNS management tools
	1.  Go to your registrar's (third-party domain registrar, company where domain was registered) DNS management page.
	2.  Find the existing `NS` records for your parent domain.
	3.  Replace the existing `NS` records with the `NS` records created for your domain by Azure DNS.
		- Remember to include a trailing period `..` at the end of the address
		- Always copy **all** DNS name server `NS` records for your domain to the parent domain 
3. Delegate subdomains (optional)
	1.  Go to the parent DNS zone for your domain in the Azure portal.
	2. Find the existing `NS` records for your parent domain.
	3. Create new `NS` records for your child DNS zone (subdomain).

[Azure DNS](https://learn.microsoft.com/en-us/azure/dns/dns-overview) *"is a hosting service for DNS domains that provides name resolution by using Microsoft Azure infrastructure."*  Azure can manage all your DNS or you can using the all the features other Azure services.. 
- It does not support DNSSEC
- Customisation Vnet with Private domains

Azure Public DNS - [Host your domain in Azure DNS](https://learn.microsoft.com/en-us/azure/dns/dns-delegate-domain-azure-dns)
- `Search DNS Zones -> Create`
- If it is a child of an existing zone already hosted in Azure DNS 
	- `Tick, providing Name and Resource Group Location`
- [Delegate your DNS zone](https://learn.microsoft.com/en-us/azure/dns/dns-delegate-domain-azure-dns) to Azure DNS
	1. Get name servers for your zone
	2. `Search DNS Zones -> $DNSzone -> Overview -> ..name servers listed..`
	3. Update parent domain with `Azure DNS name servers` - each registrar with its own DNS tools
- [Child Zones](https://learn.microsoft.com/en-us/azure/dns/tutorial-public-dns-zones-child)
	- `Search -> DNS Zones -> $DNSzone -> + Child zone`
- Dynamically Resolve a Traffic Manager (DNS Load Balancer) 
	- Zone Apexes or Root Apexes will receive a lot of traffic use Traffic Manager Profiles instead of complex redirection policies
	- `Search -> Traffic Manager -> Create a `
		- Name, Routing Method, Subscription, Resource Group
			- Routing Methods:
				- Performance
				- Weighted
				- Priority
				- Geographic
				- MultiValue
				- Subnet

[Azure Private DNS Zones](https://learn.microsoft.com/en-us/azure/dns/private-dns-overview) requires:
- VNet (With Resource Manager deployment model) and Subnet,
- Add Virtual Network Linking (add VNet to a Zone): `Resource groups -> $resourceGroup -> $domain -> select Virtual Network Links` - provide VNet, Sub and a `Link name`  
- Create an additional DNS Record in the correct DNS Zone
`Search -> Private DNS Zones -> Create`
- Subscription, Resource Group and Instance Name
- Link VNet Name `$PrivateDNSZone -> Settings -> Virtual Network Links -> Add`
	- Link Name
	- `Tick - I know the resource ID of Virtual network`...if you do
	- Subscription, Virtual Network
	- Registration and Resolution
		- If it is not registered it wont resolve
			- Consider the [Auto registration feature manages DNS records for virtual machines deployed in a virtual network](https://learn.microsoft.com/en-us/azure/dns/private-dns-autoregistration)

[Azure DNS Private Resolver](https://learn.microsoft.com/en-us/azure/dns/dns-private-resolver-overview) (enables you to query Azure DNS private zones from an on-premises environment and vice versa without deploying VM based DNS servers) - required RG and VNet - no VM based DNS servers
- Sub, RG, Name, Region and VNet
`Search DNS Private Resolvers -> Create | Manage View | Refresh` provide the required 
- Create: 
	- Set VNet and Region
	- Add Endpoints..
		- Inbound / Outbound - provide a name and Subnet 
			- For `Inbound Endpoints` and `Outbound Endpoints` require both a name and separate Subnet
	- `Ruleset` - `+ Add rules` to Domain name resolution requests that match will be forwarded to the IP addresses specified through the endpoint selected
		- Add Rulesets:
			- `Tick Add a ruleset` can be done after creation
				- Ruleset Name
				- Endpoint
		- Rules
			- Rule name: 
			- Domain Name: target domain name
			- Rule State: `Enabled || Disabled`
			- Add a destination - `IP && Port`


Azure Traffic Manager for the Network Watcher can be used the diagnose issues with Azure DNS. 
[Creating an Alias Record to support apex domains](https://learn.microsoft.com/en-us/azure/dns/tutorial-alias-tm) 
- Add DNS label from  `Search -> Public IP addresses -> $resource -> Configuration -> DNS name label & Save`
- Create a traffic manager profile: `Search -> Traffic Manager profile` - consider routing method
- Add endpoint `$TMprofile -> Endpoints`
- Create an Alias Record that points to the Traffic Manager profile: `$DNSzone and + Record set` 
Common pattern - name resolution for multiple networks, where one is focused on registration and the other resolution.
`Vnet1 = Registration <-> Azure Private DNS zone records <-> Vnet2 = Resolution`

DNS servers require network peering to resolve IPs if not using Azure DNS


#### VPN Gateways

VPN Gateway requires: - Subnet, DNS server and VPN device 
`Search -> Virtual Network Gateways -> + Create`
Select:
- VPN or ExpressRoute
- Gateway type
	- Route-based - uses routes in the IP forwarding or routing table to direct packets into their corresponding tunnel interfaces
	- Policy-based -  encrypt and direct packets through [[IPsec]] tunnels based on the IPsec policies - configured with the combinations of address prefixes between your on-premises network and the Azure virtual network
- SKU, Generation (bytes per second), Names, RG, VNet

Vnet-To-Vnet requires a Gateway Subnet Azure recommends reserving /27 and /28 for each address range of each Vnet.  [[IPv4-Subnet-Masks-Dictionary]]

Local Network Gateways - to represent the on-premises site that you want to connect to a virtual network:
`Search -> Local Network Gateways -> + Create`
- (Advanced) Border Gateway Protocol (BGP) - routability and reachable protocol - requires - the minimum prefix you need to declare is the host address of your BGP Peer IP address on your VPN device.

On-Premise VPN devices: shared key and public IP address of your VPN gateway
- Configuration scripts are available for some devices - [Download VPN device configuration scripts for S2S VPN connections](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-download-vpndevicescript) to find a downloadable script for your VPN device.

Create an ExpressRoute
`ExpressRoute -> Create ExpressRoute`; Configuration:
- Provider (name required) | Direct
- Create new | import class
- Peering Location
- Bandwidth
- SKU: Standard | Premium
- Billing Model: Metered | Unlimited
- Allow classic operations? - to allow classic virtual networks to link to the circuit

Get ExpressRoute Service Key
`ExpressRoute Circuit -> Overview -> Service Key`

#### Virtual Network Peering

VNet Peering - requires account with `(Classic) Network Contributor` role
`Search -> Virtual Networks -> $Vnet -> SEttings -> Peering -> Add(peering)` 
- Create in hub, not peers; make NSG rules!
- One Gateway to Transit them All - Vnet-to-Vnet, site-to-site and point-to-site
- VNets must have resources, the first must be made with [[Azure-Administration-Azure-Resource-Manager]], the second is referred to as the remote network.
- [Permissions](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering?tabs=peering-portal#permissions)
- Extending Peering 
	- Hub and spoke network - Central hub for VPN gateway, spoke VNets
	- User-Defined Route (UDR): either a hop to/from:
		- Virtual network gateway
		- Virtual network
		- Internet
		- Network virtual appliance (NVA)
	- Service chaining: define UDRs from VNet to a network virtual appliance or VPN

#### Azure Firewalls

Deploy Azure Firewall requires: Resource Group, VNet,
- **AzureFirewallSubnet** - the firewall is in this subnet.
- **Workload-SN** - the workload server is in this subnet. This subnet's network traffic goes through the firewall.
`Search Firewall -> Create -> Configure $Sub, $rGroup, etc..`
- Create default route 
- Configure rules

If a match is found it terminate processing.

[Azure Firewall Rules](https://learn.microsoft.com/en-us/azure/firewall/rule-processing) are processed based on:
- Firewall Policy 
	- Rule Collection Group Priority - Highest priority is 100 to Lowest priority is 4096
	- Rule Collection priority
- Classic Rules - 100 is Highest and 65,000 is Lowest priority. at can be accessed from a subnet

Type Priority - NAT Rule before Network Rule before Application Rule.
- **NAT** - Azure Firewall destination network address translation (DNAT) rules to translate and filter inbound traffic to your subnets
- **Network** rule - Any non-HTTP/S traffic that's allowed to flow through your firewall must have a network rule
- **Application** rules define fully qualified domain names (FQDNs) that can be accessed from a subnet


## Resource Groups and Resources

Azure Resource Manager provides a consistent management layer to perform tasks through Azure PowerShell, Azure CLI, Azure portal, REST API, and client SDKs.

Important
- SLA - Service Level Agree is ratio of commitments to up time and connectivity
	- VM 99.95% in a Availability Set
	- VM with Premium SSD 99.9%
	- VM with Standard SSD 99.5%
	- VM with Standard HDD 95%

#### Create Resources

Create a Disk
`Search: Disk -> Create -> Basics -> Encryption -> Networking -> Advanced -> Tags -> Review + create` Considerations: SKUs; Size, IOPs and cost; Tags - `review ->` Wait for deployment, `Go to resource` 

- SLA:
	- Premium SSD = 99.9%
	- Standard SSD = 99.5%
	- Standard HDD = 95%

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

[Check the move support resource list](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-support-resources)

Moving Resources - there are edge cases - [see Documentation for more](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-resource-group-and-subscription):
- If you're using Azure Stack Hub, you can't move resources between groups.
- [App Services move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/app-service-move-limitations)
	- No existing Apps or TLS/SSL certificate cross region is not allowed!  
	- Resources in Resource Group always move together!
	- No Apps with private endpoints
- [Azure DevOps Services move guidance](https://learn.microsoft.com/en-us/azure/devops/organizations/billing/change-azure-subscription?toc=/azure/azure-resource-manager/toc.json)
- [Classic deployment model move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/classic-model-move-limitations) - Classic Compute, Classic Storage, Classic Virtual Networks, and Cloud Services 
	- Inter-Sub
	- Lots of Operational restrictions (One-X-at-a-Time or  (No Vnets, VM moved only All VMs only with Cloud Service) not RBAC 
	- Sub-To-Sub 
		- Same AAD Tenant
		- No Cloud Service Provider subs
		- Target must not have Classic Resources
		- REST API for classic moves - no Resource Manager
- [Networking move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/networking-move-limitations)
	- Avoid AKS VNet moves
	- Disable peering
	- No VPN Gateway cross-sub moves
	- Cannot move a Subnet that has resource navigation links 
- [Recovery Services move guidance](https://learn.microsoft.com/en-us/azure/backup/backup-azure-move-recovery-services-vault?toc=/azure/azure-resource-manager/toc.json)
	- Permissions
	- One-At-A-Time
	- Vaults restrictions
		- Key Vault and VMs from same region
		- Only move a vault that contains any of the following types of backup items;
			- Any not listed -  are stopped and data permanently deleted before move:
			- Azure Virtual Machines
			- Microsoft Azure Recovery Services (MARS) Agent
			- Microsoft Azure Backup Server (MABS)
			- Data Protection Manager (DPM)
- [Virtual Machines move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
	- Not yet supported
		- Scale sets with Standard LB and Public IP SKUs 
		- Low-priority VM and SSs
		- Dependents - All or Not att all!
		- Individual Availability Sets
		- Marketplace VMs with attached plans
- To move an Azure subscription to a new management group, see [Move subscriptions](https://learn.microsoft.com/en-us/azure/governance/management-groups/manage#move-subscriptions).

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

Basic Skeleton of template with comments explaining use case
```json
{
  "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "apiProfile": "", // Valure to avoid having to specify API versions foreach resource in the template 
  "parameters": {}, //values passed to template 
  "variables": {}, // transform parameteres or resources properties using function expressions
  "functions": [], // User-Defined functions available within the template
  "resources": [] // Azure resource you want to deploy or update 
}
```

Example Resource use
```json
//...
  "resources": [
      {
          "type": "Microsoft.Storage/storageAccounts", // {ResourceProvider}/ResourceType
          "apiVersion": "2019-01-01", //resource proivdes provider their own API!
          "name": "{provide-unique-name}", // variable used here
          "location": "eastus", //region to be deployed
          "sku": {
              "name": "Standard_LRS"
          },
          "kind": "StorageV2",
          "properties": {
              "supportsHttpsTrafficOnly": true
          }
      }
  ]
//...
```
- Must lookup resource providers API version!


## Azure VMs

Create a VM
`Azure services -> Create resource -> Search (resource - Windows Server)`
Provide configurations for Basic, Disks, Networking (**BEWARE** Azure creates default - it is non trivial to change after creation - CHECK! - Address space and Subnets!), Managemnt, Advanced; Next:
1. Create an NSG
2. Create inbound traffic rule 
3. Attached data disks - best practice on App data storage not temp or C:

Connect to a VM via RDP
`Search All Resources -> $name -> Connect -> select RDP`

Change a VM size requires:
- Stop and deallocate the virtual machine then select any size available in your region.	 
	- Resizing Prod machine is not advised as it might require restart, change IP or configuration settings 

Create an Unmanaged Disk
`..$(Create VM) -> Disk -> Advanced -> Use managed disk -> No`
- Select Storage Account

#### Availability Sets

Availability Set Group of related identical virtual machines are (un)deployed together. An Availability set is
- Built: Azure Portal, ARM, Scripting, API Tools, Managed Disk for Block-Level Storage
- SLA: 99.95%
- Scale sets:
	- Update Domains - is a group of nodes that are upgraded together - `Configure amount`
		- Update Domain - up to 20
			- Are groups of virtual machines and underlying physical hardware that can be rebooted at the same time
			- If 5 Update domains, the 6th will be in the 1st, 7th will in the 2nd, etc - if 20 the 21th VM is in the 1st..
	- Fault Domains -  is a group of nodes that represent a physical unit of failure - `Configure amount`
		- Fault Domain - up to 3
		- Are a group of virtual machines that share a common power source and network switch.
	- Can't be changed once the availability set has been created 
- Use managed disks? `No (Classics) or Yes (Aligned)`
Availability Zone
- Zonal Services pin each resource to a specific zone.
- Zone-Redundant services are zone-redundant, the platform replicates automatically across all zones.

- Wait for `FailoverCommited` to comfirm replication to another region!

#### Azure Automation

Create Automation Account
`Search Automation Accounts -> Automation Accounts -> + Create

Automation Accounts - `Search -> Automataion Accounts -> Create`
`Subscriptions -> Resource Providers` - we need:
- `Microsoft.AlertsManagement` - https://learn.microsoft.com/en-us/azure/azure-monitor/insights/alert-management-solution
- `Microsoft.Insights`  - https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview?tabs=net

Compile Desired State Configuration (DSC) script 
`Search Automation Accounts -> Automation Accounts -> $AutomationAccount -> State configuration (DSC) -> Configurations -> Select DSC script -> Compile -> Yes`

Register VMs with your Azure Automation Account
`Search Automation Accounts -> Automation Accounts -> $AutomationAccount -> State configuration (DSC) -> Nodes + Add -> Configure settings -> Confirm`

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

#### VM Scale Sets

Create and Manage VM Scale Sets
`Search -> Virtual machine scale sets` 
Considerations:
Scale sets are assigned to (like Availability sets):
- Update Domains - is a group of nodes that are upgraded together
- Fault Domains -  is a group of nodes that represent a physical unit of failure
- Basics
	- Orchestration mode:
		- Uniform - for large scale stateless workloads with identical instances - department workstation
		- Flexible - high availability at scale with identical or multiple instances - any configuration to the scale set.
	- Advanced tab to enable beyond 100 instances; spreading for optimal spreading of allocation 
	- Configure Scaling in the `Scaling` tab; 
		 - Policy - min/max number of instances; manual or autoscaling 
		 - Scale in - CPU threshold, decrease of instances
		 - Scale out - CPU threshold, duration, increase of instances
		 - Scale-In policy - default, newest, oldest VMs
	- Size = Price; Azure Spot - discount unused pool ; image = OS, arch = x86 or arm64
		- Azure Spot must have set a eviction policy as Azure has capacity needs:
			- Deallocation - moves your VM to the stopped-deallocated state, allowing you to redeploy it later, with not guarantee of allocation success, you'll be charged storage costs for the underlying disks.
			- Delete - VMs is deleted with underlying disk 
- Continue with Disk, 
- Implement Virtual Networking `Search -> Virtual Network -> $Vnet (With Subnet, VMs, DNS, NSGs, etc configured)` in the `Private DNS Zone -> Virtual Network Link -> + Add - provide a Link name, Vnet` 
- Scaling - Configure Scaling in the `Scaling` tab:
	 - Policy - min/max number of instances; Manual or Autoscaling 
		- Manual - maintains a fixed instance count
		- Autoscaling -  scales the capacity on any schedule, based on any metrics.
	- Scale-In policy - default, newest, oldest VMs
		 -  Scale in - by **an decrease in** X percentage and Y number of VM instances 
	- Scale-out Policy
		- Scale out - **increase in** X percentage, Y duration and by Z number of VM instances 
- Management, Health, Tags and Review and Create
- Advanced tab
	- to enable beyond 100 instances; spreading for optimal spreading of allocation

Size Scaling
`Virtual Machines -> $VM -> Size -> Resize by select new size`
Disk Scaling
`Virtual Machines -> $VM -> Disks -> + Create and Attach a new disk -> provide a name and size (GiB)` 

Register resource providers
```powershell
Register-AzResourceProvider -ProviderNamespace $RP
```

Deploy a zone-resilient Azure VM scale set with Portal
`Search -> Virtual machine scale sets -> + Create -> Provide: Name, Resource Group and Zones! - Orchestration mode!, Image,Size` - Add to or Create a VNet; configure NIC NSG and consider `Load balancer`; Scaling; Management `Monitoring: managed or custom` - do not disable; `Advanced - Spreading and Beyond 100 instances;`

Upgrading VM scale sets
Load a script with Script with Custom Script Extension (automatically launch and execute virtual machine customization tasks after initial machine configuration - timesout after 90 minutes)
`Search -> VM scale sets -> Instances -> Select instances -> Upgrade` - check with Load balancer Frontend IP: `Search -> Load Balancers -> $LoadBalancer -> Frontend IP configuration -> Copy address` 

`Search -> VM Scale Sets -> Scaling -> Manual Scaling or Custom autoscale`
If Custom:
- Configure the Default auto created scale condition 
	- Add rules!!!
	- Scale mode - metric or instance count
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

Custom Script Extension (automatically launch and execute virtual machine customisation tasks after initial machine configuration - times out after 90 minutes) - Container with a custom IIS web server
- Storage Account with scripts, container for web server
`VMs -> $Container -> Extensions + Add -> Custom Script Extension -> Upload scripts from Storage Account`

Export Template, custom template for mass use
`VMs -> $CustomVM -> Export Template`

## Storage Accounts

Create in Azure Software Development Kit SDK or Portal `Storage Account -> Share Access signature`.

Create Storage Account `Search -> Storage Accounts`, provide name, location, redundancy 

Configure Azure Storage Encryption:
`Storage accounts -> $storage_accounts -> EncBootstrap web applications

Configure Disk Encryption:
`Search -> Storage Account -> $StorageAcc -> Add (GPv2 or Premium block blob) -> Encryption:`
- Type:
	- Microsoft-Managed keys
	- Customer Managed Keys
- Support for CMKs - Cannot change after creation
	- Blobs and file only
	- All service types
- Enable Infrastructure Encryption - Cannot change after creation

Create an Azure Files Share - [[Azure-Administration-Files-And-File-Sync]]
`Storage Account -> $storage_account -> File Shares`
- Open port 445 - check firewall - [[Azure-Administration-Azure-Firewall]]
- Enable - `Secure tranfer required`
- File mounting can be done on-demand with:
	- Windows - `Azure Portal -> Resource Groups -> Azure Files -> $FileShare -> Connect`:
		- Specify Drive
		- Authentication method:
			- Active Directory
			- Storage Account Key
	- Linux - the `mount` command or on-boot (persistent) by creating an entry in `/etc/fstab`.

Accessing a Azure a File Share - Mount with File explorer!
UNC pathing:  `\\$StorageAccount.file.core.windows.net\$FileShare` 


[Deploy File Sync](https://learn.microsoft.com/en-us/azure/storage/file-sync/file-sync-deployment-guide) - [[Azure-Administration-Files-And-File-Sync]]
- Only for:
	- Standard file shares (GPv2), LRS/ZRS
	- Standard file shares (GPv2), GRS/GZRS
	- Premium file shares (FileStorage), LRS/ZRS
`Azure File Sync -> Create` - Marketplace - not default, but covered in AZ 104
1. Deploy the Storage Sync Service
	- Configure:
		- The deployment name for the Storage Sync Service
		- The Azure subscription ID to use for the deployment
		- A Resource Group for the deployment
		- The deployment location
2. Prepare Windows Server(s)
	1. Install Azure File Sync agent
	2. Register servers with Storage Sync Service
		- The Storage Sync Service deployment name
		- The Resource Group for the deployment


Azure File Sync agent:
```powershell
Microsoft.StorageSync
```

- Beware Legacy and older generation require PowerShell at 5.1
- And may require disabling of Internet Explorer Enhanced Security for Admins and Users - **ONLY** for initial server registration! - RESET!
	- FileSyncSvc.exe - service; StorageSync.sys - system filter; PowerShell cmdlets:
```powershell
# Default location for cmdlets 
C:\\Program Files\\Azure\\StorageSyncAgent\\StorageSync.Management.PowerShell.Cmdlets.dll
C:\\Program Files\\Azure\\StorageSyncAgent\\StorageSync.Management.ServerCmdlets.dll
```

Create file share snapshots
`Storage Account -> $storage_account -> File Shares -> $file_share -> Snapshots

Create Container for Blob Storage
`Azure Storage accounts -> + Container -> Name and Change "Public Access Level"`

Use Azure Blob Storage Lifecycle management policy rules to:
`Storage Account -> $storage_account -> Lifecycle Management`
- Rule-based run scheduling
- Rule-based condition to containers or a subset of blobs
	- Access tracking
- Delete blobs 
- Transition Storage tier 

Create a Stored Access Policy for a Container
`Storage Accounts -> $storage_account -> Container -> Access Policy`

List or Add rules for Lifecycle Policy management 
`Search Storage Account -> $storageAccount -> Data Management -> Lifecycle Management -> List View | Add rules`

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

URL for Azure remote container: `Home -> Storage Accounts -> $ContainerName -> Properties` - must be globally unique!

Create a SAS:
`Storage Accounts -> $storage_account -> search SAS` configure and `Generate SAS and connection string`. Used for:
- Connection strings
- SAS Token
- Blob service SAS URL
- Queue service SAS URL
- Table service SAS URL

Can be done from `$resource`

URI Format with parameters explained
```powershell
https://myaccount.blob.core.windows.net/$containerName/file.txt
# REQUIRED
?sv= # Signed version - signature version! 
&st # Start Time
&se # Expiration Time
&sr # Storage Resource - b for blob, q for queue 
&sp # permissions  r, wr
&sig # SHA256 hash - the signature
# "Some" Optional
&ss # Storage service
&sip # IP range
&spr # Protocol
```
See [Create a service SAS - Azure Storage | Microsoft Learn](https://learn.microsoft.com/en-us/rest/api/storageservices/create-service-sas)

Storage access
**Container service** - `//`**`mystorageaccount`**`.blob.core.windows.net`
**Table service** - `//`**`mystorageaccount`**`.table.core.windows.net` 
**Queue service** - `//`**`mystorageaccount`**`.queue.core.windows.net`
**File service** - `//`**`mystorageaccount`**`.file.core.windows.net`
**Blob Access** - `//`**`mystorageaccount`**`.blob.core.windows.net/`**`mycontainer`**`/`**`myblob`**.

Configure Custom Domains - Either:
- Direct mapping - create a `CNAME` record
- Intermediary domain mapping (when domain is already in use) - prepend `asverify` to subdomain it permit Azure to recognise your custom domain thereby using a intermediary domain to validate the domain.

Secure Storage endpoints
`Storage Accounts -> $storage_account -> Networking Firewalls and virtual networks`; restrict access:
- Enabled from all networks
- Enabled from selected virtual networks and IP address
- Disabled

Job | Storage Service | Supported | Not supported 
--- | --- |--- | ---
Import | Azure Blob Storage  |  Block blobs and Page blobs supported | -  
.. | Azure Files storage |  Files supported  | ..
Export | Azure Blob Storage | Block blobs, Page blobs, and Append blobs supported | Azure Files not supported  
.. | .. | .. | Export from Archive tier not supported

Shipping with physical disk drives large amounts of data to a Azure Blob and Azure Files to a Azure data centre with CLI tool for preparation - `WAImportExport` - Consideration
- Export only from Azure Blob
- Up to 10 empty drives per job
- The WAImportExport tool is available in two versions:
	- Version 1 is best for importing and exporting data in Azure Blob Storage.
	- Version 2 is best for importing data into Azure Files.
	- The WAImportExport tool is only compatible with 64-bit Windows operating system. For the list of supported operating systems and versions, see [Azure Import/Export requirements](https://learn.microsoft.com/en-us/azure/import-export/storage-import-export-requirements#supported-operating-systems).
	
Import/Export Jobs - physical disk to data centre
1. Identity data
2. Calculate transportation disk requirement
3. `Azure Export Jobs` or install and run `WAImportExport` to copy data to disk
4. Physical transportation

Create an Azure Export Job
1. Identify the data in Azure Blob Storage to export.
2. Determine the number of disks needed to accommodate the data to transfer.
3. In the Azure portal, create an Azure Export job and provide the following information:
    - The Azure Storage account to use for the Export job
    - The blob data to export
    - The return address for shipment of your disks
    - Your shipment carrier account number
4. Ship the required number of disks to the Azure region datacenter that hosts the storage account. Note the shipment tracking number.
5. Update the Export job to include the shipment tracking number.
6. After the disks arrive at the Azure datacenter, the staff completes the following tasks:
    1. The specified data in the storage account is copied to the disks you provided.
    2. The disk volumes are encrypted by using BitLocker.
    3. The disks are shipped back to you.
- The BitLocker keys used to encrypt your disks are stored with the specified storage account in the Azure portal. You can decrypt the content of the disks and copy the data to your on-premises storage

[Import Job to Azure Files](https://learn.microsoft.com/en-us/azure/import-export/storage-import-export-data-to-files?tabs=azure-portal-preview)
1. Prep Drives
	1. Single NTFS volume per drive
	2. Modify dataset.csv
		- Import file or folder or both
	3. If specify encryption state either `Encrypt` to enable Bitlocker or `AlreadyEncrypted` and supply Bitlocker key 
2. Create Import Job
	 - `Search -> Azure Data Box` - prep transfer
		1. Select the **Import to Azure** transfer type.
		2. Select the subscription to use for the Import/Export job.
		3. Select a resource group.
		4. Select the **Source country/region** for the job.
		5. Select the **Destination Azure region** for the job.
		6. Then select **Apply**.
	- Create Job 
3. Ship Data Box
4. Update job with tracking information
5. Verify Data upload to Azure

Add more drives use the same journal file; add the `AdditionalDriveSet`
```powershell
WAImportExport.exe PrepImport /j:<JournalFile> /id:<SessionId> /AdditionalDriveSet:<driveset.csv>
```

[Import Blob to Blob Storage](https://learn.microsoft.com/en-us/azure/import-export/storage-import-export-data-to-blobs?tabs=azure-portal-preview)
- Prep data and disks
1. Connect disk drive via SATA connectors
2. Single NTFS volume per drive - no mount points
3. Bitlocker Encryption
4. `Robocopy` data 
5. Use `WaImportExport.exe`
```powershell
./WAImportExport.exe PrepImport /j:<journal file name> /id:session<session number> /t:<Drive letter> /bk:<BitLocker key> /srcdir:<Drive letter>:\ /dstdir:<Container name>/ /blobtype:<BlockBlob or PageBlob> /skipwrite
```
6. Get Bitlocker key of drive `manage-bde -protectors -get <DriveLetter>:`
7. Prep Disk
- Create Job - will check if it passes validation
- (Optional) Configure customer managed key - for customers using Microsoft manage key 
- Ship drive
- Update Job with tracking information
- Verify Data upload to Azure

`StorageExplorer.exe` - manage the data stored in multiple Azure storage accounts and across Azure subscriptions.
- Sign-in through `StorageExplorer.exe` with an Azure Account
	- Add a resource via Azure AD, choosing the Azure tenant and the associated account
- Or SAS
	- Then find connection node: `Local & attached > Storage Accounts > Attached Container > Service`
- Or with Storage account name and key
- For Data Lake Storage Gen1:
	-  URI associated with the data lake

List or Add rules for Lifecycle Policy management 
`Search Storage Account -> $storageAccount -> Data Management -> Lifecycle Management -> List View | Add rules`

Create Container for Blob Storage
`Azure Storage accounts -> + Container -> Name and Change "Public Access Level"`:
**Public access level**: The access level specifies whether the container and its blobs can be accessed publicly. By default, container data is private and visible only to the account owner. There are three access level choices:
- **Private**: (Default) Prohibit anonymous access to the container and blobs.
- **Blob**: Allow anonymous public read access for the blobs only.
- **Container**: Allow anonymous public read and list access to the entire container, including the blobs.

See Tiering for Hot, Cold, Archive and Premium Storage

Use Azure Blob Storage Lifecycle management policy rules to:
`Storage Account -> $storage_account -> Lifecycle Management`
- Rule-based run scheduling
- Rule-based condition to containers or a subset of blobs
- Delete blobs 
- Transition Storage tier 

Object replication copies blobs in a container asynchronously according to policy rules that you configure. 
- During the replication process, the following contents are copied from the source container to the destination container:
	- The blob contents
	- The blob metadata and properties
	- Any versions of data associated with the blob
- Requires:
	- Versioning enabled
	- Does not support snapshots
	- Replication Policy
- Considerations:
	- Latency reductions
	- Efficiency for compute workloads
	- Data distribution
	- Costs benefit

Create a storage account:
`Storage Accounts`
Create Container for blobs
`Storage Accounts -> $storage_account -> Containers
Upload Blob
`Storage Accounts -> $storage_account -> Containers -> $container -> Upload`
Move Data to, from, or within Azure Storage
`Storage Accounts -> $storage_account -> Diagnose and solve problems`
Monitor Storage Accounts
`Storage Accounts -> $storage_account -> Insights`

|Upload tool|Description|
|---|---|
|**AzCopy**|An easy-to-use command-line tool for Windows and Linux. You can copy data to and from Blob Storage, across containers, and across storage accounts.|
|**Azure Data Box Disk**|A service for transferring on-premises data to Blob Storage when large datasets or network constraints make uploading data over the wire unrealistic. You can use Azure Data Box Disk to request solid-state disks (SSDs) from Microsoft. You can copy your data to those disks and ship them back to Microsoft to be uploaded into Blob Storage.|
|**Azure Import/Export**|A service that helps you export large amounts of data from your storage account to hard drives that you provide and that Microsoft then ships back to you with your data.|


## Azure App Services

[App Service Plans](https://learn.microsoft.com/en-us/azure/app-service/overview-hosting-plans) are PaaS - supports lots of Languages for gRPC and HTTP related App. 
- Has a variety of tierings. 
- It can autoscales nodes - Vertically and Horizontally
- Multiple Apps per Service Plan
- Deployment slots 
	- Can be swap with Virtual IPs no route tabling

- Some Apps require multiple Subnets per service, per context!!:
	- Web = DB, Front End, Processing - one for each layer!

Azure App Services  -  Create a Web app
`All resources -> Create a Resource -> Create a web app` 
or 
`Search -> App Services + Create`
Basics 
- Resource Group
- Publish: Code, Docker Container or Static Web App
- Runtime stack
Deployment 
- Automated 
	- Azure DevSec Ops Service
	- Github
		- Github actions - continuous deployment!
	- Bitbucket similar to Github 
- Manual
	- Git
	- CLI
	- [[Microsoft-Visual-Studios]]
	- Zip Deployment
	- FTP/S - please use encrypted FTP or you will be in a lot of trouble.
- Use Deployment slot
	- Swapping between staging and production environments 
	- Development slots are live apps with their own Hostnames 
Networking:
- Public access and network injection toggles
Monitoring:
- Insights
Tags:
- TAGS TAGS TAGS!
`App services` authorisation behaviours:
- Allow unauthenticated requests
- Require authentication
- Extras
	- Always On: keep application loaded even when there is no traffic
	- ARR Affinity - in multi-instance deployment ensure app client is routed to same instance for life of the session
	- Connection strings: encrypted at rest and transmitted over encryption

Create a staging deployment slot and configure deployment 
`App Services -> $App -> Deployment Slots -> + Add Slot`
Then
`$App -> Deployment Centre -> Select a Source -> Save`

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
# Authenticate
```

Deployment Slots 
`Search -> App Services -> $App -> Deployment Slots -> + Add slot  

Deployment Swaps - Swap between slots
`Search -> App Services -> $App -> Deployment Slots -> Swap`
- Select Source and Target
[Swap operations](https://learn.microsoft.com/en-us/azure/app-service/deploy-staging-slots):
1. Target requires, then wait: 
	- Slot-specific app settings and connection strings
	- Continuous deployment
	- App Services authentication 
2. If local cache is enabled 
	- Trigger local cache initialisation - HTTP request to root `/` on each app 
3. If Auto swap is enabled with custom warm-up trigger `applicationInitialization` (if not specified)
4. All warmed up? - Swap slots by switching the routing rules for the two slots
5. Source slot has Pre-swap app previously in the target slot, perform the same operation by applying all settings and restarting the instances. No need to to re-route, it is stored
- BEWARE
	- Slot != App; Slot is more like a host:
![](azslotswappedsettingsvsslotspecificsettings.png)

Configure Application
- General Settings:
	- `Search App Services -> $App -> Configuration -> General Settings`
		- Stack settings
		- Platform settings
		- Debugging
		- Incoming Client Certificates
- Application Settings:
	- `Search App Services -> $App -> Configuration -> Application Settings`
	- Edit in bulk or configure connection strings for non-ASP variant applications
		- `-> Advanced && modify JSON -> Update`
- Configure Path Mappings
	- `Search App Services -> $App -> Configuration -> Path Mappings`
		- Windows `-> New Handler`
			- **Extension**: The file extension you want to handle, such as .php or handler.fcgi.
			- **Script processor**: The absolute path of the script processor. Requests to files that match the file extension are processed by the script processor. Use the path `D:\home\site\wwwroot` to refer to your app's root directory.
			- **Arguments**: Optional command-line arguments for the script processor.
		- Linux `-> New Azure Storage Mount`  configure:
			- **Name**: The display name.
			- **Configuration options**: Basic or Advanced.
			- **Storage accounts**: The storage account with the container you want.
			- **Storage type**: **Azure Blobs** or **Azure Files**. Windows container apps only support Azure Files.
			- **Storage container**: For basic configuration, the container you want.
			- **Share name**: For advanced configuration, the file share name.
			- **Access key**: For advanced configuration, the access key.
			- **Mount path**: The absolute path in your container to mount the custom storage.

`$app -> Certificates` for either: 

|  |  | 
|---|---|
|Create a free App Service managed certificate|A private certificate that's free of charge and easy to use if you just need to secure your [custom domain](https://learn.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain) in App Service.|
|Import an App Service certificate|A private certificate that's managed by Azure. It combines the simplicity of automated certificate management and the flexibility of renewal and export options.|
|Import a certificate from Key Vault|Useful if you use [Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/) to manage your [PKCS12 certificates](https://wikipedia.org/wiki/PKCS_12). See [Private certificate requirements](https://learn.microsoft.com/en-us/azure/app-service/configure-ssl-certificate?tabs=apex#private-certificate-requirements).|
|Upload a private certificate|If you already have a private certificate from a third-party provider, you can upload it. See [Private certificate requirements](https://learn.microsoft.com/en-us/azure/app-service/configure-ssl-certificate?tabs=apex#private-certificate-requirements).|
|Upload a public certificate|Public certificates aren't used to secure custom domains, but you can load them into your code if you need them to access remote resources.|

[Beware Caveats!](https://learn.microsoft.com/en-us/azure/app-service/configure-ssl-certificate?tabs=apex)

Create a Custom Domain for an Azure App Service
`Search -> App Services -> Custom Domains`
- `Search -> Domain Names` and reserve directly in the Azure portal
- Create DNS records - either `A` or `CNAME`
- Enable

Backup Azure App Service (App configuration settings, File content, connected Databases) - requires:
- Standard or Premium tier App Service plan 
- Full backup is default; partial backups are supported; 10 GB in size
	- Each consists of
		- Zip file containing back-up data
		- The XML manifest file of the zipped content
- Storage Container - [[Azure-Administration-Storage-Accounts]]
Provide the in `App Services -> $App -> Backup `
- Check firewall on storage account!`

## Azure Containerisation

Deploy a Windows or Linux Container using Azure Container Instances 
`Search -> Container Instances -> + Create`
- Basic - Resource Group 
- Networking - DNS name label
- Advanced - Restart policy

[[Docker]] Containers need to be built then published - [[Azure-DevOps]]

#### Azure Logic Apps

Graphical-based orchestration of business logic, serverless, runs on Azure Functions that are triggerable. Can have many Connectors and a template.

#### Azure Spring App

[[Spring]] is a Java based framework

#### Azure Container Apps

Azure Container Apps is a fully managed environment that enables you to run microservices and containerised applications on a serverless platform. Common uses of Azure Container Apps include:
- Deploying API endpoints
- Hosting background processing applications
- Handling event-driven processing
- Running microservices

Micro services with easy containerisation with [DAPR](https://learn.microsoft.com/en-us/azure/container-apps/dapr-overview?tabs=bicep1%2Cyaml) and KEDA without the complexity of Kubernetes 

#### AKS

- Important
	- Resource Group require pre-AKS-Workflow
	- `kubectl` is the only way [[Kubernetes]]
	- 10 second heartbeat

Check if registered
`Search -> Subscriptions -> $Subscription -> Resource Providers`

`Search -> Kubernetes Services -> + Create (either): + Create a Kubernetes cluster | + Add a Kubernetes cluster with Azure Arc`
Basic: 
- Availability Zones - (consider full removal for high availability)
- Scale method: Manual or Autoscale
- Node Count: 1 - 5 
Node pools - configure here
Access - RBAC and AKS-managed Microsoft Entra ID 
Networking
Integrations - Container Monitoring

Add Node pools 
`Search -> Kubernetes Services -> $KubernetesService -> Node Pools `

Scale Node pool deployed 
`Search -> Kubernetes Services -> $KubernetesService -> Node Pools -> $NodePool -> Scale Node pool` - configure and apply.

Check the bash section  for CLI deployment and scaling.

- Linux requires: `/var/run/reboot-required` - reboot not automatic

```bash
# Add the Kured Helm repository
helm repo add kubereboot https://kubereboot.github.io/charts/

# Update your local Helm chart repository cache
helm repo update

# Create a dedicated namespace where you would like to deploy kured into
kubectl create namespace kured

# Install kured in that namespace with Helm 3 (only on Linux nodes, kured is not working on Windows nodes)
helm install my-release kubereboot/kured --namespace kured --set nodeSelector."kubernetes\.io/os"=linux
```

#### Azure Functions

[Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/functions-overview) are serverless workloads to save technical and monetary costs of some services - compute-on-demand 

## Azure Backup

- Backups only occur within region! - Region (RSV, Application/Resource)

Backup Centre
`Search -> Backup Center`:
- `+ Backup`
- `<- Restore`
- `+ Policy`
- `+ Vault`

Backup Workflows
1. Create a Recovery Services Vault - choose LRS/GRS
2. Define a backup policy - when and retention length of data snapshots
3. Backup VMs, etc..
	1. Mindful of defaults - VMs is 30 days

Create a Recovery Service Vault
`Search -> Recovery Services vaults -> + Create`
- Multi-select for backup "What you want to backup" options


Create Backup Vault
`Search -> Backup Vault -> + Create`

Configure replication of recover Service Vault
`$Backup -> Properties -> Backup Configuration -> Update `
- Choose: `Geo-redundant | Locally redundant | Zone redundant`

Implement System Centre Data Protection Manager (DPM) and or Microsoft Azure Backup Server (MABS - On-Premise-to-cloud backup!)
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
- Installation Setup Wizard
- Download the Vault Credentials

Restore or File Recovery VM
`Search Recovery Services Vaults -> $rsv -> Backup items -> Azure Virtual Machines -> $VM -> Restore VM / File Recovery`

Recovery Files:
Locally
`Microsoft Azure Backup Application- > Recover Data -> Select Mode, Volume and Data `
Virtual Snapshots:
`Search Recovery Services Vaults -> $rsv -> Backup items -> $AzureVM -> View Details -> File Recovery -> Download Executable -> Open IaaSVMILRExeForWindows.exe -> copy and paste Password to run Script into IaaSVMILRExeForWindows.exe`, then
On Host open `cmd.exe` with [robocopy]((https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy):
```powershell
# Copy from the mounted virtual snapshosts
# Consider permissions!
robocopy G:\File\Path\To\Dir C:\File\Path\To\Dir $file /r:1 /w:1 
```
Then `Unmount Disks`

Azure Recovery Services soft delete 
`Search Recovery Services Vaults -> $rsv -> Backup items -> Azure Backup Agent -> View Details -> $ComputerName -> Delete -> Type the Server name* & Provide Reason & Add comment for professionalism & Tick and Delete`

Stop Backup and Deal with Data retention
`Search Recovery Services Vaults -> $rsv -> Backup items -> Azure Virtual Machine -> View Details -> Stop Backup`, then pick to:
- Retain Backup Data 
- Delete Backup Data
	- Type the name of the backup item* ; add a Reason and comment  

Undelete Backup that has Backup Disabled 
`Search Recovery Services Vaults -> $rsv -> Backup items -> $Backup -> Undelete`

Delete Backup Data Backup
`Search Recovery Services Vaults -> $rsv -> Backup items -> $Backup -> Delete backup data`

#### Failover and Reprotection

Failover to secondary region and Re-Protect (replicate back) to primary region 
From a `$VM -> Overview -> Failover`
- Choose:
	- `Latest processed`: Uses the latest recovery point processed by Site Recovery. The time stamp is shown. No time is spent processing data, so it provides a low recovery time objective (RTO).
	- `Latest`: Processes all the data sent to Site Recovery, to create a recovery point for each VM before failing over to it. Provides the lowest recovery point objective (RPO), because all data is replicated to Site Recovery when the failover is triggered.
	- `Latest app-consistent`: This option fails over VMs to the latest app-consistent recovery point. The time stamp is shown.
	- `Custom`: Fail over to particular recovery point. Custom is only available when you fail over a single VM, and don't use a recovery plan.`
- Be aware of adding disk after enabling replication - where are the replication points and which is to be replicated? 
- `(un)Tick - Shut down machine before beginning failover` 
- If satified with failover select `Overview -> Commit`
	- `Commit` deletes all available recovery points for VM in Site Recovery and cannot change the recovery point! 
- After failover, you reprotect the VM in secodary region to replicates back to the primary region 

Reprotect back to primary region
- Prerequisites: Set up replication
- `$Vault -> $VM` - VM should be in `Protected` state, `Select Failover`: 
	- Choose:
		- `Latest processed`: Uses the latest recovery point processed by Site Recovery. The time stamp is shown. No time is spent processing data, so it provides a low recovery time objective (RTO).
		- `Latest`: Processes all the data sent to Site Recovery, to create a recovery point for each VM before failing over to it. Provides the lowest recovery point objective (RPO), because all data is replicated to Site Recovery when the failover is triggered.
		- `Latest app-consistent`: This option fails over VMs to the latest app-consistent recovery point. The time stamp is shown.
		- `Custom`: Fail over to particular recovery point. Custom is only available when you fail over a single VM, and don't use a recovery plan.`
	- Be aware of adding disk after enabling replication - where are the replication points and which is to be replicated? 
	- `(un)Tick - Shut down machine before beginning failover`
-  `$Vault -> $VM -> Select Re-protect`

## Azure Monitor

Access Azure Monitor
`Search -> Monitor`

Access Network Watcher
`Search -> Network Watcher`
- One NW per region with:
Features:
- IP flow: internet or on-premise connection
- Next hop: routing configuration 
- VPN troubleshoot: VPN gateway or connection
- NSG flow logs: to map IP traffic through a NSG
- Connection Troubleshoot: Connective issues in Azure 
- Connection Monitor: end-to-end connection monitoring


[Diagnostic Extension]([Azure Diagnostics extension overview - Azure Monitor | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/diagnostics-extension-overview)) -  or Boot Diagnostics, Storage Explorer, Metrics - Autoscaling and Alerts, Data for [Azure Event Hubs](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/diagnostics-extension-stream-event-hubs)
- **Only Azure Resources and Azure Monitor Logs**
Configure VM for Log Analytics - Install and Configure Azure Diagnostics for Windows (WAD)
`Search -> Virtual Machines -> $VM -> (Metrics - for default Monitoring) Diagnostic settings -> Select a Diagnostics storage account & Enable guest-level monitoring` then configure: 
- Performance Counters
- Logs
- Crash dumps Sinks 
- Agents
	- Azure Custom Script Extension is used for post-deployment configuration, software installation, or any other configuration or management task.
	- Desired State Configuration (DSC) is a management platform to manage an IT and development infrastructure with configuration as code.
	- Log Analytics agent for Log Analytics Workspaces
		- for Linux as part of a solution to collect JSON output
	- Azure VMAccess Extension acts as a KVM switch that allows you to access the console to reset access to Linux or perform disk-level maintenance.
Then `$VM -> Logs -> Enable -> chooose a Log Analytucs Workspace -> Enable `

- Azure Storage Explorer
	- Requires: 	
		- (Azure Resource Manager)
	- Connect to storage accounts associated with your Azure subscriptions.
	- Connect to storage accounts and services that are shared from other Azure subscriptions.
	- Connect to and manage local storage by using the Azure Storage Emulator.
		- Sign-in through `StorageExplorer.exe` with an Azure Account
		- Add a resource via Azure AD, choosing the Azure tenant and the associated account
	- Or SAS
		- Then find connection node: `Local & attached > Storage Accounts > Attached Container > Service`
	- Or with Storage account name and key
	- For Data Lake Storage Gen1:
		-  URI associated with the data lake

[IT Service Management Connector](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/itsmc-definition#install-it-service-management-connector) - Integrate Azure Monitor with (non)Azure (only ITSM supported products) to resolve issues; can installed on LA Workspaces
`Markplace -> ITSMC`; to connect `Resources -> $resource (include LA Workspaces) -> ITSM Connections`
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

Create Action Groups - collection of notification preferences
`Search -> Alerts -> Action Groups`
- SMS - 5 Minute cooldown  

Log Analytics Querying - Has drop down listing of useful input!
`Search -> Monitor -> Logs -> Select a scope -> (Tables | Queries | Functions | Filters)  -> Run Query`
- You can click to collapse the left panel

Create and Configure Log Analytics workspaces - Good Workspace design equals better Analytics!
`Search Log Analytics workspaces -> Log Analytics workspaces -> Create`
`Search Automation Accounts -> Create -> $LAWrGroup` - check [supported mappings](https://learn.microsoft.com/en-us/azure/automation/how-to/region-mappings) then `$AutomationAccount -> Inventory -> Select Log Analytics workspace -> $LAW & Enable` then `Update Management -> Enable`

Configure VM for Log Analytics - with [Diagnostic Extension]([Azure Diagnostics extension overview - Azure Monitor | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/diagnostics-extension-overview)) - Boot Diagnostics, Storage Explorer, Metrics - Autoscaling and Alerts, Data for [Azure Event Hubs](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/diagnostics-extension-stream-event-hubs)
- **Only Azure Resources and Azure Monitor Logs**
Install and Configure Azure Diagnostics for Windows (WAD)
`Search -> Virtual Machines -> $VM -> (Metrics - for default Monitoring) Diagnostic settings -> Select a Diagnostics storage account & Enable guest-level monitoring` then configure: 
- Performance Counters
- Logs
- Crash dumps Sinks 
- Agent
Then `$VM -> Logs -> Enable -> chooose a Log Analytics Workspace -> Enable `

Deploy Log Analytics - beware the access control
Access mode - either
- `Resource-context`: view logs for resources in all tables you have access to - queries scope to all data in all tables
- `Workspace-context`: access to all logs in a workspace - queries scope to resource
Access control mode 
- `Require workspace permissions`: all data in any table where permission are defined 
- ` Use resource or workspace permissions`: granular RBAC
Table level RBAC - requires Azure custom roles to either grant or deny access to specific tables, either  `Workspace-context` or  `Resource-context`

#### KGL Log queries 
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

// Heartbeat data source reports the health of all computers that report to LA Workspace
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
`Monitor -> Monitoring -> Insights -> Select Enable & Refresh`; available Graphs:
- Logical Disk Performance
- CPU Utilisation
- Available Memory
- Logical Disk IOPS
- Logical Disk MB/s
- Logical Disk Latency (ms)
- Max Logical Disk Used %
- Bytes Sent Rate
- Bytes Received Rate

#### Network Watcher

Important 
- `NetworkWatcherAgentWindows` agent is an extension that required on Azure VMs!
- 1 Network Watcher per region 
- `Packet capture` - Automate remote network monitoring and triggering alerts from packet capture
	-  `Network Watcher -> Packet capture`
- Network Security Group Flow Logs (NSG Flow Logs) for network traffic pattern collection
- `VPN troubleshoot` - Diagnose VPN issues
	- `Network Watcher -> VPN troubleshoot
- Visual Network Typology 
	- `Network Watcher -> Topology`
- `Connection Troubleshoot` - suite of networking tools and capabilities to troubleshoots network performance and connectivity issues in Azure.
	 - `Network Watcher -> Connection troubleshoot`
- `Verify IP flow` -  IP flow verify checks if a packet is allowed or denied to or from a virtual machine. Identify based on NSGs
	- `Network Watcher -> IP flow verify`
- `Next Hop` - determine if traffic is being directed to the intended destination by showing the next hop
	- `Network Watcher -> Next Hop`
- `Connection Monitor` - provides unified, end-to-end connection monitoring in your Azure and hybrid networks!
- `Traffic Analytics` - is a cloud-based solution that provides visibility into user and application activity in your cloud networks by analyses NSG flow logs
- `Network Typology` - visualise a virtual network



## AzCopy 

[AZCopy]((https://learn.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy) - CLI - downloadable executable copy blobs or files to or from a storage accounts; [AzCopy](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-files) is installed by default on the CloudShell
```powershell
# Make file shares
azcopy make 'https://<storage-account-name>.file.core.windows.net/<file-share-name><SAS-token>'

# Upload files or directories
# Suport wildcard 
azcopy copy $localpath $remotepath # upload
# Download
azcopy copy $remotepath $localpath # download
azcopy login # create URI to login

# Supported by not recommended - doesn't support differential copies at scale
# Useful in Temporary File deletion and Syncing between Shares
azcopy sync $localpath $remotepath --delete-desitnation true
```

URL for Azure remote container: `Home -> Storage Accounts -> $ContainerName -> Properties`

Create a SAS for container `Home -> Storage Accounts -> $ContainerName -> Shared Access Signature` configure and `Generate SAS and connection string`. It will generate connections strings for: 
- Connection strings
- SAS Token
- Blob service SAS URL
- Queue service SAS URL
- Take service SAS URL

## Kubectl

[[Kubernetes]]

## Azure CLI

Mostly a mirror with the information from [[Azure-Administration-Azure-CLI]]

Full actual documentation:
- [Azure CLI overview](https://learn.microsoft.com/en-us/cli/azure/)
- [Azure CLI command reference](https://learn.microsoft.com/en-us/cli/azure/reference-index)

Variables in Bash `Variable` and in PowerShell `$Variable`; `export $v` and `set $v` for current session environment variable creation.

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
az vm create \ 
	--resource-group $ResourceGroup
	--name $VmName 
	--image $image
	--public-ip-sku $SKU
	--admin-username $username
# Use the az module to restart a machine 
az vm restart --resource-group $ResourceGroup -n $VmName
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

Delete a Resource Group
```bash
az group delete \
      --name myResourceGroup \
      --yes
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
az vm deletegroup
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

View current upgrade policy of Virtual Machine Scale Set
```bash
az vmss show \
    --name webServerScaleSet \
    --resource-group myResourceGroup \
    --query upgradePolicy.mode
```

Manually scale Virtual Machine Scale Sets
```bash
az vmss scale \
    --name MyVMScaleSet \
    --resource-group MyResourceGroup \
    --new-capacity 6
```

Install an application across a scale set with Custom Script Extension - Script below
```json
// yourConfigV1.json 
{
  "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v1.sh"],
  "commandToExecute": "./custom_application_v1.sh"
}
```
Install new application with Azure CLI and 
```bash
az vmss extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --resource-group myResourceGroup \
  --vmss-name yourScaleSet \
  --settings @yourConfigV1.json
```

Create a Virtual Machine Scale Set with an upgrade policy 
```bash
az vmss create \
  --resource-group MyResourceGroup \
  --name MyScaleSet \
  --image UbuntuLTS \
  --upgrade-policy-mode automatic \
  --admin-username azureuser \
  --generate-ssh-keys
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

AKS creation
```bash
# Requires a Resource Group!
az group create \ 
--name $rGroup
--location $location
# Create AKS cluster
az aks create 
--resource-group $rGroup
--name $aksClusterName
--node-count 3 
--enable-addons monitoring 
--generate-ssh-keys
```

AKS deployment
```bash
# Access AZK cluster, then show connectivity
RGROUP='azResourceGroup'
AKS_CLUSTER='azCluster'
az aks get-credentials --resource-group $RGROUP --name $AKS_CLUSTER
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
```bash
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
```bash
az network vnet list --query "[?contains(provisioningState, 'Succeeded')]" --output table
```

Create peering between two Vnets
```bash
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
```bash
# A Configuration
az network watcher configure \
  --resource-group $rGroup \
  --location eastus \
  --enabled true
# Show a typology for a resource group
az network watcher show-topology --resource-group $rGroup
```

Create a Route Table and a Custom Route - Prvate Subnets, IP forwarding
```bash
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
```bash
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
```bash
# Create a Service Plan
az appservice plan create --name $AZURE_APP_PLAN --resource-group $RESOURCE_GROUP --location $AZURE_REGION --sku FREE
# Verify 
az appservice plan list --output table
```

Create and Administrate a Web app
```bash
# Environment Variables
export RESOURCE_GROUP=$groupname
export AZURE_REGION=eastus
export AZURE_WEB_APP=$webappName
export AZURE_APP_PLAN=$webappName-$appPlanID

az appservice plan create --name $AZURE_APP_PLAN  --resource-group $RESOURCE_GROUP --location --sku FREE


az webapp create --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --plan $AZURE_APP_PLAN
# Verify
az webapp list --output table
curl $AZURE_WEB_APP.azurewebsites.net
```

Deploy code from Github
```bash
az webapp deployment source config --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration
```

Create Microsoft Entra ID objects 
```bash
# Create a new user
az ad user create
# Delete a user
az ad user delete
```

Azure RBAC with az role, use [az role definition list](https://learn.microsoft.com/en-us/cli/azure/role/definition#az-role-definition-list).
```bash
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
```bash
az storage account create --name $storageName --access-tier hot --kind StorageV2 --resource-group $resourceGroup
```

Obtain connection string to storage account
```bash
az storage account show-connection-string --name $storageName
# Copy the AccountKey=$base64string ; remember to include the ==
```

```bash
az storage account management-policy create \
    --account-name $storageAccount \
    --policy @policy.json \
    --resource-group $rGroup
```

Create a container
```bash
az storage container create --name $containerName --account-name $storageName 
--public-access off
```

Upload to a blob
```bash
az storage blob upload-batch --source sas --destination $containerName --acount-name $storageName --pattern *.ext # wildcard extensions!
```

Create a Stored Access Policy for a Container
```bash
# perm can be : <(a)dd, (c)reate, (d)elete, (l)ist, (r)ead, or (w)rite>
az storage container policy create -name $polcyName --container-name $container --start $startTime-UTC --expiry $expiryTime-UTC --permissions $perm --account-key $storageAccountKey --account $storageName
```

Create a SAS token for Blob storage and create a URI
```bash
az storage container generate-sas \
    --account-name $storageAccount \
    --container-name $container \
	--name $blob \
    --permissions acdrw \
    --expiry $insertDate \
    --auth-mode login \
    --full-uri
```


Send HTTP requests with `Get-AzWebApp`
```bash
$webapp = Get-AzWebApp -ResourceGroupName $rgName
Invoke-WebRequest -Uri $webapp.DefaultHostName
# Send infinite powershellrequest to test with while loop and powershell code blocks
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

User Defined Route
```bash
az network route-table route create -g MyResourceGroup --route-table-name MyRouteTable -n StorageRoute --address-prefix Storage --next-hop-type VirtualAppliance --next-hop-ip-address 10.0.100.4
```


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

Find outbound IPs of App Service Plan
```bash
# Same information as Azure Portal on Outbound IPs
az webapp show \
    --resource-group <group_name> \
    --name <app_name> \ 
    --query outboundIpAddresses \
    --output tsv
# All possible outbound IPs
az webapp show \
    --resource-group <group_name> \ 
    --name <app_name> \ 
    --query possibleOutboundIpAddresses \
    --output tsv
```


Create an Azure Container registry
```bash
az group create --name containerRegistry-rg --location $region
az acr create --resource-group containerRegistry-rg --name $ACR_NAME --sku Premium
```

Build an Image
```bash
az acr build --registry $ACR_NAME --image $imageName
```

Verify Image
```bash
az acr repository list --name $ACR_NAME --output table
```

Enable the registry account
```bash 
az acr update -n $ACR_NAME --admin-enabled true
az acr credential show --name $ACR_NAME
```

Deploy and then get IP address of Azure container
```bash
# Deploy
az container create \
    --resource-group $acrResourceGroup \
    --name $name \
    --image $ACR_NAME.azurecr.io/$imageName:$version \
    --registry-login-server $ACR_NAME.azurecr.io \
    --ip-address Public \
    --location $region \
    --registry-username $adminUsername \
    --registry-password $adminPassword 
# Get IP
az container show --resource-group  $acrResourceGroup --name $name --query ipAddress.ip --output table
```

Replicate a container to a different Region
```bash
az acr replication create --registry $ACR_NAME --location $TargetRegion
az acr replication list --registry $ACR_NAME --output table
```

## References

[John Savill's Microsoft Azure Master Class Part 6 - Networking](https://www.youtube.com/watch?v=K8ePZdLfU7M&t=3511s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[Subscription and Service limits](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits)
[Interactive map Resource Map](https://infrastructuremap.microsoft.com/explore) 
[Azure Cross Replication Regions](https://learn.microsoft.com/en-us/azure/reliability/cross-region-replication-azure)
[Azure subscription limits and quotas - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits)
[Pricing Calculator](https://azure.microsoft.com/en-gb/pricing/calculator/)
[Total Cost of Ownship Calculator](https://azure.microsoft.com/en-gb/pricing/tco/calculator/)
[Set-AzDnsRecordSet](https://learn.microsoft.com/en-us/powershell/module/az.dns/set-azdnsrecordset?view=azps-9.4.0)
[AzCopy](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-files)
[Deploy File Sync](https://learn.microsoft.com/en-us/azure/storage/file-sync/file-sync-deployment-guide) 
[Plan for IP addressing - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-ip-addressing)
[Load Balancer Components](https://learn.microsoft.com/en-us/azure/load-balancer/components)
[Azure virtual network traffic routing | Microsoft Learn](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-udr-overview)
[Azure subscription limits and quotas - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits?toc=%2Fazure%2Fvirtual-network%2Ftoc.json#networking-limits)
[Create a Private Link](https://learn.microsoft.com/en-us/azure/private-link/create-private-endpoint-portal?tabs=dynamic-ip) 
[Disable Network POlicies for a Private Link service](https://learn.microsoft.com/en-us/azure/private-link/disable-private-link-service-network-policy?tabs=private-link-network-policy-powershell)
[TCP V2 Proxy for Azure Private Links](https://learn.microsoft.com/en-us/azure/private-link/private-link-service-overview#getting-connection-information-using-tcp-proxy-v2)
[Arsen Vladimirskiy medium blog: TCP Proxy Protocol v2 with Azure Private Link Service — Deep Dive](https://arsenvlad.medium.com/tcp-proxy-protocol-v2-with-azure-private-link-service-deep-dive-64f8db9586cf)
[Set up staging environments - Azure App Service | Microsoft Learn](https://learn.microsoft.com/en-us/azure/app-service/deploy-staging-slots)
[Azure Diagnostics extension overview - Azure Monitor | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/diagnostics-extension-overview)
[Azure Event Hubs](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/diagnostics-extension-stream-event-hubs)
[Tutorial to import data to Azure Blob Storage with Azure Import/Export service | Microsoft Learn](https://learn.microsoft.com/en-us/azure/import-export/storage-import-export-data-to-blobs?tabs=azure-portal-preview)
[Tutorial to transfer data to Azure Files with Azure Import/Export | Microsoft Learn](https://learn.microsoft.com/en-us/azure/import-export/storage-import-export-data-to-files?tabs=azure-portal-preview)
[Microsoft learn | Move-support-resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-support-resources)