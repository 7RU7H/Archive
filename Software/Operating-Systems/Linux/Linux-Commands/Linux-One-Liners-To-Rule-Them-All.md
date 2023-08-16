# Linux-One-Liners-To-Rule-Them-All

Incoming watching of talk "One-Liners-To-Rule-Them-All"

## File System One-Liners

Make a new sub-directory putting all current directory into that new directory 
```bash
mkdir $new_subdirectory | ls | grep -v $new_subdirectory | tr -S '\n' ' ' | xargs -I@ bash -c 'mv @ $new_subdirectory/'
```

Find all the .nmap  files with open unique (no duplicates) confirmed (non 'service?') tcp services on open ports, sorted alphabetally file
```bash
find . -type f -name *.nmap -exec cat {} + | grep "/tcp" | sort -u | awk '{print $3}' | sort -u | grep -v '?\|[0-9]'
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

May require some editting post also consider adding `sed`
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

```bash
ls -1 | grep -v '$unwantdir\|proc'
```

Create bash variables from sequence, useful in using `awk`
```bash
for i in {1..10}; do echo "\"\$$i\" "; done | tr -d '\n'
# returns "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10"
```


## References

[Stackoverflow uppercasing first letter of words using sed](https://stackoverflow.com/questions/1538676/uppercasing-first-letter-of-words-using-sed)