# Active Directory Enumeration Cheatsheet

To make the articles in this repo more concise and focused, this cheatsheet was inital assimilation from [Emanlui's Incredible Cheatsheet](https://github.com/Emanlui/OSCP-Scripts/blob/main/Windows.md#enumeration) to kick start sourcing everything in this repo that is relevant and to seperate Privilege Escalation from Enumeration. For details and explainations see [[Active-Directory-Enumeration-Defined]]. 

If you have access to `Get-Wmi` powershell commands the entire process can be done with 0xinfection blogs inspired [[Active-Directory-Offensive-Enumeration-With-WMI]]

Basics with cmd
```powershell
net user /domain # User account fo r \\DC*.*domain*.*tld
net user *admin* /domain # information about the admin
net group /domain # All groups in domain - DC is sometimes required
net group "<target group name>" /domain
net accounts /domain    # Password policy
ipconfig /displaydns	# Get DC ip
runas

```

[Net command documentation](https://docs.microsoft.com/en-us/troubleshoot/windows-server/networking/net-commands-on-operating-systems)

Use runas.exe
```powershell
runas.exe /netonly /user:<domain>\<username> cmd.exe
```

IF internal DNS is configured automative through DHCP or VPN, using the IP for DNS server (usually a DC) of the target network.
```powershell
$dnsip = "<DNS Server IP>"
$index = Get-NetAdapter -Name '<interface-name>' | Select-Object -ExpandProperty 'ifIndex'
Set-DnsClientServerAddress -InterfaceIndex $index -ServerAddresses $dnsip
```

DNS Zone Transfer with `nslookup`
```
nslookup.exe
>server IP 
>ls -d domainname.com
```

 Check ConsoleHost history file:
```powershell
type %userprofile%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt

(Get-PSReadlineOption).HistorySavePath
```


## Network Enumeration
```powershell
net share # Show shares
Get-NetComputer -ping
netstat -ano # -a displays all active connections, -n prevents name resolution, -o display the pid for each connection
# ARP Table
arp -a
Get-NetNeighbor -AddressFamily IPv4 | ft ifIndex,IPAddress,LinkLayerAddress,State
# check dns server
ipconfig /all                                    
Get-NetIPConfiguration | ft InterfaceAlias,InterfaceDescription,IPv4Address
Get-DnsClientServerAddress -AddressFamily IPv4 | ft

# List routing table
route print
Get-NetRoute -AddressFamily IPv4 | ft DestinationPrefix,NextHop,RouteMetric,ifIndex

# SNMP Configuration
reg query HKLM\SYSTEM\CurrentControlSet\Services\SNMP /s
Get-ChildItem -path HKLM:\SYSTEM\CurrentControlSet\Services\SNMP -Recurse

1..15 | %(echo "10.10.10.$_"; ping -n 1 10.10.10.$_ | Select-String tt1)         # ip ping sweep 
1..1024 | %(echo ((New-Object Net.Sockets.TcpCLient).Connect("10.10.10.10", $_)) "Open port on - $_" 2>$null # Port scan
```


## Host Sercurity Enumeration
[`GetCimInstance`](https://docs.microsoft.com/en-us/powershell/module/cimcmdlets/get-ciminstance?view=powershell-7.2) maybe configured to not be avaliable for non-users, but may end up needing them to pivot through a network after inital PrivEsc.

Firewalls enumeration powershell
```powershell
Get-NetFirewallProfile | Format-Table Name, Enabled
# Tear down the WALL
Set-NetFirewallProfile -Profile Domain, Public, Private -Enable False
# Show rules
Get-NetfirewallRule | select Display, Enabled, Description
```
and with cmd.exe:
```powershell
netsh advfirewall firewall dump
# or 
netsh firewall show state
netsh firewall show config
# advfirewall
netsh advfirewall firewall show rule name=all
```

Testing a firewall from the inside:
```powershell
Test-NetConnection -ComputerName 127.0.0.1 -Port 80
```

List all block ports by firewall
```powershell
$f=New-object -comObject HNetCfg.FwPolicy2;$f.rules |  where {$_.action -eq "0"} | select name,applicationname,localports
```


Eventlogs sometimes provide an insight into applications and services, security or otherwise
```powershell 
Get-EventLog -List
```

Windows Defender
```powershell 
Get-Service WinDefend
# Check Windows Defender Enabled but have
Get-MpComputerStatus | Select RealTimeProtectionEnabled 
Set-MpPreference -DisableRealtimeMonitoring $true

# Registry Key
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender

sc stop WinDefend
sc start WinDefend

# check status of Defender
PS C:\> Get-MpComputerStatus

# disable scanning all downloaded files and attachments, disable AMSI (reactive)
PS C:\> Set-MpPreference -DisableRealtimeMonitoring $true; Get-MpComputerStatus
PS C:\> Set-MpPreference -DisableIOAVProtection $true

# disable AMSI (set to 0 to enable)
PS C:\> Set-MpPreference -DisableScriptScanning 1 

# exclude a folder
PS C:\> Add-MpPreference -ExclusionPath "C:\Temp"
PS C:\> Add-MpPreference -ExclusionPath "C:\Windows\Tasks"
PS C:\> Set-MpPreference -ExclusionProcess "word.exe", "vmwp.exe"

# remove signatures (if Internet connection is present, they will be downloaded again):
PS > & "C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.2008.9-0\MpCmdRun.exe" -RemoveDefinitions -All
PS > & "C:\Program Files\Windows Defender\MpCmdRun.exe" -RemoveDefinitions -All
```

AV
```powershell
wmic / :\\ \  path antivirusproduct
Get-CimInstance -Namespace <name/space> -ClassName AntivirusProduct
```

Sysmon Enumeration
```powershell
Get-CimInstance win32_service -Filter "Description = 'System Monitor service'"
Get-Service | where-object {$_.DisplayName -like "*sysm*"}
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Sysmon\Operational
```
If you find Sysmon, find the config file.
```powershell
 findstr /si '<ProcessCreate onmatch="exclude">' C:\* # BEWARE recursive searching!
```

## Patch Level

Software
```powershell
get-executionpolicy -list
set-executionpolicy bypass -scope process # Change executionpolicy
wmic product get name,version,vendor
wmic service list brief
wmic service list brief | findstr  "Running"
sc qc <service>
```
 Hotfix levels
```powershell
get-hotfix
get-hotfix | format-list | findstr InstalledOn
get-hotfix | format-table hotfixid
get-hotfix -ID  # specific information

wmic product get name, version, vendor
wmic qfe get Caption, Description, HotFixID, InstalledOn
```

Device Driver and Kernel Modules Queries
```powershell
driverquery
sc query windefend # requires NAME use get-ciminstance here for memory
sc queryex type=service
get-ciminstance -namespace root/securitycenter2 -classname antivirusproduct

driverquery.exe /v /fo csv | ConvertFrom-CSV | Select-Object ‘Display Name’, ‘Start Mode’, Path

Get-WmiObject Win32_PnPSignedDriver | Select-Object DeviceName, DriverVersion, Manufacturer | Where-Object {$_.DeviceName -like "*$SOMETHING*"}
```

## AD 

```powershell
Get-ADForest | Select-Object Domains # Lists all Domains in Forest

Get-ADTrust -Filter * | Select-Object Direction,Source,Target					# List trust information

dsquery group -name "Domain Admins" | dsget group -expand -members				# Query for all DCs

Get-ADDomain | Select-Object NetBIOSName, DNSRoot, InfrastructureMaster				# List all DCs

Get-ADUser -Filter * -Properties Description | Where-Object { $_.Description.length -gt 8 } 	# Searching AD replace *!
```

Windows Functions:
```powershell
NetWkstaUserEnum #(requires Administrative privileges returns a list of active users on a workstation that admin has local administrator privileges over) - Use Post for Movement
NetSessionEnum # returns list of list of active user sessions on servers 
# enumerate all active users' sessions
```

Get Current Domain: `Get-Domain`
Enumerate Other Domains: `Get-Domain -Domain <DomainName>`
Get Domain SID: `Get-DomainSID`

Get Domain Policy: 

`Get-DomainPolicy | Select-Object -ExpandProperty SystemAccess`
`Get-DomainPolicy | Select-Object -ExpandProperty KerberosPolicy`

Domain controllers:

`Get-DomainController`
`Get-DomainController -Domain <DomainName>`

Enumerate Domain Users

```powershell
#Save all Domain Users to a file
Get-DomainUser | Out-File -FilePath .\DomainUsers.txt

#Will return specific properties of a specific user
Get-DomainUser -Identity [username] -Properties DisplayName, MemberOf | Format-List

#Enumerate user logged on a machine
Get-NetLoggedon -ComputerName <ComputerName>

#Enumerate Session Information for a machine
Get-NetSession -ComputerName <ComputerName>

#Enumerate domain machines of the current/specified domain where specific users are logged into
Find-DomainUserLocation -Domain <DomainName> | Select-Object UserName, SessionFromName
```

Enumerate Domain Computers

```powershell
Get-DomainComputer -Properties OperatingSystem, Name, DnsHostName | Sort-Object -Property DnsHostName

#Enumerate Live machines 
Get-DomainComputer -Ping -Properties OperatingSystem, Name, DnsHostName | Sort-Object -Property DnsHostName

# 
nltest /DCLIST:DomainName
nltest /DCNAME:DomainName
nltest /DSGETDC:DomainName
```

Enumerate Groups and group members

```powershell
#Save all Domain Groups to a file:
Get-DomainGroup | Out-File -FilePath .\DomainGroup.txt

# LAPs group can read passwords
Get-ADComputer -Filter 'ObjectClass -eq "computer"' -Property *
# Password is in output or Kali lapsdumper

#Return members of Specific Group (eg. Domain Admins & Enterprise Admins)
Get-DomainGroup -Identity '<GroupName>' | Select-Object -ExpandProperty Member 
Get-DomainGroupMember -Identity '<GroupName>' | Select-Object MemberDistinguishedName

#Enumerate the local groups on the local (or remote) machine. Requires local admin rights on the remote machine
Get-NetLocalGroup | Select-Object GroupName

#Enumerates members of a specific local group on the local (or remote) machine. Also requires local admin rights on the remote machine
Get-NetLocalGroupMember -GroupName Administrators | Select-Object MemberName, IsGroup, IsDomain

#Return all GPOs in a domain that modify local group memberships through Restricted Groups or Group Policy Preferences
Get-DomainGPOLocalGroup | Select-Object GPODisplayName, GroupName
```

Enumerate Shares

```powershell
#Enumerate Domain Shares
Find-DomainShare

#Enumerate Domain Shares the current user has access
Find-DomainShare -CheckShareAccess

#Enumerate "Interesting" Files on accessible shares
Find-InterestingDomainShareFile -Include *passwords*
```

Enumerate Group Policies

```powershell
Get-DomainGPO -Properties DisplayName | Sort-Object -Property DisplayName

#Enumerate all GPOs to a specific computer
Get-DomainGPO -ComputerIdentity <ComputerName> -Properties DisplayName | Sort-Object -Property DisplayName

#Get users that are part of a Machine's local Admin group
Get-DomainGPOComputerLocalGroupMapping -ComputerName <ComputerName>
```

Enumerate OUs

```powershell
Get-DomainOU -Properties Name | Sort-Object -Property Name
```

Enumerate ACLs

```powershell
# Returns the ACLs associated with the specified account
Get-DomaiObjectAcl -Identity <AccountName> -ResolveGUIDs

#Search for interesting ACEs
Find-InterestingDomainAcl -ResolveGUIDs

#Check the ACLs associated with a specified path (e.g smb share)
Get-PathAcl -Path "\\Path\Of\A\Share"
```

Enumerate Domain Trust

```powershell
Get-DomainTrust
Get-DomainTrust -Domain <DomainName>

#Enumerate all trusts for the current domain and then enumerates all trusts for each domain it finds
Get-DomainTrustMapping
```

Enumerate Forest Trust

```powershell
Get-ForestDomain
Get-ForestDomain -Forest <ForestName>

#Map the Trust of the Forest
Get-ForestTrust
Get-ForestTrust -Forest <ForestName>
```

User Hunting

```powershell
#Finds all machines on the current domain where the current user has local admin access
Find-LocalAdminAccess -Verbose

#Find local admins on all machines of the domain
Find-DomainLocalGroupMember -Verbose

#Find computers were a Domain Admin OR a spesified user has a session
Find-DomainUserLocation | Select-Object UserName, SessionFromName

#Confirming admin access
Test-AdminAccess
```

### Access Directory

```powershell
Get Current Domain: `Get-ADDomain`
Enum Other Domains: `Get-ADDomain -Identity <Domain>`
Get Domain SID: `Get-DomainSID`
```


Get Domain Controllers

```powershell
Get-ADDomainController
Get-ADDomainController -Identity <DomainName>
```

Enumerate Domain Users

```powershell
Get-ADUser -Filter * -Identity <user> -Properties *

#Get a spesific "string" on a user's attribute
Get-ADUser -Filter 'Description -like "*wtver*"' -Properties Description | select Name, Description
```

Enumerate Domain Computers

```powershell
Get-ADComputer -Filter * -Properties *
Get-ADGroup -Filter * 
```

Enumerate Domain Trust

```powershell
Get-ADTrust -Filter *
Get-ADTrust -Identity <DomainName>
```

Enumerate Forest Trust

```powershell
Get-ADTrust -Filter *
Get-ADTrust -Identity <DomainName>
```

Enumerate Local Applocker Effective Policy `Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections`


## AD-module
```powershell
Get-ADUser -Identitiy <username> -Server <domain> -Properties *
Get-ADUser -Filter 'Name -like "*wildcards-allowed"' -Server <domain> | Format-Table Name,SamAccountName -A
Get-ADGroup -Identity Administrators -Server <domain>
Get-ADGroupMember -Identity Adminstrators -Server <domain>
Get-ADDomain -Server <domain>

# Find  Deleted Objects!
$ChangeDate = New-Object DateTime(2022, 02, 28, 12, 00, 00)
Get-AdObject -Filter 'whenChanged -gt $ChangeDate' -includeDeletedObejects -Server <domain>
# Bad password Counts
Get-AdObject -Filter 'badPwdCount -gt 0' -Server <domain>

# Altering AD Objects
Set-ADAccountPassword -Identity <username> -Server <domain> -OldPassword (CovertTo-SecureString -AsPlainText "<old-password>" -Force) -NewPassword (CovertTo-SecureString -AsPlaintext "<new-paasword>" -Force)
```

## References

[Emanlui's Incredible Cheatsheet](https://github.com/Emanlui/OSCP-Scripts/blob/main/Windows.md#enumeration)
[Net command documentation](https://docs.microsoft.com/en-us/troubleshoot/windows-server/networking/net-commands-on-operating-systems)
[PayloadAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Windows%20-%20Privilege%20Escalation.md)