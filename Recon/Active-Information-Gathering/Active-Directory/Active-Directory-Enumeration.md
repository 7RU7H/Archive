# Active Directory Enumeration

For exploitation see [[AD-Exploitation-Hub]] or general theory and definitions [[Active-Directory-Defined]]. For commands cheatsheet [[Active-Directory-Commands]] or for Privilege Escalation see [[Active-Directory-Privilege-Escalation]]. Once a [[Foothold-On-AD]] is established the objective is continuing the [[Lockhead-Martin-Cyber-Kill-Chain]] till escalating privileges to a Domain Controller or a Domain Admin group member. Information gathering about the domain is critical to meeting this objective.

## Enumerating Towards the Chain of Compromise
With net user/group look for custom groups and check nested groups and especially admin users. `net user` will only show user
```powershell
net user /domain # User account fo r \\DC*.*domain*.*tld
net user *admin* /domain # information about the admin
net group /domain # All groups in domain
```

[[Useful_Powershell]] cmdlets for AD `Get-ADUser` are only installed by default on the DC with [RSAT](https://docs.microsoft.com/en-us/previous-versions/technet-magazine/gg413289(v=msdn.10)?redirectedfrom=MSDN), see [[Active-Directory-Privilege-Escalation]] and [[Useful_Powershell]] for more cmdlets and commands. They maybe install on Windows 7- onwards, but require Administrative privileges to utilize. But [[Basic_Powershell]] is a useful tool installed by default regardless for administrative scripting and automation. 

[ADAPE](https://github.com/hausec/ADAPE-Script)
For User, Group and Nested Group enumeration see, the above is better but this also a perfect place to remind myself to keep added to this to learn Powershell(Probably going to translate to Csharp also) AD:
[My AllTheHackingScripts has AD Enumeration](https://github.com/7RU7H/AllTheHackingScripts/blob/main/powershell/ADtruth.ps1)

Currently Logged on users that are of important groups have credentials cached in memory that could be stolen and used to authenticate with them to perform[[Windows-Network-Lateral-Movement]] or for interacting with [Service principle names](https://docs.microsoft.com/en-us/windows/win32/ad/service-principal-names?redirectedfrom=MSDN) and [[Attacking-Kerberos]] or any other [[Foothold-On-AD]]. For more information on the mechanics of Kerberos  [[Active-Directory-Kerberos-Defined]].

Reliable functions  `NetWkstaUserEnum`(requires Administrative privileges returns a list of active users on a workstation) and `NetSessionEnum`(does not, returns list of list of active user sessions on servers). Use `NetWkstaUserEnum` post-`NT SYSTEM Level`- Only useful for users the local administrator privileges over that  are logged on. Use `NetSessionEnum` enumerate all active users' sessions. Similiarly and much more extensive enumeration with [Powerview](https://github.com/PowerShellMafia/PowerSploit/blob/dev/Recon/PowerView.ps1) can be utilised to great affect in information gathering. Link to: [[Powercat-Cheatsheet]].

[Service principle names](https://docs.microsoft.com/en-us/windows/win32/ad/service-principal-names?redirectedfrom=MSDN) as Applications are executed in the context of the operation system user and that user account defines that context, whereas service executed by system itself a [Service Account](https://docs.microsoft.com/en-us/windows/win32/services/service-user-accounts?redirectedfrom=MSDN).  Enumeration through these can lead to [[Attacking-Kerberos]] or [[Foothold-On-AD]]. Application use one of the predefined service accounts below to be lauched by the system.

Service Accounts | Privileges 
--- | ---
[LocalSystem](https://docs.microsoft.com/en-us/windows/win32/services/localsystem-account?redirectedfrom=MSDN) | [[Windows-System-And-Service-Privileges]] 
[LocalService](https://docs.microsoft.com/en-us/windows/win32/services/localservice-account?redirectedfrom=MSDN) | [[Windows-System-And-Service-Privileges]]
[NetworkService](https://docs.microsoft.com/en-us/windows/win32/services/networkservice-account?redirectedfrom=MSDN) | [[Windows-System-And-Service-Privileges]]

Domain user account may be required to provide the service accounts more access to resource inside the domain. 

By enumerating all [SPN](https://docs.microsoft.com/en-us/windows/win32/ad/service-principal-names?redirectedfrom=MSDN)s in the domain we get: IP and ports running applications intergated on AD servers, without scanning the network.

## Microsoft Management Console
If access to RDP you can enumerate with Microsoft Management Console (MMC) with the [Remote Server Administration Tools](https://docs.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps) (RSAT) AD Snap-Ins
1.  Press **Start**
2.  Search **"Apps & Features"** and press enter
3.  Click **Manage Optional Features**
4.  Click **Add a feature**
5.  Search for **"RSAT"**  [RSAT](https://docs.microsoft.com/en-us/previous-versions/technet-magazine/gg413289(v=msdn.10)?redirectedfrom=MSDN)
6.  Select "**RSAT: Active Directory Domain Services and Lightweight Directory Tools"** and click **Install**


## Active Directory Service Interfaces (ADSI)
- **DNS**
For more about [[DNS-Theory]], for enumeration for DNS see both 
[[DNS-Recon-Active]] and [[DNS-Recon-Passive]].
- **SMB**
[[SMB-Recon-Cheatsheet]] and [[RPCClient-Cheatsheet]]
- **LDAP**
[[LDAP-Recon]]

## SAM Account Type Attributes
[SAM-Account-Type](https://docs.microsoft.com/en-us/windows/win32/adschema/a-samaccounttype?redirectedfrom=MSDN)


## References
[THM Enumerating AD room](https://tryhackme.com/room/adenumeration)
[Remote Server Administration Tools](https://docs.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps)
[Remote Server Administration Tools 2](https://docs.microsoft.com/en-us/previous-versions/technet-magazine/gg413289(v=msdn.10)?redirectedfrom=MSDN)
[SAM-Account-Type](https://docs.microsoft.com/en-us/windows/win32/adschema/a-samaccounttype?redirectedfrom=MSDN)
 [Service principle names](https://docs.microsoft.com/en-us/windows/win32/ad/service-principal-names?redirectedfrom=MSDN)
 [LocalSystem](https://docs.microsoft.com/en-us/windows/win32/services/localsystem-account?redirectedfrom=MSDN)
[LocalService](https://docs.microsoft.com/en-us/windows/win32/services/localservice-account?redirectedfrom=MSDN)
[NetworkService](https://docs.microsoft.com/en-us/windows/win32/services/networkservice-account?redirectedfrom=MSDN)
[Service Accounts](https://docs.microsoft.com/en-us/windows/win32/services/service-user-accounts?redirectedfrom=MSDN)