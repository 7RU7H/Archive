For hacking [[Kubernetes-Hacking]]


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