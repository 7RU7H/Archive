# Network Technologies      

# THIS IS JUST SCAFFOLDING - REVIEW OF NOTES INCOMING


[SheNetworks - Serena  DiPenti - BHIS] 




Layer 2 
```goat
MAC addresses - burn in hardware identifiers 

Broadcast 
Broadcast address ff:ff:ff:ff:ff:ff - can send information to every host in a network segment 

arp - datalink layer protocol used to discover and map other layer 2 devices
```



The Frame encapsulates the Packet that encapsulates the Segment 

Frame | Packet | Segment | whats left of the Frame
--- | --- | --- | ---
dstMAC, srcMAC |dstIP, srcIP |  TCPportNum, Data | FCS

IP Address Reservation
Private networks
Loopback network interface:
- starts with 127.
-  127.0.0.1 = localhost; allows local machines to run network service without exposing them remotely. 
Linklocal address - start with  169 - debug your internet 
Documentation
Multicast address

NAT - multiple IP address into one address 

Simplification of NAT - User browsers to a website
- Private IP of your device communicates with Router... 
- the Public Router (your router, it is public as it needs to communicate with other devidces other than the private ones) the Private IP of your device is translated to a Public address to communicate back a forth between.. 
- Public IP (probably IPS) that does a similar translation to get data from that internet website back to the router then router translates back to your Private IP 


Private IP Range Classes

Class | Start |  Finish |  Subnet | Addresses
--- | --- | --- | --- | ---
A |  10.0.0.0 | 10.255.255.255 | /8 | 16 Million
B | 172.16.0.0 | 172.31.255.255 | /16 | 65,000
C | 192.168.0.0 | 192.168.255.255 | /24 | 254

VLANs are not a security mechanism it use for OSI layer 1-4 management
- Prevent Broadcast noise 
- Segmentation  