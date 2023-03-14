# Azure Hacking

This is collection of resources and some explainations as to attacks against Azure  



TIL; Azure AD Connect is Hybrid Cloud an some organisation want the same passwords for account on and off premises. Synchronization occur between the Cloud and On-Premise where if an attack can reach the server that synchronizes between Azure and Organization credential can be decrypted as that seerver will host mcrypt.dll - located on the server `C:\Program Files\Microsoft Azure AD Sync\Bin\mcrypt.dll`. The keys and encrypted data can be stored with xml in [[MSSQL]]

[VBscrub's blog](https://vbscrub.com/2020/01/14/azure-ad-connect-database-exploit-priv-esc/), references a talk by [Dirk jan](https://www.youtube.com/watch?v=JEIR5oGCwdg), author of [Bloodhound.py](https://github.com/dirkjanm) 

- Mitigations:
	- [MS Connect PTA security](https://docs.microsoft.com/en-us/azure/active-directory/hybrid/how-to-connect-pta-security-deep-dive) 


Adam Chester's Blog on Azure Privilege Escalation [Azure AD Connect for Red Teamers](https://blog.xpnsec.com/azuread-connect-for-redteam/)