# Active Directory Commands
For exploitation see [[AD-Exploitation-Hub]] or general theory and definitions [[Active-Directory-Defined]]. For enumeration see [[Active-Directory-Enumeration]] or for Privilege Escalation see [Active-Directory-Privilege-Escalation]].

## BEWARE Active Directory cmdlets are only installed by default on Domain Controllers
```powershell
Get-ADUser <user>
Get-ADGroupMember <groupname> -recursive


gpupdate /force 		# update group object policy, default is every 90mins!
gpresult /H outfile.html 	# use to figure out a result of multiple settings collision possibilities
```
