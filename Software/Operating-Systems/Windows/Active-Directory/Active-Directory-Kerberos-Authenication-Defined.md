# Kerberos Authentication Defined

The Kerberos authentication protocol is used by Microsoft, adopted from the Kerberos version 5 authentication protocol created by MIT and has been used as Microsoft's primary authentication mechanism since Windows Server 2003. Used to facilitate both authenication and authorization in Active Directory. Privilege Attribution Certificate contains all the relevant user information stored on each service - signed by target server and secret key value only known by DC. The DC acts a Key Distribution Centre(KDC) to authenicate client and allow authorization. SPN is the Service Principal Name and is a mapping between service and account, the KDC requires this to properly encrypt the service of the Service Ticket - with `Setspn.exe`.

## Service Ticket

KDC long-term secret key - derived from the krbtgt account password
- Used to encryupt the TGT (AS-REP) and sign the PAC (AS-REP and TGS-REP)
Client long-term secret key - derived from the client account password
- Used to check encyrpted timestamp (AS-REQ) and encrypt session key (AS-REP)
Target (service) torm-term secret key -cderived from the service account password
- Used to encrypt service portion of the ST (TGS-REP) and sign the PAC (TGS-REP)

The Architect of a ticket, which accounts get what information

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

1. AS-REQ get sent KDC performs AS-REP
1. KDC has TGS-REP Inside the TGT is also a PAC, replacement with [[Mimikatz-Cheatsheet]]
1. ST (TGS)  
1. PAC Validation of the long term, SPN can check its own hash - PAC is not always validated.
	- For TGT - the PAC is only validated when the TGT is more than 20 minutes old
	- For TGS - the PAC is typically not validated for services on modern Windows
	- Sometimes it can double check the signature with the KDC, this happens or does not:
	- If the service run as quote: "part of the OS" it will not ask the DC 
	- SQL service will not ask because latency!
	- Web will always double check! 

## Ticketing sytem

Client |  Steps | AD DC/Server
--- | --- | ---
Client|Step 1: Authentication Server Request (\_AS\_REQ) ->	|	Domain Controller
Client |<- Step 2: Authentication Server Reply (AS_REP)|	Domain Controller
Client |		Step 3: Ticket Granting Service Request (TGS_REQ) ->|	Domain Controller
Client |		<- Step 4: Ticket Granting Service Reply (TGS_REP) |	Domain Controller
Client 	|	Step 5: Application Request ->		|			Application Server
Client	    |	<- Step 6: Service Authentication	| Application Server


Transaction  |	Contents
---  | ---
\_AS\_REQ | Timestamp encrypted with hash derived from client password & username. Timestamping prevents replay attacks	
AS\_REP		 | 	Session key (Kerberos is stateless), encrypted with user password hash. 			ticket granting ticket(TGT) contains info: user, domain, a timestamp, IP of client and session key. Encrypted session keys prevents MITM attacks. TGT is encrypted with secret key only known to KDC, to avoid tampering. TGT is only valid by defult for 10 hours, renewal does not require re-entering of password
TGS\_REQ | Packet containing: username, timestamp (encrypted with session key); resource name and encrypted TGT

Before TGS_REP the KDC performs several checks:
1. TGT must have a valid timestamp.
1. Username from the TGS_REQ ==  username from the TGT.
1. The client IP address == TGT IP address.

TGS\_REP	|		Packet contains: 
--- | ---
			A	 |	service name granted access to,
			B	 |	a session key for client and service interaction, 
			C    |	service ticket containing: username and group memberships TGS_REP session key.
			A&B	 |	 are encrypted using session key from previously created TGT
			C 	 |	 is encrypted with password hash of service account registered with the service

Now the Client and Service can authenicate:

AP\_REQ			username and timestamp (encrypted with session key associated with service ticket) and service ticket 			
	
1. Service performs to then send a service authenication		
1. Decrypted with service account password hash
1. inspects packet data validity: username matches the decrypted one, 
1. Group memberships are used the assigned the approiate permissions to user 

This aides in mitigating against faking credentials 

## References

[Kerberos and Attacks 101 by Tim Medin](https://www.youtube.com/watch?v=9lOFpUA25Nk)