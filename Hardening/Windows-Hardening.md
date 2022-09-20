# Windows Hardening

This article will split first part general understanding about Windows Hardening specifics aswell general important practices, then a second half which will be powershell commands.

## Defence Points

-   Identity & access management.
	-  As a principle, always follow the **Principle of Least Privilege**, which states that (Per [CISA](https://www.cisa.gov/uscert/bsi/articles/knowledge/principles/least-privilege#:~:text=The%20Principle%20of%20Least%20Privilege%20states%20cthat%20a%20subject%20should,should%20not%20have%20that%20right)) “_a subject should be given only those privileges needed for it to complete its task. If a subject does not need an access right, the subject should not have that right_”.
	- Password Policy; Lockout Policy,
	- [[Windows-User-Account-Control]], [[Bypassing-Windows-User-Account-Control]]
-   Network management
	- Disable unused devices `Control panel > System and Security Setting > System > Device Manager`
	- Protecting Local Domain Name System (DNS)
		- `C:\Windows\System32\Drivers\etc\hosts` - Check for malicious insertion, change Write permissions
	- Disable SMBv1 
		- `Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol`
	- Prevent [Blue Keep](https://en.wikipedia.org/wiki/BlueKeep) , Disable Remote Access
		- `settings > Remote Desktop`
	- Clear Arp cache
		- `arp -d`
	- [[Firewalls]] and [[Evading-Firewalls]]; `wf.msc`
	- [[Windows-Networking]], [[Windows-Networking-Commands]]
-   Application management.
	- [[Windows-Services]], `services.msc`
-   Storage & Compute
-   Registry Management 
	- `regedit`
-  Patch Management
	- `Click Start > Settings > Update & Security > Window Updates.`
-  Event Handling
	- [[Sysmon-Events]], [[Windows-Events-To-Monitor]]
	- Event viewer; `eventvwr`, default location `C:\WINDOWS\system32\config\folder`
- Telemetry
	- `diagtrack.dll` and `%ProgramData%\Microsoft\Diagnosis` is sent every 15 minutes


## References
[THM Room Windows Hardening](https://tryhackme.com/room/microsoftwindowshardening)
[CISA](https://www.cisa.gov/uscert/bsi/articles/knowledge/principles/least-privilege#:~:text=The%20Principle%20of%20Least%20Privilege%20states%20cthat%20a%20subject%20should,should%20not%20have%20that%20right)