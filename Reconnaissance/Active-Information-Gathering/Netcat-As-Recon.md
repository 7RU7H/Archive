# Netcat-As-Recon

For full cheatsheet see: [[Netcat-Cheatsheet]]

The simplest TCP port scanning technique sometimes called CONNECT scanning uses `nc` is this case to perform successful three-way TCP handshake.  

```bash
nc -nvv -w 1 -z $ip $port_or_portrange
```

For UDP scanning 
```bash
 $ip $port_or_portrange
```
If port is open then the packet is passed to the application layer and the response received back will entirely depend on the application's handling of empty packets. Some UDP scanner use the message `ICMP port unreachable` to infer status of a port; this is unreliable when port is filtered be a firewall and scanners will infer it being as open due to there not being the aforementioned message.