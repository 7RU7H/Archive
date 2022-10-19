Silver tickets are forget Ticket Granting Service (TGSs) as part of Kerberos, see [[Active-Directory-Kerberos-Authenication-Defined]] and it one of many techniques of [[Attacking-Kerberos]]. It is a ticket that grants any ticket, which requires KRBTGT accounts password hash, maybe try [[Mimikatz-Cheatsheet]]. This article is notes on the subject of Golden Tickets:

Requirement:

- Generated TGSs is signed by the machine account of the host we are targeting
- Silver Tickets only have access to the password hash of the machine account of the server we are attacking, therefore only impersonate users on that machine.
- The Silver Ticket's scope is limited to whatever service is targeted on the specific server.
- Forging TGS has no associated TGT, therefore Domain Controller was never contacted
	- This means it is more stealthier as logging occur on the machine not on the DC for Blue Team 
- Permissions are detirmined through SID
	- Non-existent users must have relevant SIDs, i.e SID that indictated the users to be in host's local administrators group 
 - Machine Account Passwords are usually rotated every 30 days
	 - Even so we can leverage the access our TGS provides to gain access to the host's registry and alter the parameter that is responsible for the password rotation of the machine account
	
## References

[THM AD Persistence Room](https://tryhackme.com/room/persistingad)