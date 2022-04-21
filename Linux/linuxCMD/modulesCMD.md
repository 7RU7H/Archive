# Modules 

Check Grep all the things for a single files, eventual I hope to expand and organise this for each to have there own file, but for now one will do.
```bash
#### awk 
awk [flags] [select pattern/find(sort)/commands] [input file]

awk '{print}' file.txt					print to terminal
awk '/regex/' file.txt					print lines containing regrex
awk '{print $1 $3}' file.txt				print the 1st and 3rd fields of file.txt
To not truncate them:
awk '{print $1,$3}' file.txt
awk '{print NR,$0}' file.txt				NR = number record after each lines execution <-- this counts all file lines
The script demonstrates begin and end:
awk "BEGIN {FS='o'} {print $1,$3} END{print 'Total Rows=',NR}"
FS = field separator
RS = record separator
NR = number record
SO... given the fields 1 and 3 separate each field containing an 
"o" and end the script by printing the number record

OFS=":" 	= output field separator 	would delimiter the field output with a colon
ORS="\n\n" 	= output record separator	would delimiter the record/line output with two newlines
-F 		field
-v		variable
-D		debug
-o		output file

# tricks:
awk -F FS -mf Numberoffield '{operation $fieldnum}' file > file
awk -F: '{print $1}' /etc/passwd | wc -l # for all the users and the wc -l for the total users
$awk '{a[NR]=$0} END {for (j=1; j<NR; j++) print a[j];sub(/.$/,"",a[NR]);print a[NR]}' InputFile	delete the last character in a file

#### binwalk
# Allows users to analyze and extract firmware images and helps in identifying code, 
# files, and other information embedded in those, or inside another file, taking as an example steganography.
binwalk -e	extract known file types
binwalk	-B	scan target files signatures
binwalk -R	scan target files the specified sequence of byte
binwalk -A	scan target files for common executable opcode signatures
binwalk	-m	custom magic file to use
binwalk -M	recursively scan extracted files
binwalk -d 	depth limit


#### curl

--compressed				# Over encoding error of ZIP files with --compressed
-d 'data=data&data=data'		# transfer data 'inside-the-single-quotes'
-I					# output header 
-k					# suppress web cert errors
-o file.ext				# output file.ext to choice of name and extension
--silent				# silent errors
-x [protocol://]host[:port] URL		# proxy!!!
curl [option] [Protocol:HTTP, HTTPS, FTP, FTPS, SCP, SFTP, TFTP, DICT, TELNET, LDAP or FILE]
curl --limit-rate 1234B http://www.ismycomputeron.com/		limit the connection speed to 1,234 bytes/second:
curl -#								display progress metre
curl -o loginpage.html https://tryhackme.com/login		-o to save the file under a different name
curl -O https://tryhackme.com/login				-O to save the file under the same name:
curl -C-							resume broken download without specifying an offset
curl -I -s https://tryhackme.com				fetch the headers silently
curl -v http://ip:port 		-verbose
curl -u 							user authentication
VERY USEFUL:
curl -T								upload file!!!
curl -x								if you have to view page through a proxy, specify the server
curl -I								queries header not webpage
curl -A								you can spcifiy user agent to make request to the server
curl -:								follow redirects
curl -b								specify cookies
curl -X								specify http method!



#### cut
-d<delimiter> -f$int,			# cut by delimiter, for each field listed 1,2,3,4...

#### find 

find / -type f -name "*.txt" -exec rm {} \; # delete all the files with .txt extension = use xargs ITS FASTER

#### gpg

killall gpg-agent

gpg -d filetodecrypt
gpg --import key.file
gpg --cipher-algo [encryption type] [encryption method] [file to encrypt]


#### grep 		!see useful/linux/linuxCMD/grepAllTheThings.txt

#### gzip
gzip -d file.gz		decompress file

#### journalctl		query systemd logs - output of services, syslog messages, kernel logs
-r	reverse order
-u	limit message output amount
-f	continuously print new log entries

#### sed

sed -n [operations] [file] > [file]
sed ....'1,100p					print matched lines
sed -e ... -e					multiple section from a filestream 
sed 's/subthis/forthis/[]'			's = substitute /a/b/[ p = pattern, gp = global]
sed 's/\([^:]*\).*/\1/' /etc/passwd		for easy usernames
sed -f						specify file containing string pattern
sed -E						use extended regular expression
sed -n						suppress the automatic printing or pattern spacing
sed -s						substitute mode find and replace
sed -y						individual bytes in the string provide
/g						global
/i						case insensitive pattern
/d						delete the pattern found 
/p						prints the matching pattern
/1,/2,/3,/n					perform operation on an nth occurrence in a line
sed -e 'range mode/pattern/STRING/g' file.txt
sed commandline syntax:
'[condition(s)(optional)] [command/mode(optional)]/[source/to-be-searched pattern(mandatory)]/[to-be-replaced pattern(depends on command/mode you use)]/[args/flags to operate on the pattern searched(optional)]'

sed -n -e '1,5' -e '10,15p' file.txt		print lines 1to5, 10to15
sed "s/^/'/;s/$/'/" InputFile			put single quotes around a stream
sed 's/^/"/;s/$/"/' InputFile			put double quotes around a stream
sed -i '$ s/.$//' InputFile			delete last character in file



#### seq
seg $int		# print sequence of "$int\n" 

#### sort
sort -r 	reverse order
sort -c		check if sorted
sort -u		to sort and removes duplicate lines
sort -o		output to filename given


#### tac			concatenate files and print them in reverse!
tac -b	attach a separator before instead of after
tac -r	interpret te separator as a regex
tac -s	use STRING as a seaprator instead of Newline

#### strings 	
# Search each file specified and print any printable character strings found that are at least four characters long and followed by an unprintable character. 
# Often used to find human-readable content within binary files.

#### tar

tar -xf archive.tar
-x tells tar to extract files from an archive.
-f tells tar that the next argument will be the name of the archive to operate on
tar zxvf file

#### tr
#TR for TRANSLATIONS!
tr [opt] charset1 [charset2]
tr -d	...	delete characters in charset1
tr -d	"\\n"	delete newline chars!
tr -c	...	operate only on the charset1 chars
tr -s	...	remove multiple adjacent chars from charset1
tr -t	...	truncate the first set
# some sets:
[:lower:]	[:upper:]	'[a-z]'	'[A-Z]'
[:digit:]
[:xdigit:]	//hexadecimal
[:alpha:]	//total alphabet 
'[a-zA-z: ]' the regrex including the whitespace

# tricks
cat sample.txt | tr 'a-z' 'A-Z'	convert sample.txt from lower case to upper case

#### uniq

uniq -c 	count the occurrences
uniq -d		print only repeated lines
uniq -u		print only unique lines
uniq -i		ignores case


#### wget 

wget http://url|ip:port/directory

-o file.ext	# output file.ext to choice of name and extension
-o log	 	# output as log file
--recursive	# Copies entire website to host BEWARE
		download files from web via http 
-r 		for you recursive needs
-l num		recursively get from default and max of 5 directories up!
-b			background proccess
-c			continue partially download file
-t int		specify retries
-O download.txt	specify output name
-a			append logs
-i			read the list of url from a file
# wget can login from http, ftp, etc
http-* ||ftp-* :
-user=			
-password=	
To login via http or ftp
--ask-password		prompt password
--limit-rate=INT	limit download rate
-w=int			waiting time in seconds
-T=int			timeout retrieval in seconds
-N			enable timestamping
-U			specify user-agent while downloading file


#### xargs
Usage: <cmd1> | xargs <cmd2> # default cmd is echo

-t		# verbose print command before and with its output
-I		# specify a alias of the pipeto output, to use as xargs cmd parameter
-n int		# max number of arguements i.e 2 = 2 args at a time echoed out
-P int		# max number of processes at time
-0		# tertminate the arguements with null character
-a 		# read item from a file
-d		# delimiter
-L int		# max number of non-blank inputs per command
-s int		# buffer size, default is 128kB
-x		# exit execution if the size specified is exceeded
-E		# end of file string specifier
-p		# prompt the user before running any command as token of confirmation
-r 		# if stdin is blank xargs won't run
-e	 	# equivalent to -E END if END is specifed
-l		# similar to -L but defaults to at most one non-blank input line if MAX-LINES is not specified
-x		# exit command execution if size specified is exceede

ls | cut -d. -f1 | xargs -I {} mv {}.txt {}.jpg # change all the file extensions in e directory
find / -type f -name "*.txt" | xargs rm # remove all .txt files from a directory set by find
cat file | xargs -I files -t sh -c “touch files; chmod 400 files” # create all the files from a list of names and mkae them all read-only permissions
ls | xargs -I word -n 1 -t sh -c "echo word >> shortrockyou; rm word" # create filelisting of all the files in a directory then delete the files

--		# escape empty flags!
#for example:
<cmd> "-- --checkpoint-action=exec=sh"


#### xxd	create hexdump of a file
Options:
    -a          toggle autoskip: A single '*' replaces nul-lines. Default off.
    -b          binary digit dump (incompatible with -ps,-i,-r). Default hex.
    -C          capitalize variable names in C include file style (-i).
    -c cols     format <cols> octets per line. Default 16 (-i: 12, -ps: 30).
    -E          show characters in EBCDIC. Default ASCII.
    -e          little-endian dump (incompatible with -ps,-i,-r).
    -g          number of octets per group in normal output. Default 2 (-e: 4).
    -h          print this summary.
    -i          output in C include file style.
    -l len      stop after <len> octets.
    -o off      add <off> to the displayed file position.
    -ps         output in postscript plain hexdump style.
    -p		turn file contents to hex
    -r          reverse operation: convert (or patch) hexdump into binary.
    -r -s off   revert with <off> added to file positions found in hexdump.
    -d          show offset in decimal instead of hex.
    -s [+][-]seek  start at <seek> bytes abs. (or +: rel.) infile offset.
    -u          use upper case hex letters.
    -v          show version: "xxd V1.10 27oct98 by Juergen Weigert".

xxd -s 0xa -l 50 -b file.txt # get the 10th byte (0xa), of first 50 -binary-digit-dump of file.tx
xxd -c 3 -g 8 file.txt # 3 columns with groupsize 8 per row of file.txt
xxd -p -r flag.txt # plaintext reversion of hexdump

#### 7Zip
7z x file.zip
```
