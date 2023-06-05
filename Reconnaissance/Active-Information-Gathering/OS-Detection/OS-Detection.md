# OS-Detection

## Ping 

The time to live(ttl) indicates its OS. It is a decrementation from each hop back to original ping sender. Linux is < 64, Windows is < 128. 

```bash
ping -c 3 $ip
```

`fping` is better than `ping`
```bash
# show alive target, provide stats, generating a list as -f not provided - with quiet - no per-target/ping results
fping -asgq
```

## SSH Version -> Ubuntu Version

[[Search-Engine-Dorking]] - `XUbuntuY.Z Launchpad`

## References

[ippsecrocks]()
[ttl](https://ostechnix.com/identify-operating-system-ttl-ping/)