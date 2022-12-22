
# Azure Administration - Azure Containers Instances

Azure Container Instances (ACIs) allow you to launch containers without configuration or management of underlying VMS. Azure Container are stateless by default, when contain crashes or stop the stae is lost. To persist state requires mounbt an external volume.

Azure Container Instances is designed for isolated containers:
- Simple Applications
- Task Automation
- Build Jobs
Containers can be provisioned quickly, billed **per second** and have granular and custom sizing of vCPUs, Memory and GPUs - VM predetermined. ACI can deploy Linux or Windows containers with persistent storage with Azure Files for your ACI containers.

ACI are accessed via a fully qualified domain name (FQDN).

Container Groups are collection of containers - scheduled on the same host machine! - Kubernetes pod in Azure 
- Container group share - lifecycle, resources, local network and storage volumes
- Multi-Container groups currently support only Linux Containers

Deploying Multi-containers groups:
 - Resource Manager Template (ARM Template) - good for deploying addition Azure service Resource
 - YAML File - when your deployment includes only container instances

A container restart policy specifies what a container should do when their process has complete
- Always (default) -  Containers are always restarted 
- Never - run one time only
- On Failure

Contain Troubleshooting (Azure CLI):
```powershell
az container logs # pulls logs
az container attach # diagnostic info during startup 
az container exec # interactive container run
az container metrics list # 
```


## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)