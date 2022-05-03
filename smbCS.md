
# Server Message Block 
SMB oringally ran on top of NetBIOS using port 139. NetBIOS is an older trnasport layer that allows Windows computer to communicate on the same network.
Later versions of SMB(after Windows 2000) use port 445 on top of a TCP stack, TCP allows for internet communication.


## smbmap
```bash
smbmap -H $IP
smbmap -H $IP -u user -p password -H $IP # requires credentals
```

## nbtscan 
Scan NetBIOS name servers, enumerate connection points across a network
```bash
nbtscan -r $IP/$CIDR
```

## RPCclient
Query MS-RPC for  commands to try and estanblish a null session
```bash
rpcclient -U "" -N $IP
```

## Smbget
Recursively download an entire share
```bash
smbget -R smb://$IP/$share
```

## smbclient
```bash
# list share with valid user and password
smbclient -L $IP -U username%password
# connect to share 
smbclient //$IP/$share -U username%password	

smbclient -L $IP			# List shares using NULL session
smbclient -L //$IP/tmp
smbclient -U "" -L //$IP/anon
smbclient -N //$IP/tmp --option='client min protocol=NT1' # legacy


## Transfer files!
# Download a file from a specific share
smbclient //$IP/$share -c 'cd folder; ls' password -U username # list
smbclient //$IP/$sahre -c 'cd folder;get desired_file_name' password -U username 
# Copy a file to a specific share
smbclient //$IP/$share -c 'put /var/www/my_local_file.txt .\target_folder\target_file.txt' password -U username 

```

## enum4linux Enumeration
```bash
enum4linux -a $IP #  Anonymous session
enum4linux -a $IP -u <user> -p <pass> # Authenticated session
enum4linux -u <user> -p <pass> -U $IP # Users enumeration
enum4linux -u <user> -p <pass> -G $IP # Group and members enumeration
enum4linux -u <user> -p <pass> -P $IP # Password policy
```

## nmap - Enum Users
Oneliner for enumerating SMB shares
```bash
nmap -p 139,445 --script=smb-enum-shares.nse,smb-enum-users.nse $IP
```

RPC-Bind port 111,  Server convert a remote procedure call program nu,mber to into universal addresses
```bash
nmap -p 111 --script=nfs-ls,nfs-statfs,nfs-showmount $IP
```

```bash
nmap -p 445 --script smb-enum-users <target> --script-args smbuser=username,smbpass=password,smbdomain=domain nmap -p 445 --script smb-enum-users <target> --script-args smbuser=username,smbhash=LM:NTLM,smbdomain=domain
nmap --script smb-enum-users.nse --script-args smbusername=User1,smbpass=Pass@1234,smbdomain=workstation -p445 192.168.1.10
nmap --script smb-enum-users.nse --script-args smbusername=User1,smbhash=aad3b435b51404eeaad3b435b51404ee:C318D62C8B3CA508DD753DDA8CC74028,smbdomain=mydomain -p445 192.168.1.10

# nmap - Enum Groups
nmap -p 445 --script smb-enum-groups <target> --script-args smbuser=username,smbpass=password,smbdomain=domain nmap -p 445 --script smb-enum-groups <target> --script-args smbuser=username,smbhash=LM:NTLM,smbdomain=domain

# nmap - Enum Shares
nmap -p 445 --script smb-enum-shares <target> --script-args smbuser=username,smbpass=password,smbdomain=domain nmap -p 445 --script smb-enum-shares <target> --script-args smbuser=username,smbpass=LM:NTLM,smbdomain=domain

# nmap - OS Discovery
nmap -p 445 --script smb-os-discovery <target>

# nmap - SMB Vulnerabilities on Windows
nmap -p 445 --script smb-vuln-ms06-025 target-IP
nmap -p 445 --script smb-vuln-ms07-029 target-IP
nmap -p 445 --script smb-vuln-ms08-067 target-IP
nmap -p 445 --script smb-vuln-ms10-054 target-IP
nmap -p 445 --script smb-vuln-ms10-061 target-IP
nmap -p 445 --script smb-vuln-ms17-010 target-IP

# nmap - Brute Force Accounts (be aware of account lockout!)
nmap –p 445 --script smb-brute –script-args userdb=user-list.txt,passdb=pass-list.txt target-IP
```

## Search msfconsole!



## References

[toxsec](https://toxsec.com/smb-cheatsheet/)
[lzone](https://lzone.de/cheat-sheet/SMB)
[irgoncalves](https://github.com/irgoncalves/smbclient_cheatsheet)
[referenced by the above](https://sharingsec.blogspot.com/)