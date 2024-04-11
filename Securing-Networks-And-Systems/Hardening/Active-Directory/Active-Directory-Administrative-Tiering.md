# Active Directory Administrative Tiering 

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

#### Implementation Considerations

Implement OUs:
- Each Tier 0 - 2 must be segmented by Organisational Units (OUs):
	- Users
	- Groups
	- Devices - machines have accounts too!
	- Service Accounts - services have accounts too!

Implementing Access Restrictions via Group Policies:
- `Window` -> `(BELOW THESE OPTION) New Window, Cascade, Tile Horizontally, Arrange Icons` -> select a view depending on hierarchy: Forest, Domains, Sites, Group Policy Modelling, Group Policy Results 
- Modify User Rights Assignment:
	1. Descend till you reach the OU hierarchy point required
	2. ` Right-Click "Computer Configuration"` -> `(Drop Down)` -> `Edit` 
	1. Then use the GPO Management Editor: 
		- `Computer Configuration` -> `Policies` -> `Windows Settings` -> `Security Settings` -> `Local Policies` -> `User Rights Assignment`
	4. `Right-Click ` -> `(Drop Down)` -> `Properties`
	5. `Tick "Define these policy settings:"`
	6. `Add User or Group` and add - `$DOMAIN\$userORgroup` - one at time no comma delimited lists
	7. `Apply`
- Options:
	- Deny log on as a batch job: denies users from logging into the machine as a scheduled task.
	- Deny log on as a service: denies users from logging into the device as a service.
	- Deny log on locally: restricts users from logging into the machine physically.
	- Deny log on through Terminal Services: denies users logging into the machine via RDP.
	- Deny access to this computer from the network: denies access to network services like SMB, NetBIOS, CIFS and others.

Configuring Administrative Rights:
Modifying GPOs for `Restricted Groups` (Group of Groups that are Restricted):
- `Computer Configuration` -> `Policies` -> `Windows Settings` -> `Security Settings` -> `Restricted Groups`
Modifying GPOs for User Rights Assignment:
- `Computer Configuration` -> `Policies` -> `Windows Settings` -> `Security Settings` -> `Local Policies` -> `User Rights Assignment`

Delegating Permissions `<verb>` AD Object
- `Open Active Directory Users and Computers` -> `Right-Click to dropdown` -> `Delegate Control` -> `Delegation of Control Wizard` -> `Next` -> `Add...` an AD Object then either:
	- `Delegate the following common task:`
		- Select from List
	- `Create a custom task to delegate:`
		- Either:
			- `This folder, existing objects in this folder, and creation of new objects in this folder`
			- `Only the following objects in the folder` - this option unlocks both `(Create / Delete) selected objects in this folder`
		- Then `Show these permissions:` to then select permissions based on the categorise (there are a lot per category), to the tick:
			- General
			- Property-specific
			- Creation/deletion of specific child objects
## References

[THM AD Tier Model Room](https://tryhackme.com/r/room/adtiermodel)
[learn.microsoft - ADCS ](https://learn.microsoft.com/en-us/windows-server/identity/ad-cs/active-directory-certificate-services-overview)