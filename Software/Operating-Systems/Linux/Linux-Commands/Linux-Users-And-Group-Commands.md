# User and Group related commands

For non-user-and-group related command see: [[Core-Linux-Commands]]

```bash
# switch user "-l" is login switch
su
# provide general info of user
id	
# print current username
whoami	

# Adding Users
useradd

useradd -u usergroup -g groupid -p cheese -s /bin/$shell -m /$username

# Modifying Users
usermod
# add a sudo user
usermod -aG sudo $username
# Check entry of /etc/group
getent group sudo
# Beware editing the sudoer file
# Don't have no passwords, just don't - sudo + password are also a way of prevent you from just ruining your filesystem - you have to stop and enter a password before an action
visudo 

# Passwords
# Edit the /etc/passwd file, will prompt for nano, vim-* so
sudo vipw 
passwd --status $user
# Edit the /etc/shadow file
sudo vipw -s

# View the password change status
chage -l jane


# Lock account # places a ! in /etc/shadow
usermod -L username 
passwd -l username
chage -e	change expiry date of passwd
usermod -s 	change default shell of the user

# Groups 
# list groups a user is a part of BUT THEN USE THIS FIND COMMAND 
find / -group users -type f 2>/dev/null
user* -* *group *
useradd -G sudo username
usermod -aG sudo username

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
