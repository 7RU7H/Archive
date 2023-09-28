# Linux Samba



[Samba net command](https://www.samba.org/samba/docs/current/man-html/net.8.html)
```bash
# Requires correct configuration of /etc/krb5.conf
kinit Administrator
net ads info
# Get closest DC in domain and retrieve server information
net ads lookup 

net ads join -k # Kerberos Auth
net ads join -U Administrator # NTLM Auth
# Join a computer account
# Beware all the additiona requirements required: https://sssd.io/docs/ad/ad-provider-manual.html
net ads join createcomputer="<OU>" createupn


# List all users
net rpc user
# List domain info of a specific user
net rpc user info $username

# List all groups
net rpc group list
# List all users of a specific group
net rpc group members  $group
# Add a user to a specific group
net rap groupmember add $group $username

# Remote Command execution - Only works with OS/2 servers. Not currently implement :(
# net rap admin $cmd

# Enumerates all exported resources (network shares) on target server.
net share $target


# Creating Additional principals:
# Keytabs do not need to be created on the DC
# Require sufficient ACLs to jon to the domain 
net ads keytab add
```

## References

[Samba net command](https://www.samba.org/samba/docs/current/man-html/net.8.html)
[sssd.io](https://sssd.io/docs/ad/ad-provider-manual.html)