# Azure-Administration Private Link And Endpoints

Private Links and Endpoints replaces networking will traverse over the Internet to be over the Microsoft Azure backbone network.

- Private Link replaces a resource's public endpoint with a private network interface.
- Private Endpoint is the network interface that replaces the resource's public endpoint.
	- Requires Azure Standard Internal Load Balancer and associated to a Link service:
	- Azure Sotrage
	- CosmoDB
	- SQL

Benefits:
- Private access to PaaS services and Microsoft Partner services on Azure.
- Private access to Azure services in any region.
- Nonpublic routes to Azure services.
- Public endpoints are no longer required.
- Peered Azure virtual networks also get access to Private Link-powered resources.
- On-premises network also gets access to Private Link-powered resources.
	- Connected via ExpressRoute Private Peering or a VPN—and Private Link-powered Azure services.
- Private access to your own Azure services
- Lower the risk of data exfiltration
- You can deploy a maximum of 1,000 Private Endpoint interfaces per virtual network.
- You can deploy a maximum of 64,000 Private Endpoint interfaces per Azure subscription.
- You can map a maximum of 1,000 Private Endpoint interfaces to the same Private Link resource.
- You can deploy a maximum of 800 Private Link Service resources per Azure subscription.
- A maximum of 1,000 Private Endpoint interfaces can map to a single Private Link Service resource.
- You can deploy multiple Private Link Service resources on the same standard load balancer using different front-end IP configurations.
- Third-Party providers a can be powered by Private Link

The PaaS service still has a external facing endpoint that some companies do not want even with firewall/authentication - firewalls and authentication are bypassable. 

## Azure Private Link

**Private Link is a free service**

Azure Private Link provides access to Azure services privately over the Microsoft Azure backbone network instead of publicly over the internet. Azure Private Link is when a external facing Azure PaaS service is accessed from a resource in a VNet the traffic stays on the Azure network. APL enables PaaS Service is an avatar for that service instance and can project custom services that are behind a Load Balancer. Must have consistent DNS management!

Create a Private Link Service and connect it to a *required* **Standard Load Balancer**.
- After creation of a Private Link Service resource, Azure issues an `alias` for the resource:
- `alias` is a globally unique read-only string with the syntax `prefix.guid.suffix`:
	- `prefix.` = A name you supply for the custom service.
	- `guid.` = globally unique ID generated automatically by Azure.
	- `suffix.` = The text `region.azure.privatelinkservice`; region is the region where the Private Link Service is deployed.

## Azure Private Endpoints

**Private Endpoint is not a free service**

Private Endpoint is a network interface that enables a private and secure connection between your virtual network and an Azure service. 

Private Endpoint 
- Unused Private IP address is then mapped to a specified Azure service as a Private Endpoint 
	- you can map multiple Private Endpoint interface to a single resource, but is not recommended - **Beware Here Be DNS issues**   


## Workflows


``



## References

[Youtube Azure Administrator Certification (AZ-104)](https://www.youtube.com/watch?v=10PbGbTUSAg&t=14542s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[What is Azure Private Link? - Training | Microsoft Learn](https://learn.microsoft.com/en-us/training/modules/introduction-azure-private-link/2-what-is-azure-private-link)