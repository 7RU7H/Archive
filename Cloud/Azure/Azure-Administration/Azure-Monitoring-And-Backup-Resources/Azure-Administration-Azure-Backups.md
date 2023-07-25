
# Azure Backups


The Azure Backup service provides a simple, secure and cost-effective solution for backing up an organisation's data. Administrators implement the Microsoft Azure Recovery Services (MARS) agent for Azure Backup to recover their data from the Microsoft Azure cloud. Azure Backup Service is a backup layer that spans many Azure services - Scales, secures data at-rest and in-transit with unlimited data transfer:
- On-Premise, Azure VMs, Azure Files, SQL Server (via Azure VM), SAP HANA databases (vie Azure VM), Azure Database for PostgreSQL
- Azure Backup directly integrated with Azure Services - not searchable based on service name
- Offload on-premises backups
- Backup VMs
- Filter views by datasource-specific properties
- App Consistent Backups (restore apps back to an exact state) 
- Automatic Storage Management - with Storage options 
- Uses Azure Workbooks of Azure Monitor and Azure Monitor Logs (Log Analytics) to help you view detailed reports on backups.

Benefits according to Microsoft:
![](azurebackupbenefit.png)

## Backup Centre 

`Azure Portal -> Backup Center`

- Azure Files backup is snapshot-based
- Azure Backup for files and folders relies on the MARS agent

#### Storage replication options

|Replication type|Recommendation|
|---|---|
|**Geo-redundant** (GRS)|(Default) Use GRS when Azure is your primary backup storage endpoint.|
|**Locally redundant** (LRS)|If Azure **isn't** your primary backup storage endpoint, use LRS to reduce your storage costs.|
|**Zone redundant**|If you require data availability without downtime in a region and need to guarantee data residency, use ZRS.|

## Azure Recovery Services (ARS) 

Azure Recovery Services (ARS) vault is a storage entity in Azure that houses data and recovery points
- Enhanced capabilities to help secure backup data 
- Central Monitoring for your hybrid IT environment
- Azure role-based access control (Azure RBAC)
- Soft Delete
- Cross-Region Restore
 Microsoft Azure Recovery Services (MARS) agent backups files, folders, and system state from Windows on-premises machine and Azure VMs
 - Backups are stored in a Recovery Services vault in Azure
 - MARS agent is also known as the Azure Backup agent
 - The AMRS agent does not support Linux operating systems

Azure Site Recovery (ASR) is a hybrid (on-premise to cloud) backup solution for site-to-site recovery
- Recovery Services Vaults 
	- Backup: 
		- File Shares, Files and folders, IaaS VM SQL databases
	- Supports 
		-  Support System Center Data Protection Manager, Windows Server, Azure Backup Server, and other services.
	-  No data transfer -  Don't need to configure the storage replication type. 
		- Azure Files backup is snapshot-based

Soft delete for those mistakes everybody makes
![](azuresoftdeleteandbackups.png)

- Before deletion, stop backup jobs
- Apply soft-delete state
- 14 day retention period to view soft-delete data in the vault 
- Undelete backup items
- Restore items
- Resume backups

## Microsoft Azure Recovery Services (MARS) agent

- Requires installation on Windows Client and Server - does not require a separate backup server it is an agent.
- Location of installation and execution of the MARS agent determines what data is backed up 
- Not application-aware
- Runable: System Center Data Protection Manager (DPM) or Microsoft Azure Backup Server (MABS)
	- On premises
	- Specific file system locations - VM or Physical
	- From a a Microsoft Azure Backup Server (MABS) instance or a System Center Data Protection Manager (DPM) server to backup to a MABS or DPM.

Configure on-premises file and folder backups
![](azuremarsagentcompletebackupfromonpremisetocloud.png)

1. Create a Recovery Services Vault
2. Download MARS Agent and Credentials file
3. Install and register MARS agent
4. Configure Backups

## VM Backups

Azure Backup provides independent and isolated backups to guard against unintended destruction of the data on your virtual machines.
- Azure Backup - best option for production workload backup
	- Microsoft Azure Recovery Services (MARS) agent for Azure Backup
		- See comparison with MABS image
	- Microsoft Azure Backup Server (MABS)
		- See comparison with MARS image
	- Snapshot VMs and stores data a recovery points in geo-redendant recovery vaults - Files or VMs
			-  Azure Backup keeps snapshots for two days
			- Snapshot backups are problematic for configurations that require the coordination of multiple disks, such as striping - the snapshots need to coordinate with each other, but this functionality isn't currently supported.
			- You can set the default snapshot retention value from one and five days.
			- Incremental snapshots are stored as Azure page blobs (Azure Disks).
			- Recovery points are listed for the virtual machine snapshot in the Azure portal and are labelled with a _recovery point type_.

Comparison between MABS and MARS
![](azurecomparisonbetweenmabsandmars.png)

## Azure Managed Disks 

- For:
	 - Snapshots 
		- Read-only full copy of a managed disk 
		- Billed by size usedSystem Center Data Protection Manager (DPM) or Microsoft Azure Backup Server (MABS)
		- Kept two days to reduce backup and restore times
		- Incremental stored as Blobs
	- Image - Capture a single image containing all managed disks associated with a VM

## System Center Data Protection Manager (DPM) or Microsoft Azure Backup Server (MABS)

