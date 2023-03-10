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
1. OS - not just Windows, but if you want containerization use [[Azure-Administration-Azure-Container-Instances]] - What is the user require to do their job? 
	1. Azure Arc for abstraction layer on top of  Kubernetes Clusters

#### VM Sizes

Sizing is important
![1080](azurevmsizingtable.png)

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

You can monitorv Domains
- Newest VM - Delete the newest created VM, balanced across AZsr your VMs on the go 
- With [mobile App](https://azure.microsoft.com/en-gb/products/app-service/mobile/). 

#### Availabilty Sets

An availability set is a logical feature you can use to ensure a group of related identical virtual machines are deployed together and torn down together. Azure manages physical location, Administrator builds:
- Azure Portal
- ARM - [[Azure-Administration-Azure-Resource-Manager]]
- Scripting
- API Tools
Consider
- Redundancy
- Seperation of Application Tiers - no single point of failure
- Managed Disk for Block-Level Storage

Scale sets:
- Update Domains -  is a group of nodes that are upgraded together
- Fault Domains -  is a group of nodes that represent a physical unit of failure

Availability Zone
- Zonal Services pin each resource to a specific zone.
- Zone-Redundant services are zone-redundant, the platform replicates automatically across all zones.

## Azure Portal Workflows

Create a VM
`Azure services -> Create resource -> Search (resource - Windows Server)`
Provide configurations for Basic, Disks, Networking (**BEWARE** Azure creates default - it is non trivial to change after creation - CHECK! - Address space and Subnets!), Managemnt, Advanced; Next:
1. Create an NSG
2. Create inbound traffic rule 
3. Attached data disks - best practice on App data storage not temp or C:

Connect to a VM via RDP
`Search All Resources -> $name -> Connect -> select RDP`

#### VM Extensions

Many of the maintenance tasks are repetitive and time-consuming one way to automate it is VM extensions. You can manage virtual machine extensions with the Azure CLI, PowerShell, Azure Resource Manager (ARM) templates, and the Azure portal; for either existing or newly deployed VMs.
- Custom Script Extensions 
- Powershell Desired State Configuration
- First and Third party extensions exist

Custom Script Extension to run scripts - timesout after 90 minutes
```powershell
Set-AzVmCustomScriptExtension -FileUri https://scriptstore.blob.core.windows.net/scripts/Install_IIS.ps1 -Run "PowerShell.exe" -VmName vmName -ResourceGroupName resourceGroup -Location "location"
```

Desired State Configuration - create specific configuration with scripts 
```powershell
configuration IISInstall # configuration script block
{
   Node "localhost" # Which VMs are configured
   { 
      WindowsFeature IIS # The resourcce block  
      {
         Ensure = "Present" # indicate if Role or Feature
         Name = "Web-Server" 
      }
   }
}
```

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

`Search -> Bastions` or after `Creating a Virtual Machine`


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
- Virtual Networks for VMs [[Azure-Administration-Virtual-Networking]]
- Auto-instrumentation - https://learn.microsoft.com/en-us/azure/azure-monitor/app/codeless-overview

## Protect VMs with Azure Automation State Configuration

Azure Automation State Configuration ensure VMs in a a cluster are in a consistent state, one way is with the declarative model of PowerShell Desired State Configuration (DSC). Why - more than just the obvious?
- Centralizes management of your DSC artifacts and the DSC process.
- Azure Automation State Configuration has a built-in pull server
- Integrate Azure Monitor logs to review the compliance of your nodes

Requires:
- Port 443
- Global URL
- Global URL of US Gov Virginia: \*.azure-automation.us
- Agent service: https://`<workspaceId>`.agentsvc.azure-automation.net

Azure Automation DSC supports the following operating systems:

-   Windows - Azure DSC supports WMF 4.0 and later
    -   Server 2019
    -   Server 2016
    -   Server 2012 R2
    -   Server 2012
    -   Server 2008 R2 SP1
    -   11
    -   10
    -   8.1
    -   7
-   Linux
    -   The DSC Linux extension supports all the Linux distributions listed in the [PowerShell DSC documentation](https://learn.microsoft.com/en-us/powershell/dsc/getting-started/lnxgettingstarted).
Proxy support for the DSC agent is available in Windows builds 1809 and later. Proxy support is unavailable in DSC for previous versions of Windows.


The Local Configuration Manager (LCM) is the  is a component of the Windows Management Framework (WMF) on a Windows operating system responsible for updating the state of a node to match a desired state. It performs the steps: 
1. Get - get current state
2. Test - compare states
3. Set - update
LCM on each node can operate in two modes:
- Push - Administrator manually push configurations to node
- Pull - The LCM on each node polls the pull server at regular intervals, by default every 15 minutes, to get the latest configuration details

## Azure  Automation

Create Automation Account
`Search Automation Accounts -> Automation Accounts -> + Create

Compile DSC script 
`Search Automation Accounts -> Automation Accounts -> $AutomationAccount -> State configuration (DSC) -> Configurations -> Select DSC script -> Compile -> Yes`

Register VMs with your Azure Automation Account
`Search Automation Accounts -> Automation Accounts -> $AutomationAccount -> State configuration (DSC) -> Nodes + Add -> Configure settings -> Comfirm`

Azure Automation Account related

Upload the DSC script into your Azure Automation account
```powershell
Import-AzAutomationDscConfiguration `
    -Published `
    -ResourceGroupName [Sandbox resource group name] `
    -SourcePath $HOME/MyDscConfiguration.ps1 `
    -Force `
    -AutomationAccountName [your-automation-account-name]
```


DSC resources
```powershell
Get-DscResource | select Name,Module,Properties
File # Manages files and folders on a node
Archive # Decompresses an archive in the .zip format
Environment # Manages system environment variables
Log # Writes a message in the DSC event log
Package # Installs or removes a package
Registry # Manages a node's registry key (except HKEY Users)
Script # Executes PowerShell commands on a node
Service # Manages Windows services 
User # Manages local users on a node
WindowsFeature # Adds or removes a role or feature on a node
WindowsOptionalFeature # Adds or removes an optional role or feature on a node
WindowsProcess # Manages a Windows process
```

Push a configuration to a node
```powershell
Start-DscConfiguration -path D:\
```
Pulling a configuration for lots of nodes
1. Set up a DSC and create a DSC configuration
2. Upload DSC script to Azure Automation account - create if required
3. Add required modules, compile configuration
4. Register VM
5. On VM Install DSC VM extension
6. Install WMF
7. LCM applies the desired state -
	1. Poll Pull Server 
	2. Download
	3. Compare
	4. Update

DSC code block
```powershell
Configuration MyDscConfiguration {              ##1
    Node "localhost" {                          ##2
        WindowsFeature MyFeatureInstance {      # Affect resource
            Ensure = 'Present'
            Name = 'Web-Server'
        }
    }
}

MyDscConfiguration -OutputPath C:\temp\         # inline function call
# Compiled into a Managed Object Format (MOF) document a compiled language created by Desktop Management Task Force

# 1 - the configuration block
Configuration MyDscConfiguration {
param
(
    [string] $ComputerName='localhost'
)

Node $ComputerName {
    ...
}
# 2 - Node block > 1;  in array notation
Node @('WEBSERVER1', 'WEBSERVER2', 'WEBSERVER3')
```

With Windows - Create a file share - idempotent approach
```powershell
$shareExists = $false
$smbShare = Get-SmbShare -Name $Name -ErrorAction SilentlyContinue
if($smbShare -ne $null)
{
    Write-Verbose -Message "Share with name $Name exists"
    $shareExists = $true
}

if ($shareExists -eq $false)
{
    Write-Verbose "Creating share $Name to ensure it is Present"
    New-SmbShare @psboundparameters
}
else
{
    # Need to call either Set-SmbShare or *ShareAccess cmdlets
    if ($psboundparameters.ContainsKey("ChangeAccess"))
    {
       #...etc., etc., etc
    }
}
```

With DSC handling with the  `xSmbShare`
```powershell
Configuration Create_Share
{
   Import-DscResource -Module xSmbShare
   # A node describes the VM to be configured

   Node $NodeName
   {
      # A node definition contains one or more resource blocks
      # A resource block describes the resource to be configured on the node
      xSmbShare MySMBShare
      {
          Ensure      = "Present"
          Name        = "MyFileShare"
          Path        = "C:\Shared"
          ReadAccess  = "User1"
          FullAccess  = "User2"
          Description = "This is an updated description for this share"
      }
   }
}
```

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