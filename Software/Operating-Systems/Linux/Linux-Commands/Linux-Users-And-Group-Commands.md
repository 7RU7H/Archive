# User and Group related commands

**Warning `1 command` from this article was generated with the use of [Phind](https://www.phind.com/search?cache=pg2xr6qqorhhl45vb8flwxgu)  and human consultation of  testing `getent group groupname | cut -d: -f3` - listed references in references section**

For create software daemon without root privileges see: [Debian Offical - Creating users and groups for software daemons](https://www.debian.org/doc/manuals/securing-debian-manual/bpp-lower-privs.en.html)

**Warning I highly recommend critically reading the distinction between `useradd` and `adduser` - read the documentation for your own opinion on this** 

Authors:
- Is this a backdoor or some [[Perl]] [boomers](https://www.youtube.com/watch?v=0jK0ytvjv-E) mark on the world? See Appendix
- Yes, `useradd` is more complex 

For non-user-and-group related command see: [[Core-Linux-Commands]]
```bash
# switch user "-l" is login switch
su
# provide general info of user
id	
# print current username
whoami	

# Adding Users
# `useradd` - create a new user or update default new user information
# By default, a group will also be created for the new user (see -g -N, -U, and USERGROUPS_ENAB).

# Print the defaults
useradd -D
# For a username and group for that username with its own home directory:
useradd -U username -p password -g users -G $secondaryGroups -s /bin/$shell -m 
# Deleting users
deluser $username

# Modifying Users
usermod
# add a sudo user
usermod -aG sudo $username
# Check entry of /etc/group
getent group sudo
# Beware editing the sudoer file
# Don't have no passwords, just don't - sudo + password are also a way of prevent you from just ruining your filesystem - you have to stop and enter a password before an action
visudo 
# For specific command without a password for sudo for a user
$username ALL=NOPASSWD:/$path/$to/$bin


# Passwords
# Edit the /etc/passwd file, will prompt for nano, vim-* so
sudo vipw 
passwd --status $user
# Edit the /etc/shadow file
sudo vipw -s

# View the password change status
chage -l jane


# Lock account # places a ! in /etc/shadow
usermod -L $username 
passwd -l $username
chage -e	# change expiry date of passwd
usermod -s 	# change default shell of the user

# Groups 
# list groups a user is a part of BUT THEN USE THIS FIND COMMAND 
find / -group users -type f 2>/dev/null
user* -* *group *
useradd -G sudo $username
usermod -aG sudo $username

# Get the GID for a group 
getent group $groupname | cut -d: -f3

groupadd $groupName
# Add a group with a password
groupadd -p $groupPassword $groupName
# Create a system group
groupadd --system $groupName

# Edit the /etc/group file, will prompt for nano, vim-* so
sudo vigr 
# Reload the /etc/group file and update /etc/gshadow
sudo grpck 


# Create a password hash that is compliant:
openssl passwd -1 -salt [salt] [password]

ssh-keygen	generate a ssh key, store in /root/.ssh !! remember chmod 600
ssh -i id_rsa root@ip
```


## References

[Phind](https://www.phind.com/search?cache=pg2xr6qqorhhl45vb8flwxgu) - References for "how to get the group id of a group in bash?" -> `getent group groupname | cut -d: -f3` number - [1](https://stackoverflow.com/questions/29357095/linux-how-to-get-group-id-from-group-name-and-vice-versa), [2](https://lindevs.com/get-group-id-gid-in-linux/), [3](https://askubuntu.com/questions/639990/what-is-the-group-id-of-this-group-name), [4](https://unix.stackexchange.com/questions/97657/how-to-list-groups-with-gid-in-redhat), [5](https://linuxize.com/post/how-to-list-groups-in-linux/), [6](https://superuser.com/questions/819199/how-can-i-get-the-unix-group-name-based-on-the-group-id), [7](https://devicetests.com/get-group-id-linux).
[Debian Offical - Creating users and groups for software daemons](https://www.debian.org/doc/manuals/securing-debian-manual/bpp-lower-privs.en.html)
[Linuxize How to create users in Linux using useradd command - Some of this did not work on Debian](https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/)
[manpages useradd](https://manpages.debian.org/unstable/passwd/useradd.8.en.html)
[manpages adduser](https://manpages.debian.org/unstable/adduser/adduser.8.en.html)
## Appendix

What is this
![1920](whatisthisdebiandocs-1.png)
![1920](whatisthisdebiandocs.png)

