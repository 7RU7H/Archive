# Secure Network Architecture

#### Segmentation with VLANs

[CISCO](https://documentation.meraki.com/General_Administration/Tools_and_Troubleshooting/Fundamentals_of_802.1Q_VLAN_Tagging) states: *"Virtual local area networks, or VLANs, can be used to segment traffic within a network in combination with subnetting. VLANs keep traffic from different networks separated when traversing shared links and devices within a topology. This process, also known as VLAN tagging, is invaluable to limiting broadcast network traffic and securing network segments. VLAN tagging is an integral part of networks of all sizes and is supported on MX security appliances, MR access points, and MS series switches."* Terms to consider from the same article include:
- Trunk - A port enabled for VLAN tagging ([Configuring Access and Trunk Interfaces](https://www.cisco.com/c/en/us/td/docs/switches/datacenter/nexus5000/sw/configuration/guide/cli_rel_4_0_1a/CLIConfigurationGuide/AccessTrunk.html#wp1206599 "https://www.cisco.com/c/en/us/td/docs/switches/datacenter/nexus5000/sw/configuration/guide/cli_rel_4_0_1a/CLIConfigurationGuide/AccessTrunk.html#wp1206599"))
- Access - A port that does not tag and only accepts a single VLAN ([Configuring Access and Trunk Interfaces](https://www.cisco.com/c/en/us/td/docs/switches/datacenter/nexus5000/sw/configuration/guide/cli_rel_4_0_1a/CLIConfigurationGuide/AccessTrunk.html#wp1206599 "https://www.cisco.com/c/en/us/td/docs/switches/datacenter/nexus5000/sw/configuration/guide/cli_rel_4_0_1a/CLIConfigurationGuide/AccessTrunk.html#wp1206599"))
- Encapsulation - The process of modifying frames of data to include additional information
- Native VLAN - The VLAN associated with all untagged traffic on a trunk
- For the stake of non-bias the Wikipedia article states [IEEE 802.1Q](https://en.wikipedia.org/wiki/IEEE_802.1Q) often referred to as **Dot1q**, is the [networking](https://en.wikipedia.org/wiki/Computer_network) standard that supports [virtual local area networking](https://en.wikipedia.org/wiki/Virtual_local_area_network "Virtual local area network") (VLANs) on an [IEEE 802.3](https://en.wikipedia.org/wiki/IEEE_802.3 "IEEE 802.3") [Ethernet](https://en.wikipedia.org/wiki/Ethernet "Ethernet") network.

- [Open vSwitch](https://www.openvswitch.org/) is an open source virtual switch
```bash
ovs-vsctl set port <interface> tag=<0-99>
# Native VLAN for any traffic that is not tagged that passes through the switch
ovs-vsctl set port eth0 tag=10 vlan_mode=native-untagged
# New bridge 
ovs-vsctl add-port br0 
# Add an interface to a bridge to create a trunk (port enabled for tagging)
ovs-vsctl add-port br0 eth0 tag=10
```

[VyOS](https://vyos.io/)
```bash
# Adding a new virtual sub-interface 
set interfaces ethernet eth0 vif 10 description 'VLAN 10'
# Configure addressing
set interfaces ethernet eth0 vif 10 address '192.168.100.1/24'
```

#### Zonal Network Architecture

Zone | Description
--- | --- 
External | All devices and entities outside of trusted network or asset control
DMZ | Separation between internal and external resources
Trusted | Internal networks or device (without sensitive information stored)
Restricted | Mission Critical Servers and Databases
Management | Network Management devices only
Audit | Security services or devices

#### Network Security Policies and Controls

Traffic Filtering
- Access Control Lists
	- Contains Access Control entries (rules that define profiles based on pre-defined criteria - source and destinations addresses, MAC address)
	- [Cisco](https://www.cisco.com/c/en/us/td/docs/routers/asr9000/software/asr9k_r4-0/addr_serv/command/reference/ir40asrbook_chapter1.html#:~:text=An%20access%20control%20list%20(ACL,queueing%2C%20and%20dynamic%20access%20control.)) uses ACLs for traffic filtering, priority or custom queuing, and dynamic access control.

```bash
# Create the new access-list policy, defining the ACL number (1 - 2699)
set policy access-list <acl_number>
# Set the description of the access list.
set policy access-list <acl_number> description <text>
# Create an ACE for a the ACL and define the action of the rule
set policy access-list <acl_number> rule <1-65535> action <permit|deny>
# Define criteria or parameters for the rule to enforce/match.
set policy access-list <acl_number> rule <1-65535> <destination|source> <any|host|inverse-mask|network>
```

## References

[CISCO Meraki VLAN tagging](https://documentation.meraki.com/General_Administration/Tools_and_Troubleshooting/Fundamentals_of_802.1Q_VLAN_Tagging) 
[Wikipedia IEEE 802.1Q](https://en.wikipedia.org/wiki/IEEE_802.1Q)
[Open vSwitch](https://www.openvswitch.org/)
[VyOS](https://vyos.io/)
[Cisco ACL usage](https://www.cisco.com/c/en/us/td/docs/routers/asr9000/software/asr9k_r4-0/addr_serv/command/reference/ir40asrbook_chapter1.html#:~:text=An%20access%20control%20list%20(ACL,queueing%2C%20and%20dynamic%20access%20control.)) 
[THM Introduction to Security Architecture](https://tryhackme.com/room/introtosecurityarchitecture)