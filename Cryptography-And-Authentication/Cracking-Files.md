# Cracking Files


## PFX files

[pfx files](https://docs.microsoft.com/en-us/windows-hardware/drivers/install/personal-information-exchange---pfx--files) are used to store private and public keys for Software Publisher Certificates. Pvk2Pfx tool is used to perform CA issued .spc and its key to pfx file.

Crack with `pfx2john` then regular `john`

Then extract cert and key
```bash
openssl pkcs12 -in $file.pfx -info
# Extract keys without worrying about newlines, whitespace or carriage returns
openssl pkcs12 -in $file.pfx -nocert -out key.pem -nodes
openssl pkcs12 -in $file.pfx -nokeys -out key.cert
```


## SSH Keys

Crack with `ssh2john`

## Zip files

Crack with `zip2john`