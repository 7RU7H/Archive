# Linux Permissions and Rights

Each File or Directory has specific permissions for User, Groups and Other for each are symbolized thusly:

Category | Symbol Used
--- | --- 
owner | `u`
owner group | `g`
other  | `o`

Rights for each are symbolized thusly:

Category | Symbol Used
--- | --- 
Read | `r`
Write | `w`
Execute | `x`

#### Executable Rights
`setuid` and `setgid`  symbolized with `s`, this is boolean bit set to either 1 or 0. This bit set the rights to execute based on ownership `setuid` is systematically that file is run under the identity of root. Directories work differently:
- Read - grants listable
- Write - grants create and delete files in that directory
- Execute - grant access, but without ability to read it

For `setgid` directories are automatically assigned to owner group of the parent directory, instead of creator. The sticky bit is symbolized with `t`  

Format example
```bash
- rwx rwx rwx

# - = filetype: - inidcates regular file d indicate directory in Octal notation
4 = read
2 = write
1 = execute

rwx (col1) read, write, and execute permissions for the file owner
rwx (col2) read, write, and execute permissions for the group owner of the file
rwx (col3) read, write, and execute permissions for all the other users
```

## Modifing Files or Directory 
-   `chown user file` changes the owner of the file.
-   `chgrp group file` alters the owner group. `-R` is the recusive flag!
-   `chmod rights file` changes the permissions for the file.
	- Either:
		- Octal notation e.g 777
		- Symbolize notation e.g `u=rwx,g+rwx,o-rwx`
-  `umask` uses `octal` notation of file when application create files so that the system autoremoves any rights defined with `umask`; for bash `~/.bash_profile` will define the mask for current shell context. 