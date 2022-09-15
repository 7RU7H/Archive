# Kerberos Authenication Defined
The Kerberos authentication protocol used by Microsoft is adopted from the Kerberos version 5 authentication protocol created by MIT and has been used as Microsoft's primary authentication mechanism since Windows Server 2003. Used to facilitate both authenication and authorization in Active Directory. DC acts a Key Distribution Centre(KDC) to authenicate client and allow authorization.
Ticket sytem:

Client |  Steps | AD DC/Server
--- | --- | ---
Client|Step 1: Authenication Server Request (\_AS\_REQ) ->	|	Domain Controller
Client |<- Step 2: Authenication Server Reply (AS_REP)|	Domain Controller
Client |		Step 3: Ticket Granting Service Request (TGS_REQ) ->|	Domain Controller
Client |		<- Step 4: Ticket Granting Service Reply (TGS_REP) |	Domain Controller
Client 	|	Step 5: Application Request ->		|			Application Server
Client	    |	<- Step 6: Service Authenication	| Application Server


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