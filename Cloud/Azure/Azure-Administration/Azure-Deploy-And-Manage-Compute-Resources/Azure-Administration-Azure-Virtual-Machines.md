# Azure Administration - Azure Virtual Machines

Azure Virtual Machines (VMs) are a configurable server without having to buy and maintain physical hardware, they still require:
- Patching
- Installing packages
- Configuration Package
- Attach multiple Managed Disk to your Azure VMs

Consider reading [[Virtual-Machines]] for a more general overview and [[VirtualBox-Virtual-Networking]] as well as making the virtual networks first before make machines [[Azure-Administration-Configure-Virtual-Networks]], it is free and simpler.

Azure VMs support granular controls at scale and is the basis of the Azure infrastructure as a service (IaaS) model. It splits the responsibilities 
![1080](azurevmcustomerandazurerespsplit.png)
Windows VMs still require a License!

The size of the image is determined by the image, which also defines the vCPUs, Memory and Storage Capacity. Limitations on VMs per regions found here: [Azure subscription and service limits, quotas, and constraints](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits). They are billed at a hourly rate.

Components created with the Virtual Machine:
- OS you must specify the Operating Systems - found in the Azure Marketplace
	- BYOLinux require Linux Virtual Hard Disk (VHD)  - VHDX is not supported Azure
- Network Security Group (NSG) - attach to the NIC - virtual firewall
- Network Interface (NIC) - device that handles IP protocols and network communications
- Virtual Machine Instances -  the actual running server
- Public IP address - Address that you will use to public access the VM
- Virtual Network (VNet) - The network where your VM will reside

Consider reading - [[Cloud-Initialization]]; regarding VMs in Azure they require some forethought and virtual infrastructure - Questions to ask what is the purpose of the VM, where should it then be availability in security, location, use, etc? Generally the cost part is then tweakable or more obvious
1. A network - How is the VM accessed and why
2. A name - Does it fit a good naming and tag scheme to keep track of why you need it
	- best to determine how tagging will fit within the large context   
3. Location - region
3. Size 
4. Storage type - [[Azure-Administration-Storage-Accounts]], [Azure Managed Disks](https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview) handle Azure storage account creation and management - `C:` is default system disk
	- Temporary disks - do not store on temporary disk, but log temporary data for security
	- Linux `/dev/sdb`
		- Windows `D:`
1. OS - not just Windows, but if you want containerisation use [[Azure-Administration-Azure-Container-Instances]] - What is the user require to do their job? 
	1. Azure Arc for abstraction layer on top of  Kubernetes Clusters
1. Pricing 

#### VM Sizes

Sizing is important
![1080](azurevmsizingtable.png)

SKU family / Series are interchangeable terminology

General Purpose - Balanced CPU-to-Memory ratio. Testing and development, small to medium databases, and low to medium traffic web servers.
SKUs: B, Dsv3, Dv3, Dasv4, Dav4, DSv2, Dv2,Av2, DC, DCv2, Dv4, Dsv4, Ddv4, Ddsv4
- B1 is very common as it is cost effective.

Compute Optimised - High CPU-to-memory ratio. Good for medium traffic web servers, network appliances , batch processes, and app servers. 
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

## Virtual Machine Storage

- OS disk
- Temporary Disk
	-  Windows VMs
		- `D:` drive by default. This drive is used for storing the **pagefile.sys** file.
	- Linux VMs
		- The temporary disk is typically `/dev/sdb`. 
		- This disk is formatted and mounted to `/mnt` by the Azure Linux Agent.
- Data disk 
	-  A managed disk that's attached to a virtual machine to store application data, or other data you need to keep. Data disks are registered as SCSI drives and are labelled with a letter you choose.
Consider:
- Azure Premium Storage & migration
- Multiple Disks
- Managed Disk - Azure manage Paged Blobs
- Azure Bastion for Linux VM software installation

#### Disks

A Disk role is either:
- OS disk contain Operating system files
	- An ephemeral OS disk is a virtual disk that saves data on the local virtual machine storage. An ephemeral disk has faster read-and-write latency than a managed disk, **but an individual virtual machine failure might destroy all the data on an ephemeral disk and leave the virtual machine unable to boot - They are free though**
- Data disk
	- >= 1 virtual disks; maximum capacity of 32,767 GB; persistent storage for data
- Temporary
	- Only 1; Lost during maintenance events

