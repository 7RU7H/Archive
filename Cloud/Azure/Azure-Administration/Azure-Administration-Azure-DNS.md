
# Azure Administration - Azure DNS

Azure DNS is just an extended DNS - see *Alias, Record Set, Time To Live*  - no domain name purchases! For general understanding about DNS see [[DNS-Defined]]. Azure considerations and extensions:
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
- **Azure Alias** -  Points to directly to an Azure Resource instead of IP or hostname to avoid dangling dominas
- Record Set - a group of records - Azure creates a Record Set even for single records 
- Time to Live (TTL) says how long a value should be cached

## References


[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)