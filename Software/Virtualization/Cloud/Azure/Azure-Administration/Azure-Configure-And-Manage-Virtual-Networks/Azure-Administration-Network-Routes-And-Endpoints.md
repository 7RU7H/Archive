# Azure Administration Network Routes And Endpoints

Azure uses *system routes* to control network traffic between virtual machines, on-premises networks, and the internet. System routes are automatically created and assigned to each Subnet in a Virtual Network. Information about the system routes is recorded in a *route table*.
- The route table contains a set of rules (routes) specifying packet routing in a Vnet  
	- Each packet leaving a Subnet is handled by on associated route table
	- Packets are matched to routes by using the destination.
	- If matching route cannot be found it is dropped.


Azure automatically handles all network traffic routing with System Routes, except in a custom configurations called User-Defined-Routes (UDRs) in Service chains - [[Azure-Administration-Virtual-Networking-Peering]]: 
-  The valid next hop choices are virtual appliance, virtual network gateway, virtual network, internet, and none.
-  Administrators can user routes configure not system routes.

#### Virtual Network (VNet) Service Endpoint 

Virtual Network (VNet) service endpoints provides secure and direct connectivity to Azure services.
- Service endpoints always take service traffic over the Azure backbone network from your VNet.
- Extend your virtual network identity to your Azure services
- With VNet rules - no public internet access to resources - only from your VNet
- Service endpoints are configured through the Subnet no extra overhead

Determine Service endpoints: 
- **[Azure Storage](https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?toc=/azure/virtual-network/toc.json#grant-access-from-a-virtual-network)** (_Microsoft.Storage_): Generally available in all Azure regions.
	- This endpoint gives traffic an optimal route to the Azure Storage service. Each Storage account supports up to 100 virtual network rules.
- **[Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/vnet-service-endpoint-rule-overview?toc=%2fazure%2fvirtual-network%2ftoc.json)** (_Microsoft.Sql_): Generally available in all Azure regions.
- **[Azure Synapse Analytics](https://learn.microsoft.com/en-us/azure/azure-sql/database/vnet-service-endpoint-rule-overview?toc=%2fazure%2fvirtual-network%2ftoc.json)** (_Microsoft.Sql_): Generally available in all Azure regions for dedicated SQL pools (formerly SQL DW).
- **[Azure Database for PostgreSQL server](https://learn.microsoft.com/en-us/azure/postgresql/howto-manage-vnet-using-portal?toc=/azure/virtual-network/toc.json)** (_Microsoft.Sql_): Generally available in Azure regions where database service is available.
- **[Azure Database for MySQL server](https://learn.microsoft.com/en-us/azure/mysql/howto-manage-vnet-using-portal?toc=/azure/virtual-network/toc.json)** (_Microsoft.Sql_): Generally available in Azure regions where database service is available.
- **[Azure Database for MariaDB](https://learn.microsoft.com/en-us/azure/mariadb/concepts-data-access-security-vnet)** (_Microsoft.Sql_): Generally available in Azure regions where database service is available.
- **[Azure Cosmos DB](https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-configure-vnet-service-endpoint?toc=/azure/virtual-network/toc.json)** (_Microsoft.AzureCosmosDB_): Generally available in all Azure regions.
- **[Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/general/overview-vnet-service-endpoints)** (_Microsoft.KeyVault_): Generally available in all Azure regions.
	- The virtual network service endpoints for Key Vault allow you to restrict access to a specified virtual network. The endpoints also allow you to restrict access to a list of IPv4 (internet protocol version 4) address ranges. Any user connecting to your key vault from outside those sources is denied access.
- **[Azure Service Bus](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-service-endpoints?toc=/azure/virtual-network/toc.json)** (_Microsoft.ServiceBus_): Generally available in all Azure regions.
	- The integration of Service Bus with virtual network service endpoints enables secure access to messaging capabilities from workloads like virtual machines that are bound to virtual networks. The network traffic path is secured on both ends.
- **[Azure Event Hubs](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-service-endpoints?toc=/azure/virtual-network/toc.json)** (_Microsoft.EventHub_): Generally available in all Azure regions.
- **[Azure Data Lake Store Gen 1](https://learn.microsoft.com/en-us/azure/data-lake-store/data-lake-store-network-security?toc=/azure/virtual-network/toc.json)** (_Microsoft.AzureActiveDirectory_): Generally available in all Azure regions where ADLS Gen1 is available.
- **[Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/app-service-ip-restrictions)** (_Microsoft.Web_): Generally available in all Azure regions where App service is available.
- **[Azure Cognitive Services](https://learn.microsoft.com/en-us/azure/cognitive-services/cognitive-services-virtual-networks?tabs=portal)** (_Microsoft.CognitiveServices_): Generally available in all Azure regions where Cognitive services are available.


Azure Private Link (review [[Azure-Administration-Private-Link-And-Endpoints]])  provides private connectivity from a virtual network to Azure platform as a service (PaaS), customer-owned, or Microsoft partner services to simplify Network Architecture and secure connection between endpoints in Azure. 
#### Service Endpoints and Service Endpoints Policies

NSGs are focused on traffic int and out of the virtual network, Azure PaaS options have built-in Firewalls to often restrict a service to only specific subnets of specific virtual networks. Service endpoints make a specific Subnet known to specific Azure service and add optimal path to service.

- Virtual firewalls on service are configurable to allow only a specific subnet
- Service Endpoint Policies allow specific instances of services to be allowed from a virtual network, which is not possible with NSG service Tag
- Service Endpoints are not route-able

## References

[All Azure Technologies @ one Place - AZURE HEROES (azure-heros.com)](https://www.azure-heros.com/blog/azure-routing-from-zero-to-hero-the-basic)
[John Savill's Microsoft Azure Master Class Part 6 - Networking](https://www.youtube.com/watch?v=K8ePZdLfU7M&t=3511s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
