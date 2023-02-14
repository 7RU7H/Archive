
These are just ideas and things I have found. Nothing tested or works just ideas. There are better resources... I will hopeful research these 

## Objectives

Compromise the SAS
Control and Reduce valid digital communication between subscription holder and Azure - force older methods of communication to provide more time for later objective
Persist on-redeployment post-IR-removal

## Split-Horizon Request Forgery

Azure DNS allows for public and private domains of the same name to exist this seems like a vector for which you can exploit the DNS server request to give you the incorrect lookup.


## Adminstrative Password Reuse

- Upon VM creation passwords are reused, if VM has created with  `Get-Credential` or variant, ssh or rdp is open and you have a Administrative password 


## Compromise the SAS


## Administrator Browsers and Password management

Azure Portal is browser based so passowrd management may be done via browser or a password manager or Windows local host credential management  


## Empty DNS Record Sets - Not tested 

These do not a appear appear on Azure DNS name servers. Hiding in custom Child domain contain in a field of an empty DNS record set. More stealth? Also [[Data-Exfiltration-Over-DNS]]  maybe?

## Azure Persistence

#### Hide in the Blueprints

Blueprint make life easer and is safer, hiding in blueprinting could actually be a Region-Escalation to implant more hide persistence in a different region as are they used in standardising deployment.

#### Alter or Create Custom RBAC

These maybe stored in a fileshare disk and are `.json` files, blending in is important. They can be uploaded and downloaded with `CloudCLI`  with:
```powershell
New-AzRoleDefinition -InputFile $file
```

#### Desired-State Persistence Backdooring

Desired State Configuration is a management platform in Windows PowerShel used is for create specific configurations with scripts. Find a script with `configuration` keyword and under given contexts could provide persistence in customized meaning Admin only and managed by Humans leading to oversight. This can be done from CLI aswell..
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