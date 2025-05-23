# Azure Administration - Azure Kubernetes Services

Azure [[Kubernetes]] Services (AKS) makes it simple to deploy a managed Kubernetes cluster in Azure. AKS service is free and only pay agent nodes within the cluster not the masters; AKS scenarios where you require full container orchestration:
- Service Discovery across multiple containers
- Automatic scaling
- Coordinated application upgrades
- You pay for running nodes in a cluster
Bridge to Kubernetes is an extension in [[Microsoft-Visual-Studios]] and [[VS-Code]] to write, test and debug microservice code on development workstations

Azure manages:
- Kubernetes masters
- Health monitoring
- Maintenance

System Administrator must manage - Agent nodes

![1080](azureaks.png)

#### AKS Concepts

- **Pools**: A pool is a group of nodes that have an identical configuration.
- **Nodes**: A node is an individual virtual machine that runs containerized applications.
- **Pods**: A pod is a single instance of an application. A pod can contain multiple containers. A pod is a logical resource, but a container is where the application workloads run.
	- Pods are typically ephemeral, disposable resources
	- Pods typically have a 1:1 mapping with a container, although there are advanced scenarios where a pod might contain multiple containers.
	- Multi-container pods are scheduled together on the same node, and allow containers to share related resources
	- At pods creation you define resource limits (including maximum limit) to request a certain amount of CPU or memory resources, the Kubernetes scheduler attempts to meet the request
	- Individual Pods scheduling **do not gain** all the features Kubernetes provides.
- **Container**: A container is a lightweight and portable executable image that contains software and all of its dependencies.
- **Deployment**: A deployment has one or more identical pods managed by Kubernetes.
- **Manifest**: The manifest is the YAML file that describes a deployment.

- A cluster requires at least one node,
- Initial numbers and size defined when creating an AKS cluster - creates default node pool  
- Nodes are instances of Azure VMs
- Nodes of the same configuration are grouped together into node pools. A Kubernetes cluster contains one or more node pools.
- The `kubelet` is the Kubernetes agent that processes the orchestration requests from the Azure-managed node, and scheduling of running the requested containers.
- The kube-proxy component handles virtual networking on each node. The proxy routes network traffic and manages IP addressing for services and pods.

Container Runtime components:
- AKS > 1.19 use `containerd`
- AKS < 1.19 implement Moby - (upstream Docker)

When you implement Azure Kubernetes Service clusters, you pay only for running agent nodes in your cluster.
#### Kubernetes Virtual Networking And Azure

Azure Kubernetes Service expands on the Kubernetes features to simplify the process to support networking.
- Kubernetes nodes are connected to a virtual network, which provides inbound and outbound connectivity for pods.
- The kube-proxy component runs on each node to provide the network features.
- Network policies configure security and filtering of the network traffic for pods.
- Network traffic can be distributed by using a load balancer.
- Complex routing of application traffic can be achieved with Ingress Controllers.

Azure with your configuration provides:
- Create a Kubernetes load balancer, the underlying Azure Load Balancer resource is created and configured. 
- Open network ports to pods, the corresponding Azure network security group rules are configured. 
- With HTTP application routing, Azure can configure an external DNS as new ingress routes are configured.

Kubernetes Service Types
![1080](azurekubernetesservicetype.png)

The ClusterIP service creates an internal IP address for use within the Azure Kubernetes Service cluster.

The LoadBalancer service creates an Azure Load Balancer resource, configures an external IP address, and connects the requested pods to the Load Balancer back-end pool. To allow customer traffic to reach an application, load-balancing rules are created on the desired ports.

Storage options example
![](azureaksstorageoptions.png)
Storage volumes represent a way to store, retrieve, and persist data across pods and through the application lifecycle. Either Azure Disks or Azure Files.


StorageClasses:
![1080](azureaksstorageclasses.png)

Dynamic provisioning uses a `StorageClass` type to identify what kind of Azure Storage needs to be created. Define tier - `StorageClass`, which defines the `reclaimPolicy` - control behaviour of underlying Azure Storage resource.
- `PersistentVolumeClaim` (1:1 mapping to persistent volume to claims, volume is bound to claim after a resource is assigned) requests either Azure Disks or Azure Files storage of a `StorageClass`
- The pod definition includes the volume mount after the volume has been connected to the pod
- A persistent volume is *bound* to a persistent volume claim after an available Storage resource is assigned to the pod that requests the volume.

## Configure Azure Kubernetes Service scaling

An implementation of scaling:
![](azure-aksscalingimplementation.png)

Scaling is the adjustment of compute resources allocated.
![1080](azureaksscalingtech.png)

