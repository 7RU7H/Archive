# Windows User Account Forensics

#### Introduction

[Locard's exchange principle (Wikipedia)](https://en.wikipedia.org/wiki/Locard%27s_exchange_principle)

#### Typology and Security Risks

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

Authentication can occur over a network if enabled, which can artefacts from network traffic, which requires [[Network-Forensics]] - Use brain with tools not just the tools. Network traffic data to consider:
- Source and Destinations 
	- IP Addresses, Hostnames, Domain Names, Ports
- Timestamps 
- Authentication Protocols
- Success and Failure Indicators
- Packet Data
- Payload Data

There is a lot of data mentioned above so the best approach is question-based for the objective of reducing the data set to the abnormal and then piecing events through time from a red team thinking (hypothesis and simulate the linear steps taken by over-arching *what* you are looking to identify and verify with data from, the perspective of adversary, suspect, etc).

Domain authentication is more modern AD LANs *should be* using Kerberos - (see [[Active-Directory-Kerberos-Authentication-Defined]])

[[Windows-Events-To-Monitor]] relating to Authentication:
- Event ID 4624: An account was successfully logged on.
- Event ID 4625: An account failed to log on.
- Event ID 4768: A Kerberos authentication ticket (TGT) was requested. 
- Event ID 4771: Kerberos pre-authentication failed.

#### Group Policy (GPO) Artefacts

Consider adversarial uses of GPOs to achieve objectives:
- Reconnaissance: [[Active-Directory-Recon]]
- Lateral Movement: [[AD-Group-Policy-Objects-Exploitation]]
- Security Policy Modification: Tampering with GPOs weakening security setting.
- Persistence: [[AD-Persistence-GPOs]]

Compare User Context that uses the machine Vs artefacts of potential unauthorised changes.

List all GPOs of a Domain in a Forest in `Group Policy Management` Application:
 1. `Group Policy Management` 
 2. -> `Forest:` ->  Forest Name 
 3. -> `Domains`  -> Domain 
 4. -> `Group Policy Objects`
5. `Right Click` -> `Drop Down: Edit..`
An example would be changes to Windows  Defender Firewall found in changes to GPO: `Computer Configuration > Policies > Administrative Templates > Network > Network Connections > Windows Defender Firewall > Domain Profile`
Another in changes to the Logon/Logoff scripts run by a User:
`User Configuration > Policies > Windows Settings > Scripts (Logon/Logoff)`
Or changes to Windows Defender at the GPO level:
`Computer Configuration > Policies > Administrative Templates > Windows Components > Windows Defender Antivirus > Real-time Protection`


Detectable User-centric Artefacts in Group Policy Object Tampering:
- Custom User Settings:
	- Traces to look for:
		- **`HKEY_CURRENT_USER`** registry keys
		- User Profile Directories
	- Examples: 
		- Desktop configurations, startup programs and security configurations - why would normal user write custom XML to subvert something in Active Directory?
- Login Scripts:
	- Traces to look for:
		- script files in the `SYSVOL` folder and execution logs within user profiles, found under the **`User Configuration`** settings of a GPO
- User Rights Assignments: 
	- Traces to look for:
		- Unauthorized alterations in user rights and permissions `Security` database at `%SystemRoot%\security\database\secedit.sdb`
- Security Policy Changes:
	- Traces to look for:
		- System-wide modifications to security policies by GPOs are recorded in the registry under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies`, reflected in the `Local Security Policy`
- System Services Configurations:
	- Traces to look for:
		- `HKEY_LOCAL_MACHINE\SYSTEM` Registry Hive
	- Examples
		- alterations in configuration files located in `%SystemRoot%\System32\drivers\etc`
- Network Configuration Adjustments:
	- Traces to look for:
		- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList`
	- Examples
		- startup type and permissions changes
## References

[THM Windows User Account Forensics](https://tryhackme.com/r/room/windowsuseraccountforensics)
[Locard's exchange principle (Wikipedia)](https://en.wikipedia.org/wiki/Locard%27s_exchange_principle)