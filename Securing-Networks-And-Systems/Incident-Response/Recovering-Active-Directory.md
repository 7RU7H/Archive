# Recovering Active Directory

**Warning PowerShell scripting indicated of this article were created with [Phind](https://www.phind.com) and human consultation of various references provided by Phind and Microsoft documentation

## First Response

- Remain calm and breath correctly 
- Backup compromised AD server with `Window Server Backup` - `Run -> wbadmin.msc`
	- Replication for later analysis is required for:
		- Failures in the [[Pyramid-Of-Pain]] 
		- Malware Analysis
		- [[Cyber-Threat-Intelligence]] data for the organisation for threat analysis relevant to the organisation
- Restore a trust backup (hopeful from a segmented storage that has not been infected)
	- Restoration will result in a loss of LOTS of data - beware
	- If adversary is persistent in the backups by using that backup you allow them to persist longer
		- If persistence is identified in current running systems checking and removing the same persistence in a backup for restoration would be ideal 
- Segregate network 
- Activate a secondary domain controller to provide non-disruptive services to the users
- Enable any enhanced monitoring and filtering from the restored AD server to identify any attack patterns and exfiltration patterns that may be occurrence
	- Consider reviewing the various type of [[Data-Exfiltration-Defined]] possible
- Limit new artefact creation - no new accounts, GPOs, etc
	- To prevent failures of appearing adversarial for blue team activity and providing the adversary a addition technique to utilise during this phase
	- To prevent adversaries going undetected on meeting their objective the lowest of all low hanging fruit possible

## Identification

#### Considerations

Be aware of how you interact with the compromised environment! 
- Track what you do 


Be aware of evasion some logging mechanisms are have listed pages:
- [[ETW-Evasion-Disabling-Providers]]
- [[ETW-Evasion-Abusing-Log-Pipeline]]
- [[ETW-Evasion-PowerShell-Reflection]]
- [[ETW-Evasion-Group-Policy-Takeover]]
- [[ETW-Evasion-Patching-Tracing-Functions]]

Do you have the data?

List all available logs - from [adamtheautomator - get-winevent](https://adamtheautomator.com/get-winevent/)
```powershell
Get-WinEvent -ListLog * | Select-Object LogName, RecordCount, IsClassicLog, IsEnabled, LogMode, LogType | Format-Table -AutoSize
```
- Would also be wise to check for corruption of the log file before analysis. Destructive techniques may have been used against the logs to waste your compute and human time trying to parse and analyse the data that is there and what it entails.
#### Tools and Techniques to Identify Patterns, Vectors 

- [[Event-Viewer]] and [[ETW]] or preferable a more powerful way of viewing Windows Events if you can as Event Viewer - some [[SIEM-Solutions]] and Monitoring software that use these logs like [[Velociraptor]] can help cut down time to identification just by being more *wieldable* as software. 
	- Authorial note: 
		- I hear rumours that Windows were trying to update [[Event-Viewer]]
		- I have used [[Event-Viewer]] for CTFs and it has some flaws

Consider use [[Windows-Events-To-Monitor]] includes a table of Event ID to then narrow down specific searches for 
- [[Sysmon-Events]] with [[Sysinterals-Sysmon]] 
	- [[Sysmon-Basic-Hunting]]
- [[PowerShell-Event-Logging.md]]


Use the [Administrative PowerShell module](https://learn.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps) before you just run Bloodhound and PowerView .. 

Get AD users creation date to identify newly created users - this won't help that much, as a template for further checks
```powershell
Get-ADUser -Filter {((Enabled -eq $True) -and (Created -gt "Monday, April 10, 2023 00:00:00 AM"))} -Property Created, LastLogonDate | select SamAccountName, Name, Created | Sort-Object Created
```
- Check: 
	- Old employees accounts
	- Soft deleted accounts that have been 
		- Reactivated
		- Soft-deleted recently 

Get the email addresses linked `samaccountname` - from [Microsoft](https://learn.microsoft.com/en-us/answers/questions/273595/how-to-fetch-email-address-from-ad-given-users-id) 
```powershell
Get-ADUser -Identity $SamAccountName -Properties EmailAddress  
```

List all domain joined machines and devices with the corresponding person whom joined it. Beware of impersonation attacks... 
```powershell
Get-ADComputer -filter * -properties whencreated | Select Name,@{n="Owner";e={(Get-acl "ad:\$($_.distinguishedname)").owner}},whencreated 
```

#### BEWARE - DOES NOT WORK

[Phind assisted](https://www.phind.com) - use `get-winevent` detailed in [learn.microsoft.com](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-winevent?view=powershell-7.3) to get all the Group membership changes as per the follow Windows Events IDs:
- ID 4756: Member added to a universal security group.
- ID 4757: Member removed from a universal security group.
- ID 4728: Member added to a global security group.
- ID 4729: Member removed from a global security group.
```powershell
import-module Microsoft.PowerShell.Diagnostics
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4756,4757,4728,4729} | ConvertTo-Xml | Out-File -FilePath 'events.xml'
```

Use `get-winevent` detailed in [learn.microsoft.com](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-winevent?view=powershell-7.3) to . Windows Event IDs:
- ID 4719: System audit policy was changed.
- ID 4739: Domain Policy was changed.
```powershell
import-module Microsoft.PowerShell.Diagnostics
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4719,4739} | ConvertTo-Xml | Out-File -FilePath 'events.xml'
```


Use [[Bloodhound-Guide]] - to Bloodhound your environment to:
- Find hidden relations
- Find potential X-step to full re-compromise - [[Silver-Tickets]], [[Diamond-Tickets]] and [[Sapphire-Tickets]]!
	- Monitor potential vectors as a [[Honeypots]] to then gain more [[CTI-And-Containment]] 
		- Get IPs and domain names of C2 servers to had to authorities and for blacklisting 

- (Do not use PowerView if you are going to  introduce attacking tool to enumerate the environment at least use Bloodhound) - PowerView is recommended by the THM room and here [[Powerview-Cheatsheet]], but it is basically Bloodhound without the visual aid or the breakdown of what the attacker will do. I would not recommend. You could just use the administrative PowerShell module for AD as administrators of the server instead of introducing more ways for attackers to use this functionality and impersonate the IR team!  

## References

[adamtheautomator - get-winevent](https://adamtheautomator.com/get-winevent/)
[Phind](https://www.phind.com)