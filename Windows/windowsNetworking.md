# Windows Networking And Services

## Essentials

CLI is fast, efficient and powerful; a few exploits require GUI use Remote Desktop Protocol (RDP).

```bash
remmina
rdesktop
xfreerdp
```

## Basic Commands
[See full listing](/windowsNetworkCMD)  

ifconfig to inspect IPv4 and IPv6 addresses, subnet mask and default gateway
```powershell
ipconfig /all
ipconfig /release "Ethernet adapter Ethernet"
ipconfig /renew "Ethernet adapter Ethernet"
ipconfig /displaydns
ipconfig /flushdns
```
systeminfo also displays various network related properties:
```powershell
systeminfo
systeminfo /s computer1 /u user\domain1 /p password
```
set without switches or options displays all current environment variables 
```powershell
set
set VAR # for specific environment variables
```

Beware!! Some services are necessary for computers with Windows to run.

# Name Resolution:

NetBIOS1 was originally created as a Layer 5 (OSI model2) protocol to connect devices to each other within a Local Area Network (LAN). As time went on, there was a higher demand in requiring data to traverse outside of the LAN. 
Because packets needed to be routed externally, NetBIOS was eventually updated to a Layer 4 protocol, called NetBIOS over TCP/IP (NetBT).3 
By default, NBT runs on ports 137 (TCP/UDP), 138 (UDP), and 139 (TCP). 
While NBT is similar to DNS in that it resolves IP addresses to host/domain names, DNS is a layer 7 protocol (port 53 - TCP/UDP) and is more scalable due to its hierarchical naming structure.

windows hosts file is lcoated in %SystemRoot%\System32\drivers\etc

SMB port 139 445
net share # to configure
net use # to connect


# Remote Administration:

Windows Sysinternals1 is a collection of freeware tools that can assist in things like diagnosing, troubleshooting, and managing Windows systems. 
Psexec2 is one of the CLI tools within the Sysinternals suite that has many features, 
but one of the more prominent features is the ability to launch command prompts on remote devices.

netsh advfirewall set allprofiles state on # turn it all 

C:\WINDOWS\system32>netsh advfirewall firewall add rule ?

The number of arguments provided is not valid. Check help for the correct syntax.

Usage: add rule name=<string>
      dir=in|out
      action=allow|block|bypass
      [program=<program path>]
      [service=<service short name>|any]
      [description=<string>]
      [enable=yes|no (default=yes)]
      [profile=public|private|domain|any[,...]]
      [localip=any|<IPv4 address>|<IPv6 address>|<subnet>|<range>|<list>]
      [remoteip=any|localsubnet|dns|dhcp|wins|defaultgateway|
         <IPv4 address>|<IPv6 address>|<subnet>|<range>|<list>]
      [localport=0-65535|<port range>[,...]|RPC|RPC-EPMap|IPHTTPS|any (default=any)]
      [remoteport=0-65535|<port range>[,...]|any (default=any)]
      [protocol=0-255|icmpv4|icmpv6|icmpv4:type,code|icmpv6:type,code|
         tcp|udp|any (default=any)]
      [interfacetype=wireless|lan|ras|any]
      [rmtcomputergrp=<SDDL string>]
      [rmtusrgrp=<SDDL string>]
      [edge=yes|deferapp|deferuser|no (default=no)]
      [security=authenticate|authenc|authdynenc|authnoencap|notrequired
         (default=notrequired)]


# Services



## Remote Desktop Protocol(RDP)


