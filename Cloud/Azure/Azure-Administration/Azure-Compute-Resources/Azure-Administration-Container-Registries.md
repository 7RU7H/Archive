
# Azure Administration - Container Registries

Azure Container Registry is managed, private Docker Registry service based on the open-source Docker Registry, used for building container images in Azure and existing container development and deployment pipelines.

Pull images from an Azure container registry to various deployment targets:
- Kubernetes - see [[Azure-Administration-Azure-Kubernetes-Services]]
- DC/OS
- Docker Swarm - see [[Azure-Administration-Azure-Container-Instances]]

Azure Container Registry (ACR) Tasks allw you to automate OS and framework patching for Docker Containers; triggering of automated builds:
- Source code updates
- Updates to container's base image
- Timers on schedule

Create multi-step task, each ACR task has an associated source code context and can take advantage of run variables.

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)