Horizontal Pod autoscaling considerations
- Number of replicas
- Scaling metrics
- Cooldown of scaling events
- Tuning cooldown values

Cluster autoscaling considerations
- Combining with horizontal pod autoscaler
- Burst scaling to Azure Container Instances
- Scale-in events
- Avoid single pods.

Scale rapidly (scheduled) with burst scaling deploy to another subnet in the same Vnet with Virtual Nodes, not pods.
![](azureaksforburstscaling.png)

Considerations:
- Combining with HPA: Cluster autoscaler is typically used alongside the horizontal pod autoscaler.
- Scale-out events
- Burst scaling to Azure Container instances
- Scale-in events
- Avoid single pods

## AKS node updating

`kured` [is used to orchestrate the update process](https://learn.microsoft.com/en-us/azure/aks/node-updates-kured):
![](azure-k8updatenodes.png)
- Linux requires: `/var/run/reboot-required` - reboot not automatic

```bash
# Add the Kured Helm repository
helm repo add kubereboot https://kubereboot.github.io/charts/

# Update your local Helm chart repository cache
helm repo update

# Create a dedicated namespace where you would like to deploy kured into
kubectl create namespace kured

# Install kured in that namespace with Helm 3 (only on Linux nodes, kured is not working on Windows nodes)
helm install my-release kubereboot/kured --namespace kured --set nodeSelector."kubernetes\.io/os"=linux
```

## Calico network policies

[Calico network policies](https://docs.tigera.io/calico/latest/network-policy/get-started/calico-policy/calico-network-policy) in a cluster in an [Azure Kubernetes Server (AKS)](https://learn.microsoft.com/en-us/azure/aks/hybrid/calico-networking-policy) deployment are used to enforce which network traffic is allowed or denied using rules in Calico network policy.

```powershell
x = "a name"
OS = # Linux, Windows depending on the node OS
# Apply a Calico Network Policy
kubectl apply -f policy-$x-$OS.yaml
```

## Workflows

Check if registered
`Search -> Subscriptions -> $Subscription -> Resource Providers `

`Search -> Kubernetes Services -> + Create (either): + Create a Kubernetes cluster | + Add a Kubernetes cluster with Azure Arc`
Basic: 
- Avaliability Zones - (consider full removal for high avaliability)
- Scale method: Manual or Autoscale
- Node Count: 1 - 5 
Node pools - configure here
Acces - RBAC and AKS-managed Azure AD 
Networking
Integrations - Container Monitoring

Add Node pools 
`Search -> Kubernetes Services -> $KubernetesService -> Node Pools `

Scale Node pool deployed 
`Search -> Kubernetes Services -> $KubernetesService -> Node Pools -> $NodePool -> Scale Node pool` - configure and apply.

AKS creation
```bash
# Requires a Resource Group!
az group create \ 
--name $rGroup
--location $location
# Create AKS cluster
az aks create 
--resource-group $rGroup
--name $aksClusterName
--node-count 3 
--enable-addons monitoring 
--generate-ssh-keys
```

AKS deployment
```bash
# Access AZK cluster, then show connectivity
RGROUP='azResourceGroup'
AKS_CLUSTER='azCluster'
az aks get-credentials --resource-group $RGOUP --name $AKS_CLUSTER
kubectl get nodes
# Deploy an nginx image
kubectl create deployment nginx-deployment --image=nginx
kubectl get pods
kubectl get deployment
# Expose the http port to internet
kubectl expose deployment nginx-deployment --port=80 --type=LoadBalancer
# Display provisioning and IP
kubectl get service
```

Scale a AKS cluster
```bash
kubectl scale --replicas=2 deployment/nginx-deployment
kubectl get pods

# Scale by node 
az aks scale --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER --node-count 2
kubectl get nodes

# Scale by pods
kubectl scale --replicas=10 deployment/nginx-deployment
kubectl get pods

kubectl get pod -o=custom-columns=NODE:.spec.nodeName,POD:.metadata.name
# Delete deploymen
kubectl delete deplyment ngnix-deployment
```

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Kubernetes](https://kubernetes.io/) 
[Azure Kubernetes Service documentation](https://learn.microsoft.com/en-us/azure/aks/)
[Azure Kubernetes Service](https://learn.microsoft.com/en-us/azure/aks/intro-kubernetes)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[Microsfot Learn: AKS Kured](https://learn.microsoft.com/en-us/azure/aks/node-updates-kured)
[Get started with Calico network policy | Calico Documentation (tigera.io)](https://docs.tigera.io/calico/latest/network-policy/get-started/calico-policy/calico-network-policy)