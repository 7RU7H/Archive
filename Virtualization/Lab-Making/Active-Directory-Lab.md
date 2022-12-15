# Active Directory Lab Making

Under construction

## Introduction
This is manual setup guide and walkthrough of Active Directory for those that the hands on experience of making and configuring there own. There are many video guides list for variations., but this article contains both VMware(WILL AT SOME POINT) and Virtualbox setups. A brief overview of automated and automating setups will also be provided, but the overall idea is to build ground up knowledge and experience before firing of a script someone else wrote to make some vulnerable. Some have suggestedm, especially for beginnners, that the more intimate experience of turning on and off settings and testing is more valuable than than the script kiddie *spin up VM and wap-out-the someone-elses script then bang tools together to get x outcome*. 

Secondly AD is everywhere and this article is full of acronyms to ensure that the length of this is smaller than the size of the official documentation so firstly open [[Active-Directory-Defined]]. If you require termonolgy there is a glossary at the end of the page, but the article also contains defintions, theory and architecture related information. 

##### Contents
1. List of Requirements and where to get them
2. Alternate Automated Variation on setups
3. AD Components
4. ISO downloading
5. VirtualBox Setup
6. VMware Setup
7. *maybe one* cloud setup
8. References


## List of requirements
Although inspired by all the references there are two contraints for these requirements. Your CPU must support modern virtualisation - **check**. Firstly atleast 32 GB of RAM! You need enough to host your OS and four virtual machines: Hacking-OS; DC VM and two AD users VMs. Atleast 80gb spare memory:
1. 4-8gb for Kali/Parrot/BlackArch
2. Domain controller
3. Users need the least but need 

## Alternate Automated 


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
1. Select: install and install one of the Desktop Experience version for the GUI. 
1. Agree to terms of use.
1. Select: `Custom: Install...` then click next to format.
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

**Active Directory Domain Services**

Go to `Server Manager -> Manage -> Add roles and features > Next until Server Roles`(Unless you have more than one DC) . Select: `Active Directory Domain Services` Next, next  and install. And wait.

![postdeployment](Images/adlab-click-post-deployment-flag.png)
Click `Promote this server to a domain controller > Add a new forest` and name the root domain name. Then set a password for the Directory Service Restore Mode.
 
 **Administrator Account Setup**
 From start menu `Windows Administrator Tools > Active Directory Users and Computers`. `Right click mydomain.com` to make an Organizational Unit: 
 [make an ou](Images/adlab-make-ou.png) 
 `Click User` and make anything, but note that some organisations have nnaming convention for the logon name:
 [logon naming convention](Images/adlab-admin-setup.png)
 
 Right click the new user and make part of Adminstrative group by going to `Properties > Member of > Add...` input `Domain Admins`. 
 
**RAS/NAT** 

To allow the OUs to access the internet through the DC open `Server Manage > Add roles > Next till Server Selection & Select: a server from server pool = DC.<domainname>.com > Next Server Roles & Select: = Reomte Access > Next & Next > Selection Routing (it will autoselect DirectAccess and VPN (RAS) > Next & Next & Next > Install`.

Then once installed back to `Server Manager > Dashboard` click the drop down menu `Tools > Routing and Remote Access`. Right on DC and `Configure and Enable Routing and Remote Access > Next`
![RoutingAndRemoteAccess](Images/adlab-routing-and-remote-access.png)

Then `Select: Network address translation (NAT)` if NAT Internet Connection section does not allow `Use this public interface to connect to the Internet` just repeat from post installed section at `Tools > ...`. If does work `Select: <Name your made for internet routing way back when> > Next > Finish`. If success it should look similar to the image below:
![routing-internet-success](Images/adlab-internet-for-users-success.png)

**Install and Configure DHCP**

To handle addressing we need instal and configure addressing. Similarly to previous features added in past sections this time starting at `Add roles and feature > ... > Server Roles > Select: DHCP Server > Add Features > Next & Next  & Next > Install`. Then to configure go `Tool Dropdown > DHCP`. Right click on `IPv4 > Provide a scope > Set a Start & End ranges as well as a  Subnet mask`. Considering it is a lab setup the Subnet mask should be `255.255.255.0` and your Start and End address space can be how `< 253`, excluding `.0` and `.255` last octets. `Exclude` any address you like if you want then `Next`. `Lease duration` being default 8 day is fine then `Next > Select: Yes, I want to configure these options now > Set Default gateway to DC's IP address > Add > Next > Next (if you want WINS servers configure here > Next > Next > Finish`. Returning to the DHCP control panel right click on `dc.<domainname>` and `Select: Authorize` and then repeat but `Select: Refresh`. Green ticks equals success.

Depending on whether you are creating a IPv4 or IPv6 network you will also need to set unde `DHCP > dc.<domainname> > IPv* > Server Options > [Right-Click] > Configure Options > [Tick] Router > Ip Address: <DC ip address> + Select Add > Apply`

**Users**

**Client Machine** 

Firstly make sure you have enterprise ISO  version
**HIGHLY RECOMMEND** you note the exact configuration fo locale and keyboard for easy of use and *just incase the are some weird non-cooperative strangeness(I can only speculate on) regarding localisation issues*. 

Secondly this install is very simple if you read the above alot of `Next` until:
1. Choose `Custom install`
1. Select `I don't have internet`
1. Select `Continue with Limited Setup` make sure you choose something that prevent you creating Microsoft accounts.
Make User; turn off all privacy settings for your device, `not now`  for cortana.

Post setup
```powershell
ipconfig # check default gateway is set to DC
ping # something to see if setup is working
```

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
