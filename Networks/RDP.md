# Remote Desktop Protocol (RDP) 

Beware - On Windows 11, [Network Level Authentication (NLA)](https://en.wikipedia.org/wiki/Network_Level_Authentication) is enabled by default for all RDP connections.

```bash
remmina
xfreerdp /u:$username /p:$Password /v:$IP
rdesktop $ip
```

For non domain-joined machines `rdesktop` won't connect; use `xfreerdp` instead, which supports NLA for non domain-joined machines. `xfreerdp` allows for  [[Pass-The-Hash]]:
```bash
xfreerdp /v:$IP /u:DOMAIN\\Administrator /pth:$ntml
```


## References

[Wikipedia Network Level Authentication (NLA)](https://en.wikipedia.org/wiki/Network_Level_Authentication)