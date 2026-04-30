# Putty

#### Convert Putty.ppk to id_rsa for ssh usage ([[SSH-Cheatsheet]])

Convert key.ppk that looks like ([arslion Medium](https://medium.com/@arslion/convert-ppk-version-3-to-ssh-private-public-keys-pem-on-linux-ubuntu-4bf2c8db1ef2))
```
PuTTY-User-Key-File-3: ssh-rsa
Encryption: none
Comment: rsa-key-20230519
Public-Lines: 6
...CYPHER TEXT...
```

Copy the entire thing including the header

We need putty-gen to convert to ssh key
```bash
apt install putty-tools
puttygen root.ppk -O private-openssh -o id_rsa
chmod 600 id_rsa
```

## References

[arslion Medium](https://medium.com/@arslion/convert-ppk-version-3-to-ssh-private-public-keys-pem-on-linux-ubuntu-4bf2c8db1ef2)