# Core Linux Commands

For grep-related see [[Grep-All-The-Things]] and for other modules like `awk`, `sed` and `xargs` see [[Linux-Module-Commands]]. All network related commands current and legacy can be found here: [[Linux-Networking-Commands]]. For User and group related see [[Linux-Users-And-Group-Commands]]. For [[Systemctl]] related or for [[Linux-Maintaince-And-Troubleshooting-Commands]]. [[Linux-Memory-Commands]], [[Linux-Hardware-Commands]]

# `apropos`
```bash
apropos $string 		# search by keyword manual descript
```

## `base64`
```bash
base64 file.txt  			encode to base64
base64 file.txt | base64 --decode	decode base64
echo -n "string" | base64 -d
```
## `cat`
```bash
cat 		# read file to stdout
cat -n		# Number output lines
cat -b		# Number non-empty lines
cat -v		# Show nonprinting characters as ^x or M-x
cat -t		# .. and tabs as ^I
cat -e		# ...and end lines with $
cat -A		# same -vte
```
## `cd` 
```
cd 	# change directory 
cd .. 	# goto the parent of the current directory
cd ../	# traverse directory tree
cd -	# return to last directory
cd ~/   # goto user's home directory

Chmod 	change permissions of a file
chmod u=rwx,g=rx,o=rw myfile
    u = user is being giver read, write and execute permission
    g = group can now read and execute
    o = other can read and write
THESE are values that add together read+write+exec = (1+2+4) -> 777
0 stands for "no permission."
1 stands for "execute";
2 stands for "write";
4 stands for "read".
+s	execute and setuid flags set
+S	just setuid flag set

chown :group
chown user:user

comm		#compare files
comm $file.txt $file1.txt

cp 		# copy
-t		# working directory as target directory 		
# use -- as delimiter instead of - for files containing a '-'
cp --preserve # preserve the specified attributes (default: mode,ownership,timestamps), if possible additional attributes: context, links, xattr, all


```
## `date`
```bash
# Current  local system time
date
# What was the date nth unit-of-time ago?
date --date="5 year ago"
date --date="1360 day ago"
```

```
dd if=/dev/urandom of=randomfile bs=4M count=2 		# create a file of 8mb of random content

diff		compare files byte-to-byte
diff file.txt file1.txt
diff -c context format
diff -u unified format
diff -s 		report indentical files

doas # Sudo alternative
doas -s	# shell with root prompt

```

## `du`
```bash
# Total size of a directory - Ippsec
du -sb $directory
# Then plug the number in the float(HERE)  
python3 -c "print(f'{float()/1024/1024:.2f} MB')"
```

## `echo`
```bash
echo 	write output at current location
echo "stringwith whitespace you want to remove and append to a file" | tr -d " " >> FILE 

env		show enviromental variables

export		set env variables

# Process management
[ctrl+z]	# Background
fg			# Foreground
jobs		# view backgrounded processes
fg %1		# Job number
fg %$STR	# by beginning of command name	
fg %$Commandname # actual command name
fg %$+ / %%	# current job
fg %$-		# previous job

file		# reads file headers
```

## `find`
```bash
find		find things
find / -perm -u=s -type f 2>/dev/null 		Find SUID binaries
find [path] -type f|d -name [filename]
find [path] -type f -size [size] c for bytes, k for kilobytes, M megabytes, G for gigabytes
find [path] -type f -user [username]
find [path] -type f -group [groupname]
find [path] -type f -newermt [start] -newermt [end]
find [path] -type f -newerat[start] -newerat [start]
find multifiles:
find / -type f \( -NAME ... -o )
... -exec ls -irlt {} \; 2>/dev/null					List group of user of file
... -exec grep -o -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}" * {} \; 		List files containing ip addresses
... -exec [hashname] {} \;						List the checksum hash for files
... -exec wc -l [NUM]  {}						List of the multifile argument all file that dont contain the wc of NUM
... -exec ls -ln  {}							List the file own id

find ./ -type f -name test -exec wc -w {} +   # Count all the word found in list files found 
find . -type f -name *.txt -exec cat {} + # cat all the text files


find / -perm a=x	find executables
find / -mtime int	find last modified days
find / -atime int 	find last accessed days
find / -cmin int 	find changes to type in mins
find / -amin int	find accessed to type in mins
find / -size +/-int/b	find of specific size

find world writable directories:
find / -writable -type d 2>/dev/null
find / -perm -222 -type d 2>/dev/null
find / -perm -o w -type d 2>/dev/null 
# JUST REMEMBER /usr is not writable!:
find / -writable 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u

use: man find	for specific program documentation	
-user
-size [-] //for less than, c is the suffix for bytes, k for KiB’s, and M for MiB’s
-perm [octal|symbolic] //[–] or [/] prefix to make your search more inclusive
a = access, m = modified, c = created
-[]time num //[-] num less than, [+] num in last
-[]min 
```

## `fuser`
```bash
# If you need to kill a specific process using a given port
ps aux | grep $app # or..
pgrep $app

sudo fuser -k 445/tcp
```

