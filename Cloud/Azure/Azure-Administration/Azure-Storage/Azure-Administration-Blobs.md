# Azure Administration - Blobs

Blob storage is an object-store that is optimized for storing massive amounts of unstructured data (does not adhere to particular data model or definition). Azure Blob Storage uses a container resource to group a set of blobs. A blob can't exist by itself in Blob Storage. A blob must be stored in a container resource, which can store an unlimited number of blobs. Azure storage account can contain an unlimited number of containers.

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

[Managing Lifecycle](https://learn.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-policy-configure?tabs=azure-portal) can be rule base to change to a different storage tier 
```json
{
  "rules": [
    {
      "enabled": true,
      "name": "move-to-cool",
      "type": "Lifecycle",
      "definition": {
        "actions": {
          "baseBlob": {
            "tierToCool": {
              "daysAfterModificationGreaterThan": 30
            }
          }
        },
        "filters": {
          "blobTypes": [
            "blockBlob"
          ],
          "prefixMatch": [
            "sample-container/log"
          ]
        }
      }
    }
  ]
}
```

List or Add rules for Lifecycle Policy management 
`Search Storage Account -> $storageAccount -> Data Management -> Lifecycle Management -> List View | Add rules`

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
- The blob contents
- The blob metadata and properties
- Any versions of data associated with the blob
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




## References

[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[AZCopy]((https://learn.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy) 
[AzCopy Useage](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-files)