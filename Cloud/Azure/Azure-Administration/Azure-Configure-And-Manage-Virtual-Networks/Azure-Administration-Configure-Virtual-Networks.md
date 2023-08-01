# Azure Administration - Virtual Networking

## Azure Virtual Networks

An Azure virtual network is a logical isolation of the Azure cloud that's dedicated to your subscription. It is used to provision and manage VPNs in Azure and link virtual networks with an on-premises with hybrid or cross-premises solutions to prevent overlap. Virtual Networks consist of one of more Address Space(s) available IP ranges that are typically from RFC 1918, but not exclusively, which are allocating for you use within your VNet

- Exists within a specific subscription
- Region VNet Peering - Exists within a specific region, peering two Vnets in same regions
- Global VNet Peering - Exists within a different regions, peering two Vnets in two different two regions
- The only public IPs available are the one granted by Azure
- Subnet creation lose **five** addresses: all 0s, 256, Azure Default Gateway, next two address after the Default gateway will be lost to DNS.
	- /29 - would only have 3 addresses as you always lose the 5 above

Azure Virtual Network 
- Azure virtual network is a logical isolation of the Azure cloud dedicated to subscription
- For provisioning and managing VPNs in Azure
- Create hybrid or cross-premises solutions, when CIDR blocks do not overlap
- Controllable DNS server settings for virtual networks, and segmentation of the virtual network into subnets.

Network Interface Controller (NIC) - soft/hardware that interface between two device or protocol layer in a network communicating with IP

Azure Network Interfaces (NICs):
- Azure Network Interfaces are attached to azure VM instance
- Without an NIC, an Azure VM instance would have no way to communicate
- An Azure VM instance has to have an NIC and can have multiple NICs

Route Table is table of data stored in router or network host that list routes to next destinations
- By default Azure creates a route table with default routes (system routes) and associates them to your subnets
- You can override the system routes assigned to your subnets by creating a new route table and associating with a subnet

Subnet is a logical division of an address space
- Subnet requires a Route Table for access
- Public and Private subnet describes whether a subnet is reachable from the internet or not
- Azure has no concept of private and public subnets 
	- **Configure subnets to have ensure they do no reach the internet!**
- Associate an NSG to protect traffic entering and leaving your Subnet
- Azure has special types of Gateway Subnet that is used by Azure Virtual Network Gateway

Associating Public IP to a resource 
![1080](azureassociatingpublicips.png)

Associating Private IP to a resource 
![1080](azureassociatingprivateips.png)


#### Creating Virtual Networks

- Connect to Resource Group
- Name with naming convention
- IP address space, can add multiple and IPv6 - the automatic ones are drawn from Azure analysing your own IP spaces
- Remember Azure takes 5 addresses before sizing!

The Virtual Network should be broken up into subnet ranges like on-premise to manage the networking. Availability Zones (AZ)s can be spanned across subnets, zones and regions Resources in a subnets need to be alignment with resources available from a AZ dimension.

- IP always comes via fabric (Azure) OS using DHCP - can configure per OS basis 
- IPs can be reserved in ARM
	- For Domain Controllers
- VMs can have multiple NICs
- Each NIC can be in a different Virtual Subnet in the same virtual network or different subnets - Cross region also! 
- Multiple IP configuration per NIC
- IP configuration can have Public and Private IP
	- Public IP is internet routable - Just DO NOT!
		- Use Resilience Services -  Load balancer, Firewall in front of VM not Public IPs for VMs!
	- Instance Level Public - VM processes by Private IP

![1000](azure-virtualnetworking-diagram.excalidraw.md)

- VMs are placed in the subnet, in actuality you are placing NIC in the subnet and connecting it to the VM. 
- Azure tracks the IP addresses as deallocation and reallocation will result in a VM getting probably a different IP. 
- A VM can have multiple NICs to connect to multiple subnets, but not can not span multiple Virtual Networks, it can still connect to another VNet just not span! 

Ensure static IP on a VM:
`Virtual  Machines -> $VMnames -> Network Interface -> IP configuration -> Static | Dynamic` 

IP forwarding from a VM - for Firewalls and Gateway devices
`Virtual  Machines -> $VMnames -> Network Interface -> IP forwarding  set to (Disabled | Enabled)`

#### Plan IP addressing 

