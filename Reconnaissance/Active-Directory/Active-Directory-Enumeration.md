# Active Directory Enumeration

For a concise and relevant as *possible* to ethical hacking article on the subject of AD visit:[[Active-Directory-Defined]]

Everything with a Domain (domain-joined (part of a domain)) is a Organisational Unit an object with attributes. These objects represent data, policy and physical machines 

Typical a Domain Controller will host [[DNS]] - [[DNS-Active-Recon]] and [[DNS-Recon-Passive]]


File Shares using SMB - [[SMB-Recon-Cheatsheet]]

Domain joined machines use LDAP to query for Domain information, so should we - [[LDAP-Recon]]. We require specific LDAP `ADsPath` (below) in order to communicate with LDAP.
```powershell
# HostName = computer name, IP address or domain name
# PortNumber = optional - beware script/tooling defaults
# DistinguishedName = unique identifier of an object
LDAP://$HostName[:$PortNumber][/$DistinguishedName]
```
- Always find the most up-to-date information by querying the DC and to the most up-to-date DC. Beware that DCSyncing occurs to synchronise information across a Domain Forest usually from the Primary Domain Controller (PDC) to others. This DC has the `PdcRoleOwner` property
- LDAP requires a specific naming standard: [rfc2247.html](https://www.rfc-editor.org/rfc/rfc2247.html)
	- DC = Domain Component: top of the LDAP tree 
	- CN = Common Name: lowest in LDAP hierarchy

GUI User interaction with remote host - [[RDP-Recon]] and [[RDP]]

Service to Domain Joined Machine communication with RPC - see [[RPC-Recon]]


[[PSExec]]
[[WinRM]] 

## Remote Tooling 

[[Crackmapexec-Cheatsheet]]
[[Bloodhound-Guide]] has a remote python ingestor `Bloodhound.py` 

## ACL, ACE and Object Permissions

Access Control Lists ([ACL](https://learn.microsoft.com/en-us/windows/win32/secauthz/access-control-lists) (link:[[ACL-Abuse]])) is a list of [ACE](https://learn.microsoft.com/en-us/windows/win32/secauthz/access-control-entries)s (Access Control Entries) *Each ACE controls or monitors access to an object by a specified trustee. For information about adding, removing, or changing the ACEs in an object's ACLs.*

*All types of ACEs contain the following access control information:*
- A [security identifier](https://learn.microsoft.com/en-us/windows/win32/secauthz/security-identifiers) (SID) that identifies the [trustee](https://learn.microsoft.com/en-us/windows/win32/secauthz/trustees) to which the ACE applies.
- An [_access mask_](https://learn.microsoft.com/en-us/windows/desktop/SecGloss/a-gly) that specifies the [access rights](https://learn.microsoft.com/en-us/windows/win32/secauthz/access-rights-and-access-masks) controlled by the ACE.
- A flag that indicates the type of ACE.
- A set of bit flags that determine whether child containers or objects can inherit the ACE from the primary object to which the ACL is attached.

Visit the links to view exploitation of Object permissions 
- [[GenericAll]]: Full permissions on object
- [[GenericWrite]]: Edit certain attributes on the object
- [[WriteOwner]]: Change ownership of the object
- [[WriteDACL]]: Edit ACE's applied to object
- [[AllExtendedRights]]: Change password, reset password, etc.
- [[ForceChangePassword]]: Password change for object
- Self (Self-Membership): Add ourselves to for example a group


Enumerate ACEs with PowerView:
```powershell
Get-ObjectAcl -Identity $username
Get-ObjectAcl -Identity $username | select ObjectSID, SecurityIdentifier, ActiveDirectoryRights
# Username's SID and SecurityIdentifier
Convert-SidToNAme $SID

# Check all the permission 
# Change the $GROUP
$permissionList = @("GenericAll", "GenericAll", "WriteOwner", "WriteDADL", "AllExtendedRights", "ForceChangePassword", "Self")
for ($permission in $permissionList) { Get-ObjectAcl -Identity "$GROUP" | ? {$_.ActiveDirectoryRights -eq "$permission"} | select SecurityIdentifier,ActiveDirectoryRights} 
```

## LOLBAS, Powershell and .NET classes for AD enumeration.. 

Legacy Windows builtin utilities
```powershell
net user /domain
net user $username /domain
net group /domain
# Check custom groups
net group "Custom Admins" /domain
```

Active Directory PowerShell Module is only installed by default on DCs as part of Remote Server Administration Tools (RSAT) - if on non-DC requires Administrative Privileges to install them. It is possible to import the DLL.
```
```

.NET classes related to AD `System.DirectoryServices.ActiveDirectory.$classGoesHere` namespace 
```powershell
powershell -ep bypass
$domainObject = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$domainObject.PdcRoleOwner.Name
```

PowerShell interaction with ADSI (a set COM interfaces the can communicate with AD)
```powershell
## '' indicate searching from top of AD hierarchy
([adsi]'').distinguishedName
```

To get a legal LDAP query we require all of the above for least unwieldy
```powershell
$PDC = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.Name
$DN = ([adsi]'').distinguishedName 
$LDAP = "LDAP://$PDC/$DN"
$LDAP

# Search $LDAP with:
# .NET DirectorySearcher class to enumerate a .NET DirectoryEntry 
$direntry = New-Object System.DirectoryServices.DirectoryEntry($LDAP)
$dirsearcher = New-Object System.DirectoryServices.DirectorySearcher($direntry)
# Filter with LDAP filter string
# LDAPSTRING -like: 
# "DC=DOMAIN,DC=LOCAL" - all information in base naming context 
# "samAccountType=805306368" : all users in domains
# "(objectClass=group)"
$dirsearcher.filter="$LDAPSTRING"
$result = $dirsearcher.FindAll()
# Add a loop
Foreach($obj in $result)
{
    Foreach($prop in $obj.Properties)
    {
        $prop
        $prop.memberoff
    }
    Write-Host "-------------------------------"
}
```

Search LDAP with `import-module .\$name.ps1` and `LDAPSEARCH -LDAPQUERY "$QUERY"`
```powershell
function LDAPSearch {
    param (
        [string]$LDAPQuery
    )
    $PDC = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.Name
    $DistinguishedName = ([adsi]'').distinguishedName
    $DirectoryEntry = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$PDC/$DistinguishedName")
    $DirectorySearcher = New-Object System.DirectoryServices.DirectorySearcher($DirectoryEntry, $LDAPQuery)
    return $DirectorySearcher.FindAll()

}
```

Loop through group properties, find a target group and get a member
```powershell
foreach ($group in $(LDAPSearch -LDAPQuery "(objectCategory=group)")) { $group.properties | select {$_.cn}, {$_.member}}
# $GROUPNAME and NESTEDGROUP (remember the * at the end of NESTGROUP that indicates nesting)
$targetGroup = LDAPSearch -LDAPQuery "(&(objectCategory=group)(cn=$GROUPNAME))"
$targetGroup.properties.member
# If group is nested
$nestedGroup = LDAPSearch -LDAPQuery "(&(objectCategory=group)(cn=$NESTEDGROUP*))"
```

SPN enumeration - See [[Powerview-Cheatsheet]] and [[Bloodhound-Guide]] 
```powershell
# LDAP query (&(objectCategory=computer)(objectClass=computer))
sc \\$ForEachMachine queryex type= service state= all
setspn -L $service
```

#### File Shares

```powershell
# If you have administrative privileges
Get-WmiObject -Class Win32_Share -ComputerName *
net share
net view \\$ComputerName

ls \\$SHARENAME\$path\$file.$extension
# Find a Group policy preferences hash - 
# findstr /si "cpassword=""
# use gpp-decrypt "$GPPhash" on Kali
```


## PowerView

[Powerview](https://github.com/PowerShellMafia/PowerSploit/blob/master/Recon/PowerView.ps1) from PowerShellMafia's [PowerSploit](https://powersploit.readthedocs.io/en/latest/Recon/) repository is a a PowerShell module    designed to aid in reconnaissance of an Active Directory Domain. Although created before the advent of Bloodhound(visit [[Bloodhound-Guide]] for more details) it is still a powerful way to enumerate a domain, although probably in either obfuscated chunks or the translated to the direct Windows API or LDAP calls for more stealth.  Visit the [[Powerview-Cheatsheet]]

## SysInternals

Visit [[Sysinternals]] for all the tools that will eventually get used at some point or better the official Documentation as there are so many. `PSLoggedon` can enumerate logged on users, but requires Remote Registry service - not enabled on default Windows Workstations since Windows 8.
```powershell
PSLoggedon.exe 
PSLoggedon64.exe 
```

## References

[https://www.rfc-editor.org/rfc/rfc2247.html](https://www.rfc-editor.org/rfc/rfc2247.html)
[Learn Microsoft - .NET API - directorysevices.directorysearcher.filter](https://learn.microsoft.com/en-us/dotnet/api/system.directoryservices.directorysearcher.filter?view=dotnet-plat-ext-7.0)
[thehackerrecipes LDAP recon](https://www.thehacker.recipes/ad/recon/ldap)
[Powerview](https://github.com/PowerShellMafia/PowerSploit/blob/master/Recon/PowerView.ps1) 
[PowerSploit Documenation](https://powersploit.readthedocs.io/en/latest/) 
[Microsoft Documentation ACL](https://learn.microsoft.com/en-us/windows/win32/secauthz/access-control-lists) 
[Microsoft Documentation ACE](https://learn.microsoft.com/en-us/windows/win32/secauthz/access-control-entries)