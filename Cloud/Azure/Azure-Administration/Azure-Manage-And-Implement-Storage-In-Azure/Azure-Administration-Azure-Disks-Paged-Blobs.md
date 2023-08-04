
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
	 
Azure Private Links to ensure traffic between Zure disk and VMs within the Microsoft network

Azure Backup can be used to create a backup job with time-based backups and backup retention policies


#### Application data storage on a VM

Dedicated data disks are generally considered the best place to store application data files. They can be larger than OS disks and you can optimize them for the cost and performance characteristics appropriate for your data.

## VM Disks

- OS disk
	- `C:\`
- Temporary disk 
	- `D:\`
	- Windows: `pagefile.sys`
	- Linux: `/dev/sdb` - formatted and mounted to `/mnt` by Azure Linux Agent
- Data disk - registered as [Small Computer System Interface (SCSI)](https://en.wikipedia.org/wiki/SCSI) drives
	- `F:\`

Managed-disks - An Azure-managed disk is a VHD stored as paged blobs managed by Azure
- You pick a disk type
- Required for for single instance VM SLA 

Azure Premium Storage - Client managed Disk with best performance

Standard Azure Storage - for limiting costs 

#### Ultra Disks

|Disk size (GB)|IOPS|Throughput (MB/s)|
|---|---|---|
|4|1,200|300|
|8|2,400|600|
|16|4,800|1,200|
|32|9,600|2,400|
|64|19,200|4,000|
|128|38,400|4,000|
|256|76,800|2,000|
|512|153,600|4,000|
|1,024 - 65,536 (sizes in this range increase in 1 TiB increments)|160,000|2,000|
#### Premium SSD v2

|Disk Size|Maximum available IOPS|Maximum available throughput (MBps)|
|---|---|---|
|1 GiB-64 TiBs|3,000-80,000 (Increases by 500 IOPS per GiB)|125-1,200 (increases by 0.25 MBps per set IOPS)|

#### Premium SSD

|Disk size name|Disk size|IOPS|Throughput (MBps)|
|---|---|---|---|
|P4|32 GiB|120|25|
|P15|256 GiB|1,100|125|
|P40|2 TiB|7,500|250|
|P80|32 TiB|20,000|900|

#### Standard SSD

|Disk size name|Disk size (GB)|IOPS|Throughput (MBps)|
|---|---|---|---|
|E4|32|500|60|
|E15|256|500|60|
|E40|2,048|500|60|
|E80|32,767|6,000|750|

#### Standard HDD

|Disk size name|Disk size (GB)|IOPS|Throughput (MBps)|
|---|---|---|---|
|S4|32|500|60|
|S15|256|500|60|
|S40|2,048|500|60|
|S80|32,767|2,000|500|

## Workflows

Configure Disk Encryption -
`Search -> Storage Account -> $StorageAcc -> Add (GPv2 or Premium block blob) -> Encryption:`
- Type:
	- Microsoft-Managed keys
	- Customer Managed Kyeys
- Support for CMKs - Cannot change after creation
	- Blobs and file only
	- All service types
- Enable Infrastructure Encryption - Cannot change after creation

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[SCSI - Wikipedia](https://en.wikipedia.org/wiki/SCSI)