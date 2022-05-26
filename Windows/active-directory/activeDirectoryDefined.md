# ACTIVE DIRECTORY

#### This is 101 ground-up and top-down explanation information cheatsheet and a hub for all concepts I have found researching Active Directory.

## AD Defined:

Active Directory or Active Directory Directory Services(ADDS) is a directory service for Windows Domain Networks.  
Microsoft scalable centralised IT management, authentication and authorization framework. 
An Active Directory netowkr is a foresst of domains that hold a collection of servers and machines.
Location, security and many other aspect make up a rational for a sepcific architecture of forests, trees, domains and the organisation units are each are connected.

AD Components:  
1. Domain Controllers
1. Forests, Trees, Domains
1. Users + Groups 
1. Trusts
1. Policies 
1. Domain Services

## Domain Controller(DC)

A Windows Server that has Active Directory Domain Service(AD DS) installed and is the domain controller for the forest.
AD-Forest will sometimes have multiple DCs for redundancy of data and services, each having the same replicated AD data.
A DC purpose:
1. Stores all relevant information including AD DS data store for the Forest 
1. Handles all key authenication, authorization services and all core and native management services.
1. Replicates updates from other domain contollers in the forsest
1. Allow admin access to manage domain resources

DC data organisaiton:
All data is stored either direct at the Forest level or inside an Organisational Unit(OU)

## Active Directory Domain Service (AD DS) Date Store

AD DS retains the databases and processes required to store and manage directory information:
1. Contains the NTDS.dit - a database that contains all of the information of an Active Directory domain controller as well as password hashes for domain users
1. Stored by default in %SystemRoot%\NTDS
1. Accessible only to Domain Controller


## Topology 

AD is organised around a top domain domain.com, with the possibility of subdomains sub.domain.com


Forest  
|			\
Tree  
|				\
Domain
|					\
Organisation Unit
|

 
### Forest 
Forests are self-contained and provides all required services as the highest-level component, caegorizing the parts of the network as a whole.


### Trees
Trees are a hierarchy of domains in Active Directory Domain Services


Domains are used to group and manage objects 

### Organizational Units (OUs)
OUS defined as *CONTAINERS* for groups, computers, users, printers and other OUs

### Domain Trusts

Trusts are mechanism for user users to access other resources in their domain and other domains.
Trusts define the interactions that are possible between domains inside of a forest, even external domains or forest.
The type of trusts between domains, trees in a forest or external to it can be use to traverse laterally throughout the network.  
Type:  
Directional: Direction of trust flows from a trusting domain to a trusted domain  
Transitive: The trust relationship expands beyond two domains to include other trusted domains  

### Domain Policies

Policies are like groups, but they are sets of rules of operation that apply to the domain as a whole.
There are default domain policy and Domain Admin can add, remove, modify these tules when necessary to uphold the integrity of the network.

#### Group Policy Objects

GPOs are used to managing many settings, Local GPOs for local machine and AD GPOs.
They are configured through Active Directory.
GPOs are series of XML files that contain settings and configurations for a multitude of applications and options in Windows.
When created a GPO is stored in the SMB path \\domanin controller host name>\sysvol.
All members of the Authenticated Users, Domain Users, and Domain Computers group have read permissions to SYSVOL.

GPOs are processed in the following order:
Local
Domain
OU (parent, then child)
!! The GPO which is applied last will be the effective one!!
GPOs in AD work by each domain-joined computer, updated from the DC EVERY 90mins.
gpupdate /force.


### Objects

Objects are defined as users, groups, printers, computers, shares; Microsoft love Object Oriented everything.

#### Active Directory Users

##### Domain Admins 

These can access the DC and is the highest privledge level of a user.  

##### Service Accounts 

Used for service maintenance and required by Windows for services to pair a service with a service account.
When applications need to access the domain resources or require Kerberos authenication; the application is executed in the context of a domain account referred to a service account, but is still a domain user account.
Execution of applications can be possible in the context of the local SYSTEM accounnt or "group Managed Service Account(gMSA).  
The gMSA's can also perform automated credientals rotation = account password is 120 characetrs long and changes every 30 days.  

##### Local Administrators

Users that make changes to local machines as an administrator, sometimes able to control other normal users, but cannot access domain controller

##### Domain Users

Regular users, can only log in on mahcine that they are authorized to access and may have some local administrator rights to machine

#### Security Identifier or SID
S-R-I-SA
S = literal "S"
R = revision level (usually set to 1)
I = identifier-authority (usually 5 in AD)
SA = one or more sub authority value

Sub authority value is dynamic and consists tof two primary parts: 
/	Domain's numeric identifier 	-22-1234-1234-1234 
	Relative identifier(RID) 	-1010



##### Notes:
BEWARE AD-cmdlets only installed by default on DCs!
```
Get-ADUser <user> 
```

#### Active Directory Groups

Authorization process is controlled by membership in Active Directory Groups, for scalablity and dynamism
Group types:
	Distribution Groups: used only to define email lists - No access rights or permission abilities, useful for enumeration 
	Security Groups: used to assign permissions to shared resources.

For Active Directory, there are two types of administrative responsibilities:
Service administrators:
Responsible for maintaining and delivering Active Directory Domain Services (AD DS), including managing domain controllers and configuring the AD DS.
Data administrators:
Responsible for maintaining the data that is stored in AD DS and on domain member servers and workstations.
```
Get-ADGroupMember <groupname> -recursive
```
##### Default Security Groups

