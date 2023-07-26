# Azure Administration Scale and Availability Sets 

Azure Scale sets allows automatic increases and decreases in VM capacity. Load Balancers can be associated with a Scale Set:
- Evenly distribute VM across availablility Zones - more availability
- Use Load Balancer probe checks for more robust Health checks
	- Load Balancers:
		1. Application Gateway is an HTTP/HTTPS web traffic load balancer application firewall
		2. Azure Load Balancer supports all TCP/UDP network traffic, port-forwarding and outbound flaws.

An availability set is a logical feature you can use to ensure a group of related identical virtual machines are deployed together and torn down together. Azure manages physical location, Administrator builds:
- Azure Portal
- ARM - [[Azure-Administration-Azure-Resource-Manager]]
- Scripting
- API Tools
Consider
- Redundancy
- Separation of Application Tiers - no single point of failure
- Managed Disk for Block-Level Storage

An Availability set is
- Assigned an:
	- Fault Domain - up to 3
		- Are a group of virtual machines that share a common power source and network switch.
	- Update Domain - up to 20
		- Are groups of virtual machines and underlying physical hardware that can be rebooted at the same time
		- If 5 Update domain, the 6th will be in the 1st, 7th will in the 2nd, etc - if 20 the 21th VM is in the 1st..
	- Can't be changed once the availability set has been created

Scale sets:
- Update Domains -  is a group of nodes that are upgraded together
- Fault Domains -  is a group of nodes that represent a physical unit of failure

A **Scaling Policy** determines what VM is removed to decrease the capacity of the Scale Set either:
- Default - Delete VM with highest instance ID balanced across Availability Zones  and Fault Domains
- Newest VM - Delete the newest created VM, balanced across Availability Zones 
- Oldest VM - Delete oldest VM balanced across Availability Zones 

**Update Policy** determine VM instances are brought up-to-date with the latest scale set model
- Automatic: Increasing with start upgrading immediately in random order
- Manual - Existing instances must be manually upgraded
- Rolling - Upgrade roll out in batches with optional pause
Health monitoring can be enabled to determine if server is healthy or unhealthy
1. Application health extension: Ping an HTTP request to a specific path and except a status 200
2. Load Balancers Probe - allow checks based on TCP, UDP or HTTP requests.

Automatic Repair policy if an instance is found to be unhealthy the delete it and launch a new instance

**Autoscaling** - minimises the number of unnecessary virtual machine instances that run your application, consider:
- Overhead
- Events
- Scaling in and out given demand
- Define adjustment in capacity

Availability Zone
- Zonal Services pin each resource to a specific zone.
- Zone-Redundant services are zone-redundant, the platform replicates automatically across all zones.

Plan for maintenance and unexpected downtime:
- Use an availability set, which is a logical feature you can use to ensure a group of related virtual machines are deployed together - reducing single point of failure, that they are not upgraded at the same time.
	- VMs in the set should be identical

Microsoft provides [Service Level Agreements (SLAs) for Azure Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9/) for Azure virtual machines and availability sets. Considerations:
- Redundancy
- Separation of application tiers
- Load balancing
- Managed Disks

For Domains:
- `update domains`  -  is a group of nodes that are upgraded together during the process of a service upgrade
	- Each `update domain`  contains a set of virtual machines and associated physical hardware that can be updated and rebooted at the same time.
	- Configure up to 20, one update at a time
	- Default: 5 non-user configurable update domains
- `fault domains` -  is a group of nodes that represent a physical unit of failure
	- Defines a group of virtual machines that share a common set of hardware that share a single point of failure
	- 2 domains work together to mitigate against hardware failures, network outages, power interruptions, or software updates.

Availability Zones:
- Unique physical locations within a Azure Region
	- One or more Data centres
- Minimum of three Availability zones
- Prevents against Data centre failure
- Prevents single point of failure with Zone redundancy

![](azureservicessupportingavailabilityzones.png)

Scalability - goes Vertically (VM Size up or down) and Horizontally (Number of VMs)
Considerations:
- Limitations
- Flexibility
- Reprovisioning


#### Workflows

Create and Manage VM Scale Sets
`Search -> Virtual machine scale sets` 
- Size = Price; Azure Spot - discount unused pool ; image = OS, arch = x86 or arm64
- Orchestration mode:
	- Uniform - for large scale stateless workloads with indetical instances - department workstation
	- Flexible - high availability at scale with identical or multiple instances - any configuration to the scale set.
- Advanced tab to enable beyond 100 instances; spreading for optimal spreading of allocation 
 - Configure Scaling in the `Scaling` tab; 
	 - Policy - min/max number of instances; manual or autoscaling 
	 - Scale in - CPU threshold, decrease of instances
	 - Scale out - CPU threshold, duration, increase of instances
	 - Scale-In policy - default, newest, oldest vms

Size Scaling
`Virtual Machines -> $VM -> Size -> Resize by select new size`
Disk Scaling
`Virtual Machines -> $VM -> Disks -> + Create and Attach a new disk -> provide a name and size (GiB)` 

Register resource providers
```powershell
Register-AzResourceProvider -ProviderNamespace $RP
```

Deploy a zone-resilient Azure VM scale set with Portal
`Search -> Virtual machine scale sets -> + Create -> Provide: Name, Resource Group and Zones! - Orchestration mode!, Image,Size` - Add to or Create a Vnet; configure NIC NSG and consider `Load balancer`; Scaling; Management `Monitoring: managed or custom` - do not disable; `Advanced - Spreading and Beyond 100 instances;`

Upgrading VM scale sets
Load a script with Script with Custom Script Extension
`Search -> VM scale sets -> Instances -> Select instances -> Upgrade` - check with Load balancer Frontend IP: `Search -> Load Balancers -> $LoadBalancer -> Frontend IP configuration -> Copy address` 

`Search -> VM scale sets -> Scaling -> Manual Scaling or Custom autoscale`
if Custom:
- Configure the Default auto created scale condition 
	- Add rules!!!
	- Scale mode - metric or instance count
	- Instance limits
	- Schedule
Test with:
```powershell
# This is the microsoft way.. - test if you need a while loop..
# Note is this just a way to increase costs in the cli?
# "Sorry boss I spent X dollars on a web request"
$pip (Get-AzPublicIpAddress -ResourceGroupName $rgName -Name $lbpipName).IpAddress
while ($true) { Invoke-WebRequest -Uri "http://$pip" }
```

Custom Script Extension - Container with a custom IIS webserver
- Storage Account with scripts, container for webserver
`VMs -> $Container -> Extensions + Add -> Custom Script Extension -> Upload scripts from Storage Account `

Export Template, custom template for mass use
`VMs -> $CustomVm -> Export Template`

## References

[Youtube Azure Administrator Certification (AZ-104)](https://www.youtube.com/watch?v=10PbGbTUSAg)
[autoscale with Azure Virtual Machine Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-autoscale-overview).
[Deploy your application on Azure Virtual Machine Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-deploy-app).
[Choose the right number of fault domains for Azure Virtual Machine Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-manage-fault-domains)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[Learn Micorsoft - Availability Set Overview](https://learn.microsoft.com/en-us/azure/virtual-machines/availability-set-overview)