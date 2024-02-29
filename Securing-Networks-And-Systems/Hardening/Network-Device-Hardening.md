# Network Device Hardening

#### Asset List

Network Devices include:
- Routers
- Switchers
- Load Balancers
- Gateways
- Access Points
	- Wireless Access Points
- Repeaters
- Modems
- Bridges
- [[Firewalls]]
- Hubs
- Network Interface Cards

#### Threat and Attack Vectors

- Unauthorised access
	- [[Password-Attacks]]
	- Vulnerabilities
	- [[Phishing]]
- Denial of Service
- [[MITM-Attacks]]
	- [[ARP-Spoofing]]
	- [[ARP-Poisoning]]
	- [[DNS-Spoofing]]
	- [[Rogue-Access-Points]]
- Privilege Escalation
	- Weak Passwords
	- Misconfigurations
	- Vulnerabilities
- Bandwidth theft/hotlinking
	- Linking a bandwidth-intensive resource from external website to its original website, without permission

#### Hardening Physical Networks

- IPv6 - if you can
	- Has builtin support [[IPsec]]
- Updating and Patching
- Disabling unnecessary services and ports
- Principle of Least Privilege
- Logging
	- [[Syslog]] protocol 
		- Standardises transference of log messages for storing and analysing log messages on a central server
	- [[SNMP]] 
		- beware [[SNMP-Recon-Cheatsheet]] exists exposing massive information disclosure
- Monitoring
	- Netflow
	- Packet Capture
- Secure and regular Backups
- Passwords
	- No defaults
- MFA
- Secure Protocols 
	- No plain text traffic; block non encrypted protocols
- [[Virtual-Private-Networks]] 
	- Server Side Configurations
		- Strong Encryption Algorithm
		- Keep updated 
		- Implement strong authentication
			- [[SSL-TLS]] and a secure hashing algorithm
		- Change the default credentials
		- Enable Perfect Forward Secrecy (PFS)
			- Generate unique session keys
			- Generate new set of encryption keys for each session
			- Choose `cipher` and `auth`
		- Dedicated Users for VPN Server
- Prevent Rogue Servers
	- Configuring static DHCP binding and ensuring no unknown devices are added to a network through network mapping tools.
- Enabling static ARP tables - [[ARP-Spoofing]] and [[ARP-Poisoning]]
- Implementing MAC address filtering - [[MAC-Flooding]]
- Routers
	- Setup device properly
	- Update Firmware
	- Change the default credentials
	- Enable secure network protocols
	- SSH public keys for passwordless login
	- Disable unnecessary scripts
	- Alert on new Startup tasks
	- Monitor Schedule Tasks
- Wireless Routers
	- Enable WPA2/WPA3
	- Disable SSID broadcast
	- Change the default credentials
- Switches
	- Setup device properly
	- Update Firmware
	- Change the default credentials
	- Configure Port Security
		- Limit MAC addresses registered 
		- Alert on MAC address actions that are unauthorised 
- [[Firewalls]]
	- Setup device properly
	- Update Firmware
	- Change the default credentials
	- Manage Traffic Rules
	- Configure Port Forwarding
		- Forward inbound internet traffic from internet or other sources to particular device. Anything that is not compliant with rules will be blocked
	
#### Network Monitoring Tools

- [Nagios](https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/quickstart.html)
- [SolarWinds Network Performance Monitor](https://documentation.solarwinds.com/en/success_center/npm/content/npm_installation_guide.htm)
- [PRTG](https://www.paessler.com/manuals/prtg/installation)
- [Zabbix](https://www.zabbix.com/download)

## References

[THM Network Device Hardening](https://tryhackme.com/room/networkdevicehardening)
[Nagios](https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/quickstart.html)
[SolarWinds Network Performance Monitor](https://documentation.solarwinds.com/en/success_center/npm/content/npm_installation_guide.htm)
[PRTG](https://www.paessler.com/manuals/prtg/installation)
[Zabbix](https://www.zabbix.com/download)