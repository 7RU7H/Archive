# VLAN


#### Configuring an Ethernet interface as a VLAN trunk

[networkacademy.io - vlan Trunking](https://www.networkacademy.io/ccna/ethernet/vlan-trunking) summarised VLAN trunking is create one link between two switches that connect to both VLANs to reduce issues of Network scaling.

Updated Markdown Mirror of [OlivierLaflamme/Cheatsheet-God - Cheatsheet_Vlans.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_Vlans.txt)

Suppose that a host requires access to two VLANs, both carried by a trunk connected to physical interface eth0. The assigned IP addresses for the host are 192.168.2.1/24 on VLAN 2 and 192.168.3.1/24 on VLAN 3.
```bash
# First install the vlan package if it is not already present:
apt-get install vlan
# Turn off network-manager
sudo stop network-manager
# Configuring interfaces
vconfig add eth0 <VLAN ID>  # (you may get a warning message on the first one)
# example: 
vconfig add eth0 101

ifconfig eth0.<VLAN ID> <IP Address>/24 up
# example:
ifconfig eth0.101 192.168.1.10/24 up

ifconfig eth0.<VLAN ID>

#  Remove Configuration
vconfig rem eth0.101
```
Note: If any issues run, `ifconfig eth0 0.0.0.0 up`
Note: Specify interface with nmap scanning (`nmap -e eth0.101`)
Note: You will probably need to add individual routes for each vlan if you want to communicate between vlans, don't rely on your default gateway. (route add)

#### VLAN Hopping
Updated from [GitHub OlivierLaflamme/Cheatsheet-God Cheatsheet_Networking.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_Networking.txt)
```bash
git clone https://github.com/nccgroup/vlan-hopping.git
cd vlan-hopping && chmod 700 frogger.sh
./frogger.sh
```

## References

[GitHub OlivierLaflamme/Cheatsheet-God Cheatsheet_Networking.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_Networking.txt)
[networkacademy.io - vlan Trunking](https://www.networkacademy.io/ccna/ethernet/vlan-trunking)