#### Unmanaged Disks

Disk you manual create and manage stored as Paged Blob - [[Azure-Administration-Azure-Disks-Paged-Blobs]]. To...

Create an Unmanaged Disk
`..$(Create VM) -> Disk -> Advanced -> Use managed disk -> No`
- Select Storage Account


#### Managed Disks

A managed disk is a virtual hard disk for which Azure manages all the required physical infrastructure. Because Azure takes care of the underlying complexity, managed disks are easy to use. Stored as Paged Blob - [[Azure-Administration-Azure-Disks-Paged-Blobs]]

- Scalability 
- Availability
- Integration with availability sets and zones
- Support Azure Backup
- Granular access control
- Supports Encryption

#### VM Via Azure Mobile App

You can monitor Domains
- Newest VM - Delete the newest created VM, balanced across AZsr your VMs on the go 
- With [mobile App](https://azure.microsoft.com/en-gb/products/app-service/mobile/). 

## Azure Portal Workflows

Create a VM
`Azure services -> Create resource -> Search (resource - Windows Server)`
Provide configurations for Basic, Disks, Networking (**BEWARE** Azure creates default - it is non trivial to change after creation - CHECK! - Address space and Subnets!), Managemnt, Advanced; Next:
1. Create an NSG
2. Create inbound traffic rule 
3. Attached data disks - best practice on App data storage not temp or C:

Connect to a VM via RDP
`Search All Resources -> $name -> Connect -> select RDP`

Change a VM size requires:
- Stop and deallocate the virtual machine then select any size available in your region.	 
	- Resizing Prod machine is not advised as it might require restart, change IP or configuration settings 

Create an Unmanaged Disk
`..$(Create VM) -> Disk -> Advanced -> Use managed disk -> No`
- Select Storage Account


#### Hyper-V and Generation 1 vs 2

Hyper-V is Microsoft's hardware virtualization product, it lets you create and run a software version of a computer, called a virtual machine. Each virtual machine acts alike a complete computer, running an operating system and programs.

Generation 1 - BIOS-based - support most guesst operating systems
Generation 2 -  UEFI based - supports most 64-bit versions of Windows and more current version of Linux and FreeBSD operating systems

Azure has Generation 1 and Generation 2 are similar, but exactly the same as Hyper-V Generations - Hyper-V VMs are packaged into VHD or VHDX files.

#### Connecting to the VM

SSH, RDP or Azure Bastion - Use VPN to connect to Azure as raw RDP or SSH connections are MITM-able
- [[RDP-Cheatsheet]]
- [[SSH-Cheatsheet]]

Azure Bastion is a service you deploy that lets you connect to a virtual machine using your browser and the Azure Portal. It provides secure and seamless RDP/SSH connectiveity to virtual machine over TLS so that you can use the browser.

You have to create a Azure BastionSubnet called `AzureBastionSubnet` with atleast /27 size.

`Search -> Bastions` or after `Creating a Virtual Machine`Moving Resources - there are edge cases - [see Documentation for more]([Move resources to a new subscription or resource group - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-resource-group-and-subscription)):
- If you're using Azure Stack Hub, you can't move resources between groups.
- [App Services move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/app-service-move-limitations)
	- No existing Apps or TLS/SSL certificate cross region is not allowed!  
	- Resources in Resource Group always move together!
	- No Apps with private endpoints
- [Azure DevOps Services move guidance](https://learn.microsoft.com/en-us/azure/devops/organizations/billing/change-azure-subscription?toc=/azure/azure-resource-manager/toc.json)
- [Classic deployment model move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/classic-model-move-limitations) - Classic Compute, Classic Storage, Classic Virtual Networks, and Cloud Services 
	- Inter-Sub
	- Lots of Operational restrictions (One-X-at-a-Time or  (No Vnets, VM moved only All VMs only with Cloud Service) not RBAC 
	- Sub-To-Sub 
		- Same AAD Tenent
		- No Cloud Service Provider subs
		- Target must not have Classic Resources
		- REST API for classic moves - no Resource Manager
- [Networking move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/networking-move-limitations)
	- Avoid AKS VNet moves
	- Disable peering
	- No VPN Gateway cross-sub moves
	- Connat move a Subnet that has resource navigation links 
- [Recovery Services move guidance](https://learn.microsoft.com/en-us/azure/backup/backup-azure-move-recovery-services-vault?toc=/azure/azure-resource-manager/toc.json)
	- Permissions
	- One-At-A-Time
	- Vaults restrictions - Hacker Senses
		- Key Vault and VMs from same region
		- Only move a vault that contains any of the following types of backup items any not listed -  are stopped and  data permanently deleted before move:
			- Azure Virtual Machines
			- Microsoft Azure Recovery Services (MARS) Agent
			- Microsoft Azure Backup Server (MABS)
			- Data Protection Manager (DPM)
- [Virtual Machines move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
	- Not yet supported
		- Scale sets with Standard LB and Public IP SKUs 
		- Low-priority VM and SSs
		- Dependents - All or Not at all!
		- Individual Availability Sets
		- Marketplace VMs with attached plans
- To move an Azure subscription to a new management group, see [Move subscriptions](https://learn.microsoft.com/en-us/azure/governance/management-groups/manage#move-subscriptions).


#### Update Management

Update Management allow you to automate and install operating system updates and patches for both Windows and Linux. It uses Azure Automation underneath Update Management, switch performs a compliance scan every 24 hours. Log Analytics workspace and Automation Account required like all Azure Automation
lt Domains
- Newest VM - Delete the newest created VM, balanced across AZs


#### Virtual Machine Monitoring

Automation Accounts - `Search -> Automataion Accounts -> Create`

`Subscriptions -> Resource Providers` - we need:

- `Microsoft.AlertsManagement` - https://learn.microsoft.com/en-us/azure/azure-monitor/insights/alert-management-solution
- `Microsoft.insights`  - https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview?tabs=net

And also:
- Virtual Networks for VMs [[Azure-Administration-Configure-Virtual-Networks]]
- Auto-instrumentation - https://learn.microsoft.com/en-us/azure/azure-monitor/app/codeless-overview

## CLI Workflows

[Azure CLI overview](https://learn.microsoft.com/en-us/cli/azure/)
[Azure CLI command reference](https://learn.microsoft.com/en-us/cli/azure/reference-index)

```bash 
# VM Subcommands:
az vm create
--no-wait # can be used in a script to not wait and create next VM 
# Open a specific network port for inbound traffic
az vm open-port 
az vm open-port --port  80 --resource-group $rg --name $name
# Deallocate a VM
az vm deallocate 
# details of a VM
az vm show 
az vm show  --resource-group $rg --name $name
# Update a property of a virtual machine
az vm update 
# Start, Stop, Delete, Restart VM
az vm start 
az vm stop 
az vm restart
az vm delete
# List active VMs
az vm list 
az vm list --output table
# List the IP address by -n name
az vm list-ip-addresses -n SampleVM -o table

# List avaliable images
# filter with:
--publisher
--sku
--offer
az vm image list --output table
# Show all Microsoft images 
az vm image list --publisher Microsoft --output table --all
# All Wordpress images
az vm image list --sku Wordpress --output table --all
# Location specific images
az vm image list --location eastus --output table
# List Sizes of VM, can also be filtered
az vm list-sizes --location eastus --output table
```

Create a VM
```bash
# Returns a response in JSON
az vm create \
  --resource-group $resource_group_name \
  --location westus \
  --name SampleVM \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys \
  --verbose \ 
  --size "Standard_DS2_v2"  
```

Resize a VM
```bash
# List options avaliable
az vm list-vm-resize-options \
    --resource-group $resource_group_name \
    --name SampleVM \
    --output table
# Rezie
az vm resize \
    --resource-group $resource_group_name \
    --name SampleVM \
    --size Standard_D2s_v3
```

You can add filters with [JMESPath.org](http://jmespath.org/) an industry-standard query language built around JSON objects. `$identifier[?subsetObject != '0'].[names]`
```bash
az vm show \
    --resource-group $resource_group_name \
    --name SampleVM \
	--query "networkProfile.networkInterfaces[].id" -o tsv
# More Useful Queries
--query "osProfile.adminUsername"
--query hardwareProfile.vmSize
```

Verifying a stopped VM by querying PowerState
```bash
az vm get-instance-view \
    --name SampleVM \
    --resource-group $resource_group_name \
    --query "instanceView.statuses[?starts_with(code, 'PowerState/')].displayStatus" -o tsv
```

## References

[Youtube Azure Administrator Certification (AZ-104)](https://www.youtube.com/watch?v=10PbGbTUSAg&t=14542s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)