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

# Passwords

passwd --status $user
# View the password change status
chage -l jane




# Lock account # places a ! in /etc/shadow
usermod -L username 
passwd -l username
chage -e	change expiry date of passwd
usermod -s 	change default shell of the user

# groups 
# list groups a user is a part of BUT THEN USE THIS FIND COMMAND 
find / -group users -type f 2>/dev/null
user* -* *group *
useradd -G sudo username
usermod -aG sudo username




# Create a password hash that is compliant:
openssl passwd -1 -salt [salt] [password]

ssh-keygen	generate a ssh key, store in /root/.ssh !! remember chmod 600
ssh -i id_rsa root@ip
```
