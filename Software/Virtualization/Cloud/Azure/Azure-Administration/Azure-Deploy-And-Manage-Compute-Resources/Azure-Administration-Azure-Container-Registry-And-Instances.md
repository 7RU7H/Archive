# Azure Administration - Azure Container  Registry And Instances

This is not: 
- [[Docker]] contains various local curated information about Docker. It is Docker in Azure  
- Container Apps are serverless container services for microservice applications see [[Azure-Administration-Container-Apps]]. Built on Azure Kubernetes and can scale.
#### Container Registry

Azure Container Registry is a managed Docker registry service based on the open-source Docker Registry 2.0. Container Registry is private, hosted in Azure, and allows you to build, store, and manage images for all types of container deployments.

- Private therefore no `docker pull`
- Container images can be built in the cloud using Azure Container Registry Build 

A standard Dockerfile provides build instructions. Azure Container Registry Tasks enables you to reuse any Dockerfile currently in your environment, including multi-staged builds.

#### Container Instances

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
- Co-scheduled groups: Container Instances supports scheduling of multi-container groups that share host machine resources.
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

## Workflows

Create an Azure Container registry
```bash
az group create --name containerRegistry-rg --location $region
az acr create --resource-group containerRegistry-rg --name $ACR_NAME --sku Premium
```

Build an Image
```bash
az acr build --registry $ACR_NAME --image $imageName
```

Verify Image
```bash
az acr repository list --name $ACR_NAME --output table
```

Enable the registry account
```bash 
az acr update -n $ACR_NAME --admin-enabled true
az acr credential show --name $ACR_NAME
```

Deploy and then get IP address of Azure container
```bash
# Deploy
az container create \
    --resource-group $acrResourceGroup \
    --name $name \
    --image $ACR_NAME.azurecr.io/$imageName:$version \
    --registry-login-server $ACR_NAME.azurecr.io \
    --ip-address Public \
    --location $region \
    --registry-username $adminUsername \
    --registry-password $adminPassword 
# Get IP
az container show --resource-group  $acrResourceGroup --name $name --query ipAddress.ip --output table
```

Replicate a container to a different Region
```bash
az acr replication create --registry $ACR_NAME --location $TargetRegion
az acr replication list --registry $ACR_NAME --output table
```

Container Troubleshooting (Azure CLI):
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