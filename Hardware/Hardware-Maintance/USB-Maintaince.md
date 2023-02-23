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

Repartition
```bash
fdisk -l 
fdisk /dev/$disk
# press m for help
# Example of a single partition MBR
n # new partition
p # Primary
$numberOfPartitions
p # Print partitions table
w # Write changes
# reformat!
```


Reformating - will require partitions to reformat!
```bash
 # Find USB and show partition names
lsblk -fp
umount $mountpoint
# Format to FAT32
mkfs.vfat /dev/$sdxy 
# Format to NTFS
mkfs.ntfs /dev/$sdxy 
```


## References

[maketecheasier](https://www.maketecheasier.com/repair-corrupted-usb-drive-linux/)