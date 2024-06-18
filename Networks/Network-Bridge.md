# Network Bridge

[Wikipedia - Network Bridge](https://en.wikipedia.org/wiki/Network_bridge) *"A network bridge is a [computer networking device](https://en.wikipedia.org/wiki/Networking_hardware "Networking hardware") that creates a single, aggregate network from multiple [communication networks](https://en.wikipedia.org/wiki/Communication_network "Communication network") or [network segments](https://en.wikipedia.org/wiki/Network_segment "Network segment")."*

Ethernet bridge in Debian-based Linux Distributions
```bash
# Install bridge-utils
sudo apt-get install bridge-utils

# Disable network-manager + firewall

# Configuration
ifconfig
ifconfig eth0 0.0.0.0
ifconfig eth1 0.0.0.0
brctl addbr br0
brctl addif br0 eth0
brctl addif br0 eth1
ifconfig mybridge up
dhclient br0 on devices

sudo tcpdump -i mybridge
```

[man brctl](https://linux.die.net/man/8/brctl) *"`brctl` is used to set up, maintain, and inspect the ethernet bridge configuration in the linux kernel. An ethernet bridge is a device commonly used to connect different networks of ethernets together, so that these ethernets will appear as one ethernet to the participants. Each of the ethernets being connected corresponds to one physical interface in the bridge. These individual ethernets are bundled into one bigger ('logical') ethernet, this bigger ethernet corresponds to the bridge network interface."*


## References

[GitHub OlivierLaflamme/Cheatsheet-God Cheatsheet_Networking.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_Networking.txt)
[Wikipedia - Network Bridge](https://en.wikipedia.org/wiki/Network_bridge) 
[man brctl](https://linux.die.net/man/8/brctl) 