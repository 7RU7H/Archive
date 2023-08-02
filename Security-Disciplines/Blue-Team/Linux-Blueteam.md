# Linux Blueteam

## Ippsec Timestamp checking
Find all timestamps, checking for tampering of files that normally set to 00000000 by package manager 
```bash
find / -type f printf"%T+ %p\n" | grep -v 00000000
```


## References
[Ippsec Compromised Video](https://www.youtube.com/watch?v=yaV09XCDDqI&t=2040)