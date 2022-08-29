# ACTIVE DIRECTORY

This is 101 ground-up and top-down explanation information cheatsheet and a hub for all concepts I have found researching Active Directory. For [[AD-Exploitation-Hub]] and further more specified reading follow the link, for [[Active-Directory-Privilege-Escalation]]. If you want to build AD go [[Active-Directory-Lab]]. 


## AD Defined:

Active Directory or Active Directory Directory Services(ADDS) is a directory service for Windows Domain Networks. Microsoft scalable centralised IT management, authentication and authorization framework. Active Directory is a domain that is centralised collection of users and machines in network, AD is run from the Domain Controll server that runs AD services. Location, security and many other aspects make up a rational for a specific architecture of forests, trees, domains and the organisation units are each connected and how they are allowed to interact.

AD Components:  
1. Domain Controllers - Windows 2000-20* server with ADDS installed
1. Forests, Trees, Domains
2. Organisation Units - System folders containers to store and group objects. Each AD Object has attributes.
	1. Users 
	1. Groups 
	2. Workstations and Servers that are domain-joined
1. Trusts
2. Policies 
3. Domain Services

## Domain Controller(DC)

A Windows Server that has Active Directory Domain Service(ADDS) installed and is the domain controller for the forest.
AD-Forest will sometimes have multiple DCs for redundancy of data and services, each having the same replicated AD data.
A DC purpose:
1. Stores all relevant information including AD DS data store for the Forest 
2. Enforce rules governing object within an Windows domain
3. Handles all key authenication, authorization services and all core and native management services.
4. Replicates updates from other domain contollers in the forest
5. Allow admin access to manage domain resources

