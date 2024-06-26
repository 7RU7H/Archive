#  AZ 104 Exam resources

## General Requirements - Without Cloud

If you already have AWS certs, I would not know, but probably Active Directory part is the important 

- Good Network Fundamentals 
	- At Network+ level understanding
	- Sec+ level understanding will also help
- Active Directory understanding - Azure AD is AD, but you will still have On-premise AD
	- I got this through THM, HTB, OSPG and OScerts
- Good System Administration
	- Organised - TAGS TAGS TAGS!
	- Linux and Windows - both are important
	- Roles and Permissions
	- Maintenance
	- Service Availability
	- PowerShell/Bash usage is used in Azure 
- Can read PowerShell well 

Will be required 
- Containerisation - K8 and Docker
- The Exam changes more rapidly - older material gets older quick
- Kusto Log queries - double checking for this.

## Absolute Musts

Make a free Azure Account - must!

Read and [AZ-104 Microsoft Learn](https://learn.microsoft.com/en-us/certifications/exams/az-104/) - must!

Understand the Logic behind the PowerShell cmdlets naming - [Eyedia AZ-104 Exam Playlist](https://www.youtube.com/playlist?list=PLA_CqAntXBh4DPIYCcplBWLjT3AYl1822)
PowerShell Cmdlet Logic and for Az104 replace the Az with Mg and be happy you are not migrating anything:
```powershell
# Microsoft Graph Module
Get-Mg # Retrieve information
New-Mg # Create Mgure X
Update-Mg # Update Mgure X
Add-Mg # Add X to Existing Mgure Y
Move-Mg # Move Mg X to Y
Export-Mg # Capture to a template
Import-Mg # Import config
Remove-Mg # Remove..
Select-Mg # Select != Get; Choose X
Invoke-Mg # Contruct and Perform X
Clear-Mg # Clear settable values
Set-Mg # Opposite of Clear, Set values
# Deprecated Zure Powershell Module
Get-Az # Retrieve information
New-Az # Create Azure X
Update-Az # Update Azure X
Add-Az # Add X to Existing Azure Y
Move-Az # Move Az X to Y
Export-Az # Capture to a template
Import-Az # Import config
Remove-Az # Remove..
Select-Az # Select != Get; Choose X
Invoke-Az # Contruct and Perform X
Clear-Az # Clear settable values
Set-Az # Opposite of Clear, Set values
``````


[John Savill](https://www.youtube.com/@NTFAQGuy) is great resource regarding anything Azure. [Master Class](https://www.youtube.com/playlist?list=PLlVtbbG169nGccbp8VSpAozu3w9xSQJoY)

[Eyedia AZ-104 Exam Playlist](https://www.youtube.com/playlist?list=PLA_CqAntXBh4DPIYCcplBWLjT3AYl1822) - similar exam questions especially the *got-ya questions* in visual and digestible format. Absolute must! 

If you are from a Ethical Hacking Background [IT Security Labs is Ex-Windows/Azure System Administrator](https://www.youtube.com/@ITSecurityLabs) - some write up from [[HackTheBox]] have Azure Related CTFs...

## Advice cross resource

1. Read what they are asking of you not rabbit-hole in the complexity of the problem
	1. Make a picture of the problem to simplify the large body of texts of the questions.
1. Simplify scenarios to fundamentals!
	1. Is it in the same Region - Cross Region comes changes in legalities 	
	1. Address range overlapping are always prohibited in all circumstances - [Plan for IP addresses](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-ip-addressing)
	1. Peering requires Bi-direction connection
	1. Principle of Least Privilege
	3. Recursively apply hierarchies of inheritance across subsequent levels in Top-Down manner
		- Top-Level logic can affect how lower levels are permitted to operate - across concepts in Azure
1. Memorise `Microsoft.$AZURECOMPONENT/*/..` 
	- Role hierarchy check  
1. Read any PowerShell or AzCLI command snippets fully question will have fill the blanks in fundamentals will guide decision as well understanding the cmdlet naming logic 