# Azure Administration - Azure DNS

Azure DNS lets you host your DNS records for your domains on Azure infrastructure Azure DNS is extended DNS - see *Alias, Record Set, Time To Live*  - no domain name purchases! For general understanding about DNS see [[DNS]]. Azure considerations and extensions:
- Azure DNS
	- Azure managed DNS resolved by Microsoft Azure infrastructure
	- Azure Private DNS allows for private name resolution between Azure virtual networks.
	- Azure-provided name resolution does not support user-defined domain names and only supports a single virtual network. [Name resolution for resources in Azure virtual networks | Microsoft Learn](https://learn.microsoft.com/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances#azure-provided-name-resolution)
- Public DNS
	- Azure public DNS provides DNS for public access
	- Manage custom domains for internet accessible domains
		- Websites
		- Records for proof of ownership
		- Connect to email servers
- Private DNS 
	- Private Zones providing name resolution for virtual machines (VMs) within a/between. virtual network 
		- Without custom DNS solution!
		- Automatic Hostname record management
		- Hostname resolution between virtual networks
		- Azure region support in all Azure regions 
	- Internally facing custom domains  
	- For:
		- Name resolution scope to a single Vnet:
			- VMs from Vnet 1 -> Query AZ private DNS zone for VNet2 resolution, Vnet1 is linked: 
				- Auto registration needed to be enabled in Link configuration for create two `A` records
				- Resolves only *using* Vnet2 
				- Azure Private DNS also responds to reverse DNS (PTR) for Vms with Vnet1 
		- Name resolution for multiple networks
			- Vnet1 is designated for registration Vnet2 for name resolution, both share DNS zone address `testmydns.loc`
			- Vnet1 VM registration is automatic
			- Vnet2 VM registration is manual
			- DNS query from VM of Vnet2 for resource in Vnet1 returns  `NXDOMAIN` (error message - Domain does *N*ot e*X*ist)
			- DNS query from VM of Vnet1 for resource in Vnet2 return FQDN for resource 
![](azureprivatedns.png)
- Private Resolvers 
	- Zero maintenance PaaS DNS for Hybrid cloud, centralising and distrubing DNS across Azure
- DNS Security 
	- RBAC
	- Activity Logs
	- Resource Locking


[[DNS]] Servers in Azure
- Maintains a local cache of recently accessed or used domain names and their IP addresses
- Maintains the key-value pair database of IP addresses and any host or subdomain over which the DNS server has authority
- Give access to network-enabled device to web-based-resource through reference
- IPv4 or IPv6


Azure has a special record types 
- **Azure Alias** 
	- Points to directly to an Azure Resource instead of IP or hostname to avoid dangling domains 
	- Updates DNS record automatically set when IP addresses change
	- Used for:
		- Hosts load-balanced application at zone apex with a Traffic Manager profile
		- Points to Azure Content Delivery Network endpoints
		- A public IP resource
		- A front door profile
- Record Set - a group of records - Azure creates a Record Set even for single records 
- Time to Live (TTL) says how long a value should be cached

Azure Features:
- RBAC for granular control of resource request by domain
- Activity Logs
- Resource Locking - restrict or remove access to resource groups, subscriptions or resources
- Private Domains[Set-AzDnsRecordSet](https://learn.microsoft.com/en-us/powershell/module/az.dns/set-azdnsrecordset?view=azps-9.4.0)
	- No need for DNS Solution
	- All DNS records types supported
	- Hostnames of VMs are automatically maintained
	- Split-Horizon - same Private and Public co-existences and resolves to the corect one


Virtual Networks can use Azure DNS or custom DNS, Azure can provide public and private zones. Set at NIC level not at the VM level. Azure DNS is not a domain registar!
- On subscription creation - automatic domain creation for it as `$yourdomainname.onmicrosoft.com`; to be used until your custom domain name is _verified_.
	- To initiate the verification process, add a DNS record for your custom domain name either a `MX` or `TXT` record
- Private DNS Zones: 
	- Private DNS Zone - you pick the name and managed fully - names, records, etc!
	- Private DNS can be used across subscriptions, regions! - PERMISSIONS!
	- Private DNS can set auto-registration 
	- No custom solution, automatic record and resolution managenment with various support - reduce the misconfigurations
- Domain Controllers - for custom DNS Active Directory - probably not Public 
- Newest VM - Delete the newest created VM, balanced across AZs
- Azure DNS 168.63.129.16
	- Root/Parent domain is registered at the registrar and then pointed to Azure DNS.
	- Child domains are registered directly in Azure DNS.
Consider reviewing  [[Azure-Administration-Configure-Virtual-Networks]] and [[DNS]] for futher information.

Be aware of the difference between DNS Record sets and individual records
- DNS Record sets  are collection of records
	- A DNS record set can't contain two identical records.
	- A record set of type `CNAME` can contain only one record.
	- Empty record sets do appear 

#### Azure DNS Private Resolver

Azure DNS private resolver is a cloud-native, highly available, and DevOps-friendly service (PaaS DNS). **Zero maintenance** DNS service to:
- Resolve and conditionally forward DNS queries from a virtual network, on-premises, and to other target DNS servers **without the need to create and manage a custom DNS solution.**
- Resolve DNS names hosted in Azure Private DNS Zones from on-premises networks and DNS queries for your own domain names.
Capabilities:
- Conditional forwarding to on-premises DNS or external DNS servers via outbound endpoints of Azure DNS Private Resolver
- Resolve Azure Private DNS Zone records with inbound endpoints
- Inbound Endpoints - Private IP of Subnet in a VNet
- Outbound Endpoints - s conditionally forward DNS queries with **forwarding Rulesets** to forward the traffic to specific target DNS servers
- Use Case:
	- Hybrid Cloud need for DNS resolution between Cloud and on-premises
	- To centralise DNS resolution across Azure
	- To distribute DNS resolution across Azure

## Workflows

[Sample DNS script](https://github.com/MicrosoftDocs/mslearn-host-domain-azure-dns.git)

To delegate your domain to Azure DNS:
1. Identify your DNS name server - for each zone Azure DNS allocated DNS server from each pool and authoritative `NS` (or _Name server_) records in your DNS zone.
	1. Find with Azure Portal
2. Update your parent domain  - each registar has their own DNS management tools
	1. Go to your registrar's (third-party domain registrar, company where domain was registered) DNS management page.
	2. Find the existing `NS` records for your parent domain.
	3. Replace the existing `NS` records with the `NS` records created for your domain by Azure DNS.
		- Remember to include a trailing period `..` at the end of the address
		- Always copy **all** DNS name server `NS` records for your domain to the parent domain 
3. Delegate subdomains (optional)
	1.  Go to the parent DNS zone for your domain in the Azure portal.
	2.  Find the existing `NS` records for your parent domain.
	3.  Create new `NS` records for your child DNS zone (subdomain).
4. Test with `nslookup -type=SOA $domain.$tld`
5. Create Load Balancers to handle requests
	 1. Link Apex Domain with a Load Balancer
		 1. Alias Record to point to a Load Balancer  route traffic through a Traffic Manager 			

[Azure DNS](https://learn.microsoft.com/en-us/azure/dns/dns-overview) *"is a hosting service for DNS domains that provides name resolution by using Microsoft Azure infrastructure."*  Azure can manage all your DNS or you can using the all the features other Azureservices.. 
- It does not support DNSSEC
- Customisation VNet with Private domains

[Overview of Azure DNS alias records](https://learn.microsoft.com/en-us/azure/dns/dns-alias) are qualifications on a DNS record set. They reference Azure resources from a DNS zone in Azure. An alias record set is supported for the following record types in an Azure DNS zone:
- A, AAAA, CNAME
- [Create A Alias Record](https://learn.microsoft.com/en-us/azure/dns/tutorial-alias-rr):
- `Search DNS Zone -> $DNSzone -> + Record Set -> Add record set (Name, Type,, Alias record set (Yes I No), Alias Type (Azure resource | Zone record set)` referencing either a set or resource

Azure Public DNS - [Host your domain in Azure DNS](https://learn.microsoft.com/en-us/azure/dns/dns-delegate-domain-azure-dns)
- `Search DNS Zones -> Create`
- If it is a child of an existing zone already hosted in Azure DNS 
	- `Tick, providing Name and Resource Group Location`
- [Delegate your DNS zone](https://learn.microsoft.com/en-us/azure/dns/dns-delegate-domain-azure-dns) to Azure DNS
	1. Get name servers for your zone
	2. `Search DNS Zones -> $DNSzone -> Overview -> ..name servers listed..`
	3. Update parent domain with `Azure DNS name servers` - each registar with its own DNS tools
- [Child Zones](https://learn.microsoft.com/en-us/azure/dns/tutorial-public-dns-zones-child)
	- `Search -> DNS Zones -> $DNSzone -> + Child zone`
- Dynamically Resolve a Traffic Manager (DNS load balancer) 
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

[Azure Prviate DNS Zones](https://learn.microsoft.com/en-us/azure/dns/private-dns-overview) requires:
- Vnet (With Resource Manager deployment model) and Subnet,
- Add Virtual Network Linking (add VNet to a Zone): `Resource groups -> $resourceGroup -> $domain -> select Virtual Network Links` - provide VNet, Sub and a `Link name`  
- Create an additional DNS Record in the correct DNS Zone
`Search -> Private DNS Zones -> Create`
- Subscription, Resource Group and instance Name
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
- Create an Alias Record that points to the Traffic Manager profile: `$DNSzone and + Rescord set` 


Common pattern - name resolution for multiple networks, where one is focused on registration and the other resolution.
`Vnet1 = Registration <-> Azure Private DNS zone records <-> Vnet2 = Resolution`


	
[Azure DNS](https://learn.microsoft.com/en-us/powershell/module/az.dns/new-azdnsrecordset?view=azps-9.4.0)
```powershell
# Config
# New DNS Root record
New-AzDnsRecordConfig
# 
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

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[Set-AzDnsRecordSet](https://learn.microsoft.com/en-us/powershell/module/az.dns/set-azdnsrecordset?view=azps-9.4.0)
[Azure DNS](https://learn.microsoft.com/en-us/powershell/module/az.dns/?view=azps-9.4.0)
[Name resolution for resources in Azure virtual networks | Microsoft Learn](https://learn.microsoft.com/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances#azure-provided-name-resolution)
[What is auto registration feature in Azure DNS private zones? | Microsoft Learn](https://learn.microsoft.com/en-us/azure/dns/private-dns-autoregistration)