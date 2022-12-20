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

#### Connecting On-Premises to Azure

Extending On-Premise to Azure with  [[Ipsec]] tunnels:
- Point-To-Site VPN - connect specific device to a network.
- Site-To-Site VPN - connect a network to virtual network 
	- Good if ExpressRoute is too expensive
	- S2S VPN gateways enable multiple VPN connects to different networks if route not policy based
	- ExpressRoute Private Peering - Connects a network to a virtual network via ExpressRoute Gateway
		- ExpressRoute circuits enable multiple virtual networks to be connected to a single circuit, but vnet to vnet better via peering - Big Enterprises want this for it being a private connection, no hops else where connect to Microsoft Backbone Network - not Geopolitical Region locked at the Premium level.
		- Can be encrypted, but is not by default - MaxSEC at the edge router provider 
		- If Fast Path is Enabled it does not go via the Gateway, Gateway is required for routing information, also Fast Path does working for Peering.
		- MPLS can be connect to backend at carrier neutral connect that can also connect ExpressRoute
	- Microsoft Peering - Can go by Private Endpoints as well as ExpressRoute
		- Storage
		- Database Accounts


#### Controlling Traffic Flows

Default traffic will flow freely. Azure requires segmentation and traffic controls within a virtual networks and/or external a number of approaches can be utilized.

- Azure Firewalls
- Network Security Groups 
	- Listing a rules that a scoped by:
		- Source 
		- Destination
		- Protocol 
		- Port
		- Action
		- CIDR
	- And Applied at various levels - enforced a the virtual filtering platform at the NIC
	- Inheritance

Create Network Security Group
`Search -> Network Security Group` - Then use brain in relation to network and security objectives 

`Service Tag` maps to IP ranges that manage the ranges

Application Security Groups - ASG tags are tags that help when the network is sparse that helps in  rule keeping instead worrying about IP ranges the application is in.

#### Service Endpoints and Service Endpoints Policies

NSGs are focused on traffic inot and out of the virtual network, Azure PaaS options have built-in Firewalls to often restrict a service to only spoecific subnets of specific virtual networks.Service endpoints make a specific subnet known to specific Azure service and add optimal path to service.

- Virtual firewalls on service are configurable to allow only a specific subnet
- Service Enpoint Policies allow specific instances of services to be allowed from a virtual network, which is not possible with NSG service Tag
- Service Endpoints are not routeable


#### Azure DNS

Virtual Network can use Azure DNS or custom DNS, Azure can provide public and private zones. Set at NIC level not at the VM level.
- Private DNS Zone - you pick the name and managed fully - names, records, etc!
- Domain Controllers - for custom DNS Active Directory - probably not Public 
- Private DNS can set auto-registration 
- Private DNS can be used across subscriptions, regions! - PERMISSIONS!
- Azure DNS 168.63.129.16

#### Azure Private Link

Azure Private Link is when a external facing Azure PAaS serfvice is accessed from a resource in a VNet the trafffic sztays on the Azure network. Priave Endpoint into a Network. The PaaS service stil ahas a external facing endpoint that some companies do not want even with firewall/authenication - firewalls and authenication are bypassable. APL enables PaaS Service is an avatar for that service instance and can project custom services that are behind a Load Balancer. Must have consistent DNS management!


[John Savill's Microsoft Azure Master Class Part 6 - Networking](https://www.youtube.com/watch?v=K8ePZdLfU7M&t=3511s)
