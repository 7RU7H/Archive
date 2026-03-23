# Armitage

## Kali
[Armitage](https://www.kali.org/tools/armitage/) is part of the metapackages for [[Kali]]: everything, larger and tools: exploitation. Or can be install individually with `sudo apt install armitage`  


## Manual Install Up Armitage

```bash
cd /opt
git clone https://gitlab.com/kalilinux/packages/armitage.git && cd armitage
bash package.sh
cd ./release/unix/ && ls -la
# 
```
Locatein `/release/unix/` are  the Teamserver File and Armitage

File | Description and Argumentents
--- | ---
Teamserver | Starts server for multiple users, takes `IP address`, and `Shared Password` as arguments
Armitage | File used to connnect to the Aritage Teamserver - spawns a Prompt for Host, Port, User, Pass  

## Setup
Armitage relies on correct Metasploit Setup, initilize database
```bash
systemctl start postgresql && systemctl status postgresql


# For earlier Versions of MSF Don't USE ROOT
# msfdb --use-defaults delete
# msfdb --use-defaults init
```

To start up either:

```bash
cd /opt/armitage/release/unix && ./teamserver $IP $password
teamserver $IP $password # kali setup
```



## References
[Kali Tool page](https://www.kali.org/tools/armitage/)
