# Useful Powershell
This is a condensed and *Hacking themed* resource for powershell. Powershell is a massive and my humble opinion a *weird* object-oriented programming language. 
Windows and Powershell are not case-sensitive, but a *stardard* readability is to use upper-case first letter - I suggest not unless you need to present your work(use a script to change it to *standard*). Every command has a cmdlet and combinations of `verb-noun` to construct command that would be too numerous to list. So to define the theme of this document is oneliners catergorised by use(*just in case at some point they maybe some exceptions like two oneliners that need to be seperate executions* **THESE WILL HAVE A `# TASKNAME Command # THEN Command`**). I am in the process of making this better for my own use:
1. Adding aliases that I might want to use instead of full command
2. Making the comments defining explaining a better layout

## General
```powershell
Get-Command              # list of powershell commands, BEWARE OF THE LISTS
Get-Verb				 # list all verbs
Get-Help                 # help for specific cmdlet
Get-Help $Command-Name
Get-Command Verb-* 
Get-Command *-Noun # Commands and Cmdlets are both executables in ps, Command= compiled, can be solo-executed cmdlets
Get-Command | Get-Member -MemberType Method # view members for a the get command
Get-Command -Type Cmdlets | Measure-Object -Sum -ErrorAction SilentlyContinue
Get-Alias		
Set-Alias				 	# Make commands
Set-Alias -Name helpmeplease -Value Get-help

```

## Providers and Modules
```powershell
# A provider is .NET program to access data stores
# Typically included in modules and are accessible after the module has been loaded into the current session
Get-PSProvider

# Modules are packages that contain additional cmdlets, functions, providers, etc that an be imported into the current session
Get-Module 
Get-Module -ListAvaliable
Get-Command -Module Defender	# Return all functions of a module
```

## System Information
```powershell
Get-HotFix -ID
$PSVersionTable.PSVersion
Get-History							# Get command history
Get-ChildItem ENV:      # Display all environment variables
```

## Software Information
```powershell
Get-ExecutionPolicy			
Set-ExecutionPolicy -RemoteSigned	# -Flags -Name -ListAvailable

```

## Strings and objects
```powershell
Select-Object                                           select object -Properties Mode, Name
        first - gets the first x object
        last - gets the last x object
        unique - shows the unique objects
        skip - skips x objects

Select-String "..." -List  # CAREFUL WHERE YOU RUN it relative to working directory location!
Select-String $String -context 10,10			# Findstr but get the ten lines previous and after match VERY HANDY with sysinternals
Get-ChildItem C:\ -Recurse | Select-String -Pattern "password"
```

## Maths, Counting and Measuring
```powershell
Measure-Object -Sum -ErrorAction SilentlyContinue
```

## File and Directory interactions
```powershell
## Reading and Writing ##
Get-Content							  # Reading file
Get-Content -Path .\filename.FILETYPE # -Raw for raw file output

Set-Content 		# Writing to files
Expand-Archive -Path .\*.zip -DestinationPath C:\Destination # Expand a zip file

Get-Location        # print working directory
Set-Location 		# choose a directory for context to operate

## File Hashing and checksums ##
# FILTERHASHTABLE 101:
# Levels:
# NAME            VALUE
# verbose         5
# informational   4
# warning         3
# error           2
# critical        1
# logalways       0 
# FOR EXAMPLE:
Get-FileHash -Path ... -Algorithm
CertUil -hashfile [FILE] MD5|SHA256|SHA512
## Finding ##
Get-ChildItem # Aliased ls, dir, gci
Get-ChildItem -Hidden
Get-ChildItem -Path C:\ -Include *.doc,*.[FILETYPE] -File -Recurse -ErrorAction SilentlyContinue #Find all finds of a particular filetype:
Get-ChildItem –Path C:\ -Include *HSG* -Exclude *.JPG,*.MP3,*.TMP -File -Recurse -ErrorAction SilentlyContinue # Find all find that include *"..."* BUT also exclude wildcard.Filetype
Get-Childitem -Path C:\ -Recurse # Display pdirectory listing under a parent file, flag: recursive for recursive directory scrapping
Get-Acl # Get owner of directory again careful of relative running from another directory

Where-Object # TODO
Import-CSV file.csv     # Read a CSV file
```

## Processes, tasks and scheduled tasks
```powershell
Get-Process
Get-Process -ID $PID -IncludeUserName # Owner of proccess
Get-Process -ID $PID | Format-Table * # All data on a PID
Get-CimInstance -className win32_process | where-object {$_.ProcessId -eq processId_goes_here } | select ParentProcessId, Name # Get parent process

# Scheduled Tasks
schtasks
schtasks /query /fo /LIST /v

## PS Modules ##
Import-Module module.ps1

##  Sofware ##
# Change executionpolicy
set-executionpolicy bypass -scope process
```

