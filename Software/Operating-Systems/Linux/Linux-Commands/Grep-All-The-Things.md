# Grep 

```bash

grep -E "" file				# grep expressions in a file [ . =  wildcard][ -i is case insensitive]['*A ' OR '*A' with ws include ws
grep "string" *.txt			# find regular exp in plain text(*=wildcard)
grep -iRl [path/keyword]	# Find files with specific keyword
grep -oi '\S*string\S*' [pathtofile]
grep -n						#output line number
grep -E "" file | wc -l		# if expression 1to1 per line the total lines exp appears on
grep -R						# recursive grep files inside folders
grep -h						# greps recursively in a directory disabling the prefixing of filenames in results
grep -c						# count the pattern
grep -i						# ignore case
grep -l						# list filename containing the pattern
grep -v						# print all lines not containing the pattern
grep -e						# MULTIPLE PATTERNS!
grep -x                     # match whole line

# Useful greps
grep '.conf\|config*'       # Grep x or y
grep -x '.{8,}'

```

[[Regular-Expressions]] for easy text manipulation on the cmdline:
```bash
[exp]EXP		variableMatch inside [] and explicit match outside
(exp)				group
|				exp or exp
-				range
[^]				exclude with [^]
[$]				notExclude with [$] 

ALSO REMEMBER: start and end with if outside of square brackets 

^				starts with
$				ends with
.				wildcard	
\.				wildcard escape character
prevChar?			optional character

\d				matches a digit, like 9
\D 				matches a non-digit, like A or @
\w 				matches an alphanumeric character, like a or 3
\W 				matches a non-alphanumeric character, like ! or #
\s 				matches a whitespace character (spaces, tabs, and line breaks)
\S 				matches everything else (alphanumeric characters and symbols)
{int}				matches a every preceeding character int time
{12} - exactly 12 times.
{1,5} - 1 to 5 times.
{2,} - 2 or more times.
* - 0 or more times.
+ - 1 or more times.
 _ 				are included in the \w metacharacter and not in \W, \w will match every single character
```

`egrep` is `grep -e` in a single command
```bash
egrep -o '' file1 > file2	output th egrep from file1 > file2  
(\d{1,3}\.){3}\d{1,3}		grep every Ipv4 address
"([0-9]{1,3}[\.]){3}[0-9]{1,3}" grep for ip addresses
FGREPING your fixed string inside text:

```
