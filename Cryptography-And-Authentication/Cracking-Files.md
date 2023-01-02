

#### Keepass Files
Keepass .kdbx files - Crack with `keepass2john file.kdbx > kp2John-userkeypass`
- Can take key files as arguements... `keepass2john -k keyfile file.kdbx > kp2John-userkeypass``
```bash
for file in $(ls $setofkeyfiles); do keepass2john -k $img db.kdbx | sed "s/db/$file/g"; done >> keyfiles_john
```
[Ippsec](https://www.youtube.com/watch?v=CO_g3wtC7rk) and [0xdf](https://0xdf.gitlab.io/2019/10/26/htb-safe.html)


Office Documents - Crack with `office2john`

#### PFX files
[pfx files](https://docs.microsoft.com/en-us/windows-hardware/drivers/install/personal-information-exchange---pfx--files) are used to store private and public keys for Software Publisher Certificates. Pvk2Pfx tool is used to perform CA issued .spc and its key to pfx file.

Extract cert and key
```bash
openssl pkcs12 -in $file.pfx -info
# Extract keys without worrying about newlines, whitespace or carriage returns
openssl pkcs12 -in $file.pfx -nocert -out key.pem -nodes
openssl pkcs12 -in $file.pfx -nokeys -out key.cert
```

Certificate.pfx - Crack `pfx2john`   

#### SSH Keys

SSH Keys - Crack with `ssh2john`

#### Zip files

Zip files - Crack with `zip2john` 
- Hashcat mode 17200
