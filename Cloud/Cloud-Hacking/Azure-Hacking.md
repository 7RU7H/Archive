
These are just ideas and things I have found. Nothing tested or works just ideas. There are better resources...

## Objectives

Compromise the SAS



## Adminstrative Password Reuse

- Upon VM creation passwords are reused, if VM has created with  `Get-Credential` or variant, ssh or rdp is open and you have a Administrative password 


## Compromise the SAS


## Administrator Browsers and Password management

Azure Portal is browser based so passowrd management may be done via browser or a password manager or Windows local host credential management  




#### Hide in the Blueprints

Blueprint make life easer and is safer, hiding in blueprinting could actually be a Region-Escalation to implant more hide persistence in a different region as are they used in standardising deployment.

#### Alter or Create Custom RBAC

These maybe stored in a fileshare disk and are `.json` files, blending in is important. They can be uploaded and downloaded with `CloudCLI`  with:
```powershell
New-AzRoleDefinition -InputFile $file
```