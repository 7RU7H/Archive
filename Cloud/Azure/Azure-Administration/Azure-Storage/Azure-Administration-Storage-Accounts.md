# Azure Administration - Storage Accounts

Azure Storage is Microsoft's cloud storage solution for modern data storage scenarios. Azure Storage offers a massively scalable object store for data objects. It provides a file system service for the cloud, a messaging store for reliable messaging, and a NoSQL store. 
Azure Storage data catergories:
- Structure Data
- Unstructured data
- VM data

Price Tiers
- Stardard - HDD
- Premium -SSD

Considerations:
- Durability and availability
- Secure access
- Scalability
- Manageability
- Data Accessibility
- Storage optimisation for massive data
- Storage for messages should use Queue Storage
- Table Storage for structure data
- Azure Files for configs and logs for later use.
- The number of storage accounts you need is typically determined by:
	- Data diversity
	- Cost sensitivity  
	- Tolerance for management overhead.
- Access from Azure AD is best with SPN to handle the authenication.

The storage account name is used as part of the URI for API access, so it must be globally unique. Azure Storage Accounts offer several types of storage accounts:

Account Kind:
![1000](azurestorageaccounttypes.png)

Storage Accounts:
Supported Services - Azure Blob, Azure File, Azure Queue, Azure Table, Disk, Azure Data Lake Gen2
Supported Services - Azure Blob, Azure File, Azure Queue, Azure Table,  Disk, Azure Data Lake Gen2
Performance Tiers - Standard Premium
Access Tiers - Hot, Cool, Archive
Replication - LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS
Deployment model - Resource, Manager, Classic

A Comparison of Storage Types
![](azure-storageaccountcomparison.png)

#### Storage Services

**Types:**
- **Azure Blob Storage (Containers)**. Blob storage is used to store unstructured or non-relational data as a binary large object (blob).
	- Serving images or documents directly to a browser.
	- Storing files for distributed access.
	- Streaming video and audio.
	- Storing data for backup and restore, disaster recovery, and archiving.
	- Storing data for analysis by an on-premises or Azure-hosted service.
- **Azure Table Storage**. Table storage is used to store NoSQL, semi-structured data.
- **Azure Queue Storage**. Queue storage is used to store messages in a queue, which can then be accessed and processed by applications through HTTP(S) calls.
- **Azure Files**. Azure Files is a file-sharing service that enables access through the Server Message Block protocol, similar to traditional file servers.
	- File Shares for configurations files, logs, metrics, mountable on-premise file shares
- **Azure Data Lake Storage**. Azure Data Lake, based on Apache Hadoop, is designed for large data volumes and can store unstructured and structured data. Azure Data Lake Storage Gen1 is a dedicated service. Azure Data Lake Storage Gen2 is Azure Blob Storage with the hierarchical namespace feature enabled on the account.

#### Performance Tiers (Blob Storage)

2 types of performance tiers for storage accounts: Standard and Premium

