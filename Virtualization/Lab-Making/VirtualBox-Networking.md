
## Setup an Internal Network

[Video explaination from CyberStudies](https://www.youtube.com/watch?v=lm_4hoe-K7U)

```bash
vboxmanage list dhcpservers
# A DHCP server 
# --lower-ip is the lower bound of the range of IP handed out by the DHCP
vboxmanage dhcpserver add --network=intnet --server-ip=192.168.56.100 --netmask=255.255.255.0 --lower-ip=192.168.56.101 --upper-ip=192.168.56.110 --enable
```