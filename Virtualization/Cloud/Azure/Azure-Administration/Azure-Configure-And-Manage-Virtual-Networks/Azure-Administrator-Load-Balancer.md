## Azure-Administrator Load Balancer

Load Balancing is used to efficiently distribute incoming network traffic across back-end servers and resources. A load balancer is implemented by using load-balancing rules and health probes. It sit between the Frontend and Backend to test the Backend and deal with the flow of traffic from the Frontend. 
- Load Balancer scales up to millions of TCP and UDP application flows.
- For Inbound and Outbound
- Public or Internal
- Components:
	- Front-end IP configuration 
		- Specifies the public IP or internal IP that your load balancer responds to.
	- Back-end pools
		- Are services and resources including VMs or Scale-sets
	- Health probes
		- Tests health of Backend
	- Load-balancing rules
		- Detirmine traffic distribution to Backend
		
A Load Balancer Distribution modes:
- 5-tuple hash (multiple VMs: 
	- Source IP
	- Source port 
	- Destination IP 
	- Destination port
	- Protocol type 
- Source IP affinity/Session Affinity/Client IP affinity uses (for one Specific Client):
	- 2-tuple hash: Source and Destination IP

- An **availability set** is a logical grouping that you use to isolate virtual machine resources from each other when they're deployed. Availabilty sets allow virtual machines to remain available when a physical server fails.
- An **availability zone** offers groups of one or more datacenters that have independent power, cooling, and networking.

Basic load balancers allow:
- Port Forwarding
- Automatic reconfiguration
- Health probes
- Outbound connections through source network address translation (SNAT)
- Diagnostics through Azure Log Analytics for public-facing load balancers

Standard load balancers support all of the basic load balancer features. They also allow:
- HTTPS health probes
- Availability zones
- Diagnostics through Azure Monitor, for multidimensional metrics
- High availability (HA) ports
- Outbound rules
- A guaranteed SLA (99.99% for two or more virtual machines)

Basic Vs Standard SKUs for Load Balancers
![1080](azurecomparebasicandstandskusforloadbalancers.png)
The Gateway SKU supports high performance and high availability scenarios with third-party network virtual appliances (NVAs).

Load Balancers Workflows by Type and important information:
`Search -> Load Balancers` and `+ Create` a type:
- Application Gateway - Region layer 7 load balancer
- Front Door - Global Layer 7 load balancer 
- Load Balancer - Layer 4 for internal and public configurations
	- SKU options: Basic, Standard, and Gateway 
- Traffic Manager - DNS-based traffic load balancer
Manage:
`Search -> Load Balancers -> $loadBalancer`:
- Front-end IP configuration 
- Back-end pools: `+ Add -> $name & $Vnet`
- Health probes: `+ Add -> $name & Protocol, Port and Interval`
- Load-balancing rules (can be used in combination with NAT rules) - requires a frontend, backend, and health probe; define a rule:
	- IPv4 or 6
	- Frontend IP address
	- Backend pool or Backend port
	- Health probe
	- Session persistence: None (default), Client IP, Client IP and Protocol

Application Gateway Configuration
- Routing Methods
	- Path-based routing: sends requests with different URL paths to different pools of back-end servers.
	- Multi-site routing: configures more than one web application on the same application gateway instance.
- Optional Firewall checks (Recommended)
	- OWASP defines a set of generic rules for detecting attacks. These rules are referred to as the Core Rule Set (CRS)
- Traffic Redirection
- Rewrite HTTP Headers
- Custom Error pages instead of default error pages - highly advised Attacker need error pages

Application Gateway distributes requests across multiple servers by using a round-robin technique.
![](azureapplicationgatewayflowdiagram.png)
- Listen is either Basic or Multi-site and handle TLS/SSL certificates


Source IP affinity load balancer
```powershell
$lb = Get-AzLoadBalancer -Name MyLb -ResourceGroupName MyResourceGroup
$lb.LoadBalancingRules[0].LoadDistribution = 'sourceIp'
Set-AzLoadBalancer -LoadBalancer $lb
```

1. `Create a Resource -> Load Balancer` - options:
2. `Basic: SKU, Type ( Public | Internal ) and Tier (Regional | Global )`. 
3. `Configure front-end IP configuration -> Add (Consider assignment*)`  
4. `Configure back-end IP configuration -> Select backend pool VMS`  
5. `Inbound Rules -> Add`

Add session persistence to a load balancer
`Search Load Balancers -> Load Blancers -> $LB -> Edit -> Sessions persistence dropdown -> None, Client IP, Client IP and Protocol`

- RDP Desktop Gateway + Load Balancer = must be Source IP affinity LB
- Media upload + Load Balancer = must be Source IP affinity LB

Load Balancer in Powershell
```powershell;
$Location = $(Get-AzureRmResourceGroup -ResourceGroupName [sandbox resource group name]).Location
# Create a public IP address 
$publicIP = New-AzPublicIpAddress `
  -ResourceGroupName $rGroup `
  -Location $Location `
  -AllocationMethod "Static" `
  -Name "myPublicIP"
# Create Front-end IP
$frontendIP = New-AzLoadBalancerFrontendIpConfig `
  -Name "myFrontEnd" `
  -PublicIpAddress $publicIP
# Create a back-end address pool
$backendPool = New-AzLoadBalancerBackendAddressPoolConfig -Name "myBackEndPool"
# Allow Load Balancer to monitor backend pool
$probe = New-AzLoadBalancerProbeConfig `
  -Name "myHealthProbe" `
  -Protocol http `
  -Port 80 `
  -IntervalInSeconds 5 `
  -ProbeCount 2 `
  -RequestPath "/"
# Create a rule for the Load Balancer
$lbrule = New-AzLoadBalancerRuleConfig `
  -Name "myLoadBalancerRule" `
  -FrontendIpConfiguration $frontendIP `
  -BackendAddressPool $backendPool `
  -Protocol Tcp `
  -FrontendPort 80 `
  -BackendPort 80 `
  -Probe $probe
# Create Load Balancer
$lb = New-AzLoadBalancer `
  -ResourceGroupName $rGroup `
  -Name 'MyLoadBalancer' `
  -Location $Location `
  -FrontendIpConfiguration $frontendIP `
  -BackendAddressPool $backendPool `
  -Probe $probe `
  -LoadBalancingRule $lbrule
# Connect the VMs to the back-end pool 
$nic1 = Get-AzNetworkInterface -ResourceGroupName $rGroup -Name "webNic1"
$nic2 = Get-AzNetworkInterface -ResourceGroupName $rGroup -Name "webNic2"
# Update the network interfaces 
$nic1.IpConfigurations[0].LoadBalancerBackendAddressPools = $backendPool
$nic2.IpConfigurations[0].LoadBalancerBackendAddressPools = $backendPool

Set-AzNetworkInterface -NetworkInterface $nic1 -AsJob
Set-AzNetworkInterface -NetworkInterface $nic2 -AsJob
# Get pulic IP of the Load Balancer and URL for website
Write-Host http://$($(Get-AzPublicIPAddress `
  -ResourceGroupName [sandbox resource group name] `
  -Name "myPublicIP").IpAddress)
```

Load Balancer in Bash
```bash
az network public-ip create \
  --resource-group $rGroup \
  --allocation-method Static \
  --name myPublicIP

az network lb create \
  --resource-group $rGroup \
  --name myLoadBalancer \
  --public-ip-address myPublicIP \
  --frontend-ip-name myFrontEndPool \
  --backend-pool-name myBackEndPool

az network lb probe create \
  --resource-group $rGroup \
  --lb-name myLoadBalancer \
  --name myHealthProbe \
  --protocol tcp \
  --port 80

az network lb rule create \
  --resource-group $rGroup \
  --lb-name myLoadBalancer \
  --name myHTTPRule \
  --protocol tcp \
  --frontend-port 80 \
  --backend-port 80 \
  --frontend-ip-name myFrontEndPool \
  --backend-pool-name myBackEndPool \
  --probe-name myHealthProbe

# Connect the VMs to the back-end pool and update NIC
az network nic ip-config update \
  --resource-group $rGroup \
  --nic-name webNic1 \
  --name ipconfig1 \
  --lb-name myLoadBalancer \
  --lb-address-pools myBackEndPool

az network nic ip-config update \
  --resource-group $rGroup \
  --nic-name webNic2 \
  --name ipconfig1 \
  --lb-name myLoadBalancer \
  --lb-address-pools myBackEndPool
# Get pulic IP of the Load Balancer and URL for website
echo http://$(az network public-ip show \
                --resource-group [sandbox resource group name] \
                --name myPublicIP \
                --query ipAddress \
                --output tsv)
```

## References

[John Savill's Microsoft Azure Master Class Part 6 - Networking](https://www.youtube.com/watch?v=K8ePZdLfU7M&t=3511s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
