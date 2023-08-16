# Window files systems

This document assumes use of Eric Zimmermans's tool found [here](https://ericzimmerman.github.io/#!index.md). For FAT12-32 and exFAT explaination, its after NTFS.

# NTFS New Technology File System

Introduced in 1993, maintream since Windows XP
Features added:  
1. Journaling = log changes to the metadata for the volume, stored in $LOGFILE in volumes root directory
1. Access Control	= Define access control based on user
1. Volume Shadow Copy = restoration features like system restore, file version recovery # !ransomware deletes this
1. Alternate Data Sreams = Store multiple data streams of data in a single file # !malware can hide in ADS
1. Master file table = similar to FAT, but is a structure database that tracks objects stored in a volume:

### Critical Master File Table files:	
1. $MFT =  First record in volume, Volume Boot Records (VBR) pointersto relevant clusters, directory of all files present on the volume  
1. $LOGFILE = Stores all transactional logging of the file system, helps in event of a crash  
1. $UsnJrnl = Update Sequence Number (USN) journal, present in the...
1. $Extend = which records Information about all the files that were changed in the file system and reason for that change: AKA change journal

### FAT
FAT = File Allocation Table; a linked list of all the clusters, containing pointers to next in the cluster chain and information but
Clusters = basic storage unit
Directory = contains information about file identification

Attribute | FAT12 | FAT16 | FAT32
--- | --- | --- | ---
Addressable bits | 12 | 16 | 28
Max number of clusters | 4,096 | 65,536 | 268,435,456
Supported size of clusters | 512B - 8KB | 2KB - 32KB | 4KB - 32KB
Maximum Volume size	 | 32MB | 2GB | 2TB

exFAT used commonly for SSD larger than 32GB
Supported size of clusters 	4KB - 32 MB	
Maximum volume size		128PB 

```batch
MFTECmd.exe -f <path-to-$MFT-file> --csv <path-to-save-results-in-csv
```

### Evidence of Execution
```powershell
C:\Windows\Prefetch 	# location
.pf			# extension

PECmd.exe -f <path-to-Prefetch-files> --csv <path-to-save-csv>
PECmd.exe -d <path-to-Prefetch-directory> --csv <path-to-save-csv>
```

### Windows 10 timeline
C:\Users\<username>\AppData\Local\ConnectedDevicesPlatform\{randomfolder}\ActivitiesCache.db # location
