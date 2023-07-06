For hacking [[Kubernetes-Hacking]]

## Kubernetes Virtual Networking

-   Kubernetes nodes are connected to a virtual network, which provides inbound and outbound connectivity for pods.
-   The kube-proxy component runs on each node to provide the network features.
-   Network policies configure security and filtering of the network traffic for pods.
-   Network traffic can be distributed by using a load balancer.
-   Complex routing of application traffic can be achieved with Ingress Controllers.

## Command Cheatsheet

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


## Hardening K8

- Patching 
	- Legacy Kubenetes API if exposed does not require token for authenication
- RBAC Policy
	- Use namespaces to restrict access to cluster resources
- Security Policy
	- Group policies 
	- Least Privileges possibile
	- No Secrets on cluster or use managed options
	- Use strong authentication and authorization
- Network Policy
	- Network segmentation
	- Either
		- Public endpoint access disabled
		- Public endpoint access, authorized networks enabled - but restrict!
	- Firewall to limit unneeded netowkr connectivity 
- Resource limitations
	- Limitations to prevent pods DoSing other boxs 
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

[Online YAML prettifier](https://onlineyamltools.com/prettify-yaml)
[NSA CISA Kubenetes Hardening Guide](https://media.defense.gov/2022/Aug/29/2003066362/-1/-1/0/CTR_KUBERNETES_HARDENING_GUIDANCE_1.2_20220829.PDF)
[Google's Kubenetes Hardening Documentation](https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster#restrict_self_modify)
[Microsoft Learn]([Configure Azure Kubernetes Service networking - Training | Microsoft Learn](https://learn.microsoft.com/en-us/training/modules/configure-azure-kubernetes-service/4-kubernetes-networking))
[Bluematador's kubectl-cheatsheet](https://www.bluematador.com/learn/kubectl-cheatsheet)