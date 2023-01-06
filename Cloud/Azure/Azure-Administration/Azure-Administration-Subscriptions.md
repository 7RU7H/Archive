# Azure Administration - Subscriptions

An Azure subscription is a logical unit of Azure services that's linked to an Azure account. Subscriptions help you organize access to Azure cloud service resources, and help you control how resource usage is reported, billed, and paid. To procure an Azure subscription. You can obtain an Azure subscription as part of an  [Enterprise Agreement](https://azure.microsoft.com/pricing/enterprise-agreement/), or through a Microsoft Resller with  [Open Licensing program](https://www.microsoft.com/licensing/licensing-programs/open-license.aspx) or [Microsoft partner](https://azure.microsoft.com/partners/directory/) or [free trial account](https://azure.microsoft.com/free/). 
Departmentalisation for better deployment, administration and monitoring of costs, avalibility and security. Consider:
- Types of Azure account required
- Multiple subscription to segregate data and payment of all types
- A dedicated shared services subscription for common network resources are billed together
- Resource accessibility
- Resource tags for ease of managing, searching

## Region Choice

Region choice is critical to avaliability and preserve data residency, and offer comprehensive compliance and resiliency options for customers.

Search [Azure regions](https://azure.microsoft.com/global-infrastructure/geographies/#geographies) by geography.
Search [Azure products](https://azure.microsoft.com/global-infrastructure/services/) by region or geography.
Search for [paired regions](https://learn.microsoft.com/en-us/azure/best-practices-availability-paired-regions#azure-cross-region-replication-pairings-for-all-geographies) and exceptions.

Azure Region pair characteristics
![](azureregionpairs.png)

Considerations:
- Deployment - where? - why?
	- Service availablity - try to use those that do not require regions
	- Be mindful of exception to region paring
	- Benefits of residency - how where data is improves avaliability

## Cost reduction

![](azurecostsvaings.png)
[Pricing Calculator](https://azure.microsoft.com/pricing/calculator/)


## References

[Microsoft Learn](https://learn.microsoft.com/en-us/training/modules/configure-subscriptions/1-introduction)
[Pricing Calculator](https://azure.microsoft.com/pricing/calculator/)
[Azure regions](https://azure.microsoft.com/global-infrastructure/geographies/#geographies) 
[Azure products](https://azure.microsoft.com/global-infrastructure/services/) 
[paired regions](https://learn.microsoft.com/en-us/azure/best-practices-availability-paired-regions#azure-cross-region-replication-pairings-for-all-geographies) 