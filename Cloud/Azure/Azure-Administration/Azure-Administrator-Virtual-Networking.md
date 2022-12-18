# Azure Administrator - Virtual Networking



Virtual Networks consist of one of more IP ranges that are typically from RFC 1918, but not exclusively. 

- Exists within a specific subscription
- Exists within a specific region
- The only public IPs avaliable are the one granted by Azure
- Subnet creation lose **five** addresses: all 0s, 256, Azure Default Gateway, next two address after the Default gateway will be lost to DNS.
	- /29 - would only have 3 addresses as you always lose the 5 above

#### Creating 
- Connect to Resource Group
- Name with naming convention
- IP address space, can add multiple and IPv6 - the automatic ones are drawn from Azure analyzing your own IP spaces
- Remember Azure takes 5 addresses before sizing!


The Virtual Network should be broken up into subnet ranges like on-premise to manage the networking. Avaliablity Zones (AZ)s can be spanned acrossed by a subnet, resources in a subnet need to be alignment of resources avaliable from a AZ dimension.


- IP always comes via fabric (Azure) OS using DHCP - can configure per OS basis 
- IPs can be reserved in ARM
	- For Domain Controllers


![](azure-virtualnetworking-diagram.excalidraw)

- VMs are placed in the subnet, in actuality you are placing NIC in the subnet and connecting it to the VM. 
- Azure tracks the IP addresses as deallocation and reallocation will result in a VM getting probably a different IP. 
- A VM can have multiple NICs to connect to multiple subnets, but not can not span multiple Virtual Networks, it can still connect to another VNet just not span! 

Ensure static IP on a VM:
`Virtual  Machines -> $VMnames -> Network Interface -> IP configuration -> Static | Dynamic` 

IP forwarding from a VM - for Firewalls and Gateway devices
`Virtual  Machines -> $VMnames -> Network Interface -> IP forwarding  set to (Disabled | Enabled)`