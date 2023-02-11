# Azure Administration - Virtual Networking


Virtual Networks consist of one of more Address Space(s) available IP ranges that are typically from RFC 1918, but not exclusively, which are allocating for you use within your VNet

- Exists within a specific subscription
- Region VNet Peering - Exists within a specific region, peering two Vnets in same regions
- Global VNet Peering - Exists within a different regions, peering two Vnets in two different two regions
- The only public IPs avaliable are the one granted by Azure
- Subnet creation lose **five** addresses: all 0s, 256, Azure Default Gateway, next two address after the Default gateway will be lost to DNS.
	- /29 - would only have 3 addresses as you always lose the 5 above

Network Interface Controller (NIC) - soft/hardware that interface between two device or protocol layer in a network communicating with IP

Azure Network Interfaces (NICs):
- Azure Network Interfaces are attached to azure VM instance
- Without an NIC, an Azure VM instance would have no way to communicate
- An Azure VM instance has to have an NIC and can have multiple NICs

Route Table is table of data stored in router or network host that list routes to next destinations
- By default Azure creates a route table with default routes (system routes) and associates them to your subnmets
- You can override the system routes assigned to your subnets by creating a new route table and associating with a subnet

Subnet is a logical division of an address space
- Subnet requires a Route Table for access
- Public and Prviate subnet describes whether a subnet is reachale from the internet or not
- Azure has no concept of private and public subnets 
	- **Configure subnets to have ensure they do no reach the internet!**
- Associate an NSG to protect traffic entering and leaving your subnet
- Azure has special types of Gateway Subnet that is used by Azure Virtual Network Gateway

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

![1000](azure-virtualnetworking-diagram.excalidraw.md)

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
- IPv6 supported in NSGslt Domains
- Newest VM - Delete the newest created VM, balanced across AZs, UDR and LB (Loadbalancers), peering
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

SMTP (port 25) is a special case. Depending on your subscription level and when your account was created, outbound SMTP traffic may be blocked.

#### Connecting Virtual Neworks

If you have multiple subscription or region you then will have multiple virtual networks to connect them via:
- Virtual Network Peering 
	- Same or different Region
	- IP address space CANNOT overlap
	- Ingreess and egrees charge for using Azure Backbone
	- Span subscriptions and AAD tenants
	- Peers are not transitive, but they could be via (if Hub is parent and nth number of Spokes are child nodes and Vnets of a network):
		- Peering segmented Spoke Vnets
		- Vnet Hub could with user defined routing - **Beware the Capacity and Scaling of Routing Appliance in thelt Domains
- Newest VM - Delete the newest created VM, balanced across AZs Hub!** 
			- Vnet Hub has a route table for peering between Spoke VNets 
			- Solution: Forwarding to the Hub from Spoke 1 to another Spoke 2 . 

Historic comparison being: Site-to-Site VPN or connection to the same ExpressRoute:
- Peering location would hair pin on a circuit to talk to the same facility on different Virtual Network - bad latency

On-premise to an Azure subnet Gatewaycan be used to connect resources via Gateway transit, becuase of Peering to reach out to On-Premise assets. 


#### VPN Gateways and Connecting On-Premises to Azure

Organizations use a virtual private network (VPN) to create a private, encrypted connection for their resources and users to the internet using [[Ipsec]] protocol.A VPN gateway is a specific type of virtual network gateway that's used to send encrypted traffic between your Azure virtual network and an on-premises location over the public internet or over the Azure backbone Microsoft network. Considerations:
- Vnet can have one VPN gateway with multiple connects to it sharing the bandwidth

