# Perl

Executing command line perl scripting requires `-e` flag for executing, without drop to a perl environment that does not save to a file:
```bash
perl -e 'your perl goes here'
perl
...
```

Perl scripts require the file extension .pl and can be executed from the command line like other script lanaguages with its own command `perl`
```bash
perl script.pl
```

Linux Script shebang line
```bash
#!/usr/bin/perl
# Then from command line
./script.pl
```