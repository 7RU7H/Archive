# USB-Maintenance


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
sudo cat Downloads/your.iso > /disk/by-id/$DISK_ID
sudo sync # will take some time
```

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


Encrypting a USB flash memory - [THM](https://tryhackme.com/room/linuxsystemhardening) :
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


## References

[maketecheasier](https://www.maketecheasier.com/repair-corrupted-usb-drive-linux/)
[THM Room Linux System Hardening](https://tryhackme.com/room/linuxsystemhardening)
[Arch Wiki](https://wiki.archlinux.org/title/USB_flash_installation_medium)