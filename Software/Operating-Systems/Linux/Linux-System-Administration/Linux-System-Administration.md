# Linux System Administration



```bash
# Which glibc does a machine has installed
ldd --version
```

```
```bash 
passwd $user # change password
```

```bash
script -a $file # record shell [Ctrl+d] stops


shasum -a $algo $file # compute file hash  

split -b 9k $file # split a file in 9k chunks
chattr (+/-)i $file # Change immutable bit
```

`ufw`
```bash
ufw enable 
ufw disable

ufw logging on
ufw logging off

ufw status verbose

ufw delete $rule
ufw allow for $IP
ufw allow all 443/https
ufw deny all ssh
ufw deny $badIP proto udp to any port 443
```


Create a memory dump
```bash
dd if=/dev/fmem of /tmp/$name.dd
```


Reset root password in single user mode
```bash
reboot -f
# Press [Esc] at GRUB screen
e # select default entry and e for edit
# Scroll till linux, linux16, linuxefi line
# append the following:
rw init=/bin/bash
# [Ctrl+x] to reboot
# Single user mode -> change password
passwd $user
reboot -f
```

## References

BTFM: Blue Team Field Manual Ver 1.2 By Alan White and Ben Clark
[RTFM](https://www.amazon.co.uk/Rtfm-Red-Team-Field-Manual/dp/1494295504) 