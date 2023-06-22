# Powerview-Cheatsheet
Union of cheatsheets from awesome places and people on the internet [HarmJ0y](https://gist.github.com/HarmJ0y/184f9822b195c52dd50c379ed3117993) and [Macostag](https://gist.github.com/macostag/44591910288d9cc8a1ed6ea35ac4f30f). Please thank [Mario(macostag)](https://github.com/macostag) and [HarmJ0y](https://github.com/HarmJ0y) for there work, I just formatted and manually diff-ed the cheatsheets for personal use. Note from [HarmJ0y](https://github.com/HarmJ0y): "*"
PowerView's last major overhaul is detailed here: http://www.harmj0y.net/blog/powershell/make-powerview-great-again/, tricks for the 'old' PowerView are at https://gist.github.com/HarmJ0y/3328d954607d71362e3c"*

## Basic Enumeration
```powershell
#Basic Domain Information
Get-NetDomain

#User Information
Get-NetUser
Get-NetUser | select samaccountname, description, logoncount
Get-NetUser -UACFilter NOT_ACCOUNTDISABLE | select samaccountname, description, pwdlastset, logoncount, badpwdcount
Get-NetUser -LDAPFilter '(sidHistory=*)'
Get-NetUser -PreauthNotRequired
Get-NetUser -SPN

#Groups Information
Get-NetGroup | select samaccountname,description
Get-DomainObjectAcl -SearchBase 'CN=AdminSDHolder,CN=System,DC=EGOTISTICAL-BANK,DC=local' | %{ $_.SecurityIdentifier } | Convert-SidToName

#Computers Information
Get-NetComputer | select samaccountname, operatingsystem
Get-NetComputer -Unconstrained | select samaccountname 
Get-NetComputer -TrustedToAuth | select samaccountname
Get-NetUser -TrustedToAuth # Look at msds-allowedtodelegateto for Kerberos Delegation Exploitation!
Get-DomainGroup -AdminCount | Get-DomainGroupMember -Recurse | ?{$_.MemberName -like '*
```

## Domain Information
```powershell
# Domain Info
Get-NetDomain #Get info about the current domain
Get-NetDomain -Domain mydomain.local
Get-DomainSID #Get domain SID

# Policy
Get-DomainPolicy # Get the default domain policy.
(Get-DomainPolicy)."KerberosPolicy" #Kerberos tickets info(MaxServiceAge)
(Get-DomainPolicy)."System Access" #Password policy
(Get-DomainPolicy).PrivilegeRights #Check your privileges

# Domain Controller
Get-DomainController # Current DC
Get-NetDomainController -Domain mydomain.local #Get specific Domain Controller

# OUs Domain Computer
"*admin*","*server*" | Get-DomainOU # Search for OUs with the specific names.
Get-DomainComputer -SearchBase "LDAP://OU=tMachines,DC=domain,DC=local" # List computer objects in machines OU.
Get-DomainComputer -OperatingSystem '*2016*' -Properties name,operatingsystem # List computer objects with a specific operating system.
Get-DomainComputer -SPN '*mssql*' -Properties name # List computer objects with a specific service principal name.
Get-DomainComputer -TrustedToAuth # List computer objects that are trusted to authenticate for other principals.
Get-DomainComputer -Unconstrained # List computer objects that have unconstrained delegation.
Get-DomainGroup -Identity '*admin*' # List all group objects containing the word admin in group name.
```

## Local Administration 
```powershell
# Get the local groups on the local (or remote) machine. Needs administrator privs.
# By default, the Win32 API call NetLocalGroupEnum will be used (for speed). Specifying "-Method WinNT" causes the WinNT service provider to be used instead.
Get-NetLocalGroup -ComputerName SQL1
Get-NetLocalGroup -ComputerName SQL1 -Method WinNT

# Get members of a specific local group on the local (or remote) machine.By default administrator group.
# By default, the Win32 API call NetLocalGroupEnum will be used (for speed). Specifying "-Method WinNT" causes the WinNT service provider to be used instead.
Get-NetLocalGroupMember -ComputerName DC
Get-NetLocalGroupMember -ComputerName DC -Method WinNT
```

## Users, Groups and Net Computers
```powershell
# Users
Get-NetUser #Get users with several (not all) properties
Get-NetUser | select -ExpandProperty samaccountname #List all usernames
Get-NetUser -UserName student107 #Get info about a user
Get-NetUser -properties name, description #Get all descriptions
Get-NetUser -properties name, pwdlastset, logoncount, badpwdcount #Get all pwdlastset, logoncount and badpwdcount
Find-UserField -SearchField Description -SearchTerm "built" #Search account with "something" in a parameter

# Users Filters
Get-NetUser -UACFilter NOT_ACCOUNTDISABLE -properties distinguishedname #All enabled users
Get-NetUser -UACFilter ACCOUNTDISABLE #All disabled users
Get-NetUser -UACFilter SMARTCARD_REQUIRED #Users that require a smart card
Get-NetUser -UACFilter NOT_SMARTCARD_REQUIRED -Properties samaccountname #Not smart card users
Get-NetUser -LDAPFilter '(sidHistory=*)' #Find users with sidHistory set
Get-NetUser -PreauthNotRequired #ASREPRoastable users
Get-NetUser -SPN | select serviceprincipalname #Kerberoastable users
Get-NetUser -SPN | ?{$_.memberof -match 'Domain Admins'} #Domain admins kerberostable
Get-Netuser -TrustedToAuth #Useful for Kerberos constrain delegation
Get-NetUser -AllowDelegation -AdminCount #All privileged users that aren't marked as sensitive/not for delegation

#Groups
Get-NetGroup #Get groups
Get-NetGroup -Domain mydomain.local #Get groups of an specific domain
Get-NetGroup 'Domain Admins' #Get all data of a group
Get-NetGroup -AdminCount #Search admin grups
Get-NetGroup -UserName "myusername" #Get groups of a user
Get-NetGroupMember -Identity "Administrators" -Recurse #Get users inside "Administrators" group. If there are groups inside of this grup, the -Recurse option will print the users inside the others groups also
Get-NetGroupMember -Identity "Enterprise Admins" -Domain mydomain.local #Remember that "Enterprise Admins" group only exists in the rootdomain of the forest
Get-NetLocalGroup -ComputerName dc.mydomain.local -ListGroups #Get Local groups of a machine (you need admin rights in no DC hosts)
Get-NetLocalGroupMember -computername dcorp-dc.dollarcorp.moneycorp.local #Get users of localgroups in computer
Get-DomainObjectAcl -SearchBase 'CN=AdminSDHolder,CN=System,DC=testlab,DC=local' -ResolveGUIDs #Check AdminSDHolder users
Get-NetGPOGroup #Get restricted groups

# Computers
Get-NetComputer #Get all computer objects
Get-NetComputer -Ping #Send a ping to check if the computers are working
Get-NetComputer -Unconstrained #DCs always appear but aren't useful for privesc
Get-NetComputer -TrustedToAuth #Find computers with Constrined Delegation
Get-DomainGroup -AdminCount | Get-DomainGroupMember -Recurse | ?{$_.MemberName -like '*
```

## Logon and Sessions
```powershell
Get-NetLoggedon -ComputerName <servername> #Get net logon users at the moment in a computer (need admins rights on target)
Get-NetSession -ComputerName <servername> #Get active sessions on the host
Get-LoggedOnLocal -ComputerName <servername> #Get locally logon users at the moment (need remote registry (default in server OS))
Get-LastLoggedon -ComputerName <servername> #Get last user logged on (needs admin rigths in host)
Get-NetRDPSession -ComputerName <servername> #List RDP sessions inside a host (needs admin rights in host)

# Shared Files and Folders

Get-NetFileServer #Search file servers. Lot of users use to be logged in this kind of servers
Find-DomainShare -CheckShareAccess #Search readable shares
Find-InterestingDomainShareFile #Find interesting files, can use filters
```
## User Hunting 
```powershell
# get users logged on the local (or a remote) machine. Note: administrative rights needed for newer Windows OSes.
Get-NetLoggedon -ComputerName adminsrv -Verbose

# get session information for the local (or a remote) machine.This function will execute the NetSessionEnum Win32API call to query a given host for active sessions.
Get-NetSession -ComputerName APPSRV -Verbose

# get who is logged onto the local (or a remote) machine through enumeration of remote registry keys.
# Note: This function requires only domain user rights on the machine you're enumerating, but remote registry must be enabled.
Get-RegLoggedOn -ComputerName DC -Verbose

# get remote desktop/session information for the local (or a remote) machine.
# Note: only members of the Administrators or Account Operators local group can successfully execute this functionality on a remote target.
# This function will execute the WTSEnumerateSessionsEx and WTSQuerySessionInformation Win32API calls to query a given RDP remote service for active sessions and originating IPs.
Get-NetRDPSession -ComputerName STDADMIN -Verbose

# Returns the last user who logged onto the local (or a remote) machine.
# Note: This function requires administrative rights on the machine you're enumerating.
Get-WMIRegLastLoggedOn -ComputerName DC -Verbose

# Tests if the current user has administrative access to the local (or a remote) machine (use the OpenSCManagerW Win32API call).
Test-AdminAccess -Verbose

# Finds machines on the local domain where the current user has local administrator access.
Find-LocalAdminAccess -Verbose

# Enumerates the members of specified local group (default administrators) for all the targeted machines on the current (or specified) domain.
# By default, the API method is used, but this can be modified with '-Method winnt' to use the WinNT service provider.
# Needs admin privs.
Find-DomainLocalGroupMember -Verbose

# Finds domain machines where specific users are logged into.
Find-DomainUserLocation -Verbose
Find-DomainUserLocation -Stealth -Verbose

```

## GPOs & OUs
```powershell
#GPO
Get-NetGPO #Get all policies with details
Get-NetGPO | select displayname #Get the names of the policies
Get-NetGPO -ComputerName <servername> #Get the policy applied in a computer
gpresult /V #Get current policy

# Enumerate permissions for GPOs where users with RIDs of > -1000 have some kind of modification/control rights
Get-DomainObjectAcl -LDAPFilter '(objectCategory=groupPolicyContainer)' | ? { ($_.SecurityIdentifier -match '^S-1-5-.*-[1-9]\d{3,}

# Return GPO applied on OU.
Get-DomainOU -Identity "*student*" -Properties name,gplink | Format-List
Get-DomainGPO -SearchBase "LDAP://cn={3E04167E-C2B6-4A9A-8FB7-C811158DC97C},cn=policies,cn=system,DC=domain,DC=local"
# Returns all GPOs applied on a computer object.
Get-DomainGPO -ComputerName windows1.local
# Returns all GPOs applied on an user object.
Get-DomainGPO -UserIdentity "user"

# Returns all GPOs in a domain that modify local group memberships through 'Restricted Groups' or Group Policy preferences.
Get-DomainGPOLocalGroup -ResolveMembersToSIDs

# Enumerates the machines where a specific domain user/group is a member of a specific local group, all through GPO correlation.
Get-DomainGPOUserLocalGroupMapping -Identity "user" -LocalGroup "Administrators"

# Finds users who have RDP rights through domain computer-GPO correlation.
Get-DomainGPOComputerLocalGroupMapping -ComputerName PC.domain.local -LocalGroup RDP

# Finds users who have admin rights through OU-GPO correlation.
Get-DomainGPOComputerLocalGroupMapping -OUIdentity "servers" -LocalGroup Administrators

# Return the GPOs with the name of admin,server.
"*admin*","*server*" | Get-DomainGPO

# Returns all OUs with linked to the specified group policy object.
Get-DomainOU -GPLink "3E04167E-C2B6-4A9A-8FB7-C811158DC97C"
```
 
## ACL & Active Directory ACLs
```powershell
Get-ObjectAcl -SamAccountName <username> -ResolveGUIDs #Get ACLs of an object (permissions of other objects over the indicated one)
Get-PathAcl -Path "\\dc.mydomain.local\sysvol" #Get permissions of a file
Find-InterestingDomainAcl -ResolveGUIDs #Find intresting ACEs (Interesting permissions of "unexpected objects" (RID>1000 and modify permissions) over other objects
Find-InterestingDomainAcl -ResolveGUIDs | ?{$_.IdentityReference -match "RDPUsers"} #Check if any of the interesting permissions founds is realated to a username/group
Get-NetGroupMember -GroupName "Administrators" -Recurse | ?{$_.IsGroup -match "false"} | %{Get-ObjectACL -SamAccountName $_.MemberName -ResolveGUIDs} | select ObjectDN, IdentityReference, ActiveDirectoryRights #Get special rights over All administrators in domain

# Enumerate ACLs for all the GPOs.
Get-DomainGPO | %{Get-DomainObjectAcl -Identity $_.displayname -ResolveGUIDs}

# Enumerates the ACLs for every object in the domain with Get-DomainObjectAcl, and for each returned ACE entry it checks if principal security identifier is -1000 (meaning the account is not built in), and also checks if the rights for the ACE mean the object can be modified by the principal.
Find-InterestingDomainAcl -ResolveGUIDs | Select-Object ObjectDN,ActiveDirectoryRights,securityidentifier | Format-List
```

## Domain Trust
```powershell
Get-NetDomainTrust #Get all domain trusts (parent, children and external)
Get-NetForestDomain | Get-NetDomainTrust #Enumerate all the trusts of all the domains found
Get-DomainTrustMapping #Enumerate also all the trusts
Get-ForestGlobalCatalog #Get info of current forest (no external)
Get-ForestGlobalCatalog -Forest external.domain #Get info about the external forest (if possible)
Get-DomainTrust -SearchBase "GC://$($ENV:USERDNSDOMAIN)" 
Get-NetForestTrust #Get forest trusts (it must be between 2 roots, trust between a child and a root is just an external trust)
Get-DomainForeingUser #Get users with privileges in other domains inside the forest
Get-DomainForeignGroupMember #Get groups with privileges in other domains inside the forest
```


## References

[Mario(macostag)](https://github.com/macostag)
[HarmJ0y](https://github.com/HarmJ0y)
[HarmJ0y Updated Cheatsheet](https://gist.github.com/HarmJ0y/184f9822b195c52dd50c379ed3117993) 
[Macostag Cheatsheet](https://gist.github.com/macostag/44591910288d9cc8a1ed6ea35ac4f30f)