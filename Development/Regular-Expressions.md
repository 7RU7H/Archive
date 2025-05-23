# Regular Expressions

## Introduction

Regular Expressions shortened to regex or regexp and sometimes referred to a rational expressions are sequences of characters that specifies a pattern. This pattern is used to match with pattern in [string searching algorithms](https://en.wikipedia.org/wiki/String-searching_algorithm)   to perform operations on those strings or for input validation. The concept of regular expressions began in the 1950s, when the American mathematician [Stephen Cole Kleene](https://en.wikipedia.org/wiki/Stephen_Cole_Kleene "Stephen Cole Kleene") formalised the concept of a [regular language](https://en.wikipedia.org/wiki/Regular_language "Regular language"). [This free THM room is awesome highly recommended](https://tryhackme.com/room/catregex). It is design for the practical and *reading lazy* types. Massive thanks to [concatenate](https://tryhackme.com/p/concatenate)

Online editor are helpful resource, much like online code editors when you need to run some piece of code without install an entire language to a system. In no particular order:
- [[CyberChef]] - (options are set to false for readers choice not by default) `https://gchq.github.io/CyberChef/#recipe=Regular_expression('User%20defined','',false,false,false,false,false,false,'Highlight%20matches')`
- https://regex101.com/
- [https://regexr.com/](https://regexr.com/)

## Bypassing and Mitigation of Bypasses of Regex-Based Security Controls

[BugCrowd RegExp Article](https://www.bugcrowd.com/blog/how-to-regex-a-practical-guide-to-regular-expressions-regex-for-hackers/): *"it is generally recommended that using regex for input validation is **avoided** in favour of allowlists where possible"*. A simple list of what is allowed or not allowed is easier to Administrate and avoids creating nullspace of the regex's scope, which is where bypasses are located.

## Regular Language

A reminder for myself more than anything - use `egrep`
```bash
egrep OPTIONS 'PATTERNS' FILE # Just use egrep for regex 
```

Defining Patterns
```bash
'^[PATTERN]{}$' # define and encapsulate an entire line with ^ and $ in single quotes
^[ <charset is defined  enclosed in square brackets> ]$ # define charset
[a-zA-Z] # Dash '-' define a range, like all lowcase and uppercase chracters

# Excluding characters
# Not to be confused with outside of square brackets, which match "starting with"
[^] # Exclude ^; must be enclosed with square brackets 
[^a] # Exclude lowercase a

# Matching Single Characters
. # Wildcard Single Match except line break
[\.] # Escaping dot for matching dots 
a.c # Will match aac, abc, a@c

# Optional Single Characters

? # Optional single character  
acb? # Will match ab and abc

# Meta Characters
# Some binaries do not use metacharacters
\d # matches a digit
\D # matches a non-digit
\w # matches a alphanumeric - includes: _
\W # matches a non-alphanumeric characters - does not include: _  
\s # matches a whitespace character (space, tabs, and line breaks)
\S # matches everything else (alphanumeric characters and symbols)

# Repetitions
{} # Match many characters of a single type in a row 
{10} # exactly 10 times
{1,10} # 1 to 10 times
{5,} # 5 or more times
* # 0 or more times
+ # 1 or more times

# Starting with 
# Must be outside of square brackets else it will be consider as exclude single character 
^PATTERN # start with character

# Ending with
# Must be inside of square brackets else it will be consider as exclude single character 
PATTERN$ # ends with character

# Grouping
( )
(regex){10} # match  the pattern: regexregexregexregexregex
# Either Left or Right
[abc] | [def]


# Lookaheads and Lookbehinds
?= # Positive lookahead           
?! # Negative lookahead          
?<= # Positive lookbehind          
<! # Negative lookbehind         ?
# Not to be confused with
(?:PATTERN) # Non-captureing

# Positive Lookbehind
# This is modified from BugCrowd Article 
(?=< check for before rest of expression and match >)< rest of expression >
# Negative Lookabehind
(?<! check for before rest of expression but do not match >)< rest of expression >
```

## Helpful Regexes

For  >= 8 character containing atleast one of each: uppercase letter, lowercase letter and digits

```c
(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/)
```

Find the URLs both [[HTTP]] and [[HTTPS]], optional `www.`
```c
^http(s)?://(www)?.+\..+
```

Remove protocol, paths and parameters from a URL from [BugCrowd RegExp Article](https://www.bugcrowd.com/blog/how-to-regex-a-practical-guide-to-regular-expressions-regex-for-hackers/)
```bash
cat urls.txt | grep -P (?<=://)(?i)[a-z,.]*

cat urls.txt | pcregrep -o '(?<=://)(?i)[a-z,.]*'
```

Match any day of the week with a case insensitive first letter from [BugCrowd RegExp Article](https://www.bugcrowd.com/blog/how-to-regex-a-practical-guide-to-regular-expressions-regex-for-hackers/)
```c
(?i)(Mon|Tues|Wednes|Thurs|Fri|Satur|Sun)day
```

Is a number a prime regex - [noulakaz](https://www.noulakaz.net/2007/03/18/a-regular-expression-to-check-for-prime-numbers/)
```perl
# Perl
/^1?$|^(11+?)\1+$/
```


## References

[THM Room Catregex](https://tryhackme.com/room/catregex)
[https://regexr.com/](https://regexr.com/)
https://regex101.com/
[Regex Wiki](https://en.wikipedia.org/wiki/Regular_expression)
[Wikipedia String Searching Algorithms](https://en.wikipedia.org/wiki/String-searching_algorithm)  
[noulakaz](https://www.noulakaz.net/2007/03/18/a-regular-expression-to-check-for-prime-numbers/)
[BugCrowd RegExp Article](https://www.bugcrowd.com/blog/how-to-regex-a-practical-guide-to-regular-expressions-regex-for-hackers/)
[regextutorial.org Regex Tutorial](https://regextutorial.org/)