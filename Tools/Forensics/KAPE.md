# KAPE

Kroll Artifact Parser and Extractor (KAPE) parses and extracts Windows forensics artefacts. It is portable and can be used remotely from network locations or from USB drives.

1. KAPE extracts from:
	- Live System 
	- Mounted image 
	- [F-response](https://www.f-response.com/) utility
2. Target options
3. Files from Source are copied to a destination
4. KAPE module options
5. Module Output run against the files at the copied location 

KAPE Targets
- Targets = artefacts
	- A TKAPE file contains information about the artefact that we want to collect, such as the path, category, and file masks to collect.
- Compound Targets 
	- A Target that is a composite of multiple other Targets; Commands like
		- `BasicCollection`
		- `!SANS_triage` 
		- `KAPEtriage`
- `!Disabled` - non active Targets, they are kept in the KAPE instance, but not displayed
- `!Local` - Artefacts you do not want to sync with KAPE GitHub repository

KAPE Modules
- Module for KAPE have the `.mkape` extension found `Modules` directory
- Includes templates and guide for custom module creation

KAPE Binaries 
- Binaries for various Forensics activities found the `bin` directory
- [GitHub - grayfold3d/Get-KapeModuleBinaries](https://github.com/grayfold3d/Get-KapeModuleBinaries)
- [GitHub - EricZimmerman/Get-ZimmermanTools](https://github.com/EricZimmerman/Get-ZimmermanTools)

CLI and GUI:
- `kape.exe` is CLI (run with Elevated PowerShell)
	- KAPE has a Batch mode if a list of commands are provided in a `_kape.cli` file, stored in the same directory as the `kape.exe`(automatic checks if  `_kape.cli` file is present)
- `gkape.exe` is the GUI variant; it will also generate a CLI `kape.exe` one liner: good for replication!
	- `Use Target Options` checkbox contains the following options:
		- `Target Source`
		- `Target Destination`
			- `Flush` checkbox will delete all the contents of the Target destination
			- `Add %d` will append date info to the directory name where the collected data is saved
			- `Add %m` will append machine info to the Target destination directory
		- Process Volume Shadow Copies by enabling `Process VSCs`
		- `Container`:
			- `VHDX`
			- `VHD`
			- `Zip`
			- `transfer` checkbox if we want to transfer the collected artifacts through an SFTP server or an S3 bucket
	- `Use Module Options` contains the following options:
		- `Module Source` - cannot be the same `Target Source`
		- `Module Destination` cannot be the same `Target Destination`






## References

[THM Kape Room](https://tryhackme.com/room/kape)
[GitHub - grayfold3d/Get-KapeModuleBinaries](https://github.com/grayfold3d/Get-KapeModuleBinaries)
[GitHub - EricZimmerman/Get-ZimmermanTools](https://github.com/EricZimmerman/Get-ZimmermanTools)

## Appendix

Usage
```powershell
kape.exe

KAPE version 1.1.0.1 Author: Eric Zimmerman (kape@kroll.com)

        tsource         Target source drive to copy files from (C, D:, or F:\ for example)
        target          Target configuration to use
        tdest           Destination directory to copy files to. If --vhdx, --vhd or --zip is set, files will end up in VHD(X) container or zip file
        tlist           List available Targets. Use . for Targets directory or name of subdirectory under Targets.
        tdetail         Dump Target file details
        tflush          Delete all files in 'tdest' prior to collection
        tvars           Provide a list of key:value pairs to be used for variable replacement in Targets. Ex: --tvars user:eric would allow for using %user% in a Target which is replaced with eric at runtime. Multiple pairs should be separated by ^
        tdd             Deduplicate files from --tsource (and VSCs, if enabled) based on SHA-1. First file found wins. Default is TRUE

        msource         Directory containing files to process. If using Targets and this is left blank, it will be set to --tdest automatically
        module          Module configuration to use
        mdest           Destination directory to save output to
        mlist           List available Modules. Use . for Modules directory or name of subdirectory under Modules.
        mdetail         Dump Module processors details
        mflush          Delete all files in 'mdest' prior to running Modules
        mvars           Provide a list of key:value pairs to be used for variable replacement in Modules. Ex: --mvars foo:bar would allow for using %foo% in a module which is replaced with bar at runtime. Multiple pairs should be separated by ^
        mef             Export format (csv, html, json, etc.). Overrides what is in Module config

        sim             Do not actually copy files to --tdest. Default is FALSE
        vss             Process all Volume Shadow Copies that exist on --tsource. Default is FALSE

        vhdx            The base name of the VHDX file to create from --tdest. This should be an identifier, NOT a filename. Use this or --vhd or --zip
        vhd             The base name of the VHD file to create from --tdest. This should be an identifier, NOT a filename. Use this or --vhdx or --zip
        zip             The base name of the ZIP file to create from --tdest. This should be an identifier, NOT a filename. Use this or --vhdx or --vhd

        scs             SFTP server host/IP for transferring *compressed VHD(X)* container
        scp             SFTP server port. Default is 22
        scu             SFTP server username. Required when using --scs
        scpw            SFTP server password
        scd             SFTP default directory to upload to. Will be created if it does not exist
        scc             Comment to include with transfer. Useful to include where a transfer came from. Defaults to the name of the machine where KAPE is running

        s3p             S3 provider name. Example: spAmazonS3 or spGoogleStorage. See 'https://bit.ly/34s9nS6' for list of providers. Default is 'spAmazonS3'
        s3r             S3 region name. Example: us-west-1 or ap-southeast-2. See 'https://bit.ly/3aNxXhc' for list of regions by provider
        s3b             S3 bucket name
        s3k             S3 Access key
        s3s             S3 Access secret
        s3st            S3 Session token
        s3kp            S3 Key prefix. When set, this value is used as the beginning of the key. Example: 'US1012/KapeData'
        s3o             When using 'spOracle' provider, , set this to the 'Object Storage Namespace' to use
        s3c             Comment to include with transfer. Useful to include where a transfer came from. Defaults to the name of the machine where KAPE is running

        s3url           S3 Presigned URL. Must be a PUT request vs. a GET request

        asu             Azure Storage SAS Uri
        asc             Comment to include with transfer. Useful to include where a transfer came from. Defaults to the name of the machine where KAPE is running

        zv              If true, the VHD(X) container will be zipped after creation. Default is TRUE
        zm              If true, directories in --mdest will be zipped. Default is FALSE
        zpw             If set, use this password when creating zip files (--zv | --zm | --zip)

        hex             Path to file containing SHA-1 hashes to exclude. Only files with hashes not found will be copied

        debug           Show debug information during processing
        trace           Show trace information during processing

        gui             If true, KAPE will not close the window it executes in when run from gkape. Default is FALSE

        ul              When using _kape.cli, when true, KAPE will execute entries in _kape.cli one at a time vs. in parallel. Default is FALSE

        cu              When using _kape.cli, if true, KAPE will delete _kape.cli and both Target/Module directories upon exiting. Default is FALSE

        sftpc           Path to config file defining SFTP server parameters, including port, users, etc. See documentation for examples
        sftpu           When true, show passwords in KAPE switches for connection when using --sftpc. Default is TRUE

        rlc             If true, local copy of transferred files will NOT be deleted after upload. Default is FALSE
        guids           KAPE will generate 10 GUIDs and exit. Useful when creating new Targets/Modules. Default is FALSE
        sync            If true, KAPE will download the latest Targets and Modules from specified URL prior to running. Default is https://github.com/EricZimmerman/KapeFiles/archive/master.zip

        ifw             If false, KAPE will warn if a process related to FTK is found, then exit. Set to true to ignore this warning and attempt to proceed. Default is FALSE


        Variables: %d = Timestamp (yyyyMMddTHHmmss)
                   %s = System drive letter
                   %m = Machine name

Examples: kape.exe --tsource L: --target RegistryHives --tdest "c:\temp\RegistryOnly"
          kape.exe --tsource H --target EvidenceOfExecution --tdest "c:\temp\default" --debug
          kape.exe --tsource \\server\directory\subdir --target Windows --tdest "c:\temp\default_%d" --vhdx LocalHost
          kape.exe --msource "c:\temp\default" --module LECmd --mdest "c:\temp\modulesOut" --trace --debug

          Short options (single letter) are prefixed with a single dash. Long commands are prefixed with two dashes

          Full documentation: https://ericzimmerman.github.io/KapeDocs/
```
