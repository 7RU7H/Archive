# Active Directory Commands

## BEWARE Active Directory cmdlets are only installed by default on Domain Controllers
```powershell
Get-ADUser <user>
Get-ADGroupMember <groupname> -recursive


gpupdate /force 		# update group object policy, default is every 90mins!
gpresult /H outfile.html 	# use to figure out a result of multiple settings collision possibilities
```
