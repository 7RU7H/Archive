# Azure Administration - Azure Container Instances

Azure Container Instances (ACIs) allow you to launch containers without configuration or management of underlying VMs. Azure Containers are stateless by default, when contain crashes or stop the state is lost, but can be easily reorchestrated and there is no need for failover. To persist state requires mount an external volume. Containers are becoming the preferred way to package, deploy, and manage cloud applications. Containers can be provisioned quickly, billed **per second** and have granular and custom sizing of vCPUs, Memory and GPUs - VM predetermined. ACI can deploy Linux or Windows containers with persistent storage with Azure Files for your ACI containers.

A comparison between virtual machines and containers. 
![1080](azurevmandcontaincomparison.png)

Azure Container Instance Properties:
- Fast startup times
- Public IP connectivity and DNS name
	- ACI are accessed via a fully qualified domain name (FQDN). Azure containers only provide lightweight isolation from the host. A container restart policy specifies what a container should do when their process has complete:
		- Always (default) - Containers are always restarted 
		- Never - run one time only
		- On Failure
- Custom sizes
- Persistent Storage: Azure files file share [[Azure-Administration-Files-And-File-Sync]]
- Linux and Windows containers
- Coscheduled groups: Container Instances supports scheduling of multi-container groups that share host machine resources.
- VNet deployment: deployed into an Azure virtual network.
#### Container Group

A Container Group is a collection of containers that get scheduled on the same host machine. The containers in a container group share a lifecycle, resources, local network, and storage volumes. Container groups can share an external-facing IP address, one or more ports on the IP address, and a DNS label with an FQDN. 

Caveats with Container Groups:
- External client access - expose port on IP address
- Port mapping - isn't supported because containers in a group share a port namespace.
- Deleted groups - When a container group is deleted, its IP address and FQDN are released.

Deploying Multi-containers groups:
 - Resource Manager Template (ARM Template) - good for deploying addition Azure service Resource
 - YAML File - when your deployment includes only container instances

Multi-container groups are useful when you want to divide a single functional task into a few container images:
- Web app updates
- Log data collection
- App monitoring
- Front-end and Back-end supported

#### Docker

[[Docker]] contains various local curated information about Docker.

## Workflows

Contain Troubleshooting (Azure CLI):
```bash
az container logs # pulls logs
az container attach # diagnostic info during startup 
az container exec # interactive container run
az container metrics list 
```

Deploy a Docker Container using Azure Container Instances
`Search -> Container Instances -> + Create`
- Basic - Resource Group 
- Networking - DNS name label
- Advanced - Restart policy

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)