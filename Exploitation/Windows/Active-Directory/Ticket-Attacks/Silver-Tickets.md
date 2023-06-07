Silver tickets are forget Ticket Granting Service (TGSs) as part of Kerberos, see [[Active-Directory-Kerberos-Authenication-Defined]] and it one of many techniques of [[Attacking-Kerberos]]. It is a ticket that grants ticket for a specific target, which **DOES NOT requires compromising the KRBTGT**, maybe try [[Mimikatz-Cheatsheet]]. Tim Medin: *"In a Silver Ticket attack, we force a Service ticket with a custom PAC (to escalate privileges). This Service Ticket is forged using the Target LT key (NTLM Service Hash). As we don't have the KDC LT key, we cannot create a valid, complete PAC signature. However, PAC validation is usually disabled, which means there is an opportunity."*

Some Service Accounts will not verify the second signature - SQLservers, but not Webservers! This article is notes on the subject of Silver Tickets:

Server Portion: - Server gets this
- User details
- Session Key (same as Users)
- PAC
- Signed with Target LT key
- Signed with KDC LT key
- Encrypted with service account's NTLM Hash

User Portion: - User gets this
- Validity time
- Session Key (same as Server's)
Encrypted with the TGT session key


Requirement:

- Generated TGSs is signed by the machine account of the host we are targeting
- Silver Tickets only have access to the password hash of the machine account of the server we are attacking, therefore only impersonate users on that machine.
- The Silver Ticket's scope is limited to whatever service is targeted on the specific server.
- Forging TGS has no associated TGT, therefore Domain Controller was never contacted
	- This means it is more stealthier as logging occur on the machine not on the DC for Blue Team 
- Permissions are determined through SID
	- Non-existent users must have relevant SIDs, i.e SID that indicated the users to be in host's local administrators group 
 - Machine Account Passwords are usually rotated every 30 days
	 - Even so we can leverage the access our TGS provides to gain access to the host's registry and alter the parameter that is responsible for the password rotation of the machine account

## References

[THM AD Persistence Room](https://tryhackme.com/room/persistingad)
[Kerberos and Attacks 101 by Tim Medin](https://www.youtube.com/watch?v=9lOFpUA25Nk)