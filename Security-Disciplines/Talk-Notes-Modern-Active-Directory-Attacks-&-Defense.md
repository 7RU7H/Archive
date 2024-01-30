# Red vs Blue: Modern Active Directory Attacks & Defense by Sean Metcalfe

## Introduction
These are my notes from the DEFCON 23 talk about Active Directory hacking and defending available on [youtube](https://www.youtube.com/watch?v=rknpKIxT7NM). It is even six years on considered high recommended watching material. Description:

*Around this time, Active Directory (AD) admins all over the world felt a great disturbance in the Force. Golden Tickets are the ultimate method for persistent, forever AD admin rights to a network since they are valid Kerberos tickets and can’t be detected, right? This talk explores the latest Active Directory attack vectors and describes how Golden Ticket usage can be detected. When forged Kerberos tickets are used in AD, there are some interesting artefacts that can be identified. Yes, despite what you may have read on the internet, there are ways to detect Golden & Silver Ticket usage. Skip the fluff and dive right into the technical detail describing the latest methods for gaining and maintaining administrative access in Active Directory, including some sneaky AD persistence methods. Also covered are traditional security measures that work (and ones that don’t) as well as the mitigation strategies that disrupts the attacker’s preferred game-plan. Prepare to go beyond “Pass-the-Hash” and down the rabbit hole.*

For the author this talk will augment further information throughout this repository and be referenced both to this page, but also the video. I choose the DEF CON video just because it is slightly longer than the Black Hat version. It also turns out this is as this was not in the Black Hat talk and contains Sneaky AD Persistence tricks.

## Agenda

## Red Team (Recon, Escalate and Persist)
- [[Red-Team-Hub]]
	- Red team objectives
		- [[PowerSploit]]
		- [[Empire]]
			- Recon - with [[PowerShell]]
				- SPN Scanning as service discovery -> Data (User ID, Password&LastSet, LastLogon, SPNServers)
					- SQL servers, instances ports
					- Exchnage Client Access server
					- RDP
			- Data to start [Kerberoasting]([[Attacking-Kerberos]])	
				- Crack the service account passwords
				- Request TGS Service Ticket 
				- Save & Crack TGS Service Ticket with [[Mimikatz-Cheatsheet]]
			- Exploit Group Policy Preferences
				- `cpassword in SYSVOL`
				- `Get-DecryptedCpassword`
			- Pivoting with Local Admin
				- Using GPP Credentials
				- Connect to other computers using ADA Admin account
				- Compromise Local Admin creds = Admin rights no all
				- Always RID 500 - doesn't if renamed.
				- Mimikatz for more credentials!
			- Dumping AD Domain Credentials
				- Finding NTDS.dit on Network
					- Are DC backups secured properly
					- Domain Controller storages?
					- Who Administers the virtual server hosting virtual DCs
					- Are your VMWare/Hyper-V host admins considered Domain Admins
				- Get access to the NTDS.dit file & extract data
					- Copy AD database from remote DC - NTDSUtil
					- Grab AD database copy from backup
					- Get Virtual DC data (backup DCs)
				- Dump credential on DC (local remote) NTDS.dit
					- Run Mimikatz (WCE, etc) on DC.
					- Invoke-Mimkatz on DC via PS remoting
			- DCSync - DA rights + DCSync = Password Hashes over the Network
				- [[Kekeo-Cheatsheet]]
				- Impersonate DC to get password hashes 
			- MS14-068 (CVE-2014-6324)  11/18/2014 18/11/2014
				- Domain Controller Kerberos Service KDC did not correctly validate the PAC checksum
					- PyKEK 
						- Requests a TGT
						- Create a forgered PAC
						- Sends back the forgered PAC as authenicator
						- DC gets confused and then creates a new one and sends it back
				- Effectively re-write user ticket to be a Domain Admin
				- Own AD in 5 minutes
			-  **DEF CON Bonus AD Persistence Tricks**
				- Directory Service Restore Mode - DSRM 
					- "Break glass" access to DC
					- DSRM password set when DC is promoted it is rarely changed, password Change Process
					- Using DSM Credentials
						- Reboot to DSRM
						- Access DSRM without Rebooting (2k8+)
							- DsrmAdminLogonBehavior = 1 -> 2 
							- So you dont need to `Stop Active Directory (ntds) service`
							- Console logon (not RDP)			
				- SSP - Malicious Security Service Provider
					- Modify or Add SSP - Create a new authenication method into windows
						- Inject into memory 
							- Upload to memory
							- [[DLL-Injection]]
						- Collect credential point the back to SYSVOL
				- Skeleton Key on DC with [[Mimikatz-Cheatsheet]]
					- LSASS was patched in real time
				- SID History - Legacy feature, to move users from new to old domain so that new users account has access the old domain data
					- SID History -> Domain Exploitation
						- PS Remoting!
				- Custom WMI Provider - Sneaky WMI v1 and v2 @subtee -cant find github repository [mdsecactivebreach](https://github.com/mdsecactivebreach/WMIPersistence)
					- Normal usage looks like netstat
					- Enables Arbitrary Command Execution
						- Version 2: Remote Command Execution - @subtee 
				- Powershell Empire -  [[Empire]]
					- Inject into LSASS
					- Get Credentials 
		- Golden Ticket (Forged TGT) Communication
			- Limitations
			- Admin Rights limited to current domain
			- Doesn't work acrross trusts unless in EA
			- [[Mimikatz-Cheatsheet]] support SID History in Golden Tickets
		- Silver Tickets (Forged TGS) Communication
				- Attacker dumped AD & has all domain creds
				- Even if domain controller password more than once
				- Attacker still has Domain Controller hashes
		- Silver to Golden ticket 
				- Silver for HTTP, valid for HTTP service
				- Silver for WSMAN, valid for WSMAN service
				- With two silver tickets and [[Mimikatz-Cheatsheet]] combine 
				- WinRm and PS-Remoting!
		- Kerberos Trusts Cross-Domain
			- User from Domain Blue needs Application Server from Domain Green
			- Domain Blue DC communicates to Domain Green DC, when user requests 
				- Passwords don't change for 30 days
				- Shared over email
					- Access the to email can get a cross forest TGT
			
			
- Others Bullet point
	- Local Policy 
	- Logon Scripts
	- Group Policy
	- Scheduled Tasks
	- WMI
	- Output | SYSVOL
				
##  Blue Team (Detect, Mitigate and Prevent)
- [[Blueteam-Hub]]

Some of these mitigations are from 2015, no Principle Least Privilege is mentioned explicitly

- Mitigation Level One (Low)
	- Minimize the groups (& users) with DC admin/logon rights
	- Seperate user & admin accounts
	- No user account in admin groups
	- Set all admin accounts to "sensitive & cannot be delegated"
	- Deploy Security Back-port patch (KB2871997)
	- Set GPO to prevent local accounts from connecting over network to computers (KB2871997)
	- Use long, complex (>25 characters) passwords for SAs.
	- Delte (or secure) GPP policies and files with creds.
	- Patch server image (and servers) before running DCPromo
	- Implement RDP Restricted ADmin mode
	-  Response: TGS Password Cracking
- Mitigation Level Two (Moderate)
	- Microsoft LAPS (or similar) to randomize computer local admin account passwords
	- Service Accounts (SAs):
		- Leverage "(Group) Managed Service Accounts"
		- Implment Fine-Grained Passwod Policies (DFL > 2008)
		- Limit SAs to systems of the same security level, not shared between workstations & servers
	- Remove Windows 2003 from the network and other vulnerable 
	- Seperate Admin Workstations for administrators (locked-down & no internet)
	- Powershell logging
- Mitigation Level Three ("It's Complicated")
	- Number of Domain Admins = 0 
	- ADAs use smartcard auth w/ rotating pw
	- ADAs never logon to other security tiers
	- ADAs should only logon to a DC (or admin workstation or server)
	- Time-based, temporary group membership
	- Disable default local admin account & delete all other local
	- Implement network segmentation
	- CMD Process logging & enhancement (KB3004375)
	- New Admin Model
		- Active Directory Admins (ADAs)
		- Server Application Admins
		- Workstation Admins 

- Additional Mitigations
	- Monitor schedule tasks on sensitive systems (DCs, etc)
	- Block internet access to DCs & servers.
	- Monitor security event logs on all servers for known forged Kerberos & backup events.
	- Include computer account password changes as part of domain-wide password change scenario (set to 1 day)
	- Change the KRBTGT account password (twice) every year & when an AD admin leaves.
	- Incorporate Threat Intelligence in your process and model defense against real, current threats.

- Credential Theft Protection at 46:10 Sean Metcalfe discusses future protection that may not be current day in use as it references a Microsoft talk at Black Hat from 2015.

## Attack Detection Paradigm Shift
- Microsoft Advanced Threat Analytics (ATA, formerly Aorato):
	- Monitors all network traffic to Domain Controllers
	- Baselines "normal activity" for each user (computers, resources, etc)
	- Alerts on suspicious activity by user
	- Natively detects recon & attack activity without writing rules
- ATA Detection Capability:
	- Credential theft & use 
	- MS14-068 exploits
	- Golden Ticket usage
	- DNS Reconnaissance 
	- Password brute forcing
	- Domain Controller Skeleton Key Malware


## Blue Defense Against the Attacks mentioned in this talk
- Defending against attacks
	- Response: Kerberos
		- Detection
			- [[Windows-Events-To-Monitor]] Event IS 4769: A Kerberos service ticket was requested
		- Migitation
			- Service Account Password > 25 characters
			- Use (Group) Managed Service Accounts
	- Response: Exploiting GPP 
		- Detection:
			- XML Permission Denied Checks
				- Place xml file in SYSVOL & set Everyone:Deny
				- Audit Access Denied errors
			- GPO doesn't exist, no legit reason for access
		- Mitigation:
			- Install KB2962486 on every computer used to manage GPOs
			- Delete existing GPP xml files in SYSVOL containing password
	- Response: Pivoting via Local Admin
		- Detection:
			- Local admin account logon
		- Mitigation:
			- Use Microsoft LAPS (or similar) for automatice local admin password change
			- Deploy KB2871997 on all systems
			- Disallow local account logon across network via GPO.
			- Don't allow workstation to workstation communication
			- Implement network segmentation.
	- Response: Finding & Dumping 
		- Are DC backups secured properly
		- Domain Controller storages?
		- Who Administers the virtual server hosting virtual DCs
		- Are your VMWare/Hyper-V host admins considered Domain Admins
	- Response: Credential Theft
		- Detection: Difficult
		- Migitation
			- Protect admin credentials
			- Admin only logon to specific systems
			- Limit Service Account rights/permissions
			- Set all admin to "sensitive & cannot be delegated"
			- Seperate Admin workstations for Administrators (locked-down & no internet)
	- Response:  MS14-068 (CVE-2014-6324) 
		- Detection:
			- IDS Signature for Kerberos AS-REQ & TGS-REQ both containing "Include PAC: False"
		- Mitigation:
			- Patch servers with KB3011780 before running DCPromo patch the server build.
			- Check patch status before running DCPromo
	- Response: AD Persistence
		- Detection: Varies
			- DSRM: DSRM pw change
			- SSP: Registry config
			- Skeleton Key: Ticket Encryption
			- SID History: User Attribute
			- Malicious WMI: Inventory WMI
		- Mitigation:
			- Protect AD Admins
	- Response Kerberos: Golden and Silver Tickets
		- Detection:
			- Normal, valid account logon event data structure:
				- SID: DOMAIN\\AccountID
				- Account Name: AccountID
				- Account Domain DOMAIN
			- Golden & Silver Ticket events may have one of these issues:
				- The Account Domain field is blank when it should contain DOMAIN
				- The Account Domain field is DOMAIN FQN when it should contain DOMAIN
				- The Account Domain field contains "eo.oe.kiwi :)"

- Powershell Attack Detection:
	Log all Powershell activity
	Interesting Activity:
		.Net Web Client download
		Invoke-Expression (and derivates: "iex")
		"EncodedCommand" ("-enc") & "Bypass"
		BITS activity
		Scheduled Task creation/deletion
		Powershell remoting (WinRm)
	Limit & Track Powershell Remote
	Audit Meter Powershell usage
	[[Powershell-Versions]] some are very unsafe! 
- Powershell v5 Security Enhancements
	- Script block logging 
		- Logs final command executed by powershell
	- System-wide transcripts
		- All activity can be logged 
		- Group policy have data go to a share, users can access, but cannot deleted later
			- I.E if command comes from host.exe or word.exe or excel.exe then its probably very bad
	- Constained Powershell
		- Constrained Language mode - does have .NET and advanced functionality
		- Enabled in AppLocker in allow mode
	- Antimalware Integration (Win 10) [[ASMI]]
		- Be aware of [[AMSI-Exploitation]] and [[AMSI-Bypassing]]
	
	

Malware gets on the network by phishing, user training is important

[[Mimikatz-Cheatsheet]] is used to dump credentials:
- From windows protect memory (LSASS) and activity directory domain controller database
- Kerberos tickets
	- For all users
	- For current users
- Credential Injection
- Generate Silver/Golden tickets
	- [[Pass-The-Hash]]
	- [[Pass-The-Ticket]]
- And more


## Summary
- Attackers will get code running on target network
- The extent of attacker access is based on defensive posture
- Advanced attacks with forged tickets can be detected
- Protect AD Admins or a full domain compromise is likely


## Thanks!
Alva "Skip" Duckwall (@passingthehash) - http://passing-the-blogspot.com
Benjamin Delpy (@gentilekiwi) - http://blog.gentilkiwi.com/mimikatz
Casey Smith (@subtee)
Chris Campbell (@obscuresec) - http://obsecuresecurity.blogspot.com
Joe Bialek (@clym3r) - http://clymb3r.wordpress.com
Matt Graeber (@mattifestation) - http://www.exploit-monday.com
Rob Fuller (@mubix) - http://www.room362.com
Will (@harmj0y) - http://blog.harmj0y.net

- The Microsoft ATA Product Team (Tal, Michael, Idan)
- Many others in the security community!
- My wife & family for putting up with me being on the computer every night!

Contact:
Sean Metcalf @PyroTek3, https://www.ADSecurity.org


## References


[Red Vs Blue Modern Active Directory Attacks and Defense](https://www.youtube.com/watch?v=rknpKIxT7NM)