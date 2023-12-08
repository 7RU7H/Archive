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

 Perl command injection
```perl
# function is vulnerable and can be used to execute commands
open() 
# For example
open(“| shutdown -r |”)
```

## References

[haax.fr perl](https://cheatsheet.haax.fr/linux-systems/programing-languages/perl/)