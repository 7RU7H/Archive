# Azure Administration Scale and Availability Sets 

**Note: Microsoft doesn't automatically update your virtual machine operating system or other software, underlying periodically does** 

Plan for maintenance and downtime:
- Unplanned hardware maintenance
- Unexpected Downtime
- Planned maintenance 

## Azure Scale sets

Azure Virtual Machine Scale Sets are an Azure Compute resource that you can use to deploy and manage a set of **identical** virtual machines. Azure Scale sets allows automatic increases and decreases in VM capacity. Administrators could use Virtual Machine Scale Sets to run multiple instances of your application like a availability set
- Must VMs within the Scale set must be identical

Load Balancers can be associated with a Scale Set:
- Evenly distribute VM across availability Zones - more availability
- Use Load Balancer probe checks for more robust Health checks
	- Load Balancers:
		1. Application Gateway is an HTTP/HTTPS web traffic load balancer application firewall
		2. Azure Load Balancer supports all TCP/UDP network traffic, port-forwarding and outbound flaws.

Scale sets are...
- Assigned an:
	- Fault Domain - up to 3
		- Are a group of virtual machines that share a common power source and network switch.
		- Two fault domains work together to mitigate against hardware failures, network outages, power interruptions, or software updates.
	- Update Domains - up to 20
		- Are groups of virtual machines and underlying physical hardware that can be rebooted at the same time
		- Planned Maintenance:
			- Only one update domain is rebooted at a time.
		- If 5 (By default, there are five (non-user-configurable)) Update domains, the 6th will be in the 1st, 7th would in the 2nd if we added it, etc - if 20 the 21st VM is in the 1st.. 
	- Can't be changed once the availability set has been created

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

## Azure Availability sets

An Azure availability set is a logical feature you can use to ensure a group of related identical virtual machines are deployed together and torn down together. Azure manages a physical location Administrator manage policy inline with budgeting. 

Characteristic of Azure availability sets:
- All VMs *should*:
	- Perform the identical set of functionalities
	- Same software installed
	- Be created first before added 
	- To change availability set the VM needs to be deleted and then recreated
- Azure runs an availability set run across multiple physical servers, compute racks, storage units, and network switches.
- Administrators add disaster recovery and backup techniques using Azure 
	- [[Azure-Administration-Azure-Backups]]
	- [[Azure-Administration-Disaster-Recovery]]
- Administrators need to consider:
	- All the components of Disk and VMs [[Azure-Administration-Azure-Virtual-Machines]]
	- Adding correct Load Balancers [[Azure-Administrator-Load-Balancer]]
	- **Separate Application tiers**
		- Each application tier exercised in your configuration should be located in a separate availability set:
			- group VMs with similar functions together into separate availability sets
		- For No single point of failure

Microsoft provides [Service Level Agreements (SLAs) for Azure Virtual Machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_9/) for Azure virtual machines and availability sets. Considerations:
- Redundancy
- Separation of application tiers
- Load balancing
- Managed Disks

Administrator tooling:
- Azure Portal
- ARM - [[Azure-Administration-Azure-Resource-Manager]]
- Scripting
- API Tools
Consider:
- Redundancy
- Separation of Application Tiers - no single point of failure
- Managed Disk for Block-Level Storage 

An Availability set is
- Assigned an:
	- Fault Domain - up to 3
		- Are a group of virtual machines that share a common power source and network switch.
		- Two fault domains work together to mitigate against hardware failures, network outages, power interruptions, or software updates.
	- Update Domains - up to 20
		- Are groups of virtual machines and underlying physical hardware that can be rebooted at the same time
		- Planned Maintenance:
			- Only one update domain is rebooted at a time.
		- If 5 (By default, there are five (non-user-configurable)) Update domains, the 6th will be in the 1st, 7th would in the 2nd if we added it, etc - if 20 the 21st VM is in the 1st.. 
	- Can't be changed once the availability set has been created

![1080](azure-updateandfault-domains.excalidraw.md)

