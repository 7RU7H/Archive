#markdown 
Azure Storage Accounts offers several types of storage accounts:

Account Kind:
- General-purpose v1 (legacy)
- General-purpose v2
- BlobStorage (legacy)
- BlockBlobstorage
- FileStorage

Storage Accounts:
Supported Services - Blob, File, Queue, Table, Disk, Data Loake Gen2
Performance Tiers - Standard Premium
Access Tiers - Hot, Cool, Archive
Replication - LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS
Deployment model - Resource, Manager, Classic

A Comparison of Storage Types
![](azure-storageaccountcomparison.png)

#### Storage Services

Azure has 5 Core Storage services, searchable 
- Blob 
	- Azure Blob a masssive scalable object store for text and binary data.
		- Include support for big data analytics through Data Lake Storage Gen2
	- Azure Files
		- Managed file shares for cloud or on-premises deployments
	-  Azure Queues
		- A NoSQL store for schemaless storage of structured data
	- Azure Tables
		- A messaging store for reiable messaging between application components
- Disks
	- Azure Disks
		- Block-level storage volumes for Azure VMs

#### Performance Tiers (Blob Storage)

2 types of performance tiers for storage accounts: Standard and Premium

- Input/Output Operations Per Second (IOPS)

Premium Performance:
- Stored on SSD
- Optimized for low-latency
- Higher throughput
- Use cases:
	- Interactive workloads
	- Analytics
	- AI or ML
	- Data transformation

Standard Performance
- Stored on HDDs
- Varied performance based on access tier - Hot, Cool, Archive
- Use cases:
	- Backup and disaster recovery
	- Media content
	- Bulk data processing

#### Access Tiers (Blob Storage)

Account level tiering: 
- any blob that doesn't have an explicitly assigned tier infers the teir from the Storage Account access tier setting
Blob-Level Tiering:
- Upload a blob to the tier of your choice.
- Changing tiers happens instantly with the exception from moving out of archive
Rehydrating a Blob
- Moving a Blob out of Archive into another tier
Blob lifecycle management
- Creating a rule-based policies to transition data to different tiers

Standard storage:

Hot 
- Frequently accessed
- Highest storage cost - lowest access cost

Cold 
- Infrequently accessed
- Lower storage cost - higher access cost

Archive 
- Rarely accessed and stored for at least 180 days
- Lowest Storage and highest access cost


#### Access Tiers (Blob Storage)

When a blob is uploaded or moved to another tier it is charged at the new tier's rate **immediately** upon tier change:

- Hot to cooler tiers, operation is billed as a wqrite operation to destination tier
- Cold to hotter tier, operation is billed as a read from the source tier

- Cool and Archive early deletion: 
	- Any blob moved into Cool tier (GPv2 accounts only) is subject to a cool early deletion period of 30 days.
	- Any blob moved into Archive tier is subject to an Arcvhive early deletion period of 180 days -charge is prorated.

#### Replication and Data redundancy 

Upon creation of a Storage Account you need to choose a Replication Type, Replication stores multiple copies of data protecting it from:
- Planned events
- Transient hardware failures
- Network or power outages
- Massive Natural disasters

- Region Specific
- Redundacy - Standard performance:
	- Local Redundant Storage - Distributed over Local to AZ1 in a Region
	- Zone Redundant Storage -  Distributed through the Zones of a Region
	- Global Redundant Storage - Distributed both Locally in one Zone and also in the Paired Region
	- Geo-Zone Redundant Storage (GZRS) - Distributed Locally one per Zone and Paired region
		- Always replicates asynchronously!
		- Some services allow reading from a Pair
- Premium Options vary on type; never a Geo-replicated option


The greater the level of redundancy the greater the expense:
- Primary Region Redundancy - Data is replicated  either:
	- Locally Redundant Storage (LRS)
		- Copies data synchronosusly in primary region 
			- PR is just AZ1
			- 99.99999999999% durability
			- Cheapest
	- Zone-redundant storage (ZRS)
		-  Copies data synchronosusly in primary region acrross **3** AZs:
			- PR is AZ1, AZ2, AZ3
			- 99.999999999999% durability
- Secondary Region redundancy  
	- Replicated to secondary region in case of primary regional disaster with the Secondary detirmined based on Primary's pairing
	- Secondary Region - no read or write access expect in event of failover 
		- Global Redundanct Storage (GRS)
			- Copies data synchronously in primary region and asynchronously to another region 
			- PR and SR both have just one AZ1
			- 99.9999999999999999% durability
		- Global-Zone Redundant Storage  GZRS
			- Copies data synchronously across **3** AZs in the primary region and asynchronously to another region
			- PR is AZ1, AZ2, AZ3; SR has just AZ1  
			- 99.9999999999999999% durability
- Secondary Region Redundancy with Read Access
	- Data is replicated synchronously to primary region - "in sync" with primary with read access
		- RA-GRS 
		- RA-GZRS 
		- These the same in every aspect as the above expect the Secondary is synchronous 


#### Azure Blobs
 
Blob storage is an object-store that is optimizaed for storing massive amounts of unstructured data (does not adhere to particular data model or definition).

Storage Account (a unique namespace in Azure for your data) -> Containers (similar to folder in a file system) -> Blobs ( the actual data being stored).

Types:
- Block Blobs
	- Store text and binary data
	- Individual managed 
	- up 4.75 TiB of Data
- Append Blobs
	- Optimized for append operations - Good for Logging Data
- Page Blobs
	- Stores random access files up to 8 TB
	- Store Virtual Hard Drive files and serve as disks for Azure VMs

