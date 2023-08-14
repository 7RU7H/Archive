# Azure-Administration Virtual Networking Peering

Azure Virtual network peering is non-transitive meaning only directly peered can communicate. Peering in both directions and only if peered! [Azure Virtual Network peering](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview) lets you connect Virtual Networks in the same or different regions, so resources in both networks can communicate with each other, but are still managed separately. Azure Virtual Network peering does not require downtime for resources, utilises the Azure infrastructure simplifying and strengthening performance.  

You can connect to your on-premises network from a peered virtual network if you enable gateways transit from a virtual network that has a VPN gateway once Virtual Network are peered.

Peering Options:
- **Regional virtual network peering** connects Azure virtual networks that exist in the same region.
	- **Virtual network peering** connects virtual networks in the same Azure region
		- Cross-subscription Vnet Peering: Two Administrators must grant each other `Network Contributor` role as they are both separate Entra ID tenants
		- Second network is the remote network
			- -**When peering only one gets created configuration in the reverse direction is required!**
-  **Global virtual network peering** connects virtual networks that are in different Azure regions
Peering Restrictions:
- Global peering of virtual networks in different Azure Government cloud regions isn't permitted.
- China Cloud != Azure public cloud region != Microsoft Azure Government cloud region, the thee shall not mix!
-  `Network Contributor` or `Classic Network Contributor` role or Custom Role..

#### Service Chaining and (for) User-Defined Routes

**Service chaining** lets you define UDRs. These routes direct traffic from one virtual network to an NVA or VPN gateway.

**User-defined route (UDR)** is a Virtual network peering enables the next hop in a user-defined route to be the IP address of a virtual machine in the peered virtual network, or a VPN gateway. UDRs access route tables - [[Azure-Administration-Network-Routes-And-Endpoints]].
- Virtual network gateway
- Virtual network
- Internet
- Network virtual appliance (NVA)

![1080](azvnetservicechainingandudrs.excalidraw)

#### VPN Gateways and Connecting On-Premises to Azure

Organisations use a virtual private network (VPN) to create a private, encrypted connection for their resources and users to the internet using [[IPsec]] protocol. A VPN gateway is a specific type of virtual network gateway that's used to send encrypted traffic between your Azure virtual network and an on-premises location over the public internet or over the Azure backbone Microsoft network. Considerations:
- Vnet can have one VPN gateway with multiple connects to it sharing the bandwidth

