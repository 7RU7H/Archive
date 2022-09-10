# USB-Maintaince


Backup and compress data
```bash
ls /dev/disk/by-id # Check the disk name
sudo dd if=/dev/disk/by-id/$DISK_ID status=progress | gzip -c > ~/$BACKUP_NAME.img.gz
````

Fix maybe?

```bash
sudo fsck -v -a /dev/disk/by-id/$DISK_ID
```

## formating

```bash
fdisk # researching

```
