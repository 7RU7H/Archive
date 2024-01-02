# Linux-One-Liners-To-Rule-Them-All

Incoming watching of talk "One-Liners-To-Rule-Them-All"

## File System One-Liners

Make a new sub-directory putting all current directory into that new directory 
```bash
mkdir $new_subdirectory | ls | grep -v $new_subdirectory | tr -S '\n' ' ' | xargs -I@ bash -c 'mv @ $new_subdirectory/'
```

Find all the `.nmap` files with open unique (no duplicates) confirmed (non 'service?') tcp services on open ports, sorted alphabetically file
```bash
find . -type f -name *.nmap -exec cat {} + | grep "/tcp" | sort -u | awk '{print $3}' | sort -u | grep -v '?\|[0-9]'
```

The me-special replace the spell mistake across multiple files of a similar format  
```bash
find . -type f -name *-insertfile-format-identifer-here* | grep -r -e 'Your Mistake' | awk -F: '{print $1}' | xargs -I {} sed 's/Your Mistake/A correction beware of the usage of symbols with sed rtfm/g' -i {}
```

## String One-Line

Print all but the first field with awk
```bash
awk '{for (i=2; i<=NF; i++) printf $i " "; print $NF}'
```

## Line by line make a file

This is useful in scenarios where you want to copy and paste into your favourite editor, but you just have `echo` 
```bash
cat $file | awk '{print "echo \""$1" "$2"\" >> $output" }'
```

##  Grab References from a Markdown File

May require some editing post also consider adding `sed`
```bash
cat $file.md| grep -r '](' | awk -F\) '{print $1")"}' | awk -F: '{print $2$3}'
```

## Replace case of each first letter of each word

From [Stackoverflow uppercasing first letter of words using sed](https://stackoverflow.com/questions/1538676/uppercasing-first-letter-of-words-using-sed)
```bash
# Replace all the first letter with the corresponding uppercase letter 
sed -e "s/\b\(.\)/\u\1/g"
# Replace all the first letter with the corresponding lowercase letter 
sed -e "s/\b\(.\)/\l\1/g"
```

## Finding 

Single line and remove unwanted with `grep -v` a list unwanted files or directories or patterns with to delimiter `\|`
```bash
ls -1 | grep -v '$unwantdir\|proc'
```

Create bash variables from sequence, useful in using `awk`
```bash
for i in {1..10}; do echo "\"\$$i\" "; done | tr -d '\n'
# returns "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10"
```

All the exploit for the same version number - beware the `grep` [[Grep-All-The-Things]]
```bash
searchsploit $service | grep $aGoodGrepIsRequired | awk -F\| '{print $2}' | xargs -I {} searchsploit -m {}
```

For a list of domains find the total amount of a domain in a access.log file - [THM AdventOfCyber2023](https://tryhackme.com/room/adventofcyber2023)
```bash
for i in $(cat domain.txt); do echo "$(grep -ciE $i access.log) $i "; done
# To count the domain include in file by times attempted to access:
cut -d ' ' -f3 access.log | cut -d ':' -f1 | sort | uniq -c | sort -nr
```

## Git

For directory full of repository update them all  
```bash
for i in $(ls -1); do cd $i/; git pull; wait; cd ../; done
```

## References

[Stackoverflow uppercasing first letter of words using sed](https://stackoverflow.com/questions/1538676/uppercasing-first-letter-of-words-using-sed)
[THM AdventOfCyber2023](https://tryhackme.com/room/adventofcyber2023)