Domain Controllers - All domain controllers in the domain
Domain Guests - All domain guests
Domain Users - All domain users
Domain Computers - All workstations and servers joined to the domain
Domain Admins - Designated administrators of the domain
Enterprise Admins - Designated administrators of the enterprise
Schema Admins - Designated administrators of the schema
DNS Admins - DNS Administrators Group
DNS Update Proxy - DNS clients who are permitted to perform dynamic updates on behalf of some other clients (such as DHCP servers).
Allowed RODC Password Replication Group - Members in this group can have their passwords replicated to all read-only domain controllers in the domain
Group Policy Creator Owners - Members in this group can modify group policy for the domain
Denied RODC Password Replication Group - Members in this group cannot have their passwords replicated to any read-only domain controllers in the domain
Protected Users - Members of this group are afforded additional protections against authentication security threats. See http://go.microsoft.com/fwlink/?LinkId=298939 for more information.
Cert Publishers - Members of this group are permitted to publish certificates to the directory
Read-Only Domain Controllers - Members of this group are Read-Only Domain Controllers in the domain
Enterprise Read-Only Domain Controllers - Members of this group are Read-Only Domain Controllers in the enterprise
Key Admins - Members of this group can perform administrative actions on key objects within the domain.
Enterprise Key Admins - Members of this group can perform administrative actions on key objects within the forest.
Cloneable Domain Controllers - Members of this group that are domain controllers may be cloned.
RAS and IAS Servers - Servers in this group can access remote access properties of users

### Domain Services

Defined as the services provided by the Domain Controller to the rest of the domain or tree.

Domain Services include: 
	DNS Server,  
	DNS, LLMNR, NBT-NS: domain Name Services for identifying IP hostnames,  
	IPv6,
    	LDAP - see LDAP section.
    	Certificate Services - allows the Domain Controller to create, validate, and revoke public key certificates,  

#### Lightweight Directory Access Protocol(LDAP)

Lightweight Directory Access Protocol5 (LDAP) is very commonly used to interact with Domain Controllers to submit or retrieve data. 
LDAP is an open-source protocol designed to provides communication and interaction between applications and directory services.

#### Certicate Services

THM room and abusing AD certificate service in the pipeline!

### Domain Schema

Domain Schema are rules for object creation


## Domain Authentication

### NTLM

The default Windows authentication protocol uses an encrypted challenge/response protocol

### Kerberos
Used to facilitate both authenication and authorization in Active Directory.
DC acts a Key Distribution Centre(KDC) to authenicate client and allow authorization.
Ticket sytem:


Client		Step 1: Authenication Server Request (\_AS\_REQ) ->		Domain Controller
		<- Step 2: Authenication Server Reply (AS_REP)
		Step 3: Ticket Granting Service Request (TGS_REQ) ->
		<- Step 4: Ticket Granting Server Reply (TGS_REP

Client 		Step 5: Application Request ->					Application Server
		<- Step 6: Service Authenication	



Transaction 		Contents
\_AS\_REQ 		timestamp encrypted with hash derived from client password & username
			timestamping prevents replay attacks
			
AS\_REP			session key (Kerberos is stateless), encrypted with user password hash
			ticket granting ticket(TGT) contains info: user, domain, a timestamp, IP of client and session key 
			encrypted session keys prevents MITM attacks
			TGT is encrypted with secret key only known to KDC, to avoid tampering
			TGT is only valid by defult for 10 hours, renewal does not require re-entering of password

TGS\_REQ			packet containing: username, timestamp (encrypted with session key); resource name and encrypted TGT

Before TGS_REP the KDC performs several checks:
1. TGT must have a valid timestamp.
1. Username from the TGS_REQ ==  username from the TGT.
1. The client IP address == TGT IP address.

TGS\_REP			packet contains: 
			A		service name granted access to,
			B		a session key for client and service interaction, 
			C		service ticket containing: username and group memberships TGS_REP session key.
			A&B are encrypted using session key from previously created TGT
			C is encrypted with password hash of service account registered with the service

Now the Client and Service can authenicate:

AP\_REQ			username and timestamp (encrypted with session key associated with service ticket) and service ticket 			
	
1. Service performs to then send a service authenication		
1. Decrypted with service account password hash
1. inspects packet data validity: username matches the decrypted one, 
1. Group memberships are used the assigned the approiate permissions to user 

This aides in mitigating against faking credentials 
		
### Cloud AD

#### Azure AD

Azure act as middle man between physical Active Directory and users' sign on machines, securing transaction between domains 
It has its own terminalogy and security precautions beyond the that of physical AD
Windows Server AD	Azure AD
LDAP			Rest APIs
NTLM			OAuth/SAML
Kerberos		OpenID
OU Tree			Flat Structure
Domains and Forests	Tenants
Trusts			Guests

### Enterpries AD

#### Topology

Branch1
		  |
dataCenter1 - internet
		  |
Branch2

Data Centers contain: Application Servers, Domain Controller, seperated firewall/VPN
Branch contain: workstations, sperated via firewall/VPN

Naming conventions:
DC01, DC02, etc
Servers: mail01, web01, iis01, apache01, db01, sql01
Clients: client001 or by (branch-location like NY)0001

Large organizations and enterprises often use added products and features which are integrated with Active Directory:   
1. Active Directory Federation Service (ADFS) provides an extended way of offering single sign-on and authorization.  
1. Active Directory Certification Services (ADCS) provides an integrated certification authority to handle the public key infrastructure.  

