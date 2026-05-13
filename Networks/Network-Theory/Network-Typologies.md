# Network-Typologies

| **Network Type**                   | **Definition**                               |
| ---------------------------------- | -------------------------------------------- |
| Wide Area Network (WAN)            | Internet                                     |
| Local Area Network (LAN)           | Internal Networks (Ex: Home or Office)       |
| Wireless Local Area Network (WLAN) | Internal Networks accessible over Wi-Fi      |
| Virtual Private Network (VPN)      | Connects multiple network sites to one `LAN` |
| Global Area Network (GAN)          | Global network (the Internet)                |
| Metropolitan Area Network (MAN)    | Regional network (multiple LANs)             |
| (Wireless) Personal Area Network   | (WPAN) Personal network (Bluetooth)          |
WAN 
- is identifiable by *WAN Specific routing protocol such as BGP and if the IP Schema in use is not within RFC 1918 (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16).*

LAN
- [[VLAN]]

VPN
- Site-to-Site VPNs
	- Both server and client are Network Devices, generally to join company networks together
- Remote Access VPNs
	- Computer creates a virtual interface that behaves as if it is on a client's network
	- If the VPN only creates routes for specific networks (ex: 10.10.10.0/24), this is called a `Split-Tunnel VPN`, meaning the Internet connection is not going out of the VPN
- SSL VPN
	- VPN in web browser to generally stream applications or entire desktop sessions to your web browser

 GAN 
 - The Internet
 - Some companies have multiple WANs that are then connect together
 - GANs use the glass fibres infrastructure of wide-area networks and interconnect them by international undersea cables or satellite transmission.

MAN 
- A broadband telecommunications network that connects several LANs in geographical proximity

(W)PAN
- Sometimes Ad hoc network of smart devices
## References

[HTB Academy Introduction to Networks](https://academy.hackthebox.com/app/module/34/section/298)