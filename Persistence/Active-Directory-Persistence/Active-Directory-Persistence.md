# Active Directory Persistence
For Active Directory we can use traditional methods of [[Persistence]] as well as specifical [[Active-Directory-Defined]] Persistence. This one of the final stages [[Lockhead-Martin-Cyber-Kill-Chain]], after [[Active-Directory-Privilege-Escalation]] and [[Active-Directory-Lateral-Movement]]. Although any real-world penetration tests or red team engagements, persistence is not a part of the scope due to the risk of incomplete removal once the assessment is complete.


## Golden Ticket Attacks

The ultimate goal of [[Attacking-Kerberos]] is the get the secret key known only to KDCs, which is the domain user account krbtgt. [[Active-Directory-Kerberos-Authentication-Defined]] details the exact process of authenication and authorization through ticketing the KDC performs. Obtaining the KDC key is the ultimate persistence mechanism as the krbtgt account password is not automatically changed and only changed when the domain functional level is upgraded from Windows 2003 to Windows 2008. Old krbtgt passwords have been found in the wild. Using [[Mimikatz-Cheatsheet]] with current privilege of a Domain Admin group account or the compromised the DC, see [[Active-Directory-Default-Security-Groups-Table]].
```powershell
privilege::debug
lsadump::lsa /patch
# Look for krbtgt
```

Creating [[Golden-Tickets]] and injecting it into memory does not require any administrative privileges, and can even be performed from a computer that is not joined to the domain. And can be done like so:
```powershell 
kerberos::purge # Removed cached tickets
kerberos::golden /user:hacker /domain:$domainname.com /sid:$sid /krbtgt:$krbtgt-hash /ptt # Use name and ID of existing sys admin to reduce suspicion
misc::cmd
```

You will be blocked if you tried to use some `psexec`-like tool with forged TGT if you connect to DC IP forcing NTLM hash authenication.  Use the hostname as the latter is a Overpass the Hash Attack. 

## Heist the NTDS.dit file

Steal the password hashes for all administrative users in the domain by [[Active-Directory-Lateral-Movement]] to the DC and run [[Mimikatz-Cheatsheet]] dump the hashes, steal the [NTDS.dit](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-2000-server/cc961761(v=technet.10)?redirectedfrom=MSDN) (Active Directory's version of SAM database).

## DCsync Attacks

Abuse the [Directory Replication Service Remote Protocol](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/f977faaa-673e-4f66-b9bf-48c640241d47?redirectedfrom=MSDN) that uses [replication](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc772726(v=ws.10)?redirectedfrom=MSDN) to synchronize multiple DCs that exist to provide redundancy. Replication of directory data updates at the attribute level updating from the same directory partition as a unit to the corresponding replica on destination DC over the same network connection. DC's may request update for specific objects with `IDL_DRSGetNCChanges` [API](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/b63730ac-614c-431c-9501-28d6aca91894?redirectedfrom=MSDN). With [[Mimikatz-Cheatsheet]] and compromised Domain Admin:
```powershell
lsadump::dcsync /user:Administrator
```

## Skeleton Keys

Skeleton Key attack, built-in module in [[Mimikatz-Cheatsheet]], is backdoor mechanism that runs on DC in memory allows single password (the skeleton password) that can log in to any account. *"Technically the Skeleton Key does this by manipulating the way the encrypted timesamp (AS-REQ) is validated. As a reminder: in RC4, the timestamp is encrypted using the NT hash of the user by the client, after which the domain controller attempts to decrypt the timestamp using the user's NT hash AND the skeleton key NT hash (mimkatz default: 60BA4FCADC4667A033C178194C03DF6, which is password "mimikatz")".*

- Requires Kerberos RC4 encryption
- Full compromise of DC
- Does not Persist by itself as it runs in memory

Reboot the DC if you use this in a Penetration Test! It is very unsafe otherwise

## References

[THM AD Persistence Room](https://tryhackme.com/room/persistingad)
[Mimkatz Kerberos](https://github.com/gentilkiwi/mimikatz/wiki/module-~-kerberos)
[NTDS.dit Directory Data Store Documentation](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-2000-server/cc961761(v=technet.10)?redirectedfrom=MSDN)
[Directory Replication Service Remote Protocol](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/f977faaa-673e-4f66-b9bf-48c640241d47?redirectedfrom=MSDN)
[AD Replication model](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc772726(v=ws.10)?redirectedfrom=MSDN) 
[IDL_DRSGetNCChanges API](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/b63730ac-614c-431c-9501-28d6aca91894?redirectedfrom=MSDN)
[Kerberos and Attacks 101 by Tim Medin](https://www.youtube.com/watch?v=9lOFpUA25Nk)