# Active Directory Hardening

For encompassing article about the features of Active Directory - [[Active-Directory]] 
``
It would recommended to make a [[Active-Directory-Lab]] 

- Active Directory Hardening: Level - Actions
	- Implement Principle of Least Privilege Model - [[Principle-Of-Least-Privilege]]
		- Creating the Right Type of Accounts:
			- No Guest accounts - just why?
			- User accounts - promote regular use 
			- Privilege accounts - accounts with elevated privileges for purpose use only otherwise user account
			- Shared accounts 
				- Either:
					- For contractors with bare minimum privileges, to give limited access for a specific time - requiring registration to track who and reason
					- Multiple-Keys-to-the-Kingdom - Requiring multiple members of Administration to authenticate for emergency and critical use only. 
		- Role-Based Access Control on Hosts:
			-  [Wikipedia Principle of Least Privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege) states: *"The principle of minimal privilege or the principle of least authority, requires that in a particular abstraction layer of a computing environment, every module (such as a process, a user, or a program, depending on the subject) must be able to access only the information and resources that are necessary for its legitimate purpose"*
			- DNS zones, servers or 
			- Resource record level for CRUD of all resources 
		- Active Directory Tiered Access Model (TAM):
			- [Tiered and Enterprise Access Model (EAM)](https://docs.microsoft.com/en-us/security/compass/privileged-access-access-model)
			- Based on the principle of "*Prevention of privileged credentials from crossing boundaries, either accidentally or intentionally*"
			- Tier 0: Domain Accounts
			- Tier 1: Server Administrators
			- Tier 2: Workstation Administrators
		- Auditing Accounts:
			- Monitor each account's specific tasks and validating their access rights
			- Check if every account in the system has the least privilege
			- Change audits allow you to look for any improper changes to account permissions, passwords, or settings. Any unacceptable change to these may lead to a data breach.
	- Securing Authentication Methods
		- LAN Manager Hash
			- `Group Policy Management Editor -> Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Local Policies -> Security Options -> double click -> "Network security: Do not store LM hash value on next password change policy" -> select "Define policy setting"
		- SMB Signing
			- `Group Policy Management Editor -> Computer Configuration -> Policies -> Windows Settings > Security Settings -> Local, how many users have the same password as aaron.booth?l Policies -> Security Options -> double click "Microsoft network server: Digitally sign communication (always)" -> select Enable Digitally Sign Communications`
		- LDAP Signing
			- `Group Policy Management Editor -> Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Local Policies -> Security Options -> "Domain controller: LDAP server signing requirements" -> select Require signing from the dropdown`
		- Password Separation:
			- Employee has User Account and a Privilege Account - each password must be different
		- Password Rotation - Service Accounts
			- Don't make a script use Microsoft solutions
			- [Group Managed Services Accounts (gMSAs), which changes passwords after every 30 days ](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/service-accounts-group-managed) - for service account! - beware [[Silver-Tickets]] are very powerful
		- Password Rotation - Privileged and Shared Accounts
		- Credential Rotation - Critical Accounts
			- Change after every use 
			- Post Breach-Compromise:  [Microsoft Github - Change KRBTGT Keys ](https://github.com/microsoft/New-KrbtgtKeys.ps1)
		- Password Policies - Regular user
			- `Group Policy Management Editor -> Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Account Policies -> Password Policy`
				- Add Password complexity
				- Add Password look-back to prevent reusing password 
				- Add Password Expiry
					- Force password rotation on users, but do not make too short users with make it insecure
		- Add [MFA](https://docs.microsoft.com/en-us/azure/active-directory/authentication/howto-mfa-getstarted)
	- Protecting Against Known Attacks
		- Kerberoasting and ASREP-Roasting [[Attacking-Kerberos]]
			- [Microsoft Official Kerberoasting Article](https://microsoft.com/security/blog/2020/08/27/stopping-active-directory-attacks-and-other-post-exploitation-behavior-with-amsi-and-machine-learning/)
			- [[Silver-Tickets]]
			- [[Golden-Tickets]]
			- [[Diamond-Tickets]]
			- [[Sapphire-Tickets]]
		- Weak, Guessable or Password Reuse 
			- [Combined password policy and check for weak passwords in Active Directory and Microsoft Entra ID](https://docs.microsoft.com/en-us/azure/active-directory/authentication/concept-password-ban-bad-combined-policy)
		- Brute Forcing [[RDP]] 
		- Exposed Public Shares - [[SMB-Recon-Cheatsheet]]
	- Microsoft Security Compliance Toolkit
		- Installing MSCT baseline scripts
			- `Open Microsoft Security Compliance Website -> click "Download" -> click "Windows Servers Security Baseline.zip" -> Download` - [From](https://www.microsoft.com/en-us/download/details.aspx?id=55319)
			- `powershell.exe expand-archive "Windows Servers Security Baseline.zip" -> Scripts -> select a script to execute with PowerShell`
		- [Policy Analyser](https://www.microsoft.com/en-us/download/details.aspx?id=55319)
			- `PolicyAnalyzer.exe`
			- Compare Group Policy to check for:
				- Inconsistencies
				- Redundant settings
				- Alterations required
	
## Workflows

Manage Trusts: 
- `Server Manager > Tools > Active Directory Domains and Trust`

## References

[THM Active Directory Hardening](https://tryhackme.com/room/activedirectoryhardening)
[Microsoft Documentation | Group Managed Services Accounts (gMSAs)](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/service-accounts-group-managed)
[Tiered and Enterprise Access Model (EAM)](https://docs.microsoft.com/en-us/security/compass/privileged-access-access-model)
[Microsoft Official Kerberoasting Article](https://microsoft.com/security/blog/2020/08/27/stopping-active-directory-attacks-and-other-post-exploitation-behavior-with-amsi-and-machine-learning/)
[Combined password policy and check for weak passwords in Active Directory and Microsoft Entra ID](https://docs.microsoft.com/en-us/azure/active-directory/authentication/concept-password-ban-bad-combined-policy)
[Microsoft Security Compliance Toolkit](https://www.microsoft.com/en-us/download/details.aspx?id=55319)