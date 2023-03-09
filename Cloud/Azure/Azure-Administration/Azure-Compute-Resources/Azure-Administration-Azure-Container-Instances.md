
# Azure Administration - Azure Container Instances

Azure Container Instances (ACIs) allow you to launch containers without configuration or management of underlying VMs. Azure Containers are stateless by default, when contain crashes or stop the state is lost, but can be easily reorchestrated and there is no need for failover. To persist state requires mount an external volume. Containers are becoming the preferred way to package, deploy, and manage cloud applications. Containers can be provisioned quickly, billed **per second** and have granular and custom sizing of vCPUs, Memory and GPUs - VM predetermined. ACI can deploy Linux or Windows containers with persistent storage with Azure Files for your ACI containers.

A comparison between virtual machines and containers. 
![1080](azurevmandcontaincomparison.png)

ACI are accessed via a fully qualified domain name (FQDN). Azure containers only provide lightweight isolation from the host. A container restart policy specifies what a container should do when their process has complete:
- Always (default) - Containers are always restarted 
- Never - run one time only
- On Failure

####  Container Group

Container groups can share an external-facing IP address, one or more ports on the IP address, and a DNS label with an FQDN. 

Container Groups are collection of containers - scheduled on the same host machine! - Kubernetes pod in Azure - see [[Azure-Administration-Azure-Kubernetes-Services]]
- Container group share - lifecycle, resources, local network and storage volumes
- Multi-Container groups currently support only Linux Containers

Deploying Multi-containers groups:
 - Resource Manager Template (ARM Template) - good for deploying addition Azure service Resource
 - YAML File - when your deployment includes only container instances

Multi-container groups are useful when you want to divide a single functional task into a few container images:
- Web app updates
- Log data collection
- App monitoring
- Front-end and Back-end support

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