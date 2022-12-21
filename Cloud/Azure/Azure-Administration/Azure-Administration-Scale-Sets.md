
# Azure Administration Scale Sets

Azure Scale sets allows automatic increases and decreases in VM capacity. Load Balancers can be associated with a Scale Set:
- Evenly distribute VM accorss availablility Zones - more Availablility
- Use Load Balancer probe checks for more robust Health checks

Load Balancers:
1. Application Gateway is an HTTP/HTTPS web traffic load balncer application firewall
2. Azure Load Balancer supports all TCP/UDP network traffic, port-forwarding and outbound flaws.

A **Scaling Policy** detirmines what VM is removed to decrease the capacity of the Scale Set either:
- Default - Delete VM with highest instance ID balanced across AZs and Fault Domains
- Newest VM - Delete the newest created VM, balanced across AZs
- Oldest VM - Delete oldest VM balanced across AZs 

**Update Policy** determine VM instances are brought up-to-date with the latest scale set model
- Automatic: Increasing with start upgrading immediately in random order
- Manual - Existiing instances must be manaually upgraded
- Rolling - Upgrade roll out in batches with optional pause
Health monitoring can be enabled to detirmine if server is healthy or unhealthy
1. Application health extension: Ping an HTTP request to a specifrc path and except a status 200
2. Load Balancers Probe - allow checks based on TCP, UDP or HTTP requests.

Automatic Repair policy if an instance is found to be unhealthy the delete it and launch a new instance

## References

[Youtube Azure Administrator Certification (AZ-104)](https://www.youtube.com/watch?v=10PbGbTUSAg&t=14542s)