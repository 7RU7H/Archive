# Data Destruction

https://wiki.archlinux.org/title/Securely_wipe_disk


https://askubuntu.com/questions/17640/how-can-i-securely-erase-a-hard-drive
https://how-to.fandom.com/wiki/How_to_wipe_a_hard_drive_clean_in_Linux

https://www.gnu.org/software/coreutils/manual/html_node/shred-invocation.html
## Linux


Full USB drives
```bash
sudo dd if=/dev/zero of=/dev/sdb1 bs=1M
```

```bash
sudo shred -n 3 -z /dev/sdb1
```
For other [[USB-Maintenance]] follow that link.

#### Debian-based

#### RedHat

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/sec-removing_data_securely_using_scrub

## Windows

## References

[baeldung usb-drive-format](https://www.baeldung.com/linux/usb-drive-format)