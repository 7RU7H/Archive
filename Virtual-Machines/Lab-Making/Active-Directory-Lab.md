# Active Directory Lab Making

## Introduction
AD is everywhere and this article is full of Acronyms to ensure that the length of this is smaller than the size of the official documentation so firstly a glossary of term to \[Home\] key to. Then the contents.

##### Glossary of Terms 
Acronym | Contraction
--- | ---


##### Contents
1. List of Requirements and where to get them
2. *some* general Installation instructions


## List of requirements
Although inspired by all the references there are two contraints for these requirements. Your CPU must support modern virtualisation - **check**. Firstly atleast 32 GB of RAM! You need enough to host your OS and four virtual machines: Hacking-OS; DC VM and two AD users VMs. Atleast 80gb spare memory:
1. 4-8gb for Kali/Parrot/BlackArch
2. Domain controller
3. Users need the least but need 




## Active Directory Domain Service (AD DS) Components

For a more realistic AD here is a very brief outline of the compnents

[Official Overview](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview)


Physical Components | Details
--- | ---
Data Store | AD DS information as a file on DC  
DCs | Contains copy of AD DS database
Read-Only DC | Contains copy of AD DS database
Global catalog servers | Hosts global catalogue *see 1.*

1. Global catalogue - *contains information about every object in the directory. This allows users and administrators to find directory information regardless of which domain in the directory actually contains the data*. It is a mapping of contexts in AD forest , speeding up searches for objects attached to DC within a forest.  

Logical Components | Details
--- | ---
Partitions | Domain directory, Configuration directory, Schema directory, global catalog, application directory
Schema | The Ruleset defining the classes of obejcts and attributes
Domains | 
Domain Trees | 
Forests |
Sites | Collections of users, groups, computers as defined by their physical locations.

## Download the ISO files

## Virtual Box
**Installation and QoL**
1. After creating DC machine change the `Shared Clipboard` and `Drag'n'Drop` settings to `Bidirection`.
1. Creating a Network interface card NIC: First needs to be attached to` NAT`  another on `Internal Network`.
1. Run DC vm and add the ISO, select location, time and currency formating and keyboard setting you prefer.
1. Select install and install one of the Desktop Experience version for the GUI. 
1. Agree to terms of use.
1. Select `Custom: Install...` then click next to format.
1. Wait, it will reboot multiple times...
1. Set the Administrator password
1. Use `Input` tab to insert `Ctrl Alt Del` to get the Login Prompt.
1. Insert a guest image `Devices` and `Inset Guest Additional CD image...` 
	1. Go to `This PC > CD Drive (D:) VirtualBox Guest Additions` either `VboxWindowsAddition-x86` for intel and `VboxWindowsAddition-amd64` for amd.
	2. Next NEXT the `Reboot later`
	3. Shutdown VM

**Network Setup**
Click ![networkaccess](Images/adlab-networkaccess-taskbar.png), then  go to `Change adapter options > Rename networks` - 169.254.. address is the internal one consider the [naming conventions](https://social.technet.microsoft.com/wiki/contents/articles/34981.active-directory-best-practices-for-internal-domain-and-network-names.aspx).
```
IP address: 172.16.0.1
Subnet Mask: 255.255.255.0
```
[Due to 172.16.0.0 being a private address space from RFC1918](https://www.rfc-editor.org/rfc/rfc1918). This the DC so either set `Prefered DNS Server` to `172.16.0.1` or `127.0.0.1`

**Host Setup**

Rename PC by searching  for `About PC`

**Active Directory Domain Services

Go to `Server Manager > Add roles and features > Next until Server Roles`(Unless you have more than one DC) . Select `Active Directory Domain Services` Next, next  and install. And wait.

![postdeployment](Images/click-post-deployment-flag.png)
Click `Promote this server to a domain controller > Add a new forest` and name the root domain name. Then set a password for the Directory Service Restore Mode.
 
 **Administrator Account Setup**
 From start menu `Windows Administrator Tools > Active Directory Users and Computers`. `Right click mydomain.com` to make an Organizational Unit: 
 [make an ou](Images/make-ou.png) 
 `Click User` and make anything, but note that some organisations have nnaming convention for the logon name:
 [logon naming convention](Images/admin-setup.png)
 
 Right click the new user and make part of Adminstrative group by going to `Properties > Member of > Add...` input `Domain Admins`. 
 
## VMware setup

## References
[shehackske](https://shehackske.medium.com/active-directory-how-to-set-up-an-ad-lab-66647fb453c0)
[cybermentor video](https://www.youtube.com/watch?v=xftEuVQ7kY0)
[hostadvice](https://hostadvice.com/how-to/how-to-install-virtualbox-on-windows-server-2022/#paragraph3)
[hackingarticle](https://www.hackingarticles.in/active-directory-pentesting-lab-setup/)
[drunkrhin0](https://medium.com/swlh/building-an-active-directory-lab-part-1a-automatedlab-fc2399ebe5be)
[Madakar video](https://www.youtube.com/watch?v=MHsI8hJmggI)
[ADDS Overview](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview)
[Naming Converntions](https://social.technet.microsoft.com/wiki/contents/articles/34981.active-directory-best-practices-for-internal-domain-and-network-names.aspx)
[RFC1918](https://www.rfc-editor.org/rfc/rfc1918)