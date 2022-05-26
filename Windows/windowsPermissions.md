# Windows Permissions

## Permissions assignable to files

Read: Allows the user to *read* the contents of the file; read also allows users to *execute* scripts.

Write: Allows the user to *write* to the file, write does not allow a user to delete the file, although they can *delete its contents*.

Read & Execute: Allows the user to *read* the file, as well as *execute* binaries.

Modify: Allows the user to *read* and *write* to the file and *delete* it.

Full Control: Allows the user to *read, write, change, or delete* the file.

## Permissions assignable to directories

Read: Allows the user to *view and list any file* in the directory.

Write: Allows the user to *add files or subfolders* to the directory.

Read & Execute: Allows the user to *view and list any file or subfolder* in the directory, and *execution of any binary* within the folder.

List Folder Contents: Allows the user to *list any file or subfolder* in the directory, and *execution of any binary* within the folder, but *NOT viewing the contents* of the files.

Modify: Allows the user to *read, write and delete files and subfolders* within the directory.

Full Control: Allows the user to *read, write, change, and delete files and subfolders* within the directory and *delete even if they do not have Modify or Full Control permissions* of the files.

## Synchronization

[quote:](https://docs.microsoft.com/en-us/windows/win32/secauthz/standard-access-rights?redirectedfrom=MSDN)
> The right to use the object for synchronization. This enables a thread to wait until the object is in the signaled state. Some object types do not support this access right.

WIN32 API requires synchronization rights to allow directories to interact with there child items, or files their contents.

GENERIC\_READ  

        FILE_READ\_ATTRIBUTES (ReadAttributes)
        FILE_READ\_DATA (ReadData)
        FILE_READ\_EA (ReadExtendedAttributes)
        STANDARD\_RIGHTS\_READ (ReadPermissions)
        SYNCHRONIZE (Synchronize)  
  
GENERIC\_WRITE  

        FILE\_APPEND\_DATA (AppendData)
        FILE\_WRITE\_ATTRIBUTES (WriteAttributes)
        FILE\_WRITE\_DATA (WriteData)
        FILE\_WRITE\_EA (WriteExtendedAttributes)
        STANDARD\_RIGHTS\_WRITE (ReadPermissions)
        SYNCHRONIZE (Synchronize)

## icacls

To view the permissions of a file or directory: `icacls $file/directory`

```powershell
# perm is a permission mask and can be specified in one of two forms:
        # a sequence of simple rights:
                N - no access
                F - full access
                M - modify access
                RX - read and execute access
                R - read-only access
                W - write-only access
                D - delete access

	# a comma-separated list in parentheses of specific rights:
                DE - delete
                RC - read control
                WDAC - write DAC
                WO - write owner
                S - synchronize
                AS - access system security
                MA - maximum allowed
                GR - generic read
                GW - generic write
                GE - generic execute
                GA - generic all
                RD - read data/list directory
                WD - write data/add file
                AD - append data/add subdirectory
                REA - read extended attributes
                WEA - write extended attributes
                X - execute/traverse
                DC - delete child
                RA - read attributes
                WA - write attributes

# inheritance rights may precede either form and are applied
        # only to directories:
                (OI) - object inherit
                (CI) - container inherit
                (IO) - inherit only
                (NP) - don't propagate inherit
                (I) - permission inherited from parent container
```
