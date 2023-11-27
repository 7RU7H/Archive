# General maintance for various Linux distros

Disclaimer EVENTUALLY will fill this out with parrot and blackarch, I want to try them in the future.

Arch-based will be covered more in future, BUT Kali is where this is starting with mostly.

```bash
# APT & other disto System stuff:
apt			# is pacman for ubuntu, debian distos
apt-cache search # 	display information stored in internal cached package database
apt show package	# display description
apt upgrade
apt remove
apt ermove --purge
apt autoremove
apt update
apt install
add-apt-repository	# add addition repositories
dpkg			# package installer for ubuntu and debian
apt-get dist-upgrade # Offsec kali linux

pacman			# is apt for arch 
add-apt-repository --remove ppa:PPA_Name/ppa
apt remove
lsb_release -a # for version of unix
```


##  If packages are held back Debian
```bash
sudo apt-get --with-new-pkgs upgrade
sudo apt-get install <list of packages kept back>
```

## Disk Management
```bash
du 		# diskusage
-a		# list files with directory
-h		# human readable
-c		# print total size
-d		# specify depth
--time		# get timestamp

# Lost a file?
lsof | grep -i filename

mkdir Recovery
sudo foremost -v -q -t png -i /dev/sda1 -o ~/test
```