Extending On-Premise to Azure with [[Ipsec]] tunnels - see [planning table](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways#planningtable):
- Point-To-Site VPN - connect specific device to a network.
- Site-To-Site VPN - connect a network to virtual network 
	- Good if ExpressRoute is too expensive
	- S2S VPN gateways enable multiple VPN connects to different networks if route not policy based
- Vnet-To-Vnet with  IPsec/IKE VPN tunnel
	- Cross-Region/Subscriptions/Deployment-model 
- [Highly Available]((https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-highlyavailable) -  better VM availbility due to redundancy
	- Active-Active - both VMs are active
	- Active-Standby - one is on standby in case of failover

Peering
- ExpressRoute Private Peering - Connects a network to a virtual network via ExpressRoute Gateway
	- ExpressRoute circuits enable multiple virtual networks to be connected to a single circuit, but vnet to vnet better via peering - Big Enterprises want this for it being a private connection, no hops else where connect to Microsoft Backbone Network - not Geopolitical Region locked at the Premium level.
	- Can be encrypted, but is not by default - MaxSEC at the edge router provider 
	- If Fast Path is Enabled it does not go via the Gateway, Gateway is required for routing information, also Fast Path does working for Peering.
	- MPLS can be connect to backend at carrier neutral connect that can also connect ExpressRoute
- Microsoft Peering - Can go by Private Endpoints as well as ExpressRoute
	- Storage
	- Database Accounts

-   Plan your [Azure VPN Gateway solution](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways#planningtable)
-   Peruse [Azure VPN Gateway documentation](https://learn.microsoft.com/en-us/azure/vpn-gateway/).
-   Discover [VPN Gateway configuration settings](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings).
-   Create and manage a [VPN gateway by using the Azure portal](https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-create-gateway-portal).
-   Create a [site-to-site VPN connection in the Azure portal](https://learn.microsoft.com/en-us/azure/vpn-gateway/tutorial-site-to-site-portal). 
-   Explore [VPN Gateway design options: S2S, P2S, VNet-to-VNet, and high availability](https://learn.microsoft.com/en-us/azure/vpn-gateway/design).
-   Review [highly available cross-premises and VNet-to-VNet connectivity](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-highlyavailable).
-   Find [validated VPN devices and IPsec/IKE parameters for S2S VPN Gateway connections](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-devices)   

VPN Gateway requires: - subnet, dns server and VPN device 
`Search -> Virtual Network Gateways -> + Create`
Select:
- VPN or ExressRoute
- Gateway type
	- Route-based - uses routes in the IP forwarding or routing table to direct packets into their corresponding tunnel interfaces
	- Policy-based -  encrypt and direct packets through IPsec tunnels based on the IPsec policies - configured with the combinations of address prefixes between your on-premises network and the Azure virtual network
- SKU, Generation (bytes per second), Names, RG, Vnet

Local Network Gateways - to represent the on-premises site that you want to connect to a virtual network
`Search -> Local Network Gateways -> + Create`
- (Advanced) Border Gateway Protocol (BGP) - routability and reachable protocol -  requires - the minimum prefix you need to declare is the host address of your BGP Peer IP address on your VPN device.

On-Premise VPN devices: shared key and public IP address of your VPN gateway
- Configuration scripts are available for some devices - [Download VPN device configuration scripts for S2S VPN connections](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-download-vpndevicescript) to find a downloadable script for your VPN device.

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

#### Configuring Network Routing and Endpoints

Azure uses *system routes* to control network traffic between virtual machines, on-premises networks, and the internet. Information about the system routes is recorded in a *route table*.
- The route table contains a set of rules (routes) specificying packet routing in a Vnet  
- Each packet leaving a subnet is handled by on associated route table
- Packets are matched to routes by using the destination.
- If matching route cannot be found it is dropped.

Azure automatically handles all network traffic routing, except in a custom configurations called User-Defined-Routes (UDRs): 
-  The valid next hop choices are virtual appliance, virtual network gateway, virtual network, internet, and none.
-  Administrators can create user routes, but not system routes.

Virtual Network (VNet) service endpoint provides secure and direct connectivity to Azure services over an optimized route over the Azure backbone network. Endpoints allow you to secure  Azure service resources to only your virtual networks. Service Endpoints enables private IP addresses in the VNet to reach the endpoint of an Azure service without needing a public IP address on the VNet.  Service endpoints for your service: 

-   **[Azure Storage](https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?toc=/azure/virtual-network/toc.json#grant-access-from-a-virtual-network)** (_Microsoft.Storage_): Generally available in all Azure regions.
-   **[Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/vnet-service-endpoint-rule-overview?toc=%2fazure%2fvirtual-network%2ftoc.json)** (_Microsoft.Sql_): Generally available in all Azure regions.
-   **[Azure Synapse Analytics](https://learn.microsoft.com/en-us/azure/azure-sql/database/vnet-service-endpoint-rule-overview?toc=%2fazure%2fvirtual-network%2ftoc.json)** (_Microsoft.Sql_): Generally available in all Azure regions for dedicated SQL pools (formerly SQL DW).
-   **[Azure Database for PostgreSQL server](https://learn.microsoft.com/en-us/azure/postgresql/howto-manage-vnet-using-portal?toc=/azure/virtual-network/toc.json)** (_Microsoft.Sql_): Generally available in Azure regions where database service is available.
-   **[Azure Database for MySQL server](https://learn.microsoft.com/en-us/azure/mysql/howto-manage-vnet-using-portal?toc=/azure/virtual-network/toc.json)** (_Microsoft.Sql_): Generally available in Azure regions where database service is available.
-   **[Azure Database for MariaDB](https://learn.microsoft.com/en-us/azure/mariadb/concepts-data-access-security-vnet)** (_Microsoft.Sql_): Generally available in Azure regions where database service is available.
-   **[Azure Cosmos DB](https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-configure-vnet-service-endpoint?toc=/azure/virtual-network/toc.json)** (_Microsoft.AzureCosmosDB_): Generally available in all Azure regions.
-   **[Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/general/overview-vnet-service-endpoints)** (_Microsoft.KeyVault_): Generally available in all Azure regions.
-   **[Azure Service Bus](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-service-endpoints?toc=/azure/virtual-network/toc.json)** (_Microsoft.ServiceBus_): Generally available in all Azure regions.
-   **[Azure Event Hubs](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-service-endpoints?toc=/azure/virtual-network/toc.json)** (_Microsoft.EventHub_): Generally available in all Azure regions.
-   **[Azure Data Lake Store Gen 1](https://learn.microsoft.com/en-us/azure/data-lake-store/data-lake-store-network-security?toc=/azure/virtual-network/toc.json)** (_Microsoft.AzureActiveDirectory_): Generally available in all Azure regions where ADLS Gen1 is available.
-   **[Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/app-service-ip-restrictions)** (_Microsoft.Web_): Generally available in all Azure regions where App service is available.
-   **[Azure Cognitive Services](https://learn.microsoft.com/en-us/azure/cognitive-services/cognitive-services-virtual-networks?tabs=portal)** (_Microsoft.CognitiveServices_): Generally available in all Azure regions where Cognitive services are available.

A virtual network _service endpoint_ provides the identity of your virtual network to the Azure service. After service endpoints are enabled in your virtual network, you can secure Azure service resources to your virtual network by adding a _virtual network rule_ to the resources.
- Secure with Vnet Rules
- Configured through th subnet
- Can extend your Vnet identity to your Azure Services - Database for a website...

Azure Private Link  provides private connectivity from a virtual network to Azure platform as a service (PaaS), customer-owned, or Microsoft partner services to simplify network architecture and secure connection between endpoints in Azure. 
- No exposure to internet keeps all traffic on the Microsoft global network.
- It can link anywhere
	- Privately deliver your own services in your customer's virtual networks.
	- Privately to services running in other Azure regions.
	- All traffic to the service can be routed through the private endpoint. No gateways, NAT devices, Azure ExpressRoute or VPN connections, or public IP addresses are required.

Implement Virtual Networking
`Search -> Virtual Network -> $Vnet (With Subnet, VMs, DNSm, NSGs, etc configured)` in the `Private DNS Zone -> Virtual Network Link -> + Add - provide a Link name, Vnet` 

#### Azure DNS 

Virtual Network can use Azure DNS or custom DNS, Azure can provide public and private zones. Set at NIC level not at the VM level. Azure DNS is not a domain registar!
- On subscription creation - automatic domain creation for it as `$yourdomainname.onmicrosoft.com`; to be used until your custom domain name is _verified_.
	- To initiate the verification process, add a DNS record for your custom domain name either a `MX` or `TXT` record
- Private DNS Zones: 
	- Private DNS Zone - you pick the name and managed fully - names, records, etc!
	- Private DNS can be used across subscriptions, regions! - PERMISSIONS!
	- Private DNS can set auto-registration 
	- No custom solution, automatic record and resolution managenment with various support - reduce the misconfigurations
- Domain Controllers - for custom DNS Active Directory - probably not Public 
- Newest VM - Delete the newest created VM, balanced across AZs
- Azure DNS 168.63.129.16
	- Root/Parent domain is registered at the registrar and then pointed to Azure DNS.
	- Child domains are registered directly in Azure DNS.
Consider reviewing [[Azure-Administration-Azure-DNS]] and [[DNS-Defined]] for futher information.

Be aware of the difference between DNS Record sets and individual records
- DNS Record sets  are collection of records
	- A DNS record set can't contain two identical records.
	- A record set of type `CNAME` can contain only one record.
	- Empty record sets do appear 

Workflows

Create DNS zones
`Search -> DNS zones`

To delegate your domain to Azure DNS:
1.  Identify your DNS name server - for each zone Azure DNS allocated DNS server from each pool and authoritative `NS` (or _Name server_) records in your DNS zone.
	1. Find with Azure Portal
2.  Update your parent domain  - each registar has their own DNS management tools
	1.  Go to your registrar's (third-party domain registrar, company where domain was registered) DNS management page.
	2.  Find the existing `NS` records for your parent domain.
	3.  Replace the existing `NS` records with the `NS` records created for your domain by Azure DNS.
		-  Remember to include a trailing period `..` at the end of the address
		- Always copy **all** DNS name server `NS` records for your domain to the parent domain 
3.  Delegate subdomains (optional)
	1.  Go to the parent DNS zone for your domain in the Azure portal.
	2.  Find the existing `NS` records for your parent domain.
	3.  Create new `NS` records for your child DNS zone (subdomain).

Create record set or Child zone
`Search -> DNS zones -> Search $DNSzone -> + Record Set | + Child Zone 

Common pattern - name resolution for multiple networks, where one is focused on registration and the other resolution.
`Vnet1 = Registration <-> Azure Private DNS zone records <-> Vnet2 = Resolution`

#### Azure Private Link

Azure Private Link is when a external facing Azure PAaS service is accessed from a resource in a VNet the trafffic stays on the Azure network. APL enables PaaS Service is an avatar for that service instance and can project custom services that are behind a Load Balancer. Must have consistent DNS management!
- Private Link Endpoint is the Network Interface  
- Private Link service is the connection
	- Requires Azure Standard Internal Load Balancer and associated to a Link service:
		- Azure Sotrage
		- CosmoDB
		- SQL
- Third-Party providers acan be powered by Private Link

The PaaS service still has a external facing endpoint that some companies do not want even with firewall/authenication - firewalls and authenication are bypassable. 

Azure Firewall is managed, cloud-based network security service that protects your Azure VNets resources:
- It is a fully stateful Firewall as a SErvice (FWaaS) with: built-in high availability and unrestricted cloud scalability
- Uses a static public IP address for your VNet resources allowing outside firewalls to identify traffic originating from your virtual network
- Fully integrated with Azure Monitor for logging and analytics
- Azure Firewall on its own VNet
- VNets pass through this Central Vnet
- Comes with Microsoft Threat Intelligence
	- Blocks know malicious IPs and FQDNs

Azure ExpressRoutes create private connections between Azure datacenters and infrastructure on your premises or in a colocation envirnoment:
- connectivity can be from an: Any-to-any (IP VPN) network, a point-to-point Ethernet network, virtual cross-connection
- Through a connectivity provider at a colocation facililty 

ExpressRoute Direct allows for greater bandwidth connection from 50 Mbs to 10Gbs

#### Azure Network Watcher

Azure Network Watcher provides tools to monitor, diagnose and view network metrics - also enable and disable logging for resource in an Azure Vnet

Watcher can monitor and repair Azure resources you provision:
- Cannot be used to monitor PaaS (fully managed services) monitoring or Web Analytics
- Disabled by default in most regionsso you need to enable it at per region basis
- Visualize the topology of VNets

Network Performance Monitor (NPM) is cloud-based hybrid network monitoring solution , which helps you monitor network performance between various points in your network infrastructure.
- Traffic blackholing 
- Route errors
- Unventional Network Issues
- Generates Alerts andNotifies you when a threshold is breached for a network link.

#### Network Security Groups (NSG)

Network Security Group (NSG) limit network traffic to and from Azure resources in a VNet. NSGs are assignableto subnets to create demilitarized zone (DMZ) that acts as a buffer between resource within a VNet and the internet. 
- A subnet can have a maximum of one associated network security group and cannot have associated NSGs. 
- You assign NSGs to (which constitute a tiering at each level in rule precedence):
	- Subnet	
	- Resource's a Network interface card (NIC).
- A NSG is composed of many Security Rules with the following properties:
	- Name
	- Source (Any, IP addresses, Service tag)
	- Destination (Any, IP addresses, Virtual network)
	- Port Range
	- Protocol 
	- Action - Allow or Deny
	- Priority - 100 to 4096
- Each rule has a priority value - higher the priority value the more precedence in ordering amongst other rules.
- You can't remove the default security rules, but can be overriden by higher priority Security Rule
- Each NSG and its Security Rules are evaluated independently.

- NSG precedence - Outbound NIC NSG rules, Inbound Subnet NSG rules

- In/Outbound Rules have three default security rules for an NSG
- For In/Outbound Rule evaluation Azure also checks how to apply the rules for intra-subnet traffic.
- Inbound Rules apply to traffic entering the NSG
	- Inbound Rules (1) **deny all inbound traffic** except (2 - Allow) traffic from your virtual network and (3 - Allow) Azure load balancers
	- Azure first processes network security group security rules for any associated subnets and then any associated network interfaces
- Outbound Rules apply to traffic leaving the NSG
	- Outbound rules (3 - Deny All outbound) **only allow outbound traffic** (1) to the internet and your (2) virtual network
	- Azure first processes network security group security rules for any associated subnets and then any associated network interfaces
- Without an NSG Azure applies default rules aty both the NIC and Subnet level

Consider:
- Traffic
	- Intra-subnet traffic
- Deny by Default is a security default - Allow is then for avaliability, while not compromising security
- Rule Priority - Rule Priority - Rule Priority

[Application Security Group](https://learn.microsoft.com/en-us/azure/virtual-network/application-security-groups) are for logically grouping VMs by workload in Azure virtual network.

#### NSG Workflow

Overview of NSGs
`Search -> Network Security Groups`

Create an NSG
`Search -> Network Security Groups -> + Create` - Source, Destination, Service, Priority
Associate NSG with a Subnet or NSG
`$NSG -> Settings -> Network Interfaces, Subnets`

Add RDP to a VM Allowing and Disallowing the connection with NSG
`$VM -> Connect -> Configure if required then goto -> Networking -> Either:`
- `Inbound port rules Tab -> add inbound port rule -> Configure`  
- `Outbound port rules Tab -> add outbound port rule -> Configure`

#### Azure Firewall

Azure Firewall is a managed, stateful firewall and cloud-based network security service that protects your Azure Virtual Network resources. Allows creating, enforcement and logging appplication and network connectivity policies across subscriptions and Vnets. It integrates with Azure Monitor for logging and analytics.
- By default denys all trafficthrough your virtual network - protection from bad actors,  stupidity and blind spots 
- It has a static public IP address
- Can span multiple availability zones for increased availability during deployment and unrestricted in scalabilty
- Limit outbound HTTP/S traffic or Azure SQL traffic to a specified list of fully qualified domain names (FQDN) including wild cards
- Create network filtering rules 
- It can distinguish legitimate packets for different types of connections
- Supports threat intelligence-based filtering

With Azure Firewall, Bastion and VPN Gateway by default you can implementing a hub-spoke network - reduces costs of time and money by centralizing services. Consider
- Role separation
- Subscription limits
- Shared services

Azure Firewall Rules are configured for: 
- **NAT** - Azure Firewall destination network address translation (DNAT) rules to translate and filter inbound traffic to your subnets
	-   **Name**: Provide a label for the rule.
	-   **Protocol**: Choose the TCP or UDP protocol.
	-   **Source Address**: Identify the address as * (internet), a specific internet address, or a classless inter-domain routing (CIDR) block.
	-   **Destination Address**: Specify the external address of the firewall for the rule to inspect.
	-   **Destination Ports**: Provide the TCP or UDP ports that the rule listens to on the external IP address of the firewall.
	-   **Translated Address**: Specify the IP address of the service (virtual machine, internal load balancer, and so on) that privately hosts or presents the service.
	-   **Translated Port**: Identify the port that the inbound traffic is routed to by Azure Firewall.
- **Network** rule  - Any non-HTTP/S traffic that's allowed to flow through your firewall must have a network rule
	-   **Name**: Provide a label for the rule.
	-   **Protocol**: Choose the protocol for the rule, including TCP, UDP, ICMP (ping and traceroute), or Any.
	-   **Source Address**: Identify the address or CIDR block of the source.
	-   **Destination Addresses**: Specify the addresses or CIDR blocks of the destination(s).
	-   **Destination Ports**: Provide the destination port of the traffic.
- **Application** rules define fully qualified domain names (FQDNs) that can be accessed from a subnet
	- **Name**: Provide a label for the rule.
	-   **Source Addresses**: Identify the IP address of the source.
	-   **Protocol:Port**: Specify `HTTP` or `HTTPS` and the port that the web server is listening on.
	-   **Target FQDNs**: Provide the domain name of the service, such as `www.contoso.com`. Wildcards (\*) can be used. An FQDN tag represents a group of FQDNs associated with well known Microsoft services. Example FQDN tags include `Windows Update`, `App Service Environment`, and `Azure Backup`.
	
Azure Firewall Rules are processed by:
- Network rules
- Application rules

#### Azure Virtual Network Peering

[Azure Virtual Network peering](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview) lets you connect virtual networks in the same or different regions, so resources in both networks can communicate with each other, but are still managed separately. Azure Virtual Network peering does not require downtime for resources, utilizes the Azure infrastructure simplifying and strengthening performance.  

- Regional virtual network peering - Cloud, Public or Govenment Region 
- Global virtual network peering

You cannot:
- Peering different Azure Government cloud 

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
	- Service chaining: define UDRs from Vnet to a network virtual appliance or VPN

RDP in and Test with:
```powershell
Test-NetConnection -ComputerName $ip -Port 3389 -InformationLevel 'Detailed'
```

#### Azure ExpressRoute

Azure ExpressRoute provides a high-speed private connection to connect your on-premises networks to Microsoft cloud services. Why:
- Fast and private
	- Supports a wide range of bandwidths
	- Access to Microsoft Azure Services, 365, Dynamics and CRM
	- Connection to Azure and through Azure
		- To one of the support locations
		-  ExpressRoute circuit consists of two connections to two Microsoft Enterprise edge routers (MSEEs) from the connectivity provider or your network edge
	- Private Storage
	- Extend and connect your datacenters
	- Hybrid applications:
		-  Border Gateway Protocol (BGP) to exchange routes between your on-premises network, your instances in Azure, and Microsoft public addresses to provide Layer 3 connectivity. Multiple BGP sessions are created for different traffic profiles.
- [ExpressRoute Pricing options](https://azure.microsoft.com/pricing/details/expressroute/) for ExpressRoute.
- Can coexist with site-to-site
![1080](azurecoexistoptionsforexpressandsitetosite.png)

Supported ExpressRoute locations:
![1080](azuresupportedexpressroutes.png)

#### Azure WAN

The Azure Virtual WAN  (wide-area network) networking service combines networking, security, and routing functionalities into a single operational interface.

![](azurewansimage.png)
Typology:
-  **Basic**: A Basic Virtual WAN can be implemented only in an S2S VPN connection.
-  **Standard**: A Standard Virtual WAN can be implemented with Azure ExpressRoute and a User VPN (P2S). You can also use a Standard WAN with an S2S VPN, Inter-hub, and VNet-to-VNet connection transiting through the virtual hub.



## References

[John Savill's Microsoft Azure Master Class Part 6 - Networking](https://www.youtube.com/watch?v=K8ePZdLfU7M&t=3511s)
[Vnet Peering Permissions](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering?tabs=peering-portal#permissions)
[Azure Virtual Network peering documentation](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview).
[ExpressRoute Pricing options](https://azure.microsoft.com/pricing/details/expressroute/)
[Azure virtual network service endpoints | Microsoft Learn](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-service-endpoints-overview)