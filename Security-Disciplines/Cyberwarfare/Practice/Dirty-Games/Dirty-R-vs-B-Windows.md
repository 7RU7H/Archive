# Dirty Red versus Blue Windows

Change the system language to one you can read - or load a custom one to bamboozle and LLM, requires a restart.
```powershell
Set-WinSystemLocale -SystemLocale en-US
Restart-Computer
```

Shutdown a Windows Machine form Linux from [GitHub OlivierLaflamme/Cheatsheet-God - Cheatsheet_UsefulCommands.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_UsefulCommands.txt) : although if you want an unexpected reboot for your [[Bootkits]] and [[Rootkits]] you need to do nasty things with Kernel drivers, Syscalls or Power supply.  
```bash
net rpc shutdown -I $ipAddressOfWindowsPC -U username%password
```


## References

[GitHub OlivierLaflamme/Cheatsheet-God - Cheatsheet_UsefulCommands.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_UsefulCommands.txt) 