

## zip2john

```bash
zip2john backup.zip > hash
john -wordlist=/usr/share/wordlists/rockyou.txt hash
```