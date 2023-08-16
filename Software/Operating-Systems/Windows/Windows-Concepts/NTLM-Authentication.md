# NTLM Authentication


Client - Server
- Client  -> Type 1 Message: Negotiation -> Server
	- Initate Connection, Negotiate Parameters, User and Domain
		- Server can check User and Domain before beginning local authenication  
- Client  <- Type 2 Message: Challenge <- Server
	- Server create SEcurity Context and sends back its ID to the client 
- Client  -> Type 3 Message: Authentication (Empy Type if successful) (Response to Chellenge) -> Server
	- Only if the client successfully associates themselves with an existing Security Context ID 



## References

[THM Local Potato Room](https://tryhackme.com/room/localpotato)