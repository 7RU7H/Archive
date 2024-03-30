# Administrative Tiering In Active Directory

#### [[Principle-Of-Least-Privilege]] and AD

Correct implementation of [[Principle-Of-Least-Privilege]] across all domain infrastructure of an [[Active-Directory]] network is an important and very difficult task. There are a lot of [[Active-Directory]] objects; users, machine accounts, groups, Service Principle Name accounts and much more that can be assigned permissions within the domain as well as controlling how ingress and egress traffic can interact with these also. 

#### Tiered Access Models

**Accounts** (machine and SPN accounts exist!) should be restricted to their respective tiers. Limits between tiers should obey the following principles:
- **Assets in higher tiers can control other assets in the same or lower tiers** 
- **Accounts should never log into lower-tier machines.**

Tiering a [[Active-Directory]] network segmentation: 
- Tier 0 should contain CA and Identity Management solutions:
	- Domain Controllers 
	- Certificate Authority (CA) Server: [learn.microsoft - ADCS ](https://learn.microsoft.com/en-us/windows-server/identity/ad-cs/active-directory-certificate-services-overview) states: *"Active Directory Certificate Services (AD CS) is a Windows Server role for issuing and managing public key infrastructure (PKI) certificates used in secure communication and authentication protocols."*
	- Exchange Servers 
	- VPN Servers - [[IPsec]]
- Tier 1 should contain File and Application Servers:
	- Application servers 
		- internal Web Applications
		- [[Firewalls]]
		- [[Intrusion-Detection-Systems]]
		- [[Intrusion-Prevention-Systems]]
	- Database servers - like [[MSSQL]]
	- File-sharing servers
		- [[SMB]]
		- Source Code Repositories
		- Backup Servers
- Tier 2 should contain:
	- Workstations
	- End-user devices: Kiosks, IOT devices, RFID systems (on doors), [[Printers]]

Tiering Administrator Accounts:
- Tier 0 should contain Administrators accounts that manage CA and Identity Management solutions
- Tier 1 should contain Administrator accounts that manage File and Application Servers 
- Tier 2 should contain Administrator accounts that manage Workstations and End-user devices
## References

[THM AD Tier Model Room](https://tryhackme.com/r/room/adtiermodel)
[learn.microsoft - ADCS ](https://learn.microsoft.com/en-us/windows-server/identity/ad-cs/active-directory-certificate-services-overview)