- [Design IP Addressing is non-trivial](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-ip-addressing)
	- Address range overlaps restricts various connectivity potentials - see  [[IPv4-Subnet-Masks-Dictionary]]:
		- `10.11.0.0/17` overlaps with `10.11.0.0/25`
		- `192.168.16.0/22` does not overlap with `10.11.0.0/17`
	- Cross region connection use a gateway, NIC in Region A != connect to Region B
	- 5 Addresses are taken by Azure per (256 addresses of IPv4)
		- `192.82.1.0` Identifies the VNet
		- `192.82.1.1` Gateway
		- `192.82.1.2-3` Azure maps Azure DNS IP addresses to the virtual network space
		- `192.82.1.255` Broadcast
	- Add either to New Subnet or new Address space - understand the differences
	- Don't use the following address ranges:
		- `224.0.0.0/4` (multicast)
	       - `255.255.255.255/32` (broadcast)
		- `127.0.0.0/8` (loopback)
	       - `169.254.0.0/16` (link-local)
		- `168.63.129.16/32` (internal DNS)

View a Network Typology by Subscription, Resource Group and VNet
`Search -> Network Watcher -> Topology`

#### Supported Types of IP Traffic

- Standard IP-based Protocol support include:
	- TCP
	- UDP
	- ICMP

Some outside of the above may work, but Load balancers may not understnad

- Multicast, broadcast IP-in-IP encapsulated packets and Generic Routing Encapsulation (GRE) is blocked! 
	- This is Software defined networking, this is not Virtual LAN - no [[OSI-Model]] Layer 2
- Cannot `ping` the Azure Gateway or use `tracert` these are abstractions in software! 
	- There is no traffic to sniff, it is all direct!
	- VNet is the isolation
- Traditional Layer 2 VLANs are not Supported

#### IPv6

- Virtual Networks are dual stack enabling IPv4 and IPv6 address ranges assigned
	- The Azure Health probes use IPv4
- IPv6 supported in NSGslt Domains
- Newest VM - Delete the newest created VM, balanced across AZs, UDR and LB (Load Balancers), peering
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
- Ports exposed - Use encrypted variants - [[Nmap-Cheatsheet]] is easy to use to find your RDP and SSH , SMB that is externally facing, just don't - obsfucation is not security.
	- Just-In-Time access is available if you don't have private routing. Do not expose services to internet continually

SMTP (port 25) is a special case. Depending on your subscription level and when your account was created, outbound SMTP traffic may be blocked.

#### Connecting Virtual Networks

If you have multiple subscription or region you then will have multiple virtual networks to connect them via:
- Virtual Network Peering 
	- Same or different Region
	- IP address space CANNOT overlap
	- Ingress and egrees charge for using Azure Backbone
	- Span subscriptions and AAD tenants
	- Peers are not transitive, but they could be via (if Hub is parent and nth number of Spokes are child nodes and Vnets of a network):
		- Peering segmented Spoke Vnets
		- Vnet Hub could with user defined routing - **Beware the Capacity and Scaling of Routing Appliance in the Domains
- Newest VM - Delete the newest created VM, balanced across AZs Hub! 
	- Vnet Hub has a route table for peering between Spoke VNets 
	- Solution: Forwarding to the Hub from Spoke 1 to another Spoke 2 

Historic comparison being: Site-to-Site VPN or connection to the same ExpressRoute:
- Peering location would hair pin on a circuit to talk to the same facility on different Virtual Network - bad latency

On-premise to an Azure subnet Gateway can be used to connect resources via Gateway transit, because of Peering to reach out to On-Premise assets. 

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

#### Azure Load Balancer

Load Balancing is used to efficiently distribute incoming network traffic across back-end servers and resources. A load balancer is implemented by using load-balancing rules and health probes. It sit between the Frontend and Backend to test the Backend and deal with the flow of traffic from the Frontend. 
- Load Balancer scales up to millions of TCP and UDP application flows.
- For Inbound and Outbound
- Public or Internal
- Components:
	- Front-end IP configuration 
		- Specifies the public IP or internal IP that your load balancer responds to.
	- Back-end pools
		- Are services and resources including VMs or Scale-sets
	- Health probes
		- Tests health of Backend
	- Load-balancing rules
		- Detirmine traffic distribution to Backend
		
