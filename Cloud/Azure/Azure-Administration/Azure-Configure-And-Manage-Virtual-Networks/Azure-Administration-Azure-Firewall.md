# Azure-Administration Azure Firewall

Azure Firewall is a cloud-based security service that protects your Azure virtual network resources from incoming and outgoing threats. Azure Firewall is a managed, stateful firewall and cloud-based network security service that protects your Azure Virtual Network resources. Allows creating, enforcement and logging application and network connectivity policies across subscriptions and VNets. It integrates with Azure Monitor for logging and analytics.
- By default denies all traffic through your virtual network - protection from bad actors,  stupidity and blind spots 
- It has a static public IP address 
- Can span multiple availability zones for increased availability during deployment and unrestricted in scalability
- Limit outbound HTTP/S traffic or Azure SQL traffic to a specified list of fully qualified domain names (FQDN) including wild cards
- Create network filtering rules 
- It can distinguish legitimate packets for different types of connections
- Supports threat intelligence-based filtering
- It is a fully stateful Firewall as a Service (FWaaS) with: built-in high availability and unrestricted cloud scalability
- Uses a static public IP address for your VNet resources allowing outside firewalls to identify traffic originating from your virtual network
- Fully integrated with Azure Monitor for logging and analytics
- Azure Firewall on its own VNet
- VNets pass through this Central Vnet
- Comes with Microsoft Threat Intelligence
	- Blocks know malicious IPs and FQDNs

Why?
- You want to protect your network against infiltration.
- You want to protect your network against user error.
- Your business includes e-commerce or credit card payments.
- You want to configure spoke-to-spoke connectivity.
- You want to monitor incoming and outgoing traffic.
- Your network requires multiple firewalls.
- Implement hierarchical firewall policies.
- Multiple Firewalls - Firewall Manager!

Firewall Deployment Options:
![](azurefirewalldeploymentoptions.png)


Azure Firewall is managed through `Azure Portal -> Firewall Manager` - its features: 
![](azurefirewallmanagerfeatures.png)

Azure Standard Firewall features 
![](azurefirewallfeatures.png)

Azure Premium Firewall features:
![](azurepremiumfirewallfeatures.png)

The Azure Firewall signatures/rulesets include:
- An emphasis on fingerprinting actual malware, Command and Control, exploit kits, and in the wild malicious activity missed by traditional prevention methods.
- Over 55,000 rules in over 50 categories.
- The categories include malware command and control, DoS attacks, botnets, informational events, exploits, vulnerabilities, SCADA network protocols, exploit kit activity, and more.
- 20 to 40+ new rules are released each day.
- Low false positive rating by using state-of-the-art malware sandbox and global sensor network feedback loop.

#### How it works in Azure

Characteristics
- The firewall instance has a public IP address to which all inbound traffic is sent.
- The firewall instance has a private IP address to which all outbound traffic is sent.

Depending on traffic origin:
- For allowed inbound traffic, Azure Firewall uses DNAT to translate the firewall's public IP address to the private IP address of the appropriate destination resource in the virtual network.
- For allowed outbound traffic, Azure Firewall uses SNAT to translate the source IP address to the firewall's public IP address.
- Azure Firewall uses SNAT only when the destination IP address is outside your virtual network. If the destination IP address is from your virtual network's private address space, Azure Firewall doesn't use SNAT on the traffic.

With Azure Firewall, Bastion and VPN Gateway by default you can implementing a hub-spoke network - reduces costs of time and money by centralising services. Consider
- Role separation
- Subscription limits
- Shared services

Azure Firewall Rules types:
- **NAT** 
- **Network**
- **Application**


Type Priority - NAT Rule before Network Rule before Application Rule.
- **NAT** - Azure Firewall destination network address translation (DNAT) rules to translate and filter inbound traffic to your subnets
- **Network** rule - Any non-HTTP/S traffic that's allowed to flow through your firewall must have a network rule
- **Application** rules define fully qualified domain names (FQDNs) that can be accessed from a Subnet

Azure Firewall Rules are configured for: 
- **NAT** - Azure Firewall destination network address translation (DNAT) rules to translate and filter inbound traffic to your subnetsThe Azure Firewall signatures/rulesets include:
	- **Name**: Provide a label for the rule.
	- **Protocol**: Choose the TCP or UDP protocol.
	- **Source Address**: Identify the address as * (internet), a specific internet address, or a classless inter-domain routing (CIDR) block.
	- **Destination Address**: Specify the external address of the firewall for the rule to inspect.
	- **Destination Ports**: Provide the TCP or UDP ports that the rule listens to on the external IP address of the firewall.
	- **Translated Address**: Specify the IP address of the service (virtual machine, internal load balancer, and so on) that privately hosts or presents the service.
	- **Translated Port**: Identify the port that the inbound traffic is routed to by Azure Firewall.
- **Network** rule - Any non-HTTP/S traffic that's allowed to flow through your firewall must have a network rule
	- **Name**: Provide a label for the rule.
	- **Protocol**: Choose the protocol for the rule, including TCP, UDP, ICMP (ping and traceroute), or Any.
	- **Source Address**: Identify the address or CIDR block of the source.
	- **Destination Addresses**: Specify the addresses or CIDR blocks of the destination(s).
	- **Destination Ports**: Provide the destination port of the traffic.
- **Application** rules define fully qualified domain names (FQDNs) that can be accessed from a subnet
	- **Name**: Provide a label for the rule.
	- **Source Addresses**: Identify the IP address of the source.
	- **Protocol:Port**: Specify `HTTP` or `HTTPS` and the port that the web server is listening on.
	- **Target FQDNs**: Provide the domain name of the service, such as `www.contoso.com`. Wildcards (\*) can be used. An FQDN tag represents a group of FQDNs associated with well known Microsoft services. Example FQDN tags include `Windows Update`, `App Service Environment`, and `Azure Backup`

Deploy Azure Firewall requires: Resource Group, VNet,
- **AzureFirewallSubnet** - the firewall is in this subnet.
- **Workload-SN** - the workload server is in this subnet. This subnet's network traffic goes through the firewall.
`Search Firewall -> Create -> Configure $Sub, $rGroup, etc..`
- Create default route 
- Configure rules

[Azure Firewall Rules](https://learn.microsoft.com/en-us/azure/firewall/rule-processing) are processed based on:
- Firewall Policy 
	- Rule Collection Group Priority - Highest priority is 100 to Lowest priority is 4096
	- Rule Collection priority
- Classic Rules - 100 is Highest and 65,000 is Lowest priority. at can be accessed from a Subnet

If a match is found it terminates processing.


## References

[John Savill's Microsoft Azure Master Class Part 6 - Networking](https://www.youtube.com/watch?v=K8ePZdLfU7M&t=3511s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[Azure Firewall Rules](https://learn.microsoft.com/en-us/azure/firewall/rule-processing)