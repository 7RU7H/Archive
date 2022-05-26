## Box Enumeration ##

Get-ChildItem -Hidden

## General

Get-Command                                             list of powersahell commands BEWARE OF THE LISTS
Get-Help                                                help for specific cmdlet
Get-Location                                            justincase pwd
Get-Command | Get-Member -MemberType Method             view members for a the get command
Get-Command -Type Cmdlets | Measure-Object -Sum -ErrorAction SilentlyContinue


## System information
Get-HotFix -ID
$PSVersionTable.PSVersion
Get-History

## Strings and objects

Select-Object                                           select object -Properties Mode, Name
        first - gets the first x object
        last - gets the last x object
        unique - shows the unique objects
        skip - skips x objects
Select-String "..." -List                               CAREFUL WHERE YOU RUN it relative to working directory location!

## Counting and measuring

Measure-Object -Sum -ErrorAction SilentlyContinue

## File and Directory interactions

# Reading file
Get-Content
Get-Content -Path .\filename.FILETYPE 
# -Raw            for raw file output

## Writing to files ##
Set-Content

## File Hashing and checksums ##

#FILTERHASHTABLE 101:
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

# Files 

Where-Object

# Strings

Get-ChildItem
Get-ChildItem C:\ -Recurse | Select-String -Pattern "password"
Get-ChildItem -Path C:\ -Include *.doc,*.[FILETYPE] -File -Recurse -ErrorAction SilentlyContinue #Find all finds of a particular filetype:

Get-ChildItem –Path C:\ -Include *HSG* -Exclude *.JPG,*.MP3,*.TMP -File -Recurse -ErrorAction SilentlyContinue # Find all find that include *"..."* BUT also exclude wildcard.Filetype
Get-Childitem -Path C:\ -Recurse # Display pdirectory listing under a parent file, flag: recursive for recursive directory scrapping
Get-Acl # Get owner of directory again careful of relative running from another directory

## Processes, tasks and scheduled tasks
Get-Process
Get-Process -ID $PID -IncludeUserName # Owner of proccess
Get-Process -ID $PID | Format-Table * # All data on a PID
# Scheduled Tasks
schtasks
schtasks /query /fo /LIST /v

## PS Modules
Import-Module module.ps1

##  Sofware
# Change executionpolicy
set-executionpolicy bypass -scope process


## Networking ##

# Test connection
Test-NetConnection -ComputerName 127.0.0.1 -Port 80
# Check the test connection with:
(New-Object System.Net.Sockets.TcpClient("127.0.0.1", "80")).Connected

netstat -noa |findstr "LISTENING" |findstr "PORTNUMBER"			# Find process port	

# nslookup.exe for dc enumeration within a network
nslookup.exe
server ip
ls -d domainname

## Host Security Detection ##

Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct 	# Windows servers may not have SecurityCenter2
Get-Service WinDefend
Get-MpComputerStatus								# Get the status of security solution elements
Get-MpThreat									# History of detected threats
Get-NetFirewallProfile | Format-Table Name, Enabled				# Firewall details
Get-NetFirewallRule | select DisplayName, Enabled, Description 			# Show all enable firewall rules
Get-NetFirewallRule | findstr "rulename"					# Find specific rule with findstr
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False 		# disable a firewall


## Active Directory ##

Get-ADUser -Filter *
Get-ADUser -Filter * -SearchBase "CN=Admin,OU=THM,DC=redteam,DC=com" # CN=Common Name, DC=Domain Component, OU=OrganizationalUnitName, et
Get-ADForest | Select-Object Domains
Get-ADDomain | Select-Object NetBIOSName, DNSRoot, InfrastructureMaster
Get-ADTrust -Filter * | Select-Object Direction,Source,Target
Get-NetDomain
Get-NetDomainController
Get-NetForest
Get-NetDomainTrust

## Event Logging ##
#
## General
#
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



