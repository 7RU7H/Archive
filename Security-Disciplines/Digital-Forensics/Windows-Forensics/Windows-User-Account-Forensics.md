# Windows User Account Forensics

Typology of Windows User Accounts:
- Local User Accounts: local to and directly managed  by a machine 
- Domain Accounts: local to the domain managed by a Domain Controller
- System and Service Accounts: Used by services, applications and the machine:
	- Local System, Network Service, and Local Service accounts

- Security risks of:
	- Local User Accounts
		- Bad Passwords
		- Excessive permissions to write, read or execute that could lead to [[Windows-Privilege-Escalation-Vectors]]
	- Domain Accounts: 
		- Availability Vs. Security to implement changed while requirement of availability is necessary
			- Password Rotations
			- Guessable Passwords
			- Reused Passwords
		- Lack of coherent [[Active-Directory-Administrative-Tiering]]
		- Complexity, obfuscation within in-house implementation of Active Directory, System Administration tools (GUI-clicks-to-find): 
			- Nested Groups
		-  Lack of or poorly implemented or not tracking Accounts through an Accounts Life-cycle
			- Soft-Delete Accounts  
			- Accounts enabled in backups
		- Permissions that could lead to Cross-Domain, Cross-Federation or within a Domain Lateral Movement (see [[Active-Directory-Lateral-Movement]]) to elevated security contexts.
	- System and Service Accounts: 
		- [[Active-Directory-Lateral-Movement]] with:
			- [[Silver-Tickets]], [[Sapphire-Tickets]], [[Diamond-Tickets]]
		- [[Windows-Persistence-Abusing-Services]]

#### Account Life Cycle Artefacts

Account Life Cycle:
- Account Creation
- Account Modification
- Account Deletion (Soft or Hard Deletion)

[[Windows-Events-To-Monitor]] relating to the Account Life Cycle:
- Each of the event below includes:
	- The name and domain of the account created
	- The unique security identifier (SID)
	- The Initiating User or Process
	- The account creation time
- Events:
	- Event ID 4720: A user account was created.
	- Event ID 4722: A user account was enabled.
	- Event ID 4738: A user account was changed, detailing modifications to an account's properties.
	- Event ID 4740: A user account was locked, indicating repeated failed login attempts or potential unauthorized access.
	- Event ID 4726: A user account was deleted, documenting when and by whom an account was removed from the system

#### SAM 

The Security Account Manager (SAM) is a Windows database that stores the user's local account and system account info. Located at: `%SystemRoot%\\system32\\config\\SAM` the SAM provides the following forensic data:
- The account names of local users.
- Unique identifiers for each user.
- Local groups that users are part of.
- Stores the hashed representations of user passwords (not in plaintext).
- Whether accounts are active, disabled, or expired.
- Last login timestamps

#### NTDS

The NT Directory Services (NTDS) database, or NTDS.dit, stores detailed information about domain user accounts, groups, and other directory service data within a networked domain environment. The NTDS can provide the following information:
- Usernames and full names of domain users.
- Security Identifiers (SIDs) for each user.
- Detailed group memberships, including global, domain local, and universal groups.
- Hashed representations of user passwords for domain accounts.
- Account activation, disablement, and expiration status.
- Login timestamps and failed login attempts.
- Password last set and password expiration times.
- Information on other domain objects like computers, groups, organizational units (OUs), and security policies.
- Trust relationships with other domains.

Analyzing the NTDS.dit for User-Related Artefacts
```powershell
# Authorial Note: The weirdest Windows CLI Utility I have ever seen 

# Export the SYSTEM hive
# The command is as is: activate the ntds as a ifm (full installation media set) and stored it C:\Exports - quit twice to quit out of context of the args and the ntdsutil 
ntdsutil.exe "activate instance ntds" "ifm" "create full C:\Exports" quit quit
# Get the bootkey and save to a variable - Requires DSInterals PS Module
$bootKey = Get-BootKey -SystemHivePath 'C:\Exports\registry\SYSTEM'
# Get account details with:
Get-ADDBAccount -All -DBPath 'C:\Exports\Active Directory\NTDS.dit' -BootKey $bootKey
```
Remember you are writing to disk...


#### User Artefacts in Authentication Protocols

Authentication can occur over a network if enabled, which can artefacts from network traffic, which requires [[Network-Forensics]] - ``

Domain authentication is more modern AD LANs *should be* using Kerberos - (see [[Active-Directory-Kerberos-Authentication-Defined]])

[[Windows-Events-To-Monitor]] relating to Authentication:
- Event ID 4624: An account was successfully logged on.
- Event ID 4625: An account failed to log on.
- Event ID 4768: A Kerberos authentication ticket (TGT) was requested. 
- Event ID 4771: Kerberos pre-authentication failed.

Use brain. If lots of failed to log on from the same user or list of users around a similar time period. 

## References

[THM Windows User Account Forensics](https://tryhackme.com/r/room/windowsuseraccountforensics)