# Arch Linux

This is just a laziest Arch Linux Arch Wiki cheatsheet to save your fingers and shoulders, Arch Wiki is awesome even for non Arch related.


https://wiki.archlinux.org/

## Installation Extras

https://wiki.archlinux.org/title/Installation_guide

https://archlinux.org/download/#checksums

https://www.reddit.com/r/archlinux/comments/fw0fxk/using_fdisk_how_would_i_properly_partition_total/

Partitioning - **Critical point for System Encryption, LVM or RAID**
```bash
# Find the disk you want
fdisk -l 
# Select
fdisk /dev/$drive
# Important
# press m for help
g # New GUID Partition Table - 64-bit partitions table scheme and supports up to 128 primary partitions
# Example of a single partition MBR
n # new partition
# Select by digit 
# You will get the start point and the end of the partition
# Use the below to adjust the size unless you want that partition to run till the end of the disk
# +1G or +520Mb
p # Print partitions table
# Type of partitian is very important - RTFM and think about what you want
t # type of partitian

w # Write changes

```
Consider https://wiki.archlinux.org/title/Partitioning#Example_layouts

Post install general recommendations https://wiki.archlinux.org/title/General_recommendations

## `pacman`

https://wiki.archlinux.org/title/Pacman

```bash
pacman -S $packageToInstall

# Sync and upgrade
pacman -Syu

```