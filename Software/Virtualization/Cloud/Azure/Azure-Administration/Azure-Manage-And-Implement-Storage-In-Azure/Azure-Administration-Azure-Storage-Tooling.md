# Azure-Administration Azure Storage Tooling
#### Azure Storage Explorer

Storage Explorer is a GUI application developed by Microsoft to simplify access to, and the management of, data stored in Azure storage accounts. Storage Explorer is available on Windows, macOS, and Linux. 
-  Requires:
	- (Azure Resource Manager) and data layer permissions (Entra ID permissions - Azure AD)to allow full access to your resources.
- For:
	- create Blob containers, upload files, create snapshots of Disk. 

Storage Explorer gives you the ability to manage the data stored in multiple Azure storage accounts and across Azure subscriptions. Azure Storage Explorer lets you connect to different storage accounts.
- Connect to storage accounts associated with your Azure subscriptions.
- Connect to storage accounts and services that are shared from other Azure subscriptions.
- Connect to and manage local storage by using the Azure Storage Emulator.

- Sign-in through `StorageExplorer.exe` with an Azure Account
	- Add a resource via Azure AD, choosing the Azure tenant and the associated account
- Or SAS
	- Then find connection node: `Local & attached > Storage Accounts > Attached Container > Service`
- Or with Storage account name and key
- For Data Lake Storage Gen1:
	-  URI associated with the data lake

Manage Storage resource in an Azure subscription or Local using Azure Storage Emulator or...

| | |
|---|---|
|**Attach to external storage**|Manage storage resources that belong to another Azure subscription or that are under national Azure clouds by using the storage account name, key, and endpoints. This scenario is described in more detail in the next section.|
|**Attach a storage account with a SAS**|Manage storage resources that belong to another Azure subscription by using a shared access signature (SAS).|
|**Attach a service with a SAS**|Manage a specific Azure Storage service (blob container, queue, or table) that belongs to another Azure subscription by using a SAS.|

#### Azure Import/Export Service

The Azure Import/Export service is used to securely import large amounts of data to Azure Blob Storage and Azure Files by shipping disk drives to an Azure Data centre. This service can also be used to transfer data from Azure Blob Storage to disk drives and ship to your on-premises sites. Steps regardless
1. Identity data
2. Calculate transportation disk requirement
3. `Azure Export Jobs` or install and run `WAImportExport` top copy data to disk
4. Physical transportation

Shipping with physical disk drives large amounts of data to a Azure Blob and Azure Files to a Azure datacenter with CLI tool for preparation - `WAImportExport` - Window 64 bit only; Import Jobs:
- Prepares disks
- Copies data to drive
- Encrypts with AES 246 bitlocker
- Generate journal files during import
	- Journal File store basic information - drive serial number, encryption key, storage account
- Identifies number of drives required

Version 1 is import/export data to Blob storage - Version 2 is for import data  Azure File 

For export jobs
- Export only from Azure Blob
- Up to 10 empty drives per job
- shipped to location

