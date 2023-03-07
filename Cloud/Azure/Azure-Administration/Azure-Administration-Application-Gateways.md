
# Azure-Administration-Application-Gateways


Azure Application Gateway is a aaplication-level routing and load balancing service that operates on OSI Layer 7 - Application Layer of the [[OSI-Model]]. 

Azure Web Application Firewall (WAF - but Azure) polices can be attached to an Application Gatewayto porivide addition security composed of:
- Frontends
	- Private IP will create an Internal Load Balancer
	- Public IP wil create an Public/External Load Balancer
- Routing Rules
	- Listeners "listens" on specified port and IP address for traffic that uses a specified protocol and the listener criteria are met and the application gateway will apply this routing rule:
		- There are 2 types of Listeners:
			- Basic - forward all requests for any domain to backend pools
			- Multi-site - forward re1quests to different backend pools based on host header and  hostname
			- Requests are matched according to the order of the rules and type of header.
				- Add yourt listeners last otherwise it will capture all requests
- Backends
	- Backend Pools:
		- A collection of resource to which Application Gateway can send traffic
		- Can contain: VMs, Vm scale sets IP addresses, domain names, Application Service
	- Backend targets - chooses where a route should go either Backend Pool or redirection
		- To create a rule for BAckend Pool you need to create HTTP Setting
			- Defines how we want to handle cookies, connection draining, port request time out and more

## References

[Youtube Azure Administrator Certification (AZ-104)](https://www.youtube.com/watch?v=10PbGbTUSAg&t=14542s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)