|Storage account|Supported services|Recommended usage|
|---|---|---|
|[**Standard** **general-purpose v2**](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-upgrade)|Blob Storage (including Data Lake Storage), Queue Storage, Table Storage, and Azure Files|Standard storage account for most scenarios, including blobs, file shares, queues, tables, and disks (page blobs).|
|[**Premium** **block blobs**](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-block-blob-premium)|Blob Storage (including Data Lake Storage)|Premium storage account for block blobs and append blobs. Recommended for applications with high transaction rates. Use Premium block blobs if you work with smaller objects or require consistently low storage latency. This storage is designed to scale with your applications.|
|[**Premium** **file shares**](https://learn.microsoft.com/en-us/azure/storage/files/storage-how-to-create-file-share)|Azure Files|Premium storage account for file shares only. Recommended for enterprise or high-performance scale applications. Use Premium file shares if you require support for both Server Message Block (SMB) and NFS file shares.|
|[**Premium** **page blobs**](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-pageblob-overview)|Page blobs only|Premium high-performance storage account for page blobs only. Page blobs are ideal for storing index-based and sparse data structures, such as operating systems, data disks for virtual machines, and databases.|

- Input/Output Operations Per Second (IOPS)

Premium Performance:
- Stored on SSD
- Optimized for low-latency2
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

#### Access Storage

URL access to an object in your storage account 

|Service|Default endpoint|
|---|---|
|**Container service**|`//`**`mystorageaccount`**`.blob.core.windows.net`|
|**Table service**|`//`**`mystorageaccount`**`.table.core.windows.net`|
|**Queue service**|`//`**`mystorageaccount`**`.queue.core.windows.net`|
|**File service**|`//`**`mystorageaccount`**`.file.core.windows.net`|

For Custom Domains
- Direct Mapping:
	- Subdomain: `blobs.contoso.com`
	- Azure storage account: `\<storage account>\.blob.core.windows.net`
	- Direct `CNAME` record: `contosoblobs.blob.core.windows.net`
- Intermediary Domain Mapping:
	- `CNAME` record: **`asverify`**`.blobs.contoso.com`
	- Intermediate `CNAME` record: **`asverify`**`.contosoblobs.blob.core.windows.net`

#### Access Tiers (Blob Storage)

|Compare|Hot tier|Cool tier|Archive tier|
|---|---|---|---|
|**Availability**|99.9%|99%|Offline|
|**Availability (RA-GRS reads)**|99.99%|99.9%|Offline|
|**Latency (time to first byte)**|milliseconds|milliseconds|hours|
|**Minimum storage duration**|N/A|30 days|180 days|
|**Usage costs**|Higher storage costs, Lower access & transaction costs|Lower storage costs, Higher access & transaction costs|Lowest storage costs, Highest access & transaction costs|

When a blob is uploaded or moved to another tier it is charged at the new tier's rate **immediately** upon tier change:

- Hot to cooler tiers, operation is billed as a write operation to destination tier
- Cold to hotter tier, operation is billed as a read from the source tier

- Cool and Archive early deletion: 
	- Any blob moved into Cool tier (GPv2 accounts only) is subject to a cool early deletion period of 30 days.
	- Any blob moved into Archive tier is subject to an Archive early deletion period of 180 days -charge is prorated.

Account level tiering: 
- any blob that doesn't have an explicitly assigned tier infers the tier from the Storage Account access tier setting
Blob-Level Tiering:
- Upload a blob to the tier of your choice.
- Changing tiers happens instantly with the exception from moving out of archive
Re-hydrating a Blob
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

#### Replication and Data redundancy Strategies

Upon creation of a Storage Account you need to choose a Replication Type, Replication stores multiple copies of data protecting it from:
- Planned events
- Transient hardware failures
- Network or power outages
- Massive Natural disasters

- Region Specific
- Redundancy - Standard performance:
	- Local Redundant Storage (LRS) - Distributed over Local to AZ1 in a Region
	- Zone Redundant Storage (ZRS) -  Distributed through the Zones of a Region
	- Global Redundant Storage (GRS) - Distributed both Locally in one Zone and also in the Paired Region
	- Geo-Zone Redundant Storage (GZRS) - Distributed Locally one per Zone and Paired region
		- Always replicates asynchronously!
		- Some services allow reading from a Pair
- Premium Options vary on type; never a Geo-replicated option

Replication Strategies:
![1080](azurereplicationstrategies.png)

The greater the level of redundancy the greater the expense:
- Primary Region Redundancy - Data is replicated  either:
	- Locally Redundant Storage (LRS)
		- Copies data synchronosusly in primary region 
			- PR is just AZ1
			- 99.99999999999% durability
			- Cheapest
	- Zone-redundant storage (ZRS)
		-  Copies data synchronously in primary region across **3** AZs:
			- PR is AZ1, AZ2, AZ3
			- 99.999999999999% durability
- Secondary Region redundancy  
	- Replicated to secondary region in case of primary regional disaster with the Secondary determined based on Primary's pairing
	- Secondary Region - no read or write access expect in event of failover 
		- Global Redundant Storage (GRS)
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

## Import/Export Supported Types

Job | Storage Service | Supported | Not supported 
--- | --- |--- | ---
Import | Azure Blob Storage  |  Block blobs and Page blobs supported | -  
.. | Azure Files storage |  Files supported  | ..
Export | Azure Blob Storage | Block blobs, Page blobs, and Append blobs supported | Azure Files not supported  
.. | .. | .. | Export from Archive tier not supported


## Azure Blobs

[[Azure-Administration-Blob-Storage]]

## Azure Files

[[Azure-Administration-Files]]

## Azure Storage Tooling

#### Azure Storage Explorer

Storage Explorer is a GUI application developed by Microsoft to simplify access to, and the management of, data stored in Azure storage accounts. Storage Explorer is available on Windows, macOS, and Linux. - create Blob containers, upload files, create snapshots of Disk. Requires both: management (Azure Resource Manager) and data layer permissions to allow full access to your resources.

Storage Explorer gives you the ability to manage the data stored in multiple Azure storage accounts and across Azure subscriptions.

- Signin through `StorageExplorer.exe` with an Azure Account
	- Add a resource via Azure AD, choosing the Azure tenant and the associated account
- Or SAS
	- Then find connection node: `Local & attached > Storage Accounts > Attached Container > Service`
- Or with Storage account name and key
- For Data Lake Storage Gen1:
	-  URI associated with the data lake
- 
#### Azure Import/Export Service

The Azure Import/Export service is used to securely import large amounts of data to Azure Blob Storage and Azure Files by shipping disk drives to an Azure datacenter. This service can also be used to transfer data from Azure Blob Storage to disk drives and ship to your on-premises sites. Steps regardless
1. Identity data
2. Calculate transportation disk requirement
3. `Azure Export Jobs` or install and run `WAImportExport` top copy data to disk
4. Physical transportation

Shipping with physical disk drives large amounts of data to a Azure Blob and Azure Files to a Azure datacenter with CLI tool for preparation - `WAImportExport` - Window 64 bit only; Import Jobs:
- Prepares disks
- Copies data to drive
- Encrypts with AES 246 bitlocker
- Generate journal fies during import
	- Journal File store basic imformation - drive serial number, encryption key, storage account
- Identifies number of drives required

Version 1 is import/export data to Blob storage - Version 2 is for import data  Azure File 

For export jobs
- Export only from Azure Blob
- Up to 10 empty drives per job
- shipped to location

`WAImportExport` considerations:
- Bitlocker encryptions, SupportedDisk and the OS version


#### AzCopy 

[AZCopy]((https://learn.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy) - CLI - downloadable executable copy blobs or files to or from a storage accounts; [AzCopy](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-files) is installed by default on the CloudShell
```powershell
# create URI to login
azcopy login 
# Make file shares
azcopy make 'https://<storage-account-name>.file.core.windows.net/<file-share-name><SAS-token>'

# Upload files or directories
# Support wildcards * 
azcopy copy $localpath $remotepath # upload
# Download
azcopy copy $remotepath $localpath # download

# Supports wildcard include and exclude
azcopy copy [source] [destination] --include
azcopy copy [source] [destination] --exclude 

# Supported by not recommended - doesn't support differential copies at scale
# Useful in Temporary File deletion and Syncing between Shares
azcopy sync $localpath $remotepath --delete-desitnation true
```

Avaliable:
[GitHub - Azure/azure-storage-azcopy: The new Azure Storage data transfer utility - AzCopy v10](https://github.com/Azure/azure-storage-azcopy)
[Copy or move data to Azure Storage by using AzCopy v10 | Microsoft Learn](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10#download-azcopy)

- Requires Permissions!:
	- Storage Blob Data Reader - download
	- Storage Blob Data contributor - upload
	- Storage Blob Data Owner - upload
- Access via Azure AD or Shared Access Signature (SAS)

Azure Copy Features
-   Every AzCopy instance creates a job order and a related log file.
-   AzCopy supports Azure Data Lake Storage Gen2 APIs.
-   AzCopy is built into Azure Storage Explorer.  
-   AzCopy is available on Windows, Linux, and macOS.
-   Authenticate with SAS or Azure-AD


## Azure Storage Tables

[Azure Storage](https://learn.microsoft.com/en-us/azure/storage/tables/table-storage-overview): *"Azure Table storage is a service that stores non-relational structured data (also known as structured NoSQL data) in the cloud, providing a key/attribute store with a schemaless design."*

This does also require a storage account and resource group.

[Create a AzStorageTable storage](https://learn.microsoft.com/en-us/azure/storage/tables/table-storage-how-to-use-powershell) table associated with the storage account in Azure and relevant activities
```powershell
# Create new table
New-AzStorageTable -Name $tableName –Context $ctx
# create a object to perform table operations
$storageTable = Get-AzStorageTable –Name $tableName –Context $ctx
# Get the manditory CloudTable, will create a table if non-existent
$cloudTable = $storageTable.CloudTable
# table entries - entityOne/Two are fields 
Add-AzTableRow -table $cloudTable -partitionKey $partitionKey -rowKey ("CA") -property @{"entityOne"="data";"entityTwo"=1}
# Query the table; for specifics use: -columnName "" -value "" -operator $op
Get-AzTableRow -table $cloudTable | ft
# Delete a table
Remove-AzStorageTable –Name $tableName –Context $ctx
```

## Azure Storage Security

[[Azure-Administration-Storage-Security-Strategies]]

#### Stored Access Policies

Stored access policy can be created for:
- Blob containers
- File shares
- Queues
- Tables

Create a Stored Access Policy for a Container
`Storage Accounts -> $storage_account -> Container -> Access Policy`

Create a Stored Access Policy for a Container
```powershell
# perm can be : <(a)dd, (c)reate, (d)elete, (l)ist, (r)ead, or (w)rite>
az storage container policy create -name $polcyName --container-name $container --start $startTime-UTC --expiry $expiryTime-UTC --permissions $perm --account-key $storageAccountKey --account $storageName
```

With C\#
```C#
// Use a stored access policy for the SAS
private void CreateStoredAccessPolicy()
{
    // Create a stored access policy for our blobs
    BlobSignedIdentifier identifier = new BlobSignedIdentifier
    {
        Id = _storedPolicyID,
        AccessPolicy = new BlobAccessPolicy
        {
            ExpiresOn = DateTimeOffset.UtcNow.AddHours(1),
            Permissions = "r"
        }
    };

    _container.SetAccessPolicy(permissions: new BlobSignedIdentifier[] { identifier });
}
```

#### Secure Storage Endpoints

`Storage Accounts -> $storage_account -> Networking Firewalls and virtual networks`; restrict access:
- Enabled from all networks
- Enabled from selected virtual networks and IP address
- Disabled


## Workflows

Create in Azure Software Development Kit SDK or Portal `Storage Account -> Share Access signature`.

Setup File Sync `Azure File Sync -> Create` - 

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
- Intermediary domain mapping (when domain is already in use) - prepend `asverify` to subdomain it permit Azure to recognise your custom domain thereby using a intermediary domain to validate the domain.

Create Storage Account
```powershell
az storage account create --name $storageName --access-tier hot --kind StorageV2 --resource-group $resourceGroup
```

Obtain connection string to storage account
```powershell
az storage account show-connection-string --name $storageName
# Copy the AccountKey=$base64string ; remember to include the ==
```

Create a container
```powershell
az storage container create --name $containerName --account-name $storageName 
--public-access off
```

Upload to a blob
```powershell
az storage blob upload-batch --source sas --destination $containerName --acount-name $storageName --pattern *.ext # wildcard extensions!
```


## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[azcopy | Microsoft Learn](https://learn.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy)
[GitHub - Azure/azure-storage-azcopy: The new Azure Storage data transfer utility - AzCopy v10](https://github.com/Azure/azure-storage-azcopy)
[Azure Storage](https://learn.microsoft.com/en-us/azure/storage/tables/table-storage-overview)
[Create a AzStorageTable storage](https://learn.microsoft.com/en-us/azure/storage/tables/table-storage-how-to-use-powershell)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)