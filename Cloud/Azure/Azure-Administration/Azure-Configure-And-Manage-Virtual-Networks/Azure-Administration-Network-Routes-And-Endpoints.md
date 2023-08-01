Azure uses *system routes* to control network traffic between virtual machines, on-premises networks, and the internet. Information about the system routes is recorded in a *route table*.
- The route table contains a set of rules (routes) specifying packet routing in a Vnet  
- Each packet leaving a subnet is handled by on associated route table
- Packets are matched to routes by using the destination.
- If matching route cannot be found it is dropped.

Azure automatically handles all network traffic routing, except in a custom configurations called User-Defined-Routes (UDRs): 
-  The valid next hop choices are virtual appliance, virtual network gateway, virtual network, internet, and none.
-  Administrators can createazvnetservicechainingandudrs.excalidraw user routes, but not system routes.

Virtual Network (VNet) service endpoint provides secure and direct connectivity to Azure services over an optimized route over the Azure backbone network. Endpoints allow you to secure Azure service resources to only your virtual networks. Service Endpoints enables private IP addresses in the VNet to reach the endpoint of an Azure service without needing a public IP address on the VNet. Service endpoints for your service: 

- **[Azure Storage](https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?toc=/azure/virtual-network/toc.json#grant-access-from-a-virtual-network)** (_Microsoft.Storage_): Generally available in all Azure regions.
- **[Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/vnet-service-endpoint-rule-overview?toc=%2fazure%2fvirtual-network%2ftoc.json)** (_Microsoft.Sql_): Generally available in all Azure regions.
- **[Azure Synapse Analytics](https://learn.microsoft.com/en-us/azure/azure-sql/database/vnet-service-endpoint-rule-overview?toc=%2fazure%2fvirtual-network%2ftoc.json)** (_Microsoft.Sql_): Generally available in all Azure regions for dedicated SQL pools (formerly SQL DW).
- **[Azure Database for PostgreSQL server](https://learn.microsoft.com/en-us/azure/postgresql/howto-manage-vnet-using-portal?toc=/azure/virtual-network/toc.json)** (_Microsoft.Sql_): Generally available in Azure regions where database service is available.
- **[Azure Database for MySQL server](https://learn.microsoft.com/en-us/azure/mysql/howto-manage-vnet-using-portal?toc=/azure/virtual-network/toc.json)** (_Microsoft.Sql_): Generally available in Azure regions where database service is available.
- **[Azure Database for MariaDB](https://learn.microsoft.com/en-us/azure/mariadb/concepts-data-access-security-vnet)** (_Microsoft.Sql_): Generally available in Azure regions where database service is available.
- **[Azure Cosmos DB](https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-configure-vnet-service-endpoint?toc=/azure/virtual-network/toc.json)** (_Microsoft.AzureCosmosDB_): Generally available in all Azure regions.
- **[Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/general/overview-vnet-service-endpoints)** (_Microsoft.KeyVault_): Generally available in all Azure regions.
- **[Azure Service Bus](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-service-endpoints?toc=/azure/virtual-network/toc.json)** (_Microsoft.ServiceBus_): Generally available in all Azure regions.
- **[Azure Event Hubs](https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-service-endpoints?toc=/azure/virtual-network/toc.json)** (_Microsoft.EventHub_): Generally available in all Azure regions.
- **[Azure Data Lake Store Gen 1](https://learn.microsoft.com/en-us/azure/data-lake-store/data-lake-store-network-security?toc=/azure/virtual-network/toc.json)** (_Microsoft.AzureActiveDirectory_): Generally available in all Azure regions where ADLS Gen1 is available.
- **[Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/app-service-ip-restrictions)** (_Microsoft.Web_): Generally available in all Azure regions where App service is available.
- **[Azure Cognitive Services](https://learn.microsoft.com/en-us/azure/cognitive-services/cognitive-services-virtual-networks?tabs=portal)** (_Microsoft.CognitiveServices_): Generally available in all Azure regions where Cognitive services are available.

A virtual network _service endpoint_ provides the identity of your virtual network to the Azure service. After service endpoints are enabled in your virtual network, you can secure Azure service resources to your virtual network by adding a _virtual network rule_ to the resources.
- Secure with VNet Rules
- Configured through the subnet
- Can extend your Vnet identity to your Azure Services - Database for a website...

Azure Private Link  provides private connectivity from a virtual network to Azure platform as a service (PaaS), customer-owned, or Microsoft partner services to simplify Network Architecture and secure connection between endpoints in Azure. 
- No exposure to internet keeps all traffic on the Microsoft global network.
- It can link anywhere
	- Privately deliver your own services in your customer's virtual networks.
	- Privately to services running in other Azure regions.
	- All traffic to the service can be routed through the private endpoint. No gateways, NAT devices, Azure ExpressRoute or VPN connections, or public IP addresses are required.

Implement Virtual Networking
`Search -> Virtual Network -> $Vnet (With Subnet, VMs, DNS, NSGs, etc configured)` in the `Private DNS Zone -> Virtual Network Link -> + Add - provide a Link name, Vnet` 
