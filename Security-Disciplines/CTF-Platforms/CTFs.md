# CTFs


[xct](https://notes.vulndev.io/wiki/redteam/misc/other)'s Proof of Work Solution for CTFs
```python
work = b"aaaaaa"
magic = iters.mbruteforce(lambda x: hashlib.sha256(x.encode()).hexdigest()[:len(work)].encode() == work, string.ascii_lowercase, 6)
```


[notes.vulndev.io/wiki/redteam/misc/other](https://notes.vulndev.io/wiki/redteam/misc/other)