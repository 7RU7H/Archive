# (De|En)cryption

For definitions and concepts try here: [[Cryptography]]

## gpg
```bash
killall gpg-agent

gpg -d filetodecrypt
gpg --import key.file

gpg -c --cipher-algo aes256 aes256.plain
gpg --decrypt aes256.plain.gpg

gpg -c --cipher-algo blowfish blowfish.plain
gpg --decrypt blowfish.plain.gpg

gpg --import public.key
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


## Cracking Files
Consider [[Cracking-Files]]

Weird string in a file? Screenshot each! Retain originals
```bash
file $file 
cp $file $file.bak
cat $file # beware escape characters for the terminal
```

## Cryptogram solving

[quipqiup](https://www.quipqiup.com/) *"a fast and automated cryptogram solver by [Edwin Olson](http://april.eecs.umich.edu/people/ebolson). It can solve simple substitution ciphers often found in newspapers, including puzzles like cryptoquips (in which word boundaries are preserved) and patristocrats (inwhi chwor dboun darie saren t).*"*