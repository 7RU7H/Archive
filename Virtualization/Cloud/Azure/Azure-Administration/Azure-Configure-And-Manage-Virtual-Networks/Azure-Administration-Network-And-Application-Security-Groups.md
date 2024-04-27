# Azure-Administration Network And Application Security Groups 

Network Security Group (NSG) limit network traffic to and from Azure resources in a VNet. NSGs are assignable to subnets to create demilitarised zone (DMZ) that acts as a buffer between resource within a VNet and the internet. 

- Limit network traffic to resources in your virtual network by using a network security group
- A Subnet can have a maximum of one associated network security group and cannot have associated NSGs. 
- You associate NSGs to (which constitute a tiering at each level in rule precedence):
	- Subnet	
	- Resource's a Network interface card (NIC)
	- Can be associated multiple times

- A NSG is composed of list of Security Rules with the following properties:
	- Name
	- Source (Any, IP addresses, Service tag)
	- Destination (Any, IP addresses, Virtual network)
	- Port Range
	- Protocol 
	- Action - Allow or Deny
	- Priority - 100 to 4096
- Each rule has a priority value - higher the priority value the more precedence in ordering amongst other rules.
- You can't remove the default security rules, but can be overridden by higher priority Security Rule
- Each NSG and its Security Rules are evaluated independently.

- NSG processing precedence 
	- Outbound NIC NSG rules first
	- Inbound Subnet NSG rules first

Rule Priority (Best practice is to leave gaps where possible: 100, 200, 300 - assign lowest possible)
- Lower the number the higher the priority!

- In/Outbound Rules have three default security rules for an NSG
- For In/Outbound Rule evaluation Azure also checks how to apply the rules for intra-subnet traffic.
- Inbound Rules apply to traffic entering the NSG
	- Inbound Rules (1) **deny all inbound traffic** except (2 - Allow) traffic from your virtual network and (3 - Allow) Azure Load Balancers
	- Azure first processes network security group security rules for any associated subnets and then any associated network interfaces
- Outbound Rules apply to traffic leaving the NSG
	- Outbound rules (3 - Deny All outbound) **only allow outbound traffic** (1) to the internet and your (2) virtual network
	- Azure first processes network security group security rules for any associated subnets and then any associated network interfaces
- Without an NSG Azure applies default rules at both the NIC and Subnet level

Consider:
- Traffic
	- Intra-subnet traffic
- Deny by Default is a security default - Allow is then for availability, while not compromising security
- Rule Priority - Rule Priority - Rule Priority

[Application Security Group](https://learn.microsoft.com/en-us/azure/virtual-network/application-security-groups) are for logically grouping VMs by workload in Azure virtual network. Application security groups enable you to configure network security as a natural extension of an application's structure, allowing you to group virtual machines and define network security policies based on those groups. Therefore consideration of the application in context
- Inbound - Protocol and Port
- Outbound - Protocol and Port
- Internal - Protocol and Port of resources like:
	- Application Load Balancers
	- Databases
	- Business Logic Resources

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

## References

[John Savill's Microsoft Azure Master Class Part 6 - Networking](https://www.youtube.com/watch?v=K8ePZdLfU7M&t=3511s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)