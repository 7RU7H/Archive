
# Azure Administration - Application Services


Azure App Service is an HTTP-based service for hosting web applications, REST APIs, and mobile back ends:
	- Choose your own programming lanaguage for Windows or Linux
	- Platform as a Service
	- Azure App Services you supports the following runtimes: .NET, .NET Core, Java Ruby, Node.js, PHP, Python
	- Azure App services can also run docker single or multi-containers
	
	
Azure App service makes it easy to implement common:
	- Azure DevOps 
	- Github integration
	- Docker hub integration
	- Package Management
	- Easy to setup staging environments
	- Custom Domains
	- Attaching TLS/SSL certificates
	
You pay based on an Azure App Servies Plan:
	- Shared Tier - Free, Shared (Linux not supported)
	- Dedicated Teir  - Basic, Standard, Premium, PremiumV2, PremiumV3
	- Isolated Tier
	
**Custom Containers** are supported, create docker file, upload to Azure Container Registry and deploy
	
**Deployment Slots** allows you create different environemtns of your web-application, can also swap environments - potential [Blue/Green deploy](https://en.wikipedia.org/wiki/Blue-green_deployment) 
	
	
App Service Environment (ASE) is an Azure App Service feature that provides a fully isolated and dedidcated environment for securely running App Service apps at high scale
- Customers can create multiple ASEs:
	- Within a single Azure Region
	- Across Multiple Azure Region making ASEs
- Idea for horizontally scaling stateless applciation tiers in support of high requests per second (RPS) workloads
- ASE comes with its own pricing tier (Isolated Tier)
- ASEs can be used to configure security architecture
- Apps running on ASEs can have their access gated by upstream devices, such as web applcation firewalls (WAFs)
- App Services Environments can be deployed  into AZ using zone pinning
- Deployments types ASE:
	- External ASE
	- [Internal Load Balancing ILB ASE](https://azure.microsoft.com/en-gb/blog/internal-load-balancing/)

Azure App services provides many ways to deploy your applications:
- WebJobs is feature of Azure App Service that enables you to run a program or script in the same instance as  a web app, API app, or mobile app.
	- No additional cost for WebJobs!

## References

[Internal Load Balancing](https://azure.microsoft.com/en-gb/blog/internal-load-balancing/)
[Blue/Green deploy](https://en.wikipedia.org/wiki/Blue-green_deployment)
[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
