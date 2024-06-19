# DHCP 

[Dynamic Host Configuration Protocol (DHCP)](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol) [*is a network management protocol used to dynamically assign an IP address to any device, or node, on a network so it can communicate using IP*](https://www.techtarget.com/searchnetworking/definition/DHCP). This protocol ensures any new machines that join a network can negotiate with a DHCP server to receive an assigned unused unique IP address.

- Role 
	- It uses UDP
	- A DHCP server assigns IP address to each host that join the network. 
		- These IP addresses are only valid to set amounts of time. 
	 - Provides the machines that then are network joined: 
		 - network's subnet mask, default gateway address and it domain name server addresses.
- Entails - Prevents Spoofing
	- Prevents issues regarding new machines joining the network 
	- Centralise address to host name configuration
	- Reduces human network administration
	- Centralisation

Remember DHCP with DORA
```c
DHCP Discover (DIS)
DHCP Offer (OFF)
DHCP Request (REQ)
DHCP Acknowledge (ACK)

Client -> Discover -> Server
Client <- Offer <- Server
Client -> Request -> Server
Client <- Acknowledge <- Server
```

## References


[YouTube - Part 1 Networking for Pentesters: Beginner -SheNetworks - Serena  DiPenti - BHIS](https://www.youtube.com/watch?v=FFzBgb00ffk)
[YouTube - Part 2 Networking for Pentesters: Beginner -SheNetworks - Serena  DiPenti - BHIS](https://www.youtube.com/watch?v=ikIGTW0uraA)
[YouTube - Part 3 Networking for Pentesters: Beginner -SheNetworks - Serena  DiPenti - BHIS](https://www.youtube.com/watch?v=HS0bicAd-5A)
[Wikipedia - Dynamic Host Configuration Protocol (DHCP)](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol)
[TechTarget - DHCP](https://www.techtarget.com/searchnetworking/definition/DHCP)
[learn.microsoft - DHCP](https://learn.microsoft.com/en-us/windows-server/networking/technologies/dhcp/dhcp-top)