# NFS Recon
Network File System is a distributed file system protocol originally developed by Sun Microsystems in 1984. It uses client-server model to access/share file storage over a network. It is insecure by it host's implementation. See [[Network-Protocols-Cheatsheet]] for port information.

RPCbind and Portmap run on port 111

## Enumeration
```bash
nmap -sV -p 111 --script rpc* $ip
```

## Boarding the Server
This is the hacking equivilent to boarding a ship and just because its computer a server can mount on to itself.
```bash
sudo showmount -e $ip
sudo mount $ip:/file/path /local/file/path

sudo mount -o port=1234 -t nfs $ip:/dir /tmp/local
# nolock maybe required for older systems
sudo mount -o nolock port=1234 -t nfs $ip:/dir /tmp/local

umount $ip:/local/file/path		
```

[Wiki NFS](https://en.wikipedia.org/wiki/Network_File_System)