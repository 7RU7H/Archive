# Azure Administration - Managing Virtual Network


## Azure Virtual Networks

- An Azure virtual network is a logical isolation of the Azure cloud that's dedicated to your subscription.
- Provision and manage VPNs in Azure
- Link virtual networks with an on-premises with hybrid or cross-premises solutions to prevent overlap
- DNS server settings control

Associating Public IP to a resource 
![1080](azureassociatingpublicips.png)

Associating Private IP to a resource 
![](azureassociatingprivateips.png)

## Configuring VM Avaliability

Plan for maintaince and unexpected downtime:
- Use an availability set, which is a logical feature you can use to ensure a group of related virtual machines are deployed together - reducing single point of failure, that they are not upgraded at the same time.
	- VMs in the set should be identical

Microsoft provides [Service Level Agreements (SLAs) for Azure Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9/) for Azure virtual machines and availability sets. Considerations:
- Redundancy
- Seperation of application tiers
- Load balancing
- Managed Disks

For Domains:
- `update domains`  -  is a group of nodes that are upgraded together during the process of a service upgrade
	- Each `update domain`  contains a set of virtual machines and associated physical hardware that can be updated and rebooted at the same time.
	- Configure up to 20, one update at a time
	- Default: 5 non-user configurable update domains
- `fault domains` -  is a group of nodes that represent a physical unit of failure
	- Defines a group of virtual machines that share a common set of hardware that share a single point of failure
	- 2 domains work togther to mitigate against hardware failures, network outages, power interruptions, or software updates.

Availability Zones:
- Unique physical locations qithin a Azure Region
	- One or more Datacentres
- Minimum of three Availability zones
- Prevents against Datacentre failure
- Prevents single point of failure with Zone redundancy

![](azureservicessupportingavailabilityzones.png)

Scalability - goes Vertically (VM Size up or down) and Horizonally (Number of VMs)
Considerations:
- Limitations
- Flexibility
- Reprovisioning


## Workflows


Create Virtual Networks and Manage
`Search "Virtual Networks" -> Virtual Networks (-> Create)`
- Azure Fiewall, Bastion and other require a subnet!

Create Subnets
`Search "Virtual Networks" -> Virtual Networks -> $VN -> Subnets -> + Subnets/Gateway subnet`
Remember to: plan IP addresses - they can be `private` or  `public`, `static` or `dynamic` and Azure reserves five IP addresses:
- 192.168.1.0 - Identifier for the Virtual Network
- 192.168.1.1 - Azure Default Gateway
- 192.168.1.2 - Azure DNS address 
- 192.168.1.3 - Azure DNS address
- 192.168.1.255 - virtual network broadcast address

Consideration :
- Service requirements
- Avaliability requirements - static IPs for DNS and DCs, TLS/SSL certs linked to an IP
- Network virtual appliances
- Service Endpoints
- Network Security Groups
- Private links
- VMs do not manage there IPs

Create and manage public IPs
`Search "Public IP Address -> Pulic IP addresses" ` then with `+ Create` provide the options `IP version, SKU, Tier, Name, Assignment, Routing`

## References

[Service Level Agreements for Azure Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9/) 