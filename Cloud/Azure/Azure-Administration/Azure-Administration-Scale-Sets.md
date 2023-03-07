# Azure Administration Scale Sets

Azure Scale sets allows automatic increases and decreases in VM capacity. Load Balancers can be associated with a Scale Set:
- Evenly distribute VM accross availablility Zones - more avaliablility
- Use Load Balancer probe checks for more robust Health checks

Load Balancers:
1. Application Gateway is an HTTP/HTTPS web traffic load balancer application firewall
2. Azure Load Balancer supports all TCP/UDP network traffic, port-forwarding and outbound flaws.

A **Scaling Policy** detirmines what VM is removed to decrease the capacity of the Scale Set either:
- Default - Delete VM with highest instance ID balanced across AZs and Fault Domains
- Newest VM - Delete the newest created VM, balanced across AZs
- Oldest VM - Delete oldest VM balanced across AZs 

**Update Policy** determine VM instances are brought up-to-date with the latest scale set model
- Automatic: Increasing with start upgrading immediately in random order
- Manual - Existing instances must be manaually upgraded
- Rolling - Upgrade roll out in batches with optional pause
Health monitoring can be enabled to detirmine if server is healthy or unhealthy
1. Application health extension: Ping an HTTP request to a specifrc path and except a status 200
2. Load Balancers Probe - allow checks based on TCP, UDP or HTTP requests.

Automatic Repair policy if an instance is found to be unhealthy the delete it and launch a new instance

**Autoscaling** - minimizes the number of unnecessary virtual machine instances that run your application, consider:
- Overhead
- Events
- Scaling in and out given demand
- Define adjustment in capacity

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