# Azure-Administration Configure Azure App Service Plan

In Azure App Service, an application runs in an Azure App Service plan. For Azure App Service administration: [[Azure-Administration-Azure-App-Services]].  An App Service plan defines a set of compute resources for a web application to run. 
Considerations:
- Additional application can be added to existing plans if the plan has the resources.
- Manual adjusting plan tiers: Start low and scale up for more features if needed
- Autoscale to support users and reduce costs
- No redeployment
- Scaling with other Azure Service: Azure SQL database **are be scale separately!**

App Service Plan settings:
- Region
- Number of VM instances
- Size of VM instances
- Price Tier
	- Free or Shared
		- Applications run by receiving CPU minutes on a shared virtual machine instance.
		- Applications can't scale out.
	- Basic, Standard, Premium, Isolated
		- Applications run on all virtual machine instances configured in the App Service plan.
		- Multiple applications in the same plan share the same virtual machine instances.
		- If you have multiple deployment slots for an application, all deployment slots run on the same virtual machine instances.
		- If you enable diagnostic logs, perform backups, or run WebJobs, these tasks use CPU cycles and memory on the same virtual machine instances.
	- Do you need Isolated tier?
		- The application is resource-intensive.
		- You want to scale the application independently from the other applications in the existing plan.
		- The application needs resource in a different geographical region.

|Feature|Free|Shared|Basic|Standard|Premium|Isolated|
|---|---|---|---|---|---|---|
|Usage|Development, Testing|Development, Testing|Dedicated development, Testing|Production workloads|Enhanced scale, performance|High performance, security, isolation|
|Web, mobile, or API applications|10|100|Unlimited|Unlimited|Unlimited|Unlimited|
|Disk space|1 GB|1 GB|10 GB|50 GB|250 GB|1 TB|
|Auto scale|n/a|n/a|n/a|Supported|Supported|Supported|
|Deployment slots|n/a|n/a|n/a|5|20|20|
|Max instances|n/a|n/a|Up to 3|Up to 10|Up to 30|Up to 100|


Azure App Service Scaling
- Scale up
	- Increase: CPU, Memory and disk space
- Scale out
	- Increase: Instances running application 
- Autoscale
	- Scale based on metric
		- Metric-based rules
	- Scale to a specific instance count
		- Time-based rules
	- Consider:
		- Min and Max instance counts
		- Adequate scale margins
		- Metric statistics
		- Default instance count
		- Notifications

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)