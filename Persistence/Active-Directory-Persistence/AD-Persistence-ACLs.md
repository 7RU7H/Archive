
The Access Control List (ACL) is used as a template to copy permissions to all protected groups. Just adding accounts to privileged groups is easy for Blue Team to cleanup by removing membership, instead injecting into the defaults of the templating that assist in automate generation of default groups. If we lose persistence this way we just wait till the template refreshes to grant membership. Below are some of the protected groups:

[For more modern AD](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/plan/security-best-practices/appendix-c--protected-accounts-and-groups-in-active-directory)
![](protected-accounts-and-groups-in-ad-by-os.png)
[For Older AD](https://learn.microsoft.com/en-us/previous-versions/technet-magazine/ee361593(v=msdn.10))
![](protected-accounts-and-groups-in-ad-by-os-older.png)

See [[ACL-Abuse]]

Templates are Objects and to perform persistence we want default templates like AdminSDHolder is to provide "template" permissions for the protected accounts and groups in the domain. It exists in every AD domain, its ACL is used to as a template to copy permissions to all protected protected groups. 

The SDProp is a process that runs every 60 minutes (by default) on the domain controller that holds the domain's PDC Emulator (PDCE); it takes the ACL of the AdminSDHolder container and applies it to all protected groups. Therefore we could write an ACE that will grant us full permissions on all protected groups. Reoccuring backdoor every hour even if Blue Team revoke or change permissions and group memberships of individual affect user accounts. It is normal AD process no alerting as it default structuring of AD that has reconstruction mechanisms to facilitate an AD Domaun existing.

- Use Microsoft Management Console (MMC) - avoid kicking users out of RDP sessions
	1. add the Users and Groups Snap-in: -
		- `File -> Add Snap-In -> Active Directory Users and Groups
	1. Make sure to enable Advanced Features:
		- `View -> Advanced Features` We can find the AdminSDHolder group under `Domain -> System` 
	1.  Navigate to the Security of the group:
		- `Right-click -> Properties -> Security`
	1. Add account and grant full control - `Apply` and then  `Ok` 

Use a AD propagation script like [theyoge's version](https://github.com/theyoge/AD-Pentesting-Tools/blob/main/Invoke-SDPropagator.ps1)
```powershell
Import-Module .\Invoke-ADSDPropagation.ps1 
Invoke-ADSDPropagation
```


## References

[THM AD Persistence Room](https://tryhackme.com/room/persistingad)
[For Older AD Protected Groups](https://learn.microsoft.com/en-us/previous-versions/technet-magazine/ee361593(v=msdn.10))'
[For Modern AD Protected Groups](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/plan/security-best-practices/appendix-c--protected-accounts-and-groups-in-active-directory)