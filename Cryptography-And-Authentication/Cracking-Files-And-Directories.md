# Cracking Files and Directories
#### bitlocker
- Crack with `bitlocker2john`
#### .doc files

Office Documents - Crack with `office2john`

#### `dmg`
- Crack with `dmg2john`

#### `gpg`

- Crack with `gpg2john`
#### `hccap`
- Crack with `hccap2john`
#### Keepass Files
Keepass .kdbx files - Crack with `keepass2john file.kdbx > kp2John-userkeypass`
- Can take key files as arguments... `keepass2john -k keyfile file.kdbx > kp2John-userkeypass``
```bash
for file in $(ls $setofkeyfiles); do keepass2john -k $img db.kdbx | sed "s/db/$file/g"; done >> keyfiles_john
```
[Ippsec](https://www.youtube.com/watch?v=CO_g3wtC7rk) and [0xdf](https://0xdf.gitlab.io/2019/10/26/htb-safe.html)

#### `keepass`
- Crack with `keepass2john`


#### PFX files
[pfx files](https://docs.microsoft.com/en-us/windows-hardware/drivers/install/personal-information-exchange---pfx--files) are used to store private and public keys for Software Publisher Certificates. Pvk2Pfx tool is used to perform CA issued .spc and its key to pfx file.

Extract cert and key
```bash
openssl pkcs12 -in $file.pfx -info
# Extract keys without worrying about newlines, whitespace or carriage returns
openssl pkcs12 -in $file.pfx -nocert -out key.pem -nodes
openssl pkcs12 -in $file.pfx -nokeys -out key.cert
```

Certificate - Crack with `pfx2john`   

#### putty
- Crack with `putty2john`

#### racf
- Crack with `racf2john`
#### SSH Keys

SSH Keys - Crack with `ssh2john`

#### `uaf`
- Crack with `uaf2john`
#### vncpcap
- Crack with `vncpcap2john`
#### wpapcap
- Crack with `wpapcap2john`
#### `zip` files

Zip files - Crack with `zip2john` 
- Hashcat mode 17200

## References

[THM Linux Strength Training Room](https://tryhackme.com/r/room/linuxstrengthtraining)