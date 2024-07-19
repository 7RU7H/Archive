# John The Ripper

[OpenWall wiki's sample hashes can be found here](https://openwall.info/wiki/john/sample-hashes)

## Quick Useful Commands

```bash
john --list=formats | grep $grep_

```


## Scenarios

Cracking a file check out [[Cracking-Files-And-Directories]]
Have a `/etc/passwd` and `/etc/shadow`

```bash
unshadow shadow.txt passwd.txt > unshadow.txt
john --wordlist=/usr/share/wordlists/rockyou.txt unshadowed.txt
```



## Wordlist expansion with JtR
```bash
john --wordlist=/wordlist.txt --rules=rulename --stdout >> newlist.txt


# Border mutation 
#       commonly used combinations of digits and special symbols 
#               can be added at the end or at the beginning, or both

[List.Rules:borderMut5]
cAz"[0-9!@#$%^&*()_+][0-9!@#$%^&*()_+][0-9!@#$%^&*()_+][0-9!@#$%^&*()_+][0-9!@#$%^&*()_+]"

[List.Rules:borderMut3]
cAz"[0-9!@#$%^&*()_+][0-9!@#$%^&*()_+][0-9!@#$%^&*()_+]"

For "CaPiTaLiSeD LeTtEr ThEn LoWeRcAsE" --rules=NT

    Freak mutation - letters are replaced with similarly looking special symbols
    Case mutation - the program checks all variations of uppercase/lowercase letters for any character
   
#  Order mutation
#       character order is reversed

[List.Rules:reversed]
r
```

## References

[Openwall Wiki](https://openwall.info/wiki)
[erev0s cracking /etc/shadow /etc/passwd blog](https://erev0s.com/blog/cracking-etcshadow-john/)