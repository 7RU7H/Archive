# Azure Administration - Storage Accounts

Azure Storage is Microsoft's cloud storage solution for modern data storage scenarios. Azure Storage offers a massively scalable object store for data objects. It provides a file system service for the cloud, a messaging store for reliable messaging, and a NoSQL store. Azure Storage data catergories:
- Structure Data
- Unstructure data
- VM data

Price Tiers
- Stardard
- Premium

Considerations:
- Durability and availability
- Secure access
- Scalability
- Manageability
- Data Accessibility
- Storage optimization for masive data
- Storage for messages should use Queue Storage
- Table Storage for structure data
- Azure Files for configs and logs for later use.


The storage account name is used as part of the URI for API access, so it must be globally unique. Azure Storage Accounts offer several types of storage accounts:

Account Kind:
![1000](azurestorageaccounttypes.png)

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
	- Azure Files - Managed file shares for cloud or on-premises deployments
	-  Azure Queues - A messaging store for reliable messaging between application components.
	- Azure Tables - A NoSQL store for schemaless storage of structured data or _relational_ data.
		
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

Premium Blob Storage: *"Premium Blob Storage is best suited for I/O intensive workloads that require low and consistent storage latency. Premium Blob Storage uses solid-state drives (SSDs) for fast and consistent response times. This storage is best for workloads that perform many small transactions."*

![1000](azurecomparisonofstoragetiering.png)


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
	- Local Redundant Storage (LRS) - Distributed over Local to AZ1 in a Region
	- Zone Redundant Storage (ZRS) -  Distributed through the Zones of a Region
	- Global Redundant Storage (GRS) - Distributed both Locally in one Zone and also in the Paired Region
	- Geo-Zone Redundant Storage (GZRS) - Distributed Locally one per Zone and Paired region
		- Always replicates asynchronously!
		- Some services allow reading from a Pair
- Premium Options vary on type; never a Geo-replicated option

Replication Strategies:
![1000](azurereplicationstrategies.png)

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
 
Blob storage is an object-store that is optimizaed for storing massive amounts of unstructured data (does not adhere to particular data model or definition). Azure Blob Storage uses a container resource to group a set of blobs. A blob can't exist by itself in Blob Storage. A blob must be stored in a container resource, -which can store an unlimited number of blobs. Azure storage account can contain an unlimited number of containers.

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

![1000](azureblobuploadtools.png)

Moving Blobs:
Method | Description
--- | ---
AzCopy | CLI for Linux and Windows - uses ASDML
Azure Storage Data Movement Library | .NET Library  
Azure Data Factory | ETL service 
Blobfuse | Virtual file system driver - access through Linux file system
Azure Data Box | Rugged device to physically transport data to Azure
Azure Import/Export service | Service to ship physical disks for data transfer no Azure

Create Container for Blob Storage
`Azure Storage accounts -> + Container -> Name and Change "Public Access Level"`:
**Public access level**: The access level specifies whether the container and its blobs can be accessed publicly. By default, container data is private and visible only to the account owner. There are three access level choices:
    -   **Private**: (Default) Prohibit anonymous access to the container and blobs.
    -   **Blob**: Allow anonymous public read access for the blobs only.
    -   **Container**: Allow anonymous public read and list access to the entire container, including the blobs.

See Tiering for Hot, Cold, Archive and Premium Storage

Use Azure Blob Storage lifecycle management policy rules to:
`Storage Account -> $storage_account -> Lifecycle Management`
- Rule-based run scheduling
- Rule-based condition to containers or a subset of blobs
- Delete blobs 
- Transition Storage tier 

Object replication copies blobs in a container asynchronously according to policy rules that you configure. During the replication process, the following contents are copied from the source container to the destination container:
-   The blob contents
-   The blob metadata and properties
-   Any versions of data associated with the blob
Requires:
- Versioning enabled
- Does not support snapshots
- Replication Policy
Considerations:
- Latency reductions
- Efficiency for compute workloads
- Data distribution
- Costs benefit

