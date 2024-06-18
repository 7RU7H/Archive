# Cisco Commands

```bash
? - Help
> - User mode
# - Privileged mode
router(config)# - Global Configuration mode
```
enable secret more secure than enable password.

For example, in the configuration command:
```bash
enable secret 5 $1$iUjJ$cDZ03KKGh7mHfX2RSbDqP.
```

The `enable secret` has been hashed with MD5, whereas in the command:
```
username jdoe password 7 07362E590E1B1C041B1E124C0A2F2E206832752E1A01134D
```

The password has been encrypted using the weak reversible algorithm.
```bash
enable # Change to privileged mode to view configs
config terminal/config t #  Change to global config mode to modify

#show version # Gives you the router's configuration register (Firmware)
#show running-config #  Shows the router, switch, or firewall's current configuration
#show ip route # show the router's routing table
#show tech-support #  Dump config but obscure passwords
```

## References

[OlivierLaflamme/Cheatsheet-God - Cheatsheet_PenTesting.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_PenTesting.txt)