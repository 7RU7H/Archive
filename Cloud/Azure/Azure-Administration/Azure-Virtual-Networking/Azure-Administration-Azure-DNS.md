
# Azure Administration - Azure DNS


Azure DNS is extended DNS - see *Alias, Record Set, Time To Live*  - no domain name purchases! For general understanding about DNS see [[DNS-Defined]]. Azure considerations and extensions:
- Azure DNS
	- Azure managed DNS resolved by Microsoft Azure infrastructure
- Public DNS
	- Manage custom domains for internet accessible domains
		- Websites
		- Records for proof of ownership
		- Connect to email servers
- Private DNS 
	- Internally facing custom domains  

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
Consider reviewing  [[Azure-Administration-Virtual-Networking]] and [[DNS-Defined]] for futher information.

Be aware of the difference between DNS Record sets and individual records
- DNS Record sets  are collection of records
	- A DNS record set can't contain two identical records.
	- A record set of type `CNAME` can contain only one record.
	- Empty record sets do appear 

## Workflows

Create DNS zones
`Search -> DNS zones`

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
		

Create record set or Child zone
`Search -> DNS zones -> Search $DNSzone -> + Record Set | + Child Zone 

Common pattern - name resolution for multiple networks, where one is focused on registration and the other resolution.
`Vnet1 = Registration <-> Azure Private DNS zone records <-> Vnet2 = Resolution`

Private DNS Zones
`Search -> Private DNS Zones`
1. Identify VNets
2. Link Vnet to Private DNS Zone

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
[Azure DNS ](https://learn.microsoft.com/en-us/powershell/module/az.dns/?view=azps-9.4.0)