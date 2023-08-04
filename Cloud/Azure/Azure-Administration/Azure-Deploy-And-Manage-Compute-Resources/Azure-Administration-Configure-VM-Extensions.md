# Azure-Administration Configure VM Extensions


Many of the maintenance tasks are repetitive and time-consuming one way to automate it is VM extensions. You can manage virtual machine extensions with the Azure CLI, PowerShell, Azure Resource Manager (ARM) templates, and the Azure portal; for either existing or newly deployed VMs.
- Custom Script Extensions 
- PowerShell Desired State Configuration
- First and Third party extensions exist

Know your Azure Agents and Extensions:
- Agents and Extension disambiguation
	-  Extensions
		-  Virtual machine extensions:
			- Small applications that automate the tasks of creating, maintaining, and removing virtual machines.
		- Azure Custom Script Extension
			- is used for post-deployment configuration, software installation, or any other configuration or management task.
		- Desired State Configuration (DSC) 
			- is a management platform to manage an IT and development infrastructure with configuration as code.
		- Azure VMAccess extension
			- acts as a KVM switch that allows you to access the console to reset access to Linux or perform disk-level maintenance.
	- Agents
		- Azure Monitor Agent - Collects monitoring data 
			- Will replace the both Log Analytics Agent and Azure diagnostic at some point:
			- Azure Diagnostic Extension - Enables customers to receive extra data from guest OSes and Workload on Azure resource
			- Log Analytics agent - Collects logs and performance data for Azure Resources
				- for Linux as part of a solution to collect JSON output
		- Dependency Agent 
			- Collects discovered data about certain processes to maps all dependencies between virtual machines and any external process dependencies.

#### Custom Script Extension

Custom Script Extension to run scripts
```powershell
Set-AzVmCustomScriptExtension -FileUri https://scriptstore.blob.core.windows.net/scripts/Install_IIS.ps1 -Run "PowerShell.exe" -VmName vmName -ResourceGroupName resourceGroup -Location "location"
```
 Considerations:
 - Times out after 90 minutes
 - Identify dependencies on VM - do you need network or storage access?
 - Failure Events - plan for erroneous events (need more (permissions|space|etc)?)
 - Protecting sensitive data
#### Desired State Configuration

Desired State Configuration - create specific configuration with scripts 
```powershell
configuration IISInstall # configuration block
{
   Node "localhost" # Which VMs are configured - Node block 
   { 
      WindowsFeature IIS # The resource block  
      {
         Ensure = "Present" # indicate if Role or Feature
         Name = "Web-Server" 
      }
   }
}
```

#### Protect VMs with Azure Automation State Configuration

Azure Automation State Configuration ensure VMs in a a cluster are in a consistent state, one way is with the declarative model of PowerShell Desired State Configuration (DSC). Why - more than just the obvious?
- Centralises management of your DSC artefacts and the DSC process.
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

#### Azure  Automation

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

## Workflows

Install Custom Script Extensions
`Search -> $VM -> Extensions`

## References

[Youtube Azure Administrator Certification (AZ-104)](https://www.youtube.com/watch?v=10PbGbTUSAg)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
