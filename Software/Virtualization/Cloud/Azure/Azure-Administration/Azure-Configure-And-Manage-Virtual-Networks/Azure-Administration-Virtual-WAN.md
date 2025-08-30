# Azure Administration - Virtual WAN

Azure Virtual Wide Area Network (WAN) is a unified framework for networking, security, and routing. The Azure Virtual WAN (wide-area network) networking service combines networking, security, and routing functionalities into a single operational interface.
- Azure Virtual WAN is a hub-and-spoke architecture
- Microsoft-managed
- Azure-based networking service
- Enables any-to-any connectivity to workloads distributed globally in virtual networks
- Connect Virtual Hubs together to access each's spokes 
- Secured with Azure Firewall Manager

Azure Virtual WAN is a consolidated networking service that provides Network, security and routing functionalities in a single operational interface. Azure Virtual WAN is a Software Defined WAN (SD-WAN) is better way to route to your branches, datacenters, VNet and cloud services.
- Branch Connectivity
- Site-to-site
- Remote User VPN
- Connectivity, private (ExpressRoute) connectivity
- Intra-cloud connectivity (transitive connectivity for virtual networks)
- VPN ExpressRoute inter-connectivity
- Routing
- Azure Firewall encryption for private connectivity

![](azurewansimage.png)
Typology:
-  **Basic**: A Basic Virtual WAN can be implemented only in an S2S VPN connection.
	- Site-to-site VPN only
-  **Standard**: A Standard Virtual WAN can be implemented with Azure ExpressRoute and a User VPN (P2S). You can also use a Standard WAN with an S2S VPN, Inter-hub, and VNet-to-VNet connection transiting through the virtual hub.
	- Full-mesh connectivity
	- ExpressRoute
	- User VPN (P2S)
	- VPN (site-to-site)
	- Inter-hub
	- Virtual Network-to-Virtual Network transiting through the virtual hub

Terminology:
- A Point of Presence (PoP) is an entry at the edge a Network
- A Hop is when you change networks
- Multi-Protocol Label Switching (MPLS) a method of packet forwarding where instead of using IP address and Layer 3 information to make forwarding decisions an MPLS label is used to determine the shortest route to end destination.
- Software Defined WAN (SD-WAN) decouples CPU intensive tasks from router such as Management, Operations and the Control plane that can now be controlled in a central location remotely and virtually at your headquarters:
	- Replace MLPS, so you traverse the internet instead of a private network
	- More cost effective require less configuration than an MLPS initially and at scale
	- Secure because you will use HTTPS which is supported by your ISP

- Components
	- Virtual Hub: All traffic flows through these fully meshed hubs
	- Hub-to-Hub connection
	- Virtual Hub Router: Supports custom route tables for virtual networks, acts as default route table for branch
	- Supported connections between sites:
		-  Any-to-any branch to Azure
		- Branch to branch
		- Users to branch
		- Virtual network to virtual network transit
		- VPN to ExpressRoute transit connectivity.
	- Secure Virtual Hub with Azure Firewall Manager - [[Azure-Administration-Azure-Firewall]]: 
		- Create policy and apply across multiple firewalls
		- Work across regions/subscription/deployments
		- Secure internet traffic (virtual network to internet and branch to internet)
		- Secure private traffic (virtual network to and from a branch)
	- Secure with Security-as-a-Service (SECaaS) partners with  Firewall Manager's API to set up security policies:
		- zScaler
		- iBoss
		- Check Point

Enterprises can choose the follow types of WAN
![](azureenterprisechoicesofwan.png)
Azure Virtual WAN is beneficial for organisations that:
- Need to manage the traffic between the user and the destination.
- Provide automatic connections between company services in other regions.
- Want to take advantage of a global service using Azure global transit network.
- Use automated spoke setup and configuration.
- Take advantage of enhanced WAN performance without sacrificing security.
- Use optimal routing through virtual network connections with low latency and high bandwidth.
- Use firewall protection with security policy managed by Azure Firewall Manager.

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)