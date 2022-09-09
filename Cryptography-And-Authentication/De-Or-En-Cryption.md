# (De|En)cryption
For definitions and concepts try here: [[Cryptography101]]
## gpg
```bash
killall gpg-agent

gpg -d filetodecrypt
gpg --import key.file

gpg -c --cipher-algo aes256 aes256.plain
gpg --decrypt aes256.plain.gpg

gpg -c --cipher-algo blowfish blowfish.plain
gpg --decrypt blowfish.plain.gpg
```

## Openssl
```bash
openssl genrsa -aes256 -out private.key 8912
openssl rsa -in private.key -pubout -out public.key
openssl rsautl -encrypt -pubin -inkey public.key -in plaintext.txt -out encrypted.txt
openssl rsautl -decrypt -inkey private.key -in encrypted.txt -out plaintext.txt


# openssl passwd  
# -6                  SHA512-based password algorithm
# -5                  SHA256-based password algorithm
# -writerand outfile  Write random data to the specified file
# -salt val           Use provided salt

```

## ssh-keygen
```bash
ssh-keygen
ssh-copy-id -i /.ssh/id_rsa.pub kali@localhost # send to remote server
ssh -i .ssh/id_rsa kali@localhost # logon to remote server with key

```