A Load Balancer Distribution modes:
- 5-tuple hash (multiple VMs: 
	- Source IP
	- Source port 
	- Destination IP 
	- Destination port
	- Protocol type 
- Source IP affinity/Session Affinity/Client IP affinity uses (for one Specific Client):
	- 2-tuple hash: Source and Destination IP

- An **availability set** is a logical grouping that you use to isolate virtual machine resources from each other when they're deployed. Availabilty sets allow virtual machines to remain available when a physical server fails.
- An **availability zone** offers groups of one or more datacenters that have independent power, cooling, and networking.

Basic load balancers allow:
- Port Forwarding
- Automatic reconfiguration
- Health probes
- Outbound connections through source network address translation (SNAT)
- Diagnostics through Azure Log Analytics for public-facing load balancers

Standard load balancers support all of the basic load balancer features. They also allow:
- HTTPS health probes
- Availability zones
- Diagnostics through Azure Monitor, for multidimensional metrics
- High availability (HA) ports
- Outbound rules
- A guaranteed SLA (99.99% for two or more virtual machines)

Basic Vs Standard SKUs for Load Balancers
![1080](azurecomparebasicandstandskusforloadbalancers.png)
The Gateway SKU supports high performance and high availability scenarios with third-party network virtual appliances (NVAs).

Load Balancers Workflows by Type and important information:
`Search -> Load Balancers` and `+ Create` a type:
- Application Gateway - Region layer 7 load balancer
- Front Door - Global Layer 7 load balancer 
- Load Balancer - Layer 4 for internal and public configurations
	- SKU options: Basic, Standard, and Gateway 
- Traffic Manager - DNS-based traffic load balancer
Manage:
`Search -> Load Balancers -> $loadBalancer`:
- Front-end IP configuration 
- Back-end pools: `+ Add -> $name & $Vnet`
- Health probes: `+ Add -> $name & Protocol, Port and Interval`
- Load-balancing rules (can be used in combination with NAT rules) - requires a frontend, backend, and health probe; define a rule:
	- IPv4 or 6
	- Frontend IP address
	- Backend pool or Backend port
	- Health probe
	- Session persistence: None (default), Client IP, Client IP and Protocol

Application Gateway Configuration
- Routing Methods
	- Path-based routing: sends requests with different URL paths to different pools of back-end servers.
	- Multi-site routing: configures more than one web application on the same application gateway instance.
- Optional Firewall checks (Recommended)
	- OWASP defines a set of generic rules for detecting attacks. These rules are referred to as the Core Rule Set (CRS)
- Traffic Redirection
- Rewrite HTTP Headers
- Custom Error pages instead of default error pages - highly advised Attacker need error pages

Application Gateway distributes requests across multiple servers by using a round-robin technique.
![](azureapplicationgatewayflowdiagram.png)
- Listen is either Basic or Multi-site and handle TLS/SSL certificates


Source IP affinity load balancer
```powershell
$lb = Get-AzLoadBalancer -Name MyLb -ResourceGroupName MyResourceGroup
$lb.LoadBalancingRules[0].LoadDistribution = 'sourceIp'
Set-AzLoadBalancer -LoadBalancer $lb
```

1. `Create a Resource -> Load Balancer` - options:
2. `Basic: SKU, Type ( Public | Internal ) and Tier (Regional | Global )`. 
3. `Configure front-end IP configuration -> Add (Consider assignment*)`  
4. `Configure back-end IP configuration -> Select backend pool VMS`  
5. `Inbound Rules -> Add`

Add session persistence to a load balancer
`Search Load Balancers -> Load Blancers -> $LB -> Edit -> Sessions persistence dropdown -> None, Client IP, Client IP and Protocol`

- RDP Desktop Gateway + Load Balancer = must be Source IP affinity LB
- Media upload + Load Balancer = must be Source IP affinity LB

Load Balancer in Powershell
```powershell;
$Location = $(Get-AzureRmResourceGroup -ResourceGroupName [sandbox resource group name]).Location
# Create a public IP address 
$publicIP = New-AzPublicIpAddress `
  -ResourceGroupName $rGroup `
  -Location $Location `
  -AllocationMethod "Static" `
  -Name "myPublicIP"
# Create Front-end IP
$frontendIP = New-AzLoadBalancerFrontendIpConfig `
  -Name "myFrontEnd" `
  -PublicIpAddress $publicIP
# Create a back-end address pool
$backendPool = New-AzLoadBalancerBackendAddressPoolConfig -Name "myBackEndPool"
# Allow Load Balancer to monitor backend pool
$probe = New-AzLoadBalancerProbeConfig `
  -Name "myHealthProbe" `
  -Protocol http `
  -Port 80 `
  -IntervalInSeconds 5 `
  -ProbeCount 2 `
  -RequestPath "/"
# Create a rule for the Load Balancer
$lbrule = New-AzLoadBalancerRuleConfig `
  -Name "myLoadBalancerRule" `
  -FrontendIpConfiguration $frontendIP `
  -BackendAddressPool $backendPool `
  -Protocol Tcp `
  -FrontendPort 80 `
  -BackendPort 80 `
  -Probe $probe
# Create Load Balancer
$lb = New-AzLoadBalancer `
  -ResourceGroupName $rGroup `
  -Name 'MyLoadBalancer' `
  -Location $Location `
  -FrontendIpConfiguration $frontendIP `
  -BackendAddressPool $backendPool `
  -Probe $probe `
  -LoadBalancingRule $lbrule
# Connect the VMs to the back-end pool 
$nic1 = Get-AzNetworkInterface -ResourceGroupName $rGroup -Name "webNic1"
$nic2 = Get-AzNetworkInterface -ResourceGroupName $rGroup -Name "webNic2"
# Update the network interfaces 
$nic1.IpConfigurations[0].LoadBalancerBackendAddressPools = $backendPool
$nic2.IpConfigurations[0].LoadBalancerBackendAddressPools = $backendPool

Set-AzNetworkInterface -NetworkInterface $nic1 -AsJob
Set-AzNetworkInterface -NetworkInterface $nic2 -AsJob
# Get pulic IP of the Load Balancer and URL for website
Write-Host http://$($(Get-AzPublicIPAddress `
  -ResourceGroupName [sandbox resource group name] `
  -Name "myPublicIP").IpAddress)
```

Load Balancer in Bash
```bash
az network public-ip create \
  --resource-group $rGroup \
  --allocation-method Static \
  --name myPublicIP

az network lb create \
  --resource-group $rGroup \
  --name myLoadBalancer \
  --public-ip-address myPublicIP \
  --frontend-ip-name myFrontEndPool \
  --backend-pool-name myBackEndPool

az network lb probe create \
  --resource-group $rGroup \
  --lb-name myLoadBalancer \
  --name myHealthProbe \
  --protocol tcp \
  --port 80

az network lb rule create \
  --resource-group $rGroup \
  --lb-name myLoadBalancer \
  --name myHTTPRule \
  --protocol tcp \
  --frontend-port 80 \
  --backend-port 80 \
  --frontend-ip-name myFrontEndPool \
  --backend-pool-name myBackEndPool \
  --probe-name myHealthProbe

# Connect the VMs to the back-end pool and update NIC
az network nic ip-config update \
  --resource-group $rGroup \
  --nic-name webNic1 \
  --name ipconfig1 \
  --lb-name myLoadBalancer \
  --lb-address-pools myBackEndPool

az network nic ip-config update \
  --resource-group $rGroup \
  --nic-name webNic2 \
  --name ipconfig1 \
  --lb-name myLoadBalancer \
  --lb-address-pools myBackEndPool
# Get pulic IP of the Load Balancer and URL for website
echo http://$(az network public-ip show \
                --resource-group [sandbox resource group name] \
                --name myPublicIP \
                --query ipAddress \
                --output tsv)
```


[View Azure virtual network topology | Microsoft Learn](https://learn.microsoft.com/en-us/azure/network-watcher/view-network-topology)

#### Service Endpoints and Service Endpoints Policies

NSGs are focused on traffic inot and out of the virtual network, Azure PaaS options have built-in Firewalls to often restrict a service to only specific subnets of specific virtual networks. Service endpoints make a specific subnet known to specific Azure service and add optimal path to service.

- Virtual firewalls on service are configurable to allow only a specific subnet
- Service Enpoint Policies allow specific instances of services to be allowed from a virtual network, which is not possible with NSG service Tag
- Service Endpoints are not routeable

#### Designing an IP addressing schema for your Azure deployment

Before you start integrating Azure with on-premises networks, it's important to identify the current private IP address scheme used in the on-premises network. There can be no IP address overlap for interconnected networks. To ensure compatibility between:
- On-premise: Administrator defined
- Azure: Azure (Reserved Address spaces!) and NSG defined
	- Public IPs
		- Public IP addres prefix is reserved - the rest is specified by Azure
		- Allows On-Premise Public IP address
	- Private IPs
		- Reserved by Internet Assigned Numbers Authority (IANA) based on your network requirements:
			-   10.0.0.0/8
			-   172.16.0.0/12
			-   192.168.0.0/16
	 - Dynamic or Static allocation
	- SKUs: Basic or Standard

Planning for IP Addressing is a non-trivial problem and a nightmare to replan review - [Plan for IP addressing - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-ip-addressing)

Routable address over the internet: 215.11.0.0 to 215.11.255.255

Discover IP address scheme requirements:
- How many devices do you have on the network?
- How many devices are you planning to add to the network in the future?

When your network expands, you don't want to redesign the IP address scheme. Here are some other questions you could ask:
- Based on the services running on the infrastructure, what devices do you need to separate?
- How many subnets do you need?
- How many devices per subnet will you have?
- How many devices are you planning to add to the subnets in future?
- Are all subnets going to be the same size?
- How many subnets do you want or plan to add in future?

Address spaces - Review IP Schema Implementation
By CIDR 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
Routable address over the internet: 215.11.0.0 to 215.11.255.255

Create a Vnet with Subnets 
```powershell
# Create Vnet
az network vnet create \
    --resource-group $rGroup \
    --name CoreServicesVnet \
    --address-prefixes 10.20.0.0/16 \
    --location westus
# Creat Subnets with address prfixes
az network vnet subnet create \
    --resource-group $rGroup \
    --vnet-name CoreServicesVnet \
    --name GatewaySubnet \
    --address-prefixes 10.20.0.0/27

az network vnet subnet create \
    --resource-group $rGroup \
    --vnet-name CoreServicesVnet \
    --name SharedServicesSubnet \
    --address-prefixes 10.20.10.0/24

az network vnet subnet create \
    --resource-group $rGroup \
    --vnet-name CoreServicesVnet \
    --name DatabaseSubnet \
    --address-prefixes 10.20.20.0/24

az network vnet subnet create \
    --resource-group $rGroup \
    --vnet-name CoreServicesVnet \
    --name PublicWebServiceSubnet \
    --address-prefixes 10.20.30.0/24
# List the subnets
az network vnet subnet list \
    --resource-group $rGroup \
    --vnet-name CoreServicesVnet \
    --output table
```

#### Configuring Network Routing and Endpoints

[[Azure-Administration-Network-Routes-And-Endpoints]]
#### Azure DNS 

[[Azure-Administration-Azure-DNS]]

#### Azure Private Link and Endpoints

[[Azure-Administration-Private-Link-And-Endpoints]]
#### Azure Virtual Network Peering

[[Azure-Administration-Virtual-Networking-Peering]]
#### Network Security Groups (NSG)

[[Azure-Administration-Network-And-Application-Security-Groups]]

#### Azure Firewall

[[Azure-Administration-Azure-Firewall]]


#### Azure ExpressRoute

Azure ExpressRoutes create private connections between Azure datacenters and infrastructure on your premises or in a colocation environment:
- connectivity can be from an: Any-to-any (IP VPN) network, a point-to-point Ethernet network, virtual cross-connection
- Through a connectivity provider at a colocation facililty 
ExpressRoute Direct allows for greater bandwidth connection from 50 Mbs to 10Gbs

#### Azure Virtual Network Peering

[[Azure-Administration-Virtual-Networking-Peering]]

#### Traffic Control with Routes In Azure Virtual Network

Configuration of Network Virtual Applicance (NVA) to control traffic through routing.  A network virtual appliance (NVA) is a virtual appliance that consists of various layers like:
- Firewall
- WAN optimizer
- Application-delivery controllers
- Routers
- Load balancers
- IDS/IPS
- Proxies
Some require multiple network interfaces. Customers often create network virtual appliances and they can be downloaded from the Azure Marketplace.

Routing is controlled by System Routes - You can't create or delete system routes, but you can override the system routes by adding custom routes to control traffic flow to the next hop. Types:
- System Default Routes 
- Virtual network peering
- Service chainingazvnetservicechainingandudrs.excalidraw
- Virtual network gateway
- Virtual network service endpoint

Subnet default system routes

Address prefix | Next hop type
--- | ---
Unique to the virtual network | Virtual network 
0.0.0.0/0 | Internet
10.0.0.0/8 | None
172.16.0.0/12 | None
192.168.0.0/16 | None
100.64.0.0/10 | None
Defaults can be overridden!

Custom routes:
- Create a user-defined route 
	- Virtual appliance: Firewall, NIC of VM for IP forwarding or Private IP of a Load Balancer
	- Virtual Network Gateway: VPN hops
	- Virtual Network: Override System defaults within a Vnet
	- Internet
	- None
- Border Gateway Protocol (BGP) - Used to transfer data and information between different host gateways
	- Typically use of a BGP is to advertise on-premises routes to Azure when you're connected to an Azure data centre through Azure ExpressRoute

Create a Route Table and a Custom Route - Private Subnets, IP forwarding
```powershell
# Create a Route Table
az network route-table create \
        --name publictable \
        --resource-group $rGroup \
        --disable-bgp-route-propagation false
# Create a Custom Route		
az network route-table route create \
        --route-table-name publictable \
        --resource-group $rGroup \
        --name productionsubnet \
        --address-prefix 10.0.1.0/24 \
        --next-hop-type VirtualAppliance \
        --next-hop-ip-address 10.0.2.4		
# Associate Route Table with publicsubnet
az network vnet subnet update \
        --name publicsubnet \
        --vnet-name vnet \
        --resource-group $rGroup \
        --route-table publictable
```

Deploy a Network Virtual Appliance, Enable IP forwarding 
```powershell
# Create NVA
az vm create \
    --resource-group $rGroup \
    --name nva \
    --vnet-name vnet \
    --subnet dmzsubnet \
    --image UbuntuLTS \
    --admin-username azureuser \
    --admin-password <password>
# Query the ID of NVA NIC
NICID=$(az vm nic list \
    --resource-group $rGroup \
    --vm-name nva \
    --query "[].{id:id}" --output tsv)
# Query the name of NVA NIC
NICNAME=$(az vm nic show \
    --resource-group $rGroup \
    --vm-name nva \
    --nic $NICID \
    --query "{name:name}" --output tsv)
# # Enable IP forwarding for the appliance
az network nic update --name $NICNAME \
    --resource-group $rGroup \
    --ip-forwarding true
# Enable IP forwarding in the appliance
NVAIP="$(az vm list-ip-addresses \
    --resource-group $rGroup  \
    --name nva \
    --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
    --output tsv)"
```

Cloud Config Example - cloud-init.txt
```yaml
#cloud-config
package_upgrade: true
packages:
   - inetutils-traceroute
```

Private and Public flags for `az vm create`
```powershell
--public-ip-address 10.10.10.10
--private-ip-address 10.10.10.10
--public-ip-address-allocation 'dynamic' # or 'static' 
--public-ip-address-dns-name $DNSname
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

[[Azure-Administration-Virtual-WAN]]

## Workflows

Create Virtual Networks and Manage
`Search "Virtual Networks" -> Virtual Networks (-> Create)`
- Azure Firewall, Bastion and other require a subnet!

Create Subnets
`Search "Virtual Networks" -> Virtual Networks -> $VN -> Subnets -> + Subnets/Gateway subnet`
Remember to: plan IP addresses - they can be `private` or  `public`, `static` or `dynamic` and Azure reserves five IP addresses:
- 192.168.1.0 - Identifier for the Virtual Network
- 192.168.1.1 - Azure Default Gateway
- 192.168.1.2 - Azure DNS address 
- 192.168.1.3 - Azure DNS address
- 192.168.1.255 - Virtual Network broadcast address

Consideration:
- Service requirements
- Availability requirements - static IPs for DNS and DCs, TLS/SSL certs linked to an IP
- Network virtual appliances
- Service Endpoints
- Network Security Groups
- Private links
- VMs do not manage there IPs

Create and manage public IPs
`Search "Public IP Address -> Pulic IP addresses" ` then with `+ Create` provide the options `IP version, SKU, Tier, Name, Assignment, Routing`

## References

[Service Level Agreements for Azure Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9/) 
[John Savill's Microsoft Azure Master Class Part 6 - Networking](https://www.youtube.com/watch?v=K8ePZdLfU7M&t=3511s)
[Vnet Peering Permissions](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-peering?tabs=peering-portal#permissions)
[Azure Virtual Network peering documentation](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview).
[ExpressRoute Pricing options](https://azure.microsoft.com/pricing/details/expressroute/)
[Azure virtual network service endpoints | Microsoft Learn](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-service-endpoints-overview)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[Azure Firewall Rules](https://learn.microsoft.com/en-us/azure/firewall/rule-processing)