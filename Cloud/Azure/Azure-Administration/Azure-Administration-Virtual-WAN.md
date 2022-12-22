
# Azure Administration - Virtual WAN

Azure Virtual WAN is consolidated networking service that provides Network, security and routing functionalities in a single operational interface. Azure Virtuual WAN is a Software Defined WAN (SD-WAN) is better way to route to your branches, datacenters, VNet and cloud services.
- Branch Connectivity
- Site-to-site
- Remote User VPN
- Connectivity, private (ExpressRoute) connectivity
- Intra-cloud connectivity (transitive connectivity for virtual networks)
- VPN ExpressRoute inter-connectivity
- Routing
- Azure Firewall encryption for private connectivity

Terminology:
- A Point of Presence (PoP) is an entry at the edge a Network
- A Hop is when you change networks
- Multi-Protocol Label Switching (MPLS) a method of packet forwarding where instead of using IP address and Layer 3 information to make forwarding decisions an MPLS labal is used to determine the shortest route to end destination.
- Software Defined WAN (SD-WAN) decouples CPU intensive tasks from router such as Management, Operations and the Control plane that can now be controlled in a central location remotely and virtually at your headquanters:
	- Replace MLPS, so you traverse the internet insteead of a private network
	- More cost effective require less configuration than an MLPS initially and at scale
	- Secure because you will use HTTPS which is supported by your ISP

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)