A Primary domain controller emulator is one of the five operations master roles or [FSMO roles](https://docs.microsoft.com/en-GB/troubleshoot/windows-server/identity/fsmo-roles) performed by domain controllers. Technically speaking, the property is called `PdcRoleOwner` and the domain controller with this property will always have the most updated information about user login and authentication.

DC data organisation:
All data is stored either direct at the Forest level or inside an Organisational Unit(OU)

## Active Directory Domain Service (AD DS) Date Store

AD DS retains the databases and processes required to store and manage directory information:
1. Contains the NTDS.dit - a database that contains all of the information of an Active Directory domain controller as well as password hashes for domain users
1. Stored by default in %SystemRoot%\NTDS
1. Accessible only to Domain Controller


## Topology 

AD is organised around a top domain domain.com, with the possibility of subdomains sub.domain.com

```
Forest  -	-	-	-	-	-	-	- Another Forest
|		\							  /   /		\
Tree  	 \	-	Connections Vary -   /	Tree 	Tree
|		  \				        	/	 /	      \
Domain	   \				  	   /  Domain	Domain
|			\				      /     /		  \		 
Organisation Units				 /  (OUs)		(OUs)		
```

Often clients on a internal network are connectioned vai one of the DC as the gateway to the external forests or tree. Internal OUs are also internal member servers(web servers, database servers, etc) and printers reside accessable the DC within their local internal network. It reliant on Domain Name System (check[[DNS-Theory]]) typically with DC will also host a DNS server.

 
### Forest 
Forests are self-contained and provides all required services as the highest-level component, caegorizing the parts of the network as a whole.

### Trees
Trees are a hierarchy of domains in Active Directory Domain Services

### Domains
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

Policies are like groups, but they are sets of rules of operation that apply to the domain as a whole. There are default domain policy and Domain Admin can add, remove, modify these tules when necessary to uphold the integrity of the network.

#### Group Policy Objects

GPOs are used to managing many settings, Local GPOs for local machine and AD GPOs. They are configured through Active Directory. GPOs are series of XML files that contain settings and configurations for a multitude of applications and options in Windows. When created a GPO is stored in the SMB path `\\domain controller host name>\sysvol`. All members of the Authenticated Users, Domain Users, and Domain Computers group have read permissions to SYSVOL.
Any account and Domain-joined computers  can read `SYSVOL`, it is located on the DC and is a shared folder storing the Group Policy Objects (GPOs).

GPOs are processed in the following order:
1. Local
1. Domain
1. OU (parent, then child)

**The GPO which is applied last will be the effective one**
GPOs in AD work by each domain-joined computer, updated from the DC **EVERY**90mins. Or with command: `gpupdate /force`


### Objects

Objects are defined as users, groups, printers, computers, shares; Microsoft love Object Oriented everything. The default containers:

OU Container Name | Description
--- | ---
Builtin | Windows default groups
Computers | Any machine that is domain joined
Domain Controllers | Default OU containing the network DC
Users | Defult users and groups applicable to domain wide context
Manage Service Accounts | Accounts used by services in the domain

**OUs are not Security Groups and Security Groups are not OUs.**
Security Groups used to **assign permissions** to shared resources.
OUs are for **applying policies** 

#### Machine

Machines are objects in Active Directory are **objects** known security principals (see [Documentation](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-principals)) and are assign an account with limit rights within the domain. Naming conventions `( machine name ) DC01 -> DC01$ ( machine account )`  

Machine Account passwords are automatically rotated out and are generally comprised of 120 random characters.

#### Active Directory Users

Users are either people or services, Users are **objects** known security principals (see [Documentation](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-principals))

On the DC use `Search -> Active Directory Users and Computers` to configure users, groups or machines

##### Domain Admins 

These can access the DC and is the highest privledge level of a user.  

##### Service Accounts 

[Service principle names](https://docs.microsoft.com/en-us/windows/win32/ad/service-principal-names?redirectedfrom=MSDN) as Applications are executed in the context of the operation system user and that user account defines that context, whereas service executed by system itself a [Service Account](https://docs.microsoft.com/en-us/windows/win32/services/service-user-accounts?redirectedfrom=MSDN). Used for service maintenance and required by Windows for services to pair a service with a service account. When applications need to access the domain resources or require Kerberos authenication; the application is executed in the context of a domain account referred to a service account, but is still a domain user account. Domain user account may be required to provide the service accounts more access to resource inside the domain. Execution of applications can be possible in the context of the local SYSTEM accounnt or "group Managed Service Account(gMSA).  The gMSA's can also perform automated credientals rotation = account password is 120 characetrs long and changes every 30 days. 

Service Accounts | Description
--- | ---
[LocalSystem](https://docs.microsoft.com/en-us/windows/win32/services/localsystem-account?redirectedfrom=MSDN) | Local account used by SVCM
[LocalService](https://docs.microsoft.com/en-us/windows/win32/services/localservice-account?redirectedfrom=MSDN) |
[NetworkService](https://docs.microsoft.com/en-us/windows/win32/services/networkservice-account?redirectedfrom=MSDN) |

 
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
- Distribution Groups: used only to define email lists - No access rights or permission abilities, useful for enumeration 
- Security Groups: used to assign permissions to shared resources.


For incomplete list for demonstrative purposes:
Security Group | Description
--- | ---
Domain Admins | Administrative Privileges over entire domain, including DC
Server Operators |  User that can administer Domain Controller - cannot change any administrative group memberships
Backup Operators | User that can access any file(ignoring permissions) - useed for data backups
Account Operators | User can create modify other accounts in the domain
Domain Users | Includes all existing user accounts in the domain
Domain Computer | Includes all existing computer in the domain
Domain Controllers | Includes all existing DCs on the domain
See the table of [[Active-Directory-Default-Security-Groups-Table]] 



For Active Directory, there are two types of administrative responsibilities:
1. Service administrators:
	- Responsible for maintaining and delivering Active Directory Domain Services (AD DS), including managing domain controllers and configuring the AD DS.

2. Data administrators:
	- Responsible for maintaining the data that is stored in AD DS and on domain member servers and workstations.
```
Get-ADGroupMember <groupname> -recursive
```

### Domain Services

Defined as the services provided by the Domain Controller to the rest of the domain or tree.

Domain Services include: 
	DNS Server,  
	DNS, LLMNR, NBT-NS: domain Name Services for identifying IP hostnames,  
	IPv6,
    	LDAP - see LDAP section.
    	Certificate Services - allows the Domain Controller to create, validate, and revoke public key certificates,  

#### Lightweight Directory Access Protocol(LDAP)

Lightweight Directory Access Protocol (LDAP) is one the [[Network-Services]] very commonly used to interact with Domain Controllers to submit or retrieve data. LDAP is an open-source protocol designed to provides communication and interaction between applications and directory services. See [[LDAP-Recon]].

#### Certicate Services

[[AD-Certificate-Exploitation]]

### Domain Schema

Domain Schema are rules for object creation

## Domain Authentication
[[Active-Directory-Authentication]] is detailed in the aforemented article, although a brief summary of both mechanism for the context of this article is also provided here. NTLM is the default Windows authentication protocol uses an encrypted challenge/response protocol. Whereas Kerberos Ticket System authenciation, discuss at length with related information in [[Active-Directory-Kerberos-Defined]] see [[Attacking-Kerberos]]
		
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

## Protocols
#### LLMNR, NBT-NS, and WPAD
 Wiki: *"The Link-Local Multicast Name Resolution (LLMNR) is a protocol based on the [Domain Name System](https://en.wikipedia.org/wiki/Domain_Name_System "Domain Name System") (DNS) packet format that allows both [IPv4](https://en.wikipedia.org/wiki/IPv4 "IPv4") and [IPv6](https://en.wikipedia.org/wiki/IPv6 "IPv6") hosts to perform name resolution for hosts on the same local link."* NBNS is a server responsible for maintaining a list of mappings between NetBIOS computer names and network addresses for a network that uses [NetBIOS](https://networkencyclopedia.com/netbios/) as its naming service. Wiki: *The **Web Proxy Auto-Discovery (WPAD) Protocol** is a method used by clients to locate the URL of a configuration file using [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol "Dynamic Host Configuration Protocol") and/or [DNS](https://en.wikipedia.org/wiki/Domain_Name_System "Domain Name System") discovery methods. Once detection and download of the configuration file is complete, it can be executed to determine the proxy for a specified URL.*

## Active Directory Terminology
-   **AS-REQ** - 
-   **AS-REP** - 
-   **TGS-REP** - 
-   **TGS-REQ** - 
-   **AP-REP** - 
-   **AP-REQ** -  

-   **Ticket Granting Ticket (TGT)** - A ticket-granting ticket is an authentication ticket used to request service tickets from the TGS for specific resources from the domain.
-   **Key Distribution Center (KDC)** - The Key Distribution Center is a service for issuing TGTs and service tickets that consist of the Authentication Service and the Ticket Granting Service.
-   **Authentication Serv****ice (AS)** - The Authentication Service issues TGTs to be used by the TGS in the domain to request access to other machines and service tickets.
-   **Ticket Granting Service (TGS)** - The Ticket Granting Service takes the TGT and returns a ticket to a machine on the domain.
-   **Service Principal Name (SPN)** - A Service Principal Name is an identifier given to a service instance to associate a service instance with a domain service account. Windows requires that services have a domain service account which is why a service needs an SPN set.
-   **KDC Long Term Secret Key (KDC LT Key)** - The KDC key is based on the KRBTGT service account. It is used to encrypt the TGT and sign the PAC.
-   **Client Long Term Secret Key (Client LT Key)** - The client key is based on the computer or service account. It is used to check the encrypted timestamp and encrypt the session key.
-   **Service Long Term Secret Key (Service LT Key)** - The service key is based on the service account. It is used to encrypt the service portion of the service ticket and sign the PAC.
-   **Session Key** - Issued by the KDC when a TGT is issued. The user will provide the session key to the KDC along with the TGT when requesting a service ticket.
-   **Privilege Attribute Certificate (PAC)** - The PAC holds all of the user's relevant information, it is sent along with the TGT to the KDC to be signed by the Target LT Key and the KDC LT Key in order to validate the user.
-  **Security principals** - Security principals are any entity that can be authenticated by the operating system

## References
[LDAP Wiki](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol)
[WPAD Wiki](https://en.wikipedia.org/wiki/Web_Proxy_Auto-Discovery_Protocol)
[SMB Wiki](https://en.wikipedia.org/wiki/Server_Message_Block)
[FSMO roles](https://docs.microsoft.com/en-GB/troubleshoot/windows-server/identity/fsmo-roles)
[Remote Server Administration Tools](https://docs.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps)
[Remote Server Administration Tools 2](https://docs.microsoft.com/en-us/previous-versions/technet-magazine/gg413289(v=msdn.10)?redirectedfrom=MSDN)
[Domain Name System](https://en.wikipedia.org/wiki/Domain_Name_System "Domain Name System") 
[IPv4](https://en.wikipedia.org/wiki/IPv4 "IPv4") 
[IPv6](https://en.wikipedia.org/wiki/IPv6 "IPv6") 
[NetBIOS](https://networkencyclopedia.com/netbios/) 
[DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol "Dynamic Host Configuration Protocol")
[Security Principle](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-principals)