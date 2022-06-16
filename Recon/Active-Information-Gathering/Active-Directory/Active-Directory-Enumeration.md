# Active Directory Enumeration

For exploitation see [[AD-Exploitation-Hub]] or general theory and definitions [[Active-Directory-Defined]]



## Credential Injection 
The  `runas.exe` with AD credentials of a user of a AD forest.
```bash
runas.exe /netonly /user:<domain>\<username> cmd.exe
```

The flag `/netonly` allows loading of credentials for network authentication, but will not be verified directly by a DC. If hosting a Windows Box tt is required to when run with Administrative privileges.


When using a Windows Box you can verify the credentials by listing `SYSVOL`. Any account and Domain-joined computers  can read `SYSVOL`, it is located on the DC and is a shared folder storing the Group Policy Objects (GPOs).

But we may need to configure DNS if is has not been through VNP or DHCP 
 
```powershell
$dnsip = "<DC IP>"
$interface = "<Interface>"
$index = Get-NetAdapter -Name $interface | Select-Object -ExpandProperty 'ifIndex'
Set-DnsClientServerAddress -InterfaceIndex $index -ServerAddresses $dnsip
```
c d