## `getcap`
```bash
getcap 		# displays the capabilities on the queried file(s)
getcap -r / 2>/dev/null
```

## `head`
```bash
head		# print the first 10 lines of a file to stdout
head -n $int # print $int number of the lines from the "head" of the file
```

## `iconv`
```bash
iconv 		# convert file format
```
`id`
```bash
id	#	user, group, and effective id
```
`ln`
```bash
ln	# 	create hardlink beetween files
ln -s #		create softlink between files
```

## `ls`
```bash
ls # list directory
ls -l # list long formatting file wrx, filesize ... [filename] 

# For specific file info
ls -1 # One file per line
ls -a # list all files including dotfiles
ls -a1 # list all on one line
ls -A # list all file including double dotfiles
ls -la /  #  ... Look for hidden files under system root
ls -s # list allocated blocs
ls -i # list inodde numbers
ls -L # Follow symlinks
ls -H # follow symlinks on command line
ls -R # recurse
ls -d # list directories
ls -h # list human readable size
ls -n # list by uid and gids instead of names
ls -ln # list long formattting and uid 
ls -x # list by lines
ls -S # sort by size
ls -X # sort by extension
ls -v # sort by version
ls -t # sort by mtime
ls -tc # sort by ctime
ls -tu # sort by atime
ls -r # reverse sort order
ls --full-time # list full data and time
ls --group-directories-first
(sha1,sha256,sha512,md5)sum https://cheatsheet.haax.fr/linux-systems/tricks/
sha512sum file1 file2 file3 > tests.sha512
sha512sum -c tests.sha512		check batch
ls -1 --sort=time -r # File per line from earliest creation time to lastes
ls -la --sort=time -r # Same above expect list all permissions  

```

## `lsof`
```bash
lsof   # List Open files

lspci  # for hardware info
lscpu  # for cpu info

ldd	print shared libraries

man <software>	manual page
man -k keyword! or '^regex$'
man int_section manual_name

mkdir		# create directory
mkdir -p 	#create directory tree
mkdir -p ~/parent-directory/{child-directory-1,child-directory-2,child-directory-3}

more/less	# cat alternative with scroll down

mv 		move file or folder: mv arg1 arg2, merge or modify a2, a2 can also be a rename!
mv * dir	move all files to dir!
# use -- as delimiter instead of - for files containing a '-'

netstat		list any network activity on current system

ps		# process
ps -aef --forest # sacii art process tree
ps -aux # -a - all with tty except session leaders; -u  -user orientated format; -x processes without controlling ttys


pwd		# print working directory

reset		# reset shell
```
## `rm`
```bash
rm 		# remove file or folder, directories require -R switch: "rm -R dir"
-r		# recursive directory removalhaax.fr/linux-systems/tricks
rm -rf # FORCED recursive directory removal


service		# initialise services present in /etc/init.d
sleep		# good for linux system on network for the hanging of connection
ss		 	# socket statistic (netstat alternative)
stat $DIRECTORY	# file/file system's status from a directory --help lots of flags

sudo -l	# Lists commands you are able to with an account! VERY USEFUL
sudo -i	# run a login shell as the target user
sudo -e	# edit files instead of running a command
sudo -g --group=GROUP # run command as group name or id
sudo -C # close all file descriptor >= n
sudo -b	# run command in background
sudo -A	# use a helper program for password prompting
sudo --host=HOST # run command on host!
sudo -K	--remove-timestamp
sudo -k --reset-timestamp

systemctl # permanent system changes BEWARE!
systemctl stop $servicename
systemctl start $servicename
systemctl restart $servicename

tac 
-r -s 'x\|[^x]' Reverse a file character by character.

tail		print l(sha1,sha256,sha512,md5)sum 
sha512sum file1 file2 file3 > tests.sha512
sha512sum -c tests.sha512		check batchast 10 lines of a file to stdout
(sha1,sha256,sha512,md5)sum 
sha512sum file1 file2 file3 > tests.sha512
sha512sum -c tests.sha512	# 	check batch

touch		# create file
touch -- --preserve=mode # preserve a files permissions 

uname		# system info

vimdiff		# opens vim with highlighting between multiple files

watch
-n int	interval run
-w 	list loggin in user

wc		word counting
wc -l : Prints the number of lines in a file.
wc -w : prints the number of words in a file.
wc -c : Displays the count of bytes in a file.
wc -m : prints the count of characters from a file.
wc -L : prints only the length of the longest line in a file.
echo (-n) "" | wc -c : count the characters! Add -n for no newline

which $input	location of /bin/$input

who		# logged in
w       #
```

Linux File ACLs and Attributes 
```bash
getfacls
chattr
lsattr
```

## References

[Ippsec.Rocks](https://ippsec.rocks)
[haax.fr/linux-systems/tricks](https://cheatsheet.haax.fr/linux-systems/tricks/)
[redhat - formatting date command ](https://www.redhat.com/sysadmin/formatting-date-command)