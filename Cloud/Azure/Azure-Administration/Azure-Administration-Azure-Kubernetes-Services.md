
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

-   **Pools**: A pool is a group of nodes that have an identical configuration.
-   **Nodes**: A node is an individual virtual machine that runs containerized applications.
-   **Pods**: A pod is a single instance of an application. A pod can contain multiple containers. A pod is a logical resource, but a container is where the application workloads run.
	- Pods are typically ephemeral, disposable resources
	- Pods typically have a 1:1 mapping with a container, although there are advanced scenarios where a pod might contain multiple containers.
	- Multi-container pods are scheduled together on the same node, and allow containers to share related resources
	- At pods creation you define resource limits (including maximum limit) to request a certain amount of CPU or memory resources, the Kubernetes scheduler attempts to meet the request
	- Individual Pods scheduling **do not gain** all the features Kubernetes provides.
-   **Container**: A container is a lightweight and portable executable image that contains software and all of its dependencies.
-   **Deployment**: A deployment has one or more identical pods managed by Kubernetes.
-   **Manifest**: The manifest is the YAML file that describes a deployment.

- A cluster requires a node,
- Initial numbers and size defined when creating an AKS cluster - creates default node pool  
- Nodes are instances of Azure VMs
- The kubelet is the Kubernetes agent that processes the orchestration requests from the Azure-managed node, and scheduling of running the requested containers.
- The kube-proxy component handles virtual networking on each node. The proxy routes network traffic and manages IP addressing for services and pods.

Container Runtime components:
- AKS > 1.19 use `containerd`
- AKS < 1.19 implement Moby - (upstream Docker)

#### Kubernetes Virtual Networking And Azure

Azure Kubernetes Service expands on the Kubernetes features to simplify the process to support networking.

-   Kubernetes nodes are connected to a virtual network, which provides inbound and outbound connectivity for pods.
-   The kube-proxy component runs on each node to provide the network features.
-   Network policies configure security and filtering of the network traffic for pods.
-   Network traffic can be distributed by using a load balancer.
-   Complex routing of application traffic can be achieved with Ingress Controllers.

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

Define tier - `StorageClass`, which defines the `reclaimPolicy` - control beheviour of underlying Azure Storage resource.
- `PersistentVolumeClaim` (1:1 to persistent volume to claims, volume is bound to claim after a resource is assigned) requests either Azure Disks or Azure Files storage of a `StorageClass`

#### Scaling

Scaling is the adjustment of compute resources allocated.
![1080](azureaksscalingtech.png)

Horizonal Pod autoscaler considerations
- Number of replicas
- Scaling metrics
- Cooldown of scaling events
- Tuning cooldown values

Cluster autoscaling considerations
- Combining with horizontal pod autoscaler
- Burst scaling to Azure Container Insces
- Scale-in evetns
- Avoid single pods.

Scale rapidly (scheduled) with burst scaling deploy to another subnet in the same Vnet with Virtual Nodes, not pods.
![](azureaksforburstscaling.png)

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