Availability Zones:
- Unique physical locations within a Azure Region
	- One or more Data centres
- Minimum of three Availability zones to ensure resiliency 
- Prevents against Data centre failure
- Prevents single point of failure with Zone redundancy

![](azureservicessupportingavailabilityzones.png)
for
Scalability - goes Vertically (VM Size up or down) and Horizontally (Number of VMs)
Considerations:
- Limitations
- Flexibility
- Reprovisioning

#### Workflows

Create and Manage VM Scale Sets
`Search -> Virtual machine scale sets` 
Considerations:
Scale sets are assigned to (like Availability sets):
- Update Domains -  is a group of nodes that are upgraded together
- Fault Domains -  is a group of nodes that represent a physical unit of failure
- Basics
	- Orchestration mode:
		- Uniform - for large scale stateless workloads with identical instances - department workstation
		- Flexible - high availability at scale with identical or multiple instances - any configuration to the scale set.
	- Advanced tab to enable beyond 100 instances; spreading for optimal spreading of allocation 
	- Configure Scaling in the `Scaling` tab; 
		 - Policy - min/max number of instances; manual or autoscaling 
		 - Scale in - CPU threshold, decrease of instances
		 - Scale out - CPU threshold, duration, increase of instances
		 - Scale-In policy - default, newest, oldest vms
	- Size = Price; Azure Spot - discount unused pool ; image = OS, arch = x86 or arm64
		- Azure Spot must have set a eviction policy as Azure has capacity needs:
			- Deallocation - moves your VM to the stopped-deallocated state, allowing you to redeploy it later, with not guarantee of allocation success, you'll be charged storage costs for the underlying disks.
			- Delete - VMs is deleted with underlying disk 
- Continue with Disk, 
-  Implement Virtual Networking `Search -> Virtual Network -> $Vnet (With Subnet, VMs, DNS, NSGs, etc configured)` in the `Private DNS Zone -> Virtual Network Link -> + Add - provide a Link name, Vnet` 
- Scaling - Configure Scaling in the `Scaling` tab; 
	 - Policy - min/max number of instances; manual or autoscaling 
		- Manual - maintains a fixed instance count
		- Autoscaling -  scales the capacity on any schedule, based on any metrics.
	- Scale-In policy - default, newest, oldest VMs
		 -  Scale in - by **an decrease in** X percentage and Y number of VM instances 
	- Scale-out Policy
		- Scale out - **increase in** X percentage, Y duration and by Z number of VM instances 
- Management, Health, Tags and Review and Create
- Advanced tab
	- to enable beyond 100 instances; spreading for optimal spreading of allocation
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


Manually scale Virtual Machine Scale Sets
```bash
az vmss scale \
    --name MyVMScaleSet \
    --resource-group MyResourceGroup \
    --new-capacity 6
```

Install an application across a scale set with Custom Script Extension - Script below
```json
# yourConfigV1.json 
{
  "fileUris": ["https://raw.githubusercontent.com/yourrepo/master/custom_application_v1.sh"],
  "commandToExecute": "./custom_application_v1.sh"
}
```
Install new application with Azure CLI and 
```bash

az vmss extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --resource-group myResourceGroup \
  --vmss-name yourScaleSet \
  --settings @yourConfigV1.json
```

Create a Virtual Machine Scale Set with an upgrade policy 
```bash
az vmss create \
  --resource-group MyResourceGroup \
  --name MyScaleSet \
  --image UbuntuLTS \
  --upgrade-policy-mode automatic \
  --admin-username azureuser \
  --generate-ssh-keys
```

## References

[Youtube Azure Administrator Certification (AZ-104)](https://www.youtube.com/watch?v=10PbGbTUSAg)
[autoscale with Azure Virtual Machine Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-autoscale-overview).
[Deploy your application on Azure Virtual Machine Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-deploy-app).
[Choose the right number of fault domains for Azure Virtual Machine Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-manage-fault-domains)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[Learn Microsoft - Availability Set Overview](https://learn.microsoft.com/en-us/azure/virtual-machines/availability-set-overview)