Moving Blobs:
Method | Description
--- | ---
AzCopy | CLI for Linux and Windows - uses ASDML
Azure Storage Data Movement Library | .NET Library  
Azure Data Factory | ETL service 
Blobfuse | Virtual file system driver - access through Linux file system
Azure Data Box | Rugged device to physically transport data to Azure
Azure Import/Export service | Service to ship physical disks for data transfer no Azure


#### Azure Files

File share in cloud, a centralized server for storage allowing for multiple connections (mounting) with either SMB or NFS. Azure Files uses:
- Replacement or supplement for Network Attach Storage NAS
- Lift-and-Shift - Classic or Hybird Lifes
- Simplify cloud development
	- Shared application settings
	- Diagnostic share - logs to file share
	- Dev/Test/Debug - Quick sharing of tooling
- Containerization - to persist stateful containers

Azure files instead of File Shares server
- Share Access - Already setup to work with standard networking protocols SMB and NFS
- Fully managed patched by Azure
- Scalable
- Scripting and Tooling - Automation
- Resiliency 

Azure Files Feature
- Backups - shared snapshots
	- Incremental
	- Read-only
	- 200 snapshots per file share
	- 10 year retention
	- Stored in file share
- Soft Delete
- Advanced Threat Protection
	- Very powerful software
- Store Tiers
	- Premium - SSD storage
	- Transaction optimized - HDD with transaction heavy workloads - historically called standard
	- Hot - optimized for general purpose file sharing 
	- Cool - stored in HDD for cost effienct storage- optimized for archiving scenarios


Types of Storage
- General Purpose version 2 - deployed on HDD
- FileStorage - SSD deplyment

Identity
- On-Premise Azure Storage can  be joined to AD DS
- Managed - Azure Storage can  be joined to AD DS - Microsoft manages
- Store Account Key - Username and password 

Networking 
- Azure Files are accessible from anywhere via storage account public endpoint
- SMB - 445 

 Encryption
 - Encrypted-at-rest using Azure Storage Service Encryptions
 - Encrypted-in-transit with SMB 3.0+ or HTTPS

Azure File Sync

Allows cacheing of Azure File Share on an on-premise or cloud VM, no limit to amount of cacheing with SMB, NFS and FTPS.

Azure Storage Explorer

Standalone app to work with Azure Storage data on Windows, Linux and macOS - create Blob containers, uplaod files, create snopshops of Disk

[AZCopy]((https://learn.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy) - CLI - downloadable executable copy blobs or files to or from a storage accounts

Avaliable:
[GitHub - Azure/azure-storage-azcopy: The new Azure Storage data transfer utility - AzCopy v10](https://github.com/Azure/azure-storage-azcopy)
[Copy or move data to Azure Storage by using AzCopy v10 | Microsoft Learn](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10#download-azcopy)

- Requires Permissions!:
	- Storage Blob Data Reader - download
	- Storage Blob Data contributor - upload
	- Storage Blob Data Owner - upload
- Access via Azure AD or Shared Access Signature (SAS)

```powershell
azcopy copy $localpath $remotepath # upload
azcopy copy $remotepath $localpath # download
```

Azure Import and Export Services

Shipping with physical disk drives large amounts of data to a Azure Blob and Azure Files to a Azure datacenter. CLI tool for preparation `WAImportExport` - Window 64 bit only; Import Jobs:
- Prepares disks
- Copies data to drive
- Encrypts with AES 246 bitlocker
- Generate journal fies during import
	- Journal File store basic imformation - drive serial number, encryption key, storage account
- Identifies number of drives required

Version 1 is import/export data to Blob storage - Version 2 is for import data  Azure File 

For export jobs
- export only from Azure Blob
- up to 10 empty drives per job
- shipped to location

Shared Access Signatures

URI that grants restricted temporary access to Azure Storage resources
- Account-level SAS - access to one or more storage services 
- Service-level SAS - access to single storage services with storage account key
- User delegation SAS 
	- Azure AD credentials for access to storage account
	- Limited to only Blobs and Containers
	- Best practice methods
- Ad hoc 
	- Start, expiry times plus permission are part of the URI
	- Any SAS type 
- Service SAS with stored access policy
	- Stored access policcy is defined on a resource container
	- Stored access policy can be associated to multiple SAS to managed constraints

URI Format with parametres explained
```powershell
https://myaccount.blob.core.windows.net/$containerName/file.txt
?sv= # Storage services version
&st # Start Time
&se # Expiration Time
&sr # Storage Resource - b for blob, q for queue 
&sp # permissions  r, wr
&sig # SHA256 hash
```

Create in Azure Software Development Kit SDK or Portal `Storage Account -> Share Access signature`.

Setup File Sync `Azure File Sync -> Create` - 

#### AzCopy 

AZcopy is installed by default on the CloudShell
```powershell
azcopy copy $localpath $remotepath # upload
azcopy copy $remotepath $localpath # download
azcopy login # create URI to login
```

URL for Azure remote container: `Home -> Storage Accounts -> $ContainerName -> Properties`

Create a SAS for container `Home -> Storage Accounts -> $ContainerName -> Shared Access Signature` configure and `Generate SAS and connection string`. It will generate connections trings for: 
- Connection strings
- SAS Token
- Blob service SAS URL
- Queue service SAS URL
- Tabe service SAS URL
## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[azcopy | Microsoft Learn](https://learn.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy)
[GitHub - Azure/azure-storage-azcopy: The new Azure Storage data transfer utility - AzCopy v10](https://github.com/Azure/azure-storage-azcopy)