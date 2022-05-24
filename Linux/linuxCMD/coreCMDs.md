# Core Linux Commands

```bash

apropos $string 		# search by keyword manual descript

(sha1,sha256,sha512,md5)sum 
sha512sum file1 file2 file3 > tests.sha512
sha512sum -c tests.sha512		check batch


base64 file.txt  			encode to base64
base64 file.txt | base64 --decode	decode base64
echo -n "string" | base64 -d

cat 		read file to stdout
cat -n		Number output lines
cat -b		Number nonemtpy lines
cat -v		Show nonprinting characters as ^x or M-x
cat -t		.. and tabs as ^I
cat -e		...and end lines with $
cat -A		same -vte

cd 	change directory 
cd .. 	goto the parent of the current directory
cd ../	traverse directory tree
cd -	return to last directory

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
chown user


comm		compare files
comm file.txt file1.txt

cp 		copy
-t		# working directory as target directory 		
# use -- as delimiter instead of - for files containing a '-'

dd if=/dev/urandom of=randomfile bs=4M count=2 		# create a file of 8mb of random content

diff		compare files byte-to-byte
diff file.txt file1.txt
diff -c context format
diff -u unified format
diff -s 		report indentical files

doas # Sudo alternative
doas -s	# shell with root prompt


echo 	write output at current location
echo "stringwith whitespace you want to remove and append to a file" | tr -d " " >> FILE 

env		show enviromental variables

export		set env variables

file		reads file headers

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
JUST REMEMBER /usr is not writable!:
find / -writable 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u

use: man find	for specific program documentation	
-user
-size [-] //for less than, c is the suffix for bytes, k for KiB’s, and M for MiB’s
-perm [octal|symbolic] //[–] or [/] prefix to make your search more inclusive
a = access, m = modified, c = created
-[]time num //[-] num less than, [+] num in last
-[]min 
	
getcap 		displays the capabilities on the queried file(s)
getcap -r / 2>/dev/null

head		print the first 10 lines of a file to stdout

iconv 		convert file format

id		user id

ln		create hardlink beetween files
ln -s 		create softlink between files

ls 		list directory
ls -l	list long formatting file wrx, filesize ... [filename] 

# for specific file info
ls -a	list all files including dotfiles
ls -a1 	list all on one line
ls -A	list all file including double dotfiles
ls -la / ... Look for hidden files under system root
ls -s	list allocated blocs
ls -i	list inodde numbers
ls -L	Follow symlinks
ls -H	follow symlinks on command line
ls -R	recurse
ls -d	list directories
ls -h	list human readable size
ls -n	list by uid and gids instead of names
ls -ln	list long formattting and uid 
ls -x	list by lines
ls -S	sort by size
ls -X	sort by extension
ls -v	sort by version
ls -t	sort by mtime
ls -tc	sort by ctime
ls -tu	sort by atime
ls -r	reverse sort order
ls --full-time	list full data and time
ls --group-directories-first

lspci  # for hardware info
lscpu  # for cpu info

ldd	print shared libraries

man <software>	manual page
man -k keyword! or '^regex$'
man int_section manual_name

mkdir		create folder
mkdir -p 	create directory tree

more/less	cat alternative

mv 		move file or folder: mv arg1 arg2, merge or modify a2, a2 can also be a rename!
mv * dir	move all files to dir!
# use -- as delimiter instead of - for files containing a '-'

netstat		list any network activity on current system

ps/		# process
ps -aef --forest # sacii art process tree
ps -aux # -a - all with tty except session leaders; -u  -user orientated format; -x processes without controlling ttys


pwd		# print working directory


reset		reset shell

rm 		remove file or folder, directories require -R switch: "rm -R dir"
-r		recursive directory removal

service		initialise services present in /etc/init.d
sleep		good for linux system on network for the hanging of connection
ss		 	# socket statistic (netstat alternative)
stat		# file/file system's status

sudo -l	LISTs commands you are able to with an account! VERY USEFUL
sudo -i	run a login shell as the target user
sudo -e	edit files instead of running a command
sudo -g --group=GROUP run command as group name or id
sudo -C close all file descriptor >= n
sudo -b	run command in background
sudo -A	use a helper program for password prompting
sudo --host=HOST	run command on host!
sudo -K	--remove-timestamp
sudo -k --reset-timestamp

systemctl	permanent system changes BEWARE!


tac 
-r -s 'x\|[^x]' Reverse a file character by character.

tail		print last 10 lines of a file to stdout

touch		create file

uname		system info

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

who		ownership
```		
