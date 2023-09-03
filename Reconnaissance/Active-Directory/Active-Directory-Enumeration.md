# Active Directory Enumeration

For a concise and relevant as *possible* to ethical hacking article on the subject of AD visit:[[Active-Directory-Defined]]

Everything with a Domain (domain-joined (part of a domain)) is a Organisational Unit an object with attributes. These objects represent data, policy and physical machines 

Typical a Domain Controller will host [[DNS]] - [[DNS-Active-Recon]] and [[DNS-Recon-Passive]]



File Shares using SMB - [[SMB-Recon-Cheatsheet]]

Domain joined machines use LDAP to query for Domain information, so should we - [[LDAP-Recon]]. We require specific LDAP ADsPath (below) in order to communicate with LDAP.
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


[[Crackmapexec-Cheatsheet]]

[[PSExec]]
[[WinRM]] 

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
```

## References

[https://www.rfc-editor.org/rfc/rfc2247.html](https://www.rfc-editor.org/rfc/rfc2247.html)
