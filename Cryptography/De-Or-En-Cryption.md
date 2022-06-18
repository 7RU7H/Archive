# (De|En)cryption
Gpg
```bash
gpg -e filetoencrypt

killall gpg-agent

gpg -d filetodecrypt
```
Openssl
```bash
openssl genrsa -aes256 -out private.key 8912
openssl rsa -in private.key -pubout -out public.key
openssl rsautl -encrypt -pubin -inkey public.key -in plaintext.txt -out encrypted.txt
openssl rsautl -decrypt -inkey private.key -in encrypted.txt -out plaintext.txt
```