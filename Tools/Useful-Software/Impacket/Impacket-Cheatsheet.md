# Impacket 

Impacket is awesome.

## dccomexec.py 
Useful for [[Windows-Network-Lateral-Movement]]

## dpapi.py
Password Encryption tool on Windows

## GetNPUsers.py
For users that do not require Kerberos preauthentiation
```bash
GetNPUSers.py  -dc-ip $IP -request '$domain/' 
GetNPUSers.py  -dc-ip $IP -request '$domain/' -format hashcat

```

## mssqlclient

```bash
mssqlclient.py -port $PORT $domain/$user@$IP -windows-auth
```

## psexec
Similiar to [[Sysinternals-Psexec]]

```bash
psexec.py $username@$IP
```

## smbexec

