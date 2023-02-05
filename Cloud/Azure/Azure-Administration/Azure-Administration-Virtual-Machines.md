# Azure Administration - Virtual Machines



Azure Virtual Machines (VMs) are a configurable server without having to buy and maintain physical hardware, they still require:
- Patching
- Installing packages
- Configurating Package
- Attach multiple Managed Disk to your Azure Vms

Consider reading [[Virtual-Machines]] for a more general overview and [[VirtualBox-Networking]] as well as making the virtual networks first before make machines [[Azure-Administration-Virtual-Networking]], it is free and simplier.

Azure VMs support granular controls at scale and is the basis of the Azure infrastructure as a service (IaaS) model. It splits the reponsibilities 
![1080](azurevmcustomerandazurerespsplit.png)
Windows VMs still require a License!

The size of the image is detirmined by the image, which also defines the vCPUs, Memory and Storage Capacity. Limitations on VMs per regions found here: [Azure subscription and service limits, quotas, and constraints](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits). They are billed at a hourly rate.

Components created with the Virtual Machine:
- OS you must specify the Operating Systems - found in the Azure Marketplace
	- BYOLinux require Linux Virtual Hard Disk (VHD)  - VHDX is not supported Azure
- Network Security Group (NSG) - attach to the NIC - virtual firwall
- Network Interface (NIC) - device that handles IP protocols and network communications
- Virtual Machine Instances -  the actual running server
- Public IP address - Address that you will use to public access the VM
- Virtual Network (VNet) - The network where your VM will reside

Consider reading - [[Cloud-Initialization]]; regarding VMs in Azure they require some forethought and virtual infrastructure - Questions to ask what is the purpose of the VM, where should it then be avaliability in security, location, use, etc? Generally the cost part is then tweakable or more obvious
1. A network - How is the VM accessed and why
2. A name - Does it fit a good naming and tag scheme to keep track of why you need it
	- best to detirmine how tagging will fit within the large context   
3. Location - region
3. Size 
4. Storage type - [[Azure-Administration-Storage-Accounts]], [Azure Managed Disks](https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview) handle Azure storage account creation and management - `C:` is default system disk
	- Temporary disks - do not store on temporary disk, but log temporary data for security
	- Linux `/dev/sdb`
		- Windows `D:`
1. OS - not just Windows, but if you want containerization use [[Azure-Administration-Azure-Containers-Instances]] - What is the user require to do their job? 
	1. Azure Arc for abstraction layer on top of  Kubernetes Clusters

#### VM Sizes

SKU family / Series are interchangable terminology

General Purpose - Balanced CPU-to-Memory ratio. Testing and development, small to medium databases, and low to medium traffic web servers.
SKUs: B, Dsv3, Dv3, Dasv4, Dav4, DSv2, Dv2,Av2, DC, DCv2, Dv4, Dsv4, Ddv4, Ddsv4
- B1 is very common as it is cost effective.

Compute Optimized - High CPU-to-memory ratio. Good for medium traffic web servers, network appliances , batch processes, and app servers. 
SKUs: F, Fs, Fsv2

Memory Optimized - High CPU-to-memory rational database servers, medium to large caches, and in-memory analytics:
SKUs: Esv3, Ev3, Easv4, Eav4, Ev4, Esv4, Edsv4, Mv2, M, DSv2, Dv2

Storage Optimizaed - High disk throughput and IO idea for Big Data, SQL, NoSQL databases, data warehousing and large transactional databases
SKUs: Lsv2

GPU - Specialized VMs for heavy grpahic rendering and video editing, model training and inferencing (ND) with deep learning. Available with single or multiple GPUs.
SKUs: NC, NCv2, NCv3, NCastT4_v3 (Preview), ND, NDv2, (Preview), NV, NVv3, NVv4

High performance compute - fastest and pomst powerful CPU virtual machines with optional high-throughput network interfaces (RDMA)
SKUs: HB, HBv2, HC, H

Azure Compute Units (ACU) a method of comparing compute CPU performance across Azure SKUs. ACU is a Small (Standrd_A1) VM with [current value of 100](https://learn.microsoft.com/en-us/azure/virtual-machines/acu), whereare all other SKUs then represent approximately how much faster that SKU can run a standard benchmark

#### VM Via Azure Mobile App

You can monitolt Domains
- Newest VM - Delete the newest created VM, balanced across AZsr your VMs on the go with [mobile App](https://azure.microsoft.com/en-gb/products/app-service/mobile/). 

#### Hyper-V and Generation 1 vs 2

Hyper-V is Microsoft's hardware virtualization product, it lets you create and run a software version of a computer, called a virtual machine. Each virtual machine acts alike a complete computer, running an operating system and programs.

Generation 1 - BIOS-based - support most guesst operating systems
Generation 2 -  UEFI based - supports most 64-bit versions of Windows and more current version of Linux and FreeBSD operating systems

Azure has Generation 1 and Generation 2 are similar, but exactly the same as Hyper-V Generations - Hyper-V VMs are packaged into VHD or VHDX files.

#### Connecting to the VM

SSH, RDP or Azure Bastion
- [[RDP-Cheatsheet]]
- [[SSH-Cheatsheet]]

Azure Bastion is a service you deploy that lets you connect to a virtual machine using your browser and the Azure Portal. It provides secure and seamless RDP/SSH connectiveity to virtual machine over TLS so that you can use the browser.

You have to create a Azure BastionSubnet called `AzureBastionSubnet` with atleast /27 size.

`Search -> Bastions` or after `Creating a Virtual Machine`


#### Update Management

Update Management allow you to automate and install operating system updates and patches for both Windows and Linux. It uses Azure Automation underneath Update Managemen, switch performs a compliance scan every 24 hours. Log Analytics workspace and Automation Account required like all Azure Automation
lt Domains
- Newest VM - Delete the newest created VM, balanced across AZs


#### Virtual Machine Monitoring

Automation Accounts - `Search -> Automataion Accounts -> Create`

`Subscriptions -> Resource Providers` - we need:

- `Microsoft.AlertsManagement` - https://learn.microsoft.com/en-us/azure/azure-monitor/insights/alert-management-solution
- `Microsoft.insights`  - https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview?tabs=net

And also:
- Virtual Networks for VMs [[Azure-Administration-Virtual-Networking]]
- Auto-instrumentation - https://learn.microsoft.com/en-us/azure/azure-monitor/app/codeless-overview




## References

[Youtube Azure Administrator Certification (AZ-104)](https://www.youtube.com/watch?v=10PbGbTUSAg&t=14542s)
