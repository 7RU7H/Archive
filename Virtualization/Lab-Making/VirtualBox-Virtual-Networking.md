# VirtualBox Virtual Networking


[Abstract Programmer's explaination of VirtualBox networking](https://www.youtube.com/watch?v=2Fkf6Kysh7I) is possible the best explainations and demonstrations for each type of Virtual Networking configuration in VirtualBox, although is for an older version of VirtualBox contains caveats for each. [He references this forum post from Scottgus](https://forums.virtualbox.org/viewtopic.php?t=96608)




## Setup a Internal Network

Setup a DHCP server to allocate IPs in a virtual network. From a [video explaination by CyberStudies](https://www.youtube.com/watch?v=lm_4hoe-K7U)

```bash
vboxmanage list dhcpservers
# A DHCP server 
# --lower-ip is the lower bound of the range of IP handed out by the DHCP
vboxmanage dhcpserver add --network=intnet --server-ip=192.168.56.100 --netmask=255.255.255.0 --lower-ip=192.168.56.101 --upper-ip=192.168.56.110 --enable
```

## Setup a Host Only 

Is like aInternal Network, but includes the Host.

## Setup a NAT Network

`Tools -> Network Manager -> Add -> Configure`
- Ensure all VMs have unique MAC address

## Setup a Bridged Adapter

VM with a Bridge Adapter is the most permissive and is akin to adding another physical machine. Beware WIFI 


## References

[VirtualBox Manual](https://www.virtualbox.org/manual/ch06.html)
[VirtualBox Forums - Scottgus1 post](https://forums.virtualbox.org/viewtopic.php?t=96608))
[Abstract Programmer's explaination of VirtualBox networking](https://www.youtube.com/watch?v=2Fkf6Kysh7I) 
[CyberStudies Video](https://www.youtube.com/watch?v=lm_4hoe-K7U)
