
Warning I have no idea whether anything works. These are just ideas and things I have found from learning some Azure. There are better resources... I will hopeful research these at some point. This just a place for me to be creative, which I yet to really succeed in, in this field in any meaningful sense.  


## Azure (Bloodhound/Responder) for badAdmins

If Administrator credentials are compromised a stealthier approach to using Bloodhound or Responder would to use Azure Network Watcher is awesome it can
- `Packet Capture` - if you want to sniff credentials in a sneaky way that looks like a Admin check connectivity of your C-Suite
- `Topology` can visual entire Network typology down to the NIC  

If you can compromise a Cloud environment understanding the network patterns in the packet economy and the defensive mindset surround Alerting and Rule creation could help you understand your adversary as well as where the important data is.

## Split-Horizon Request Forgery

Azure DNS allows for public and private domains of the same name to exist this seems like a vector for which you can exploit the DNS server request to give you the incorrect lookup.
- DNS Proxy for Azure Firewall to exfiltrate out...

## Administrative Password Reuse

- Upon VM creation passwords are reused, if VM has created with  `Get-Credential` or variant, ssh or RDP is open and you have a Administrative password 


## Compromise the SAS

Control and reduce valid digital communication between subscription holder and Azure - force older methods of communication to provide more time for later objective
Persist on-redeployment post-IR-removal


## Administrator Browsers and Password management

Azure Portal is browser based so password management may be done via browser or a password manager or Windows local host credential management. 

## Empty DNS Record Sets - Not tested 

These do not a appear appear on Azure DNS name servers. Hiding in custom Child domain contain in a field of an empty DNS record set. More stealth? Also [[Data-Exfiltration-Over-DNS]] maybe?
- If it is empty does that mean you can have an empty record for the Azure DNS proxy? 

## Azure Persistence

#### Hide in the Blueprints

Blueprint make life easier and is safer, hiding in blueprinting could actually be a Region-Escalation to implant more hide persistence in a different region as are they used in standardising deployment.

#### Alter or Create Custom RBAC

These maybe stored in a file share disk and are `.json` files, blending in is important. They can be uploaded and downloaded with `CloudCLI`  with:
```powershell
New-AzRoleDefinition -InputFile $file
```

#### Desired-State Persistence Backdooring

Desired State Configuration is a management platform in Windows PowerShell used is for create specific configurations with scripts. Find a script with `configuration` keyword and under given contexts could provide persistence in customised meaning Admin only and managed by Humans leading to oversight. This can be done from CLI aswell..
```powershell
configuration IISInstall # configuration script block
{
   Node "localhost" # Which VMs are configured
   { 
      WindowsFeature IIS # The resourcce block  
      {
         Ensure = "Present" # indicate if Role or Feature
         Name = "Web-Server" 
      }
   }
}
```
The Windows PowerShell Desired State Configuration comes with a set of built-in configuration resources, such as `File Resource`, `Log Resource`, and `User Resource`.

#### Template Supply Chain Compromise

If templating is archival in storage with sufficient access a variety of attacks could occur: 
- Backdooring
	- VMs
	- NIC 
	- Whitelisted traffic for Firewalls and Load Balancers
	- Route
- Files Share Poisoning

- Scrapping templated credentials for patterning and reusable credentials that are not managed by Azure. 

#### Backup Poisoning

Tools probably exist somewhere that can edit blob data - if so you can persistent in any way possible relative to the context of which backup is poisoned - such that Backup Vault can be compromised post reset. 

#### MARS Double Agent

Why target:
- Microsoft Signed
- Can schedule network traffic as part of its normal functionality - C2 Beacons evading by backup scheduling expectations
- Could be spread in a File Share without needing to download for every box
	- If social engineered, other Admins could implement script that would indicate exactly what and where all the data that Attacker with the objective of data theft, disclosure or destruction or as ransomware
- MARS agent **does not have to receive** Microsoft Update - You can push back updates!
- It also downloads PowerShell and .NET 4.5 :) 
-  MARS Agent like [[Potato-Exploits]]

One consideration that inspired this was also the way it is taught:
- The Data Trail, a Bad MARS Agent and Admin Credentials
	- **NOTE** can download it without it is just that it is taught that you do so through the portal from the box - [Install the Microsoft Azure Recovery Services (MARS) agent - Azure Backup | Microsoft Learn](https://learn.microsoft.com/en-us/azure/backup/install-mars-agent)
	- When doing the Microsoft Learn this was possible the most eyebrow raising:
		- Admin has to Azure portal from the box to register Backup
		    - Admin Creds in the Browser
			    - In a machine with a MARSAgentInstaller.exe, it may be that the Admin has configured the backup through the browser of that VM or Physical machine to download the MARAgentInstaller. Some artefact trace of the Sysadmin dropping credentials to access the portal to downloads the MARS agent.
		- Downloads the MARInstaller.exe that does not have to be updated
		- Downloads Credential generator
		    - Saves the passphase to the Disk
		    - Vault credential could also be left on the target computer.
		        - This can be recoverable with Open Sourced Tools

![](wheredoyouthinkitisdonefrom.png)

## Destructive

#### Untag everything 

Forcing a hard reset of subscription if they backups, but would also provide additional time as it would become difficult and unwieldy to use non-tag variables.

#### Reassign all Log endpoints

Create a misconfiguration where all the endpoints are logging other end points such that the data is mixed up


## Strategies

#### User-Defined Exfiltration Pipeline and Route to Network Insanity 

Emergency Data Exfiltration the equivlent of pulling out a heart, leaving a clockwork toy in its place and that sows up the wound and cleans up everything.

Use User Defined Routes to configure an burst exfiltration route configuration, before a clean up task and then a reconfiguration of the entire network with User Defined Routes to force return to backup or delay the amount of time it takes that a team can interfere with the clean up bot.  

Requires calculation of time to exfiltrate data

Two scripts, one scheduled task:
1. Exfiltration Pipe
	- Turn all NVAs against all traffic expect the exfiltration stream
	- Route all traffic to each Hub
2. Nightmare version of each target network - on-premise and off-premise.

3. Script a configuration to entire network into user defined route that utilises the maximum bandwidth
4. Have some scheduled Administrative task to wipe, reconfigure post exfiltration
5. 