Extending On-Premise to Azure with [[IPsec]] tunnels - see [planning table](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways#planningtable):
- Point-To-Site VPN - connect specific device to a network.
- Site-To-Site VPN - connect a network to virtual network 
	- Good if ExpressRoute is too expensive
	- S2S VPN gateways enable multiple VPN connects to different networks if route not policy based
- Vnet-To-Vnet with IPSec/IKE VPN tunnel
	- Cross-Region/Subscriptions/Deployment-model 
- [Highly Available]((https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-highlyavailable) - better VM availability due to redundancy
	- Active-Active - both VMs are active
	- Active-Standby - one is on standby in case of failover

Peering
- ExpressRoute Private Peering - Connects a network to a virtual network via ExpressRoute Gateway
	- ExpressRoute circuits enable multiple virtual networks to be connected to a single circuit, but VNet to VNet better via peering - Big Enterprises want this for it being a private connection, no hops else where connect to Microsoft Backbone Network - not Geopolitical Region locked at the Premium level.
	- Can be encrypted, but is not by default - MaxSEC at the edge router provider 
	- If Fast Path is Enabled it does not go via the Gateway, Gateway is required for routing information, also Fast Path does working for Peering.
	- MPLS can be connect to backend at carrier neutral connect that can also connect ExpressRoute
- Microsoft Peering - Can go by Private Endpoints as well as ExpressRoute
	- Storage
	- Database Accounts

- Plan your [Azure VPN Gateway solution](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways#planningtable)
- Peruse [Azure VPN Gateway documentation](https://learn.microsoft.com/en-us/azure/vpn-gateway/).
- Discover [VPN Gateway configuration settings](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings).
- Create and manage a [VPN gateway by using the Azure portal](https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-create-gateway-portal).
- Create a [Site-to-Site VPN connection in the Azure portal](https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-site-to-site-portal). 
- Explore [VPN Gateway design options: S2S, P2S, VNet-to-VNet, and high availability](https://learn.microsoft.com/en-us/azure/vpn-gateway/design).
- Review [highly available cross-premises and VNet-to-VNet connectivity](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-highlyavailable).
- Find [validated VPN devices and IPsec/IKE parameters for S2S VPN Gateway connections](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-devices)   

VPN Gateway requires: - subnet, DNS server and VPN device 
`Search -> Virtual Network Gateways -> + Create`
Select:
- VPN or ExpressRoute
- Gateway type
	- Route-based - uses routes in the IP forwarding or routing table to direct packets into their corresponding tunnel interfaces
	- Policy-based - encrypts and directs packets through IPsec tunnels based on the IPsec policies - configured with the combinations of address prefixes between your on-premises network and the Azure virtual network
- SKU, Generation (bytes per second), Names, RG, Vnet

Local Network Gateways - to represent the on-premises site that you want to connect to a virtual network
`Search -> Local Network Gateways -> + Create`
- (Advanced) Border Gateway Protocol (BGP) - routability and reachable protocol -  requires - the minimum prefix you need to declare is the host address of your BGP Peer IP address on your VPN device.

On-Premise VPN devices: shared key and public IP address of your VPN gateway
- Configuration scripts are available for some devices - [Download VPN device configuration scripts for S2S VPN connections](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-download-vpndevicescript) to find a downloadable script for your VPN device.


## Workflows

- Regional Virtual Network peering - Cloud, Public or Government Region 
- Global Virtual Network peering

You cannot:
- Peering different cloud types:  China Cloud != Azure public cloud region != Microsoft Azure Government cloud region

Configure a Azure VPN Gateway in a peered virtual network as a transit point between target Virtual Networks for peering.
- VPN gateway in the hub, not in peer networks
- Apply NSGs
- One VPN gateway, but can be all the following 
	- vnet-to-vnet
	- site-to-site
	- point-to-site

Vnet Peering - requires account with `(Classic) Network Contributor` role
`Search -> Virtual Networks -> $Vnet -> SEttings -> Peering -> Add(peering)` 
- Create in hub, not peers; make NSG rules!
- One Gateway to Transit them All - vnet-to-vnet, site-to-site and point-to-site
- Vnets must have resources, the first must be made with [[Azure-Administration-Azure-Resource-Manager]], the second is referred to as the remote network
-  [Permissions](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering?tabs=peering-portal#permissions)
- Extending Peering 
	- Hub and spoke network - Central hub for VPN gateway, spoke Vnets
	- User-defined route (UDR): either a hop to/from VM IP address or VPN Gateway
	- Service chaining: define UDRs from VNet to a network virtual appliance or VPN

RDP in and Test with:
```powershell
Test-NetConnection -ComputerName $ip -Port 3389 -InformationLevel 'Detailed'
```

- Gateway transit from VNet to On-premise via VPN gateway:
	- `$HubNetwork -> Allow gateway Transit` `
	- `SpokeNetwork -> Use remote gateways`


Query Vnet are Provisioned
```powershell
az network vnet list --query "[?contains(provisioningState, 'Succeeded')]" --output table
```

Create peering between two Vnets
```powershell
# Forward and Reverseing Peering is required
# Initial Forward Peering
az network vnet peering create \
    --name SalesVNet-To-MarketingVNet \
    --remote-vnet MarketingVNet \
    --resource-group $rgNameSales \
    --vnet-name SalesVNet \
    --allow-vnet-access
# Reverse peering between the inital Vnet Peering
az network vnet peering create \
    --name MarketingVNet-To-SalesVNet \
    --remote-vnet SalesVNet \
    --resource-group $rgNameMarketing \
    --vnet-name MarketingVNet \
    --allow-vnet-access

# Query Connection
az network vnet peering list \
    --resource-group $rgName \
    --vnet-name $VnetName \
    --query "[].{Name:name, Resource:resourceGroup, PeeringState:peeringState, AllowVnetAccess:allowVirtualNetworkAccess}"\
    --output table

# Check Effective Routes
az network nic show-effective-route-table \
    --resource-group $rgNameSales \
    --name SalesVMVMNic \
    --output table
    
# Ceck Effective Routes From the Reverse Peering
az network nic show-effective-route-table \ 
--resource-group $rgNameMarketing \ 
--name MarketingVMVMNic \ 
--output table
```

## References

[John Savill's Microsoft Azure Master Class Part 6 - Networking](https://www.youtube.com/watch?v=K8ePZdLfU7M&t=3511s)
[Vnet Peering Permissions](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering?tabs=peering-portal#permissions)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)