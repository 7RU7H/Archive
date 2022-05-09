# Port Knocking
[As a security conecpt is has positives and negative but generally consider bad](https://security.stackexchange.com/questions/1194/port-knocking-is-it-a-good-idea), MITM attacks sniff packets or if the knock-daemon fails via log file mismanagement.

## Knock
```bash
apt-get install knockd
knock $ip $ports-space-seperated
```

## Nmap/bash
Refactored one-liner provided by[sushant747](https://sushant747.gitbooks.io/total-oscp-guide/content/port_knocking.html) into a script found at my [AllTheHackingScripts]()
```bash
# Set $IP and replace $X with port number to knock
for port in $X; do nmap -Pn --host_timeout 201 --max-retries 0 -p $port $IP; done;
```

## Netcat
```bash
nc $IP $PORT
nc $IP $PORT
nc $IP $PORT
nc $IP $PORT
```

## References

[sushant747](https://sushant747.gitbooks.io/total-oscp-guide/content/port_knocking.html)