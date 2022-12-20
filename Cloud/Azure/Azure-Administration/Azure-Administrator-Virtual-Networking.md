# Azure Administrator - Virtual Networking



Virtual Networks consist of one of more IP ranges that are typically from RFC 1918, but not exclusively. 

- Exists within a specific subscription
- Exists within a specific region
- The only public IPs avaliable are the one granted by Azure
- Subnet creation lose **five** addresses: all 0s, 256, Azure Default Gateway, next two address after the Default gateway will be lost to DNS.
	- /29 - would only have 3 addresses as you always lose the 5 above

#### Creating 
- Connect to Resource Group
- Name with naming convention
- IP address space, can add multiple and IPv6 - the automatic ones are drawn from Azure analyzing your own IP spaces
- Remember Azure takes 5 addresses before sizing!


The Virtual Network should be broken up into subnet ranges like on-premise to manage the networking. Avaliablity Zones (AZ)s can be spanned acrossed by a subnet, resources in a subnet need to be alignment of resources avaliable from a AZ dimension.


- IP always comes via fabric (Azure) OS using DHCP - can configure per OS basis 
- IPs can be reserved in ARM
	- For Domain Controllers
- VMs can have multiple NICs
- Each NIC can be in a different virtual subnet in the same virtual network or different subnets
- Multiple IP configuration per NIC
- IP configuration can have Public and Private IP
	- Public IP is internet routable - Just DO NOT!
		- Use Resilience Services -  Load balance, Firewall in front of VM not Public IPs for VMs!
	- Instance Level Public - VM processes by Private IP

![](azure-virtualnetworking-diagram.excalidraw)

- VMs are placed in the subnet, in actuality you are placing NIC in the subnet and connecting it to the VM. 
- Azure tracks the IP addresses as deallocation and reallocation will result in a VM getting probably a different IP. 
- A VM can have multiple NICs to connect to multiple subnets, but not can not span multiple Virtual Networks, it can still connect to another VNet just not span! 

Ensure static IP on a VM:
`Virtual  Machines -> $VMnames -> Network Interface -> IP configuration -> Static | Dynamic` 

IP forwarding from a VM - for Firewalls and Gateway devices
`Virtual  Machines -> $VMnames -> Network Interface -> IP forwarding  set to (Disabled | Enabled)`

#### Supported Types of IP Traffic

- Standard IP-based Protocol support include:
	- TCP
	- UDP
	- ICMP

Some outside of the above may work, but Load balances may not understnad

- Multicast, broadcast IP-in-IP encapsulated packets and Generic Routing Encapsulation (GRE) is blocked! 
	- This is Software defined networking, this is not Virtual LAN - no [[OSI]] Layer 2
- Cannot `ping` the Azure Gateway or use `tracert` these are abstractions in software! 
	- There is no traffic to sniff, it is all direct!
	- VNet is the isolation
- Traditional Layer 2 VLANs are not Supported

#### IPv6

- Virtual Networks are dual stack enabling IPv4 and IPv6 address ranges assigned
	- The Azure Health probes use IPv4
- IPv6 supported in NSGs, UDR and LB (Loadbalancers), peering
	- Kubernetes is work in progress, but also is dual stack
- Can enable IPv6 existing resources - may require reboot - DHCP addressing
- No ExpressRoute (on-premises to Azure) IPv6
- Public IPs can be IPv4 or IPv6
- IPv6 has to be `/64`  - for interoperability

#### External Access

BIG WARNING - **Use Network Security Groups** - The defaults are dangerous 

- There is no special DMZ subnet!
- Public IP on a load balancer to then resolve to resources - segment 
- From VM in Virtual Network Azure enables SNAT and PNAT
	- Stateful (let the response return to VM) internet access from virtual network resources 
	- If VM is behind a Load Balance with public IP in place, it will use the Load Balancer
		- If it is a **Basic** Load Balancers and does not have a Public IP it will create one
		- If it is a **Standard** Load Balancer, it will use its Public IP if it does not have a Public IP then there is no access
			- If the later another route must be taken:
				- Either outbound rules on an externally facing Load Balancer
				- NAT gateway for outbound commutications
		- If there is no Load Balancer! WARNING
			- Azure will automatically create Public IPs and allow internet access
- Ports exposed - Use encrypted variants - [[Nmap-Cheatsheat]] is easy to use to find your RDP and SSH , SMB that is externally facing, just don't - obsfucation is not security.
	- Just-In-Time access is avaliable if you don't have private routing. Do not expose services to internet continually

#### Connecting Virtual Neworks

If you have multiple subscription or region you then will have multiple virtual networks to connect them via:
- Virtual Network Peering 
	- Same or different Region
	- IP address space CANNOT overlap
	- Ingreess and egrees charge for using Azure Backbone
	- Span subscriptions and AAD tenants
	- Peers are not transitive, but they could be via (if Hub is parent and nth number of Spokes are child nodes and Vnets of a network):
		- Peering segmented Spoke Vnets
		- Vnet Hub could with user defined routing - **Beware the Capacity and Scaling of Routing Appliance in the Hub!** 
			- Vnet Hub has a route table for peering between Spoke VNets 
			- Solution: Forwarding to the Hub from Spoke 1 to another Spoke 2 . 

Historic comparison being: Site-to-Site VPN or connection to the same ExpressRoute:
- Peering location would hair pin on a circuit to talk to the same facility on different Virtual Network - bad latency

On-premise to an Azure subnet Gatewaycan be used to connect resources via Gateway transit, becuase of Peering to reach out to On-Premise assets. 
