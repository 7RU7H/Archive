## User and Group Management

Use `vipw` and `vigr` to edit to avoid accidental harm.
Important File and Location | Purpose
--- | --- 
`/etc/passwd` | list of users
`/etc/shadow` | encrypted passwords user
`/etc/group` | list of groups
`/etc/gshadow` | encrypted group passwords

`getent` command checks the system databases using the appropriate library functions that call the name service switch (NSS) modules configured in the `/etc/nsswitch.conf` file.

Command | Task | Configuration
--- | --- | ---
`adduser` | adds user | /etc/adduser.conf
`addgroup` | add group | /etc/group 
`delgroup` | delete group |
`groupmod` | modifiers a group information |
`gpasswd group` | add password for group |  
`gpasswd -r group` | deletes password for group |
`newgrp` | start new shell `sg` to executs a command using the suppplied alternate group | 
 `setgid` | set the `setgid` bit on a directory that causes all files to belong automatically to that group  |
`id` | current state of a user and its personal and group identifiers `uid` and `gid`  | 

Creation of an account triggers the populatiojn of the user's home directory with content sof `/etc/skel`. 

**Modification**
-   `passwd` —permits a regular user to change their password, which in turn, updates the `/etc/shadow` file.
-  `passwd -l $user`—Disables the account of the user.
-   `chfn`—(CHange Full Name), reserved for the super-user (root), modifies the `GECOS`, or "general information" field.
-   `chsh`—(CHange SHell) changes the user's login shell. However, available choices will be limited to those listed in `/etc/shells`; the administrator, on the other hand, is not bound by this restriction and can set the shell to any program chosen.
-   `chage`—(CHange AGE) allows the administrator to change the password expiration settings by passing the user name as an argument or list current settings using the `-l user` option. Alternatively, you can also force the expiration of a password using the `passwd -e user` command, which forces the user to change their password the next time they log in.