`WAImportExport` considerations:
- Bitlocker encryptions, SupportedDisk and the OS version
- The WAImportExport tool is available in two versions:
	- Version 1 is best for importing and exporting data in Azure Blob Storage.
	- Version 2 is best for importing data into Azure Files.
	- The WAImportExport tool is only compatible with 64-bit Windows operating system. For the list of supported operating systems and versions, see [Azure Import/Export requirements](https://learn.microsoft.com/en-us/azure/import-export/storage-import-export-requirements#supported-operating-systems).


## Azure Copy 

AzCopy v10 is the next-generation command-line utility for copying data to and from Azure Blob Storage and Azure Files.

- Every AzCopy instance creates a job order and a related log file. You can view and restart previous jobs, and resume failed jobs.
- You can use AzCopy to list or remove files or blobs in a given path. AzCopy supports wildcard patterns in a path, `--include` flags, and `--exclude` flags.
- AzCopy automatically retries a transfer when a failure occurs.
- When you use Azure Blob Storage, AzCopy lets you copy an entire account to another account. No data transfer to the client is needed.
- AzCopy supports Azure Data Lake Storage Gen2 APIs.
- AzCopy is built into Azure Storage Explorer.
- AzCopy is available on Windows, Linux, and macOS.
- Azure Storage Explorer uses AzCopy

Authentication with:

|Authentication|Support|Description|
|---|---|---|
|**Azure Active Directory (Azure AD)**|Azure Blob Storage and Azure Data Lake Storage Gen2|The user enters the `.\\azcopy` sign-in command to sign in by using Azure AD. The user should have the _Storage Blob Data Contributor_ role assigned, which allows them to write to Blob Storage by using Azure AD authentication. When the user signs in from Azure AD, they provide their credentials only once. This option allows the user to circumvent having to append a SAS token to each command.|
|**SAS tokens**|Azure Blob Storage and Azure Files|On the command line, the user appends a SAS token to the blob or file path for every command they enter.|

## Workflows 


Job | Storage Service | Supported | Not supported 
--- | --- |--- | ---
Import | Azure Blob Storage  |  Block blobs and Page blobs supported | -  
.. | Azure Files storage |  Files supported  | ..
Export | Azure Blob Storage | Block blobs, Page blobs, and Append blobs supported | Azure Files not supported  
.. | .. | .. | Export from Archive tier not supported

Shipping with physical disk drives large amounts of data to a Azure Blob and Azure Files to a Azure data center with CLI tool for preparation - `WAImportExport` - Window 64 bit only
- Export only from Azure Blob
- Up to 10 empty drives per job

Import/Export Jobs - physical disk to data centre
1. Identity data
2. Calculate transportation disk requirement
3. `Azure Export Jobs` or install and run `WAImportExport` to copy data to disk
4. Physical transportation

Create an Azure Export Job
1. Identify the data in Azure Blob Storage to export.
2. Determine the number of disks needed to accommodate the data to transfer.
3. In the Azure portal, create an Azure Export job and provide the following information:
    - The Azure Storage account to use for the Export job
    - The blob data to export
    - The return address for shipment of your disks
    - Your shipment carrier account number
4. Ship the required number of disks to the Azure region datacenter that hosts the storage account. Note the shipment tracking number.
5. Update the Export job to include the shipment tracking number.
6. After the disks arrive at the Azure datacenter, the staff completes the following tasks:
    1. The specified data in the storage account is copied to the disks you provided.
    2. The disk volumes are encrypted by using BitLocker.
    3. The disks are shipped back to you.
- The BitLocker keys used to encrypt your disks are stored with the specified storage account in the Azure portal. You can decrypt the content of the disks and copy the data to your on-premises storage

[Import Job to Azure Files](https://learn.microsoft.com/en-us/azure/import-export/storage-import-export-data-to-files?tabs=azure-portal-preview)
1. Prep Drives
	1. Single NTFS volume per drive
	2. Modify dataset.csv
		- Import file or folder or both
	3. If specify encryption state either `Encrypt` to enable Bitlocker or `AlreadyEncrypted` and supply Bitlocker key 
2. Create Import Job
	 - `Search -> Azure Data Box` - prep transfer
		1. Select the **Import to Azure** transfer type.
		2. Select the subscription to use for the Import/Export job.
		3. Select a resource group.
		4. Select the **Source country/region** for the job.
		5. Select the **Destination Azure region** for the job.
		6. Then select **Apply**.
	- Create Job 
3. Ship Data Box
4. Update job with tracking information
5. Verify Data upload to Azure

Add more drives use the same journal file; add the `AdditionalDriveSet`
```powershell
WAImportExport.exe PrepImport /j:<JournalFile> /id:<SessionId> /AdditionalDriveSet:<driveset.csv>
```

[Import Blob to Blob Storage](https://learn.microsoft.com/en-us/azure/import-export/storage-import-export-data-to-blobs?tabs=azure-portal-preview)
- Prep data and disks
1. Connect disk drive via SATA connectors
2. Single NTFS volume per drive - no mmountpoints
3. Bitlocker Encryption
4. `Robocopy` data 
5. Use `WaImportExport.exe`
```powershell
./WAImportExport.exe PrepImport /j:<journal file name> /id:session<session number> /t:<Drive letter> /bk:<BitLocker key> /srcdir:<Drive letter>:\ /dstdir:<Container name>/ /blobtype:<BlockBlob or PageBlob> /skipwrite
```
6. Get Bitlocker key of drive `manage-bde -protectors -get <DriveLetter>:`
7. Prep Disk
- Create Job - will check if it passes validation
- (Optional) Configure customer managed key - for customers using Microsoft manage key 
- Ship drive
- Update Job with tracking information
- Verify Data upload to Azure

`StorageExplorer.exe` - manage the data stored in multiple Azure storage accounts and across Azure subscriptions.
- Sign-in through `StorageExplorer.exe` with an Azure Account
	- Add a resource via Azure AD, choosing the Azure tenant and the associated account
- Or SAS
	- Then find connection node: `Local & attached > Storage Accounts > Attached Container > Service`
- Or with Storage account name and key
- For Data Lake Storage Gen1:
	-  URI associated with the data lake

List or Add rules for Lifecycle Policy management 
`Search Storage Account -> $storageAccount -> Data Management -> Lifecycle Management -> List View | Add rules`

#### AzCopy 

[AZCopy]((https://learn.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy) - CLI - downloadable executable copy blobs or files to or from a storage accounts; [AzCopy](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-files) is installed by default on the CloudShell
```powershell
# Make file shares
azcopy make 'https://<storage-account-name>.file.core.windows.net/<file-share-name><SAS-token>'

# Upload files or directories
# Suport wildcard 
azcopy copy $localpath $remotepath # upload
# Download
azcopy copy $remotepath $localpath # download
azcopy login # create URI to login

# Supported by not recommended - doesn't support differential copies at scale
# Useful in Temporary File deletion and Syncing between Shares
azcopy sync $localpath $remotepath --delete-desitnation true
```

URL for Azure remote container: `Home -> Storage Accounts -> $ContainerName -> Properties`

Create a SAS for container `Home -> Storage Accounts -> $ContainerName -> Shared Access Signature` configure and `Generate SAS and connection string`. It will generate connections strings for: 
- Connection strings
- SAS Token
- Blob service SAS URL
- Queue service SAS URL
- Take service SAS URL

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[azcopy | Microsoft Learn](https://learn.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy)
[GitHub - Azure/azure-storage-azcopy: The new Azure Storage data transfer utility - AzCopy v10](https://github.com/Azure/azure-storage-azcopy)
[Azure Storage](https://learn.microsoft.com/en-us/azure/storage/tables/table-storage-overview)
[Create a AzStorageTable storage](https://learn.microsoft.com/en-us/azure/storage/tables/table-storage-how-to-use-powershell)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)