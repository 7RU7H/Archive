# USB Maintenance

[YouTube - Funny and only slightly relevant](https://www.youtube.com/watch?v=ZY2XoQCxGxg); USB maintenance is important.

[[GitHub]]
Mount to different volume types
```bash
mount -t exfat /dev/sdXN /mnt/usb
```

Backup and compress data
```bash
ls /dev/disk/by-id # Check the disk name
sudo dd if=/dev/disk/by-id/$DISK_ID status=progress | gzip -c > ~/$BACKUP_NAME.img.gz
````

USB for installing one OS
```bash
sudo su -
lsblk
# Reformat if requried
sudo mkfs.vfat /dev/$SDA123
sudo fsck -v -a /dev/disk/by-id/$DISK_ID
sudo cat Downloads/your.iso > /dev/disk/by-id/$DISK_ID
sudo sync # will take some time
```

Fix maybe?
```bash
sudo fsck -v -a /dev/disk/by-id/$DISK_ID
```

Re-partition
```bash
fdisk -l 
fdisk /dev/$disk
# press m for help
g # New GUID Partition Table - 64-bit partitions table scheme and supports up to 128 primary partitions
# Example of a single partition MBR
n # new partition
$numberOfPartitions
p # Print partitions table
w # Write changes
# reformat!
```


Reformatting - will require partitions to reformat!
```bash
 # Find USB and show partition names
lsblk -fp
umount $mountpoint
# EXFAT
mkfs.exfat /dev/sda1

# FAT32
sudo mkfs.fat -F 32 -n Pendrive /dev/sdb1
# Format to VFAT32
mkfs.vfat -F 32 /dev/$sdxy 
# Format to NTFS
mkfs.ntfs /dev/$sdxy 
# Format to ext4 - file
# -L: Label
# -m reserved block percentage
# -b block size
sudo mkfs.ext4 -L Pendrive -m 1 -b 4096 /dev/sdb1
# Format to exFAT
sudo mkfs.btrfs -n Pendrive /dev/sdb1
# Format to xfs
sudo mkfs.xfs -n Pendrive /dev/sdb1
```
For [FAT](https://en.wikipedia.org/wiki/File_Allocation_Table) (File Allocation Table), [FAT16](https://en.wikipedia.org/wiki/File_Allocation_Table#FAT16), [VFAT](https://en.wikipedia.org/wiki/File_Allocation_Table#VFAT) (Virtual FAT), and [FAT32](https://www.baeldung.com/cs/ntfs-vs-fat32-vs-exfat#fat32) file systems Wikipedia links are provided by [baeldung usb-drive-format](https://www.baeldung.com/linux/usb-drive-format).


Encrypting a USB flash memory - [THM](https://tryhackme.com/room/linuxsystemhardening):
```bash
# List USB drives
sudo lsblk
# Locate/print block device atttributes
sudo blkid
# With verbose cryptsetup verify passphrase 
sudo cryptsetup -y -v luksFormat /dev/sdb1
# open a LUKs device <device> <name>
sudo cryptsetup luksOpen /dev/sdb1 EDCdrive
# make ext4 filesystem - 2 and 3 are avaliable
sudo mkfs.ext4 /dev/mapper/EDCdrive -L "Strategos USB"
# Mount USB
sudo mount /dev/mapper/EDCdrive /media/secure-USB
# Check Settings:
sudo cryptsetup luksDump /dev/sdb1
```

Delete a partition-table signatures - from [serverfault](https://serverfault.com/questions/250839/deleting-all-partitions-from-the-command-line)
```bash
wipefs -a /dev/sda
```

## References

[maketecheasier](https://www.maketecheasier.com/repair-corrupted-usb-drive-linux/)
[THM Room Linux System Hardening](https://tryhackme.com/room/linuxsystemhardening)
[Arch Wiki](https://wiki.archlinux.org/title/USB_flash_installation_medium)
[baeldung usb-drive-format](https://www.baeldung.com/linux/usb-drive-format)
[serverfault](https://serverfault.com/questions/250839/deleting-all-partitions-from-the-command-line)
[YouTube - Funny and only slightly relevant](https://www.youtube.com/watch?v=ZY2XoQCxGxg)