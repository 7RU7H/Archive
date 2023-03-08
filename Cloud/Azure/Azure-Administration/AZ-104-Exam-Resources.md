#  AZ 104 Exam resources

## General Requirements - Without Cloud

If you already have AWS certs, I would not know, but probably Active Directory part is the important 

- Good Network Fundementals 
	- At Network+ level understanding
	- Sec+ level understanding will also help
- Active Directory understanding - Azure AD is AD, but you will still have On-premise AD
	- I got this through THM, HTB, OSPG and OScerts
- Good SysAdmin
	- Organised - TAGS TAGS TAGS!
	- Linux and Windows - both are important
	- Roles and Permissions
	- Maintaince
	- Service Avaliability
	- Powershell/Bash usage is used in Azure 
- Can read Powershell well 

Will be required 
- Containerisation - K8 and Docker
- The Exam changes more rapidly - older material gets older quick
- Kusto Log quieries - double checking for this.

## Absolute Musts

Make a free Azure Account - must!

Read and [AZ-104 Microsoft Learn](https://learn.microsoft.com/en-us/certifications/exams/az-104/) - must!

Understand the Logic behind the Powershell Commandlets naming - [Eyedia AZ-104 Exam Playlist](https://www.youtube.com/playlist?list=PLA_CqAntXBh4DPIYCcplBWLjT3AYl1822) 
```powershell
Get-Az # Retrieve information
New-Az # Create Azure X
Update-Az # Update Azure X
Add-Az # Add X to Existing Azure Y



```



[John Savile](https://www.youtube.com/@NTFAQGuy) is great resource regarding anything Azure. [Master Class](https://www.youtube.com/playlist?list=PLlVtbbG169nGccbp8VSpAozu3w9xSQJoY)

[Eyedia AZ-104 Exam Playlist](https://www.youtube.com/playlist?list=PLA_CqAntXBh4DPIYCcplBWLjT3AYl1822) - similar exam questions especially the *got-ya questions* in visual and digestable format. Absolute must! 

If you are from a Ethical Hacking Background [IT Security Labs is Ex-Windows/Azure System Administrator](https://www.youtube.com/@ITSecurityLabs) - some writeup from [[HackTheBox]] have Azure Related CTFs...

## Advice cross resource


1. Read what they are asking of you not rabbit-hole in the complexity of the problem
	1. Make a picture of the problem to simplify the large body of texts of the questions.
1. Simplify scenarios to fundementals!
	1. Is it in the same Region - Cross Region comes changes in legalities 	
	1. Address range overlapping are always prohibited in all circumstances - [Plan for IP addresses](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-ip-addressing)
	1. Peering requires Bi-direction connection
	1. Principle of Least Privilege
	1. Recursively apply heirarchies of inheritance across subsequent levels in Top-Down manner
		- Top-Level logic can affect how lower levels are permitted to operate - across concepts in Azure
1. Memorize `Microsoft.$ROLE/*/` role logic
