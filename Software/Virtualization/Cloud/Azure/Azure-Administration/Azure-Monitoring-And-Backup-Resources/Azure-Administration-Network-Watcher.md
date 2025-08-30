# Azure-Administration Network Watcher

#### Azure Network Watcher

**Network Watcher** provides tools to **monitor**, **diagnose**, view **metrics**, and enable or disable **logs** for resources in an Azure virtual network (**regional service**)!

Watcher can monitor and repair Azure resources you provision:
- Cannot be used to monitor PaaS (fully managed services) monitoring or Web Analytics
- Disabled by default in most regions you need to enable it at per region basis
- Visualise the topology of VNets

Network Performance Monitor (NPM) is cloud-based hybrid network monitoring solution , which helps you monitor network performance between various points in your network infrastructure.
- Traffic black-holing 
- Route errors
- Unconventional Network Issues
- Generates Alerts and Notifies you when a threshold is breached for a network link.

- `NetworkWatcherAgentWindows` agent is an extension that required on Azure VMs!
- 1 Network Watcher per region 
- `Packet capture` - Automate remote network monitoring and triggering alerts from packet capture
	-  `Network Watcher -> Packet capture`
- Network Security Group Flow Logs (NSG Flow Logs) for network traffic pattern collection
- `VPN troubleshoot` - Diagnose VPN issues
	- `Network Watcher -> VPN troubleshoot
- Visual Network Typology 
	- `Network Watcher -> Topology`
- `Connection Troubleshoot` - suite of networking tools and capabilities to troubleshoots network performance and connectivity issues in Azure.
	 - `Network Watcher -> Connection troubleshoot`
- `Verify IP flow` -  IP flow verify checks if a packet is allowed or denied to or from a virtual machine. Identify based on NSGs
	- `Network Watcher -> Ip flow verify`
- `Next Hop` - determine if traffic is being directed to the intended destination by showing the next hop
	- `Network Watcher -> Next Hop`
- `Connection Monitor` - provides unified, end-to-end connection monitoring in your Azure and hybrid networks!
- `Traffic Analytics` - is a cloud-based solution that provides visibility into user and application activity in your cloud networks by analyses NSG flow logs
- `Network Typology` - visualise a virtual network

#### Network Watcher Workflows

View a Network Typology by subscription, Resource Group and Vnet
`Search -> Network Watcher -> Topology`

Azure CLI view network typology
```powershell
# A Configuration
az network watcher configure \
  --resource-group $rGroup \
  --location eastus \
  --enabled true
# Show a typology for a resource group
az network watcher show-topology --resource-group $rGroup
```

Create a new NetworkWatcher
```powershell
New-AzNetworkWatcher `
  -Name NetworkWatcher_eastus `
  -ResourceGroupName NetworkWatcherRG
```

Retrieve a Network Watcher instance with [Get-AzNetworkWatcher](https://learn.microsoft.com/en-us/powershell/module/az.network/get-aznetworkwatcher)
```powershell
$nw = Get-AzResource `
  | Where {$_.ResourceType -eq "Microsoft.Network/networkWatchers" -and $_.Location -eq "EastUS" }
$networkWatcher = Get-AzNetworkWatcher `
  -Name $nw.Name `
  -ResourceGroupName $nw.ResourceGroupName
```

Retrieve a topology
```powershell
Get-AzNetworkWatcherTopology `
  -NetworkWatcher $networkWatcher `
  -TargetResourceGroupName $rGroup
```

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[John Savill](https://www.youtube.com/@NTFAQGuy) 