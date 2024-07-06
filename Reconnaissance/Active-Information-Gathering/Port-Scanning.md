# Port Scanning


[xct](https://notes.vulndev.io/wiki/redteam/misc/other)'s  Randomized Curl Portscan Scan
```bash
a=( $(shuf -e $(seq 20000 60000)) )
for i in ${a[@]}; do curl -v -k https://<target>:$i -m 1;done | tee out
```



## References

[notes.vulndev.io/wiki/redteam/misc/other](https://notes.vulndev.io/wiki/redteam/misc/other)