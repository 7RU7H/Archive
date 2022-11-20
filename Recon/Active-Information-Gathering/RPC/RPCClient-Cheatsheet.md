For `rcpclient` see [[SMB-Recon-Cheatsheet]]

```powershell
querydispinfo
srvinfo

lookupdomain $domain
querydominfo
enumdomusers
enumalsgroups builtin
enumdomgroups
netshareenum
netshareenumall
netsharegetinfo Confidential
querygroup $0xRID
queryuser
enumprivs
getdompwinfo
getusrdompwinfo $0xRID
```
## Enumerating LSA Group Privileges
```powershell
lsaenumsid
lookupsids $S-1-1-0
lsaenumacctrights $S-1-1-0
lsaaddpriv $S-1-1-0 SeCreateTokenPrivilege
lsaenumprivsaccount S-1-1-0
lsadelpriv $S-1-1-0 SeCreateTokenPrivilege
lsaenumprivsaccount $S-1-1-0
```
## Creating a user
```powershell
createdomuser hacker
setuserinfo2 hacker 24 Password@1
enumdomusers
# LSA Create Account
lookupnames $user
lsacreateaccount $SID
# Create a dom group
createdomgroup newgroup
```
## SAM related
```powershell
# SAM Lookup
samlookupnames $domian $user
samlookuprids $domian $0xRID
# SID Lookup
lsaenumsid
# LSA Queries
lsaquery
lsaquerysecobj
dsroledominfo
# Enumerating LSA Account Privileges
lookupnames $user
lsaaddacctrights $SID SeCreateTokenPrivilege
lsaenumprivsaccount $SID
lsaremoveacctrights $SID SeCreateTokenPrivilege
lsaenumprivsaccount $SID
```
## Domain Info
```powershell
# Get Primary Domain Information
dsroledominfo
# Query DFS support
dfsexist
# Add a DFS share
dfsadd
# Remove a DFS share
dfsremove
# Query DFS share info 
dfsgetinfo
# Enumerate dfs shares
dfsenum
```
##  NETLOGON
```powershell
# Logon Control 2
logonctrl2
# Logon Control
logonctrl
# Sam Synchronisation
samsync
# Query Sam Deltas
samdeltas
# Sam Logon
samlogon
```
## FSRVP
```powershell
# Check whether a share supports shadow-copy requests
fss_is_path_sup
# Get supported FSRVP version from server
fss_get_sup_version
# Request shadow-copy creation and exposure
fss_create_expose
# Request shadow-copy share deletion
fss_delete
# Check for an associated share shadow-copy
fss_has_shadow_copy
# Get shadow-copy share mapping information
fss_get_mapping
# Flag read-write snapshot as recovery complete, allowing further shadow-copy requests
fss_recovery_complete
```

## Tony Ng's SPOOLs section:
 This from [tonyng](https://pentest.tonyng.net/rpcclient-help/); un-altered as I have yet to test or have anything to add to it. 

```
adddriver <arch> <config> [<version>]
```
Execute an AddPrinterDriver() RPC to install the printer driver information on the server. Note that the driver files should already exist in the directory returned by `getdriverdir`. Possible values for _`arch`_ are the same as those for the `getdriverdir` command. The _`config`_ parameter is defined as follows:
```
Long Printer Name:\
Driver File Name:\
Data File Name:\
Config File Name:\
Help File Name:\
Language Monitor Name:\
Default Data Type:\
Comma Separated list of Files
```
Any empty fields should be enter as the string “NULL”.

Samba does not need to support the concept of Print Monitors since these only apply to local printers whose driver can make use of a bi-directional link for communication. This field should be “NULL”. On a remote NT print server, the Print Monitor for a driver must already be installed prior to adding the driver or else the RPC will fail.

The _`version`_ parameter lets you specify the printer driver version number. If omitted, the default driver version for the specified architecture will be used. This option can be used to upload Windows 2000 (version 3) printer drivers.
```
addprinter <printername> <sharename> <drivername> <port>
```
Add a printer on the remote server. This printer will be automatically shared. Be aware that the printer driver must already be installed on the server (see `adddriver`) and the `port`must be a valid port name (see `enumports`.
```
deldriver <driver>
```
Delete the specified printer driver for all architectures. This does not delete the actual driver files from the server, only the entry from the server’s list of drivers.
```
deldriverex <driver> [architecture] [version] [flags]
```
Delete the specified printer driver and optionally files associated with the driver. You can limit this action to a specific architecture and a specific version. If no architecture is given, all driver files of that driver will be deleted. _`flags`_ correspond to numeric DPD_* values, i.e. a value of 3 requests (DPD_DELETE_UNUSED_FILES | DPD_DELETE_SPECIFIC_VERSION).
```
enumdata
```
Enumerate all printer setting data stored on the server. On Windows NT clients, these values are stored in the registry, while Samba servers store them in the printers TDB. This command corresponds to the MS Platform SDK GetPrinterData() function (* This command is currently unimplemented).
```
enumdataex
```
Enumerate printer data for a key
```
enumjobs <printer>
```
List the jobs and status of a given printer. This command corresponds to the MS Platform SDK EnumJobs() function
```
enumkey
```
Enumerate printer keys
```
enumports [level]
```
Executes an EnumPorts() call using the specified info level. Currently only info levels 1 and 2 are supported.
```
enumdrivers [level]
```
Execute an EnumPrinterDrivers() call. This lists the various installed printer drivers for all architectures. Refer to the MS Platform SDK documentation for more details of the various flags and calling options. Currently supported info levels are 1, 2, and 3.
```
enumprinters [level]
```
Execute an EnumPrinters() call. This lists the various installed and share printers. Refer to the MS Platform SDK documentation for more details of the various flags and calling options. Currently supported info levels are 1, 2 and 5.
```
getdata <printername> <valuename;>
```
Retrieve the data for a given printer setting. See the `enumdata` command for more information. This command corresponds to the GetPrinterData() MS Platform SDK function.
```
getdataex
```
Get printer driver data with keyname
```
getdriver <printername>
```
Retrieve the printer driver information (such as driver file, config file, dependent files, etc…) for the given printer. This command corresponds to the GetPrinterDriver() MS Platform SDK function. Currently info level 1, 2, and 3 are supported.
```
getdriverdir <arch>
```
Execute a GetPrinterDriverDirectory() RPC to retrieve the SMB share name and subdirectory for storing printer driver files for a given architecture. Possible values for _`arch`_ are “Windows 4.0” (for Windows 95/98), “Windows NT x86”, “Windows NT PowerPC”, “Windows Alpha_AXP”, and “Windows NT R4000”.
```
getprinter <printername>
```
Retrieve the current printer information. This command corresponds to the GetPrinter() MS Platform SDK function.
```
getprintprocdir
```
Get print processor directory
```
openprinter <printername>
```
Execute an OpenPrinterEx() and ClosePrinter() RPC against a given printer.
```
setdriver <printername> <drivername>
```
Execute a SetPrinter() command to update the printer driver associated with an installed printer. The printer driver must already be correctly installed on the print server.

See also the `enumprinters` and `enumdrivers` commands for obtaining a list of of installed printers and drivers.
```powershell
# Add form
addform
# Set form
setform
# Get form
getform
# Delete form
deleteform
# Enumerate form
enumforms
# Set printer comment
setprinter
# Set REG_SZ printer data
setprinterdata
# Set printer name
setprintername <printername> <newprintername>
# Rffpcnex test
rffpcnex
```


## References 
[hacking-articles](https://www.hackingarticles.in/active-directory-enumeration-rpcclient/)
[tonyng](https://pentest.tonyng.net/rpcclient-help/)