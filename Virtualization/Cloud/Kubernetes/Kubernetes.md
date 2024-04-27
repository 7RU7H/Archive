# Kubernetes 

[Kubernetes](https://kubernetes.io/docs/concepts/overview/), *"also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized applications."*

Kubernetes is:
- Container orchestration
- Used for microservices as alternative to monolithic applications
- Design to try to be:
	- Portable across architectures
	- Scalable
	- *highly Available* (it runtime management so that services remain up)
- Authorial opinion: ...is not a simple solution and has lot of very interesting complexities for better and for worse. This has led to third parties providing the backbone and management because of the knowledge required to *gleem the `kube`* - know some fundamentals of networking and system administration helps.

For hacking [[Kubernetes-Hacking]].

Kubernetes Architecture:
- Control Plane - services that manage orchestration
	- kube-apiserver
		- All communication between the components in Kubernetes is done through this API
		- kube-apiserver exposes a RESTful API that you can use to post commands or YAML-based configuration files
	- Controller Manager
		- Launches and monitors the controllers configured for a cluster through the API server
		- Cloud controllers integrate with the underlying cloud technologies
	- Scheduler
		- Responsible for the assignment of workloads across all nodes.
	- [etcd](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/) 
		- A  key value store used as Kubernetes' backing store for all cluster data
- Node - where compute workloads run
	- Kubelet
		- Agent running on a node - processes the orchestration requests
	- Kube-Proxy 
		- Responsible for local cluster networking
		- Doesn't provide DNS services requires an add-on
	- Container Runtime 
		- underlying software that runs containers on a Kubernetes cluster

Kubernetes does not provide:
- Middleware
- Data-processing frameworks
- Databases
- Caches
- Cluster storage systems

Hierarchy of Kubernetes:
- Cluster
	- Node 
		- Pods - represents a single instance of an app running in Kubernetes
			- Container
			- Applications

#### Pod Deployments

Either:
- Pod templates - YAML Template 
- Replication controllers
	- uses pod templates and defines a specified number of pods that must run
- Replica sets 
	- uses pod templates and defines a specified number of pods that must run
	- Newer variant of Replication controllers, but requires a Selector definition to identify what pod is to be managed by it.
```YAML
Selector:
	matchLabels:
		type: database
```
- Deployments
	- Creates a management object one level higher than a replica set, and enables you to deploy and manage updates for pods in a cluster.
	- Can do rolling-update across all the pods 

#### Kubernetes Virtual Networking

- Kubernetes nodes are connected to a virtual network, which provides inbound and outbound connectivity for pods.
- The Kube-Proxy component runs on each node to provide the network features.
- Network policies configure security and filtering of the network traffic for pods.
- Network traffic can be distributed by using a load balancer.
- Complex routing of application traffic can be achieved with Ingress Controllers.
- Nodes
	- IP address is automatically assigned to each node from an internal private network range
- Pods
	- By default, the pods and nodes can't communicate with each other by using different IP address ranges.
	- Pods are transient - IP address is temporary
- Excepted configurations
	- Pods can communicate with one another across nodes without Network Address Translation (NAT).
	- Nodes can communicate with all pods, and vice versa, without NAT.
	- Agents on a node can communicate with all nodes and pods.

#### Kubernetes Service

A Kubernetes service is a Kubernetes object that provides stable networking for pods

#### Kubernetes Storage

- Pod Volumes
- Persistent Volumes 

#### `kubectl` Command Cheatsheet

```bash
# ++cmd: <additional of domain specific cmds
# Info about the master and services in cluster
# useful options
-f $file / $url $directory
-n=[$namespace_name]
-o $output

kubectl cluster-info
# K8 version
kubectl version # api-version for api!
# Get current cluster configuration
kubectl config view
# List everything
kubectl get all --all-namespaces
# avaliablle API resources
kubectl api-resources

#  cmds: get, edit, delete, create, rollout
# examples provided
# Daemonsetbluematador.com/learn/kubectl-cheatsheet
kubectl <cmd> daemonset # / ds
# Describe state 
kubectl describe ds $name -n $namespace_name
# Deployments
kubectl <cmd> deployment
# Events, check flags lots of granularity
kubectl <cmd> events --field-selector type=Warning
# Logs, check flags lots of granularity
kubectl <cmd> logs $podname
# Modify object through Manifest Files
# cmds: apply,create 
kubectl <cmd> -f manifest_file.yaml
# Namespaces
kubectl <cmd> namespace $nsName
# Nodes
# ++cmds: taint, top, cordon, annotate, uncordon, drain, label, exec
kubectl <cmd> node
# Replication Controllers - ReplicaSets
kubectl <cmd> rc
# replicasets
# ++cmd: scale
kubectl <cmd> replicasets
# Scale a replicaet
kubectl scale --replicas=[X]
# Secret management
# ++cmds: delete
kubectl <cmd> secret(s)
# Services
# ++cmd: expose
kubectl <cmd> services
# expose a replication controller, service, deployment or pod
kubectl expose <k8insert> $deploymentName
# Service Accounts
kubectl <cmd> serviceaccount
# Stateful Set
kubectl <cmd> statefulset
```


#### Hardening K8

- Patching 
	- Legacy Kubernetes API if exposed does not require token for authentication
- RBAC Policy
	- Use namespaces to restrict access to cluster resources
- Security Policy
	- Group policies 
	- Least Privileges possible
	- No Secrets on cluster or use managed options
	- Use strong authentication and authorisation
- Network Policy
	- Network segmentation
	- Either
		- Public endpoint access disabled
		- Public endpoint access, authorised networks enabled - but restrict!
	- Firewall to limit unneeded network connectivity 
- Resource limitations
	- Limitations to prevent pods DoS-ing other Nodes 
	- Monitor for expectations of provisioned usage
- TLS - force with ingress controller
- Capabilities
	- Use provider's management tooling to govern and enforce how the cluster is used
	- Restrict self-modifying workloads
- Monitoring
	- Scan containers and pod for vulnerabilities and misconfigurations
	- Capture and Audit logs
	- Periodic manual review of settings

## References

[THM Intro to Kubernetes Room](https://tryhackme.com/room/introtok8s)
[Online YAML prettifier](https://onlineyamltools.com/prettify-yaml)
[NSA CISA Kubenetes Hardening Guide](https://media.defense.gov/2022/Aug/29/2003066362/-1/-1/0/CTR_KUBERNETES_HARDENING_GUIDANCE_1.2_20220829.PDF)
[Google's Kubenetes Hardening Documentation](https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster#restrict_self_modify)
[Microsoft Learn]([Configure Azure Kubernetes Service networking - Training | Microsoft Learn](https://learn.microsoft.com/en-us/training/modules/configure-azure-kubernetes-service/4-kubernetes-networking))
[Bluematador's kubectl-cheatsheet](https://www.bluematador.com/learn/kubectl-cheatsheet)
[Microsoft Learn's Intro to Kubernetes](https://learn.microsoft.com/en-us/training/modules/intro-to-kubernetes/)
[Replication Controller Vs Replica Set | by Avinash Kumar - The Learning Destination | Medium](https://medium.com/@avinashkumarmahto51/replication-controller-vs-replica-set-29b5e0bc83d9)
[Kubernetes](https://kubernetes.io/docs/concepts/overview/)
[etcd](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/) 