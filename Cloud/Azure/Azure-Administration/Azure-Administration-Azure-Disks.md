
# Azure Administration -  Azure Disks

Azure Managed Disk are block-level storage volumes that are managed by Azure and used with Azure VMs. Azure Creates three replicas of data.  Managed Disks are:
- Integrated with availability sets
- Managed disks support Availability Zones
- RBAC to assign specific permissions for a managed disk to one or more users
- Virtual Hard Disks (VHD) can be directly imported into Azure Disks
- Support two encryption types:
	- Server Side Encryption (SSE) enabled by defulat for all managed disks, snapshots and images 	
	 - Temporary disk are not encrypted by server-side encryption by default
	 - Keys managed either with:
		- Platform-managed keys - Azure manages your keys
		- Customer-managed Keys - You manage it 
	- Azure Disk Encryption (ADE) allows encryption of the OS and the Data disk used by an IaaS Virtual Machine
- Encryption for 
	- Windows - Bitlocker
	- Linux - DM-Crypt
	 
Azure Private Links to ensure traffic between Zure disk and Vms within the Microsoft network

Azure Backup can be used to create a backup job with time-based backups and backup retention policies


## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)