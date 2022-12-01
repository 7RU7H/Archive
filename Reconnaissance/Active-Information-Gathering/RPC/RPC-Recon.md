
## RPCclient
Query MS-RPC for commands to try and estanblish a null session
```bash
rpcclient -U "" -N $IP
# Authenticated Session
rpcclient -U <username> --password=<password> $ip
```
See enumeration commands [[RPCClient-Cheatsheet]] and its usage [[RPCClient-Usage]]

With enum4linux
```bash
# Verbose mode
enum4linux -v target-ip

# Do everything
enum4linux -a target-ip

# List users
enum4linux -U target-ip

# If you've managed to obtain credentials, you can pull a full list of users regardless of the RestrictAnonymous option
enum4linux -u administrator -p password -U target-ip

# Get username from the defaut RID range (500-550, 1000-1050)
enum4linux -r target-ip

# Get username using a custom RID range
enum4linux -R 600-660 target-ip

# List groups
enum4linux -G target-ip

# List shares
enum4linux -S target-ip

# Perform a dictionary attack, if the server doesn't let you retrieve a share list 
enum4linux -s shares.txt target-ip

# Pulls OS information using smbclient, this can pull the service pack version on some versions of Windows
enum4linux -o target-ip

# Pull information about printers known to the remove device.
enum4linux -i target-ip
```

## References

[haax.fr](https://cheatsheet.haax.fr/network/services-enumeration/135_rpc/)