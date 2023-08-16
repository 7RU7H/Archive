# Active Directory Commands
For exploitation see [[AD-Exploitation-Hub]] or general theory and definitions [[Active-Directory-Defined]]. For enumeration see [[Active-Directory-Enumeration-Defined]] or for Privilege Escalation see [[Active-Directory-Privilege-Escalation]].

BEWARE Active Directory cmdlets are only installed by default on Domain Controllers
```powershell

import-module ActiveDirectory
# General logic to syntax of powershell
# Get-X = retrieve information of a object
# Set-X = set a value
# New-X = Create a new
# Add-X = add something to a object that exists
# For examples creating a new Domain Admin 
New-ADUser -Name '7ru7h'
Set-ADAccountPassword -Identity 7ru7h -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd1!" -Force)
Add-ADGroupMember -Identity "Domain Admins" -Members "7ru7h"
Enable-ADAccount -Identity NVM
net localgroup "Administrators" 7ru7h /add 
gpupdate /force


# Display all trusts
Get-ADTrust -Filter *
# Get information about a user
Get-ADUser $user
Get-ADGroupMember $group -recursive

Get-ADGroup -Identity "Enterprise Admins" -Server rootdc.thereserve.loc

gpupdate /force 		# update group object policy, default is every 90mins!
gpresult /H outfile.html 	# use to figure out a result of multiple settings collision possibilities
```