Create a storage account:
`Storage Accounts`
Create Container for blobs
`Storage Accounts -> $storage_account -> Containers
Upload Blob
`Storage Accounts -> $storage_account -> Containers -> $container -> Upload`
Move Data to, from, or within Azure Storage
`Storage Accounts -> $storage_account -> Diagnose and solve problems`
Monitor Storage Accounts
`Storage Accounts -> $storage_account -> Insights`

#### Azure Files

File share in cloud, a centralized server for storage allowing for multiple connections (mounting) with either SMB or NFS. Azure Files uses:
- Replacement or supplement for Network Attach Storage NAS
- Lift-and-Shift - Classic or Hybird Lifes
- Simplify cloud development
	- Shared application settings
	- Diagnostic share - logs to file share
	- Dev/Test/Debug - Quick sharing of tooling
- Containerization - to persist stateful containers
- Diagnostic logs, metrics, and crash dumps can be written to a file share and processed or analyzed later.
- Configuration files can be stored on a file share and accessed from multiple virtual machines.

Azure files instead of File Shares server
- Share Access - Already setup to work with standard networking protocols SMB and NFS
- Fully managed patched by Azure
- Scalable
- Scripting and Tooling - Automation
- Resiliency 

Azure Files Features:
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


## Azure Storage Security

- Encryption 
	- Secure data in transit
	- Secure data at rest - decrypted on retrieva
- Shared access signatures
- Authorized & Authenication

Configure Azure Storage Encryption:
`Storage accounts -> $storage_accounts -> Encryption`

Customer Managed Keys for greater control - create, disable, audit, rotate and define access controls. Choose:
- Encryption Type
- Encryption Key

Consideration regarding Storage Security
![1000](azurestorageauthorizationstrategies.png)

Microsoft's Recommendations:
- Always use HTTPS
- Reference stored access policies
- Set near-term expiry for unplanned SAS
- Require client renew SAS
- Set SAS start time to avoid clock skew -  set: -15 minutes ago 
- Define *minimum* and limit access permissions for resource
	- Consider costs of over provisioning
- Do not assume a SAS is always correct choice
- Monitor applications


#### Shared Access Signatures

Create a SAS
`Storage Accounts -> $storage_account -> search SAS`

A shared access signature (SAS) is URI that grants restricted temporary access to Azure Storage resources
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
	- Stored access policy is defined on a resource container
	- Stored access policy can be associated to multiple SAS to managed constraints
- IP addresses
- Protocols

URI Format with parametres explained
```powershell
https://myaccount.blob.core.windows.net/$containerName/file.txt
?sv= # Storage services version
&ss # Storage service
&sip # IP range
&spr # Protocol
&st # Start Time
&se # Expiration Time
&sr # Storage Resource - b for blob, q for queue 
&sp # permissions  r, wr
&sig # SHA256 hash - the signature
```




#### Secure Storage Endpoints

`Storage Accounts -> $storage_account -> Networking Firewalls and virtual networks`; restrict access:
- Enabled from all networks
- Enabled from selected virtual networks and IP address
- Disabled



## Workflows

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

Create a SAS for container `Home -> Storage Accounts -> $ContainerName -> Shared Access Signature` configure and `Generate SAS and connection string`. It will generate connections strings for: 
- Connection strings
- SAS Token
- Blob service SAS URL
- Queue service SAS URL
- Table service SAS URL

#### Storage Access

**Container service** - `//`**`mystorageaccount`**`.blob.core.windows.net`
**Table service** - `//`**`mystorageaccount`**`.table.core.windows.net` 
**Queue service** - `//`**`mystorageaccount`**`.queue.core.windows.net`
**File service** - `//`**`mystorageaccount`**`.file.core.windows.net`
**Blob Access** - `//`**`mystorageaccount`**`.blob.core.windows.net/`**`mycontainer`**`/`**`myblob`**.

#### Configure Custom Domains

Azure Storage doesn't currently provide native support for HTTPS with custom domains. You can implement an Azure Content Delivery Network (CDN) to access blobs by using custom domains over HTTPS. By either configuring:
- Direct mapping - create a `CNAME` record
- Intermediary domain mapping (when domain is already in use) - prepend `asverify` to subdomain it permit Azure to recognize your custom domain thereby using a intermediary domain to validate the domain.

#### Azure Storage Explorer

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

#### Azure Import and Export Services

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


## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[azcopy | Microsoft Learn](https://learn.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy)
[GitHub - Azure/azure-storage-azcopy: The new Azure Storage data transfer utility - AzCopy v10](https://github.com/Azure/azure-storage-azcopy)