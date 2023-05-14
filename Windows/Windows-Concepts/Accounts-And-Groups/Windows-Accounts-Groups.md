# Accounts and Groups

```powershell
net user /add <user> password
net localgroup <preferedGroup> <user> /add
net user /del <user>
net localgroup <usersfromgroupsyoudontwantpartof> <users> /del
```

SIDs are used to track the security principal and the account's access when connecting to resources

SID Attributes

Attribute | Description and Use
--- | ---
SID History | To enable access for an account to effectively be cloned to another

## Account SID simplified format
NAME |SID	
--- | ---
Administrator |	S-1-5-DOMAIN-500
Guest	|	S-1-5-32-546
System	|	ALL the permissions of admin

[LAPs](https://techcommunity.microsoft.com/t5/itops-talk-blog/step-by-step-guide-how-to-configure-microsoft-local/ba-p/2806185) Group can read passwords

## References

[Security identifier documentation](https://docs.microsoft.com/en-us/windows/win32/secauthz/security-identifiers) 
[Setting Up Laps Blog](https://techcommunity.microsoft.com/t5/itops-talk-blog/step-by-step-guide-how-to-configure-microsoft-local/ba-p/2806185)