- System Center Data Protection Manager (DPM) or Microsoft Azure Backup Server (MABS):
	- For specialized workloads, virtual machines, or files, folders, and volumes - data from SQL server or Microsoft Exchange or Sharepoint
	 - MABS agent must be installed on target machines, added to the [System Center DPM _protection group_](https://learn.microsoft.com/en-us/system-center/dpm/create-dpm-protection-groups).
	- To protect your on-premises machines, the System Center DPM or MABS instance must be located on-premises.
	- To protect your Azure virtual machines, the MABS instance must run as an Azure virtual machine and located in Azure.

Requires: 
- [System Center DPM (and MABS) protection agent](https://learn.microsoft.com/en-us/system-center/dpm/deploy-dpm-protection-agent)
- [Microsoft Azure Backup Server (MABS)](https://learn.microsoft.com/en-us/azure/backup/backup-mabs-whats-new-mabs)


## Azure Site Recovery 

Azure Site Recovery for scenarios involving replication, failover, and fall back. 
- Disaster recovery for VMs 
- Can backup data from SQL database  or IaaS VMs, Azure Services
- Replicate Azure virtual machines from one Azure region to another
- Replicate on-premises VMware virtual machines, Hyper-V virtual machines, physical servers (Windows and Linux), and Azure Stack virtual machines to Azure
- Replicate AWS Windows instances to Azure
- Replicate on-premises VMware virtual machines, Hyper-V virtual machines managed by System Center VMM, and physical servers to a secondary site
- [Azure Site Recovery documentation](https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview).

Azure Site Recovery visualised
![](azuresiterecovery.png)

Azure Site Recovery features
![](azuresiterecoveryfeatures.png)

## Workflows

Backup Center
`Search -> Backup Center`:
- `+ Backup`
- `<- Restore`
- `+ Policy`
- `+ Vault`

Backup Workflows
1. Create a Recovery Services Vault - choose LRS/GRS
2. Define a backup policy - when and retention length of data snapshots
3. Backup VMs, etc..

Create a Recovery Service Vault
`Search -> Recovery Services vaults -> + Create`
- Create -> Define backup policy -> Backup X
	- Multi-select for backup "What you want to backup" options


Configure replication of Recover Service Vault
`$Backup -> Properties -> Backup Configuration -> Update `
- Choose: `Geo-redundant | Locally redundant | Zone redundant`

Implement System Center Data Protection Manager (DPM) and or Microsoft Azure Backup Server (MABS)
- First [deploy the System Center DPM protection agent](https://learn.microsoft.com/en-us/system-center/dpm/deploy-dpm-protection-agent)
- Then [install the DPM protection agent (for MABS)](https://learn.microsoft.com/en-us/azure/backup/backup-azure-microsoft-azure-backup#install-and-update-the-data-protection-manager-protection-agent)
- Any machines that you want to back up must be added to a [System Center DPM _protection group_](https://learn.microsoft.com/en-us/system-center/dpm/create-dpm-protection-groups).

Backup 
`$Backup -> Overview -> + Backup -> Select Workload and What to backup -> Configure:
- Policy Sub type - How many per day, Operation tier (x-y days) Resilience Level 
- Backup Policy - Default, Custom and
	- `Create a new policy`
		- Backup schedule
		- Instant Restore -  Retain instant recovery snapshots for X days
		- Retention Range
- `Add` - Add a Resource
- Check `$Backup -> Protected items -> Backup items -> $resourcetype`

Backup a resource
`$Backup -> Protected items -> Backup items -> $resourcetype -> $resource -> View Details -> Backup Now`

Backup File/Folder 
`Search Virtual Machines -> $VM -> Connect` - Connect to machine - 
`Log into Azure Portal -> Recovery Services vaults -> $rsv -> + Backup -> Workload: On-Premise (regardless) -> Backup: Files and folders -> Prepare Infrastructure:`
- Download the Agent for Windows Server or Window Client
- Installation Setup Wiazrd
- Download the Vault Credentials

Restore or File Recovery VM
`Search Recovery Services Vaults -> $rsv -> Backup items -> Azure Virutal Machines -> $VM -> Restore VM / File Recovery`

Recovery Files:
Locally
`Microsoft Azure Backup Application- > Recover Data -> Select Mode, Volume and Data `
Virtual Snapshots:
`Search Recovery Services Vaults -> $rsv -> Backup items -> $AzureVM -> View Details -> File Recovery -> Download Excutable -> Open IaaSVMILRExeForWindows.exe -> copy and paste Password to run Script into IaaSVMILRExeForWindows.exe`, then
On Host open `cmd.exe` with [robocopy]((https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy):
```powershell
# Copy from the mounted virtual snapshosts
# Consider permissions!
robocopy G:\File\Path\To\Dir C:\File\Path\To\Dir $file /r:1 /w:1 
```
Then `Unmount Disks`

Azure Recovery Services soft delete 
`Search Recovery Services Vaults -> $rsv -> Backup items -> Azure Backup Agent -> View Details -> $ComputerName -> Delete -> Type the Server name* & Provide Reason & Add comment for professionalism & Tick and Delete`

Stop Backup and Deal with Data retention
`Search Recovery Services Vaults -> $rsv -> Backup items -> Azure Virtual Machine -> View Details -> Stop Backup`, then pick to:
- Retain Backup Data 
- Delete Backup Data
	- Type the name of the backup item* ; add a Reason and comment  

Undelete Backup that has Backup Disabled 
`Search Recovery Services Vaults -> $rsv -> Backup items -> $Backup -> Undelete`

Delete Backup Data Backup
`Search Recovery Services Vaults -> $rsv -> Backup items -> $Backup -> Delete backup data`

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[robocopy | Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[System Center DPM _protection group_](https://learn.microsoft.com/en-us/system-center/dpm/create-dpm-protection-groups)