## Networking
```powershell
# Test connection
Test-NetConnection -ComputerName 127.0.0.1 -Port 80
# Check the test connection with:
(New-Object System.Net.Sockets.TcpClient("127.0.0.1", "80")).Connected

netstat -noa |findstr "LISTENING" |findstr "PORTNUMBER"                 # Find process port

# nslookup.exe for dc enumeration within a network
nslookup.exe
server ip
ls -d domainname
```

## Host Security Detection
```powershell
Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct     # Windows servers may not have SecurityCenter2
Get-Service WinDefend
Get-MpComputerStatus                                                            # Get the status of security solution elements
Get-MpThreat                                                                    # History of detected threats
Get-NetFirewallProfile | Format-Table Name, Enabled                             # Firewall details
Get-NetFirewallRule | select DisplayName, Enabled, Description                  # Show all enable firewall rules
Get-NetFirewallRule | findstr "rulename"                                        # Find specific rule with findstr
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False          # disable a firewall
```

## Active Directory
```powershell
# Certain Privileges!
Get-ADUser -Filter *
Get-ADUser -Filter * -SearchBase "CN=Admin,OU=THM,DC=redteam,DC=com" # CN=Common Name, DC=Domain Component, OU=OrganizationalUnitName, et
Get-ADForest | Select-Object Domains
Get-ADDomain | Select-Object NetBIOSName, DNSRoot, InfrastructureMaster
Get-ADTrust -Filter * | Select-Object Direction,Source,Target
Get-NetDomain
Get-NetDomainController
Get-NetForest
Get-NetDomainTrust
```

## Event Logging
```powershell
# General
# Get service infomation either:
Get-CimInstance win32_service -Filter "Description = 'System Monitor service'" # OR
Get-Service | where-object {$_.DisplayName -like "*sysm*"}
# Registry Query with a path to hivekey-..\child\items\
reg query HK..\\
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Sysmon/Operational # sysmon key
# Find what the admins are monitoring:
findstr /si '<ProcessCreate onmatch="exclude">' C:\tools\*

## WinEvents
# These are themed by find if and what admins are using sysmon to monitor
Get-WinEvent                                           # get the events!
Get-WinEvent -LogName Application | Where-Object { $_.ProviderName -Match 'WLMS' } # Filter event logs..generally
Get-WinEvent -Path .\file.evtx -FilterXPath '*/System/EventID=1' | Sort-Object TimeCreated | Where-Object {$_.Message -like "*kw*"} | fl # Find EventID 
Get-WinEvent -Path .\sysmonlog.evtx -FilterXPath '*/System/*' | Where-Object { $_.TimeCreated -ge $start -and $_.TimeCreated -le $end } | Sort-Object TimeCreated# Find Event between $start -and $end
Get-WinEvent -LogName Application -FilterXPath '*/XML pathing/EVENTID=...'   # Eventid
Get-WinEvent -LogName Application -FilterXPath '*/XML pathing/Provider=[@Name=""]'       # Provider name query
# This instruction can also be done in wevtutil as well:
wevtutil.exe qe Application /q:*/System[EventId= ] /f:text /c:1
Get-WinEvent -LogName Application -FilterXPath '*/System/EventID=101 and */System/Provider[@Name="WLMS"]'
Get-WinEvent -LogName Application -FilterXPath '*/System/Provider[@Name="WLMS"]'
# Detect powershell downgrade
Get-WinEvent -LogName "Windows PowerShell" |
    Where-Object Id -eq 400 |
    Foreach-Object {
        $version = [Version] (
            $_.Message -replace '(?s).*EngineVersion=([\d\.]+)*.*','$1')
        if($version -lt ([Version] "5.0")) { $_ }
}

# NOTE FOR efficiency: use FilterHashTable over Where-Object 
Get-WinEvent -FilterHashtable @{
        LogName=''
        ProviderName=''
        ID=someint
}
#
## EventLogs
#
Get-EventLog                                           #  gets replace by the get-winevent
Get-EventLog -list 

# 
## Processes 
#
Get-Process | Where-Object { $_.ProcessName -eq "Sysmon" } # Get information of a process by name
Get-Process -ID $PID -IncludeUserName # Owner of proccess
Get-Process -ID $PID | Format-Table * # All data on a PID
```
