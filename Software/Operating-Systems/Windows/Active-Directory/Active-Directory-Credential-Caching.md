# Active Directory Credential Caching

For type of authenication see [[Active-Directory-Authentication]] for attacks against them see [[Password-Attacks]] and [[Attacking-Kerberos]]. This article is a about the storage and retrieval of cached credentials used in [[Active-Directory-Defined]].

Microsoft's implementation of Kerberos utilizes single sign-on. The password hashes must be stored somewhere in order to renew a TGT request. Windows, stores these hashes in the Local Security Authority Subsystem Service (LSASS) from versions 2000-2022. LSASS one of the critical [[Windows-Processes]] that is run as SYSTEM, access is limited to SYSTEM or local Administrator level [[Windows-Accounts]] and [[Windows-System-And-Service-Privileges]]. The builtin `klist` command can be used to display all cached Kerberos tickets 

[[Mimikatz-Cheatsheet]] is commonly used attack tool used to retrieve these. Output with TGT will allow for [[Attacking-Kerberos]] with Golden Ticket Attacks, [[Mimikatz-Cheatsheet]] can export tickets and import tickets into LSASS.

## References

[AD Security Subsystem Architecture](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-2000-server/cc961760(v=technet.10)?redirectedfrom=MSDN)
[theITbros](https://theitbros.com/active-directory-cached-credentials/)
[Microsoft Documentation: Passwords technical overview](https://docs.microsoft.com/en-us/windows-server/security/kerberos/passwords-technical-overview)