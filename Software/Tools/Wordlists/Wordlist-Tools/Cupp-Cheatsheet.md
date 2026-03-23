# Cupp Cheatsheet

Common User Passwords Profiler (CUPP) is Python 3 application for wordlist generation focus on password generation. With user input can aid in password profiling for a user with  `-i`. Modify a wordlist with `-w` or parse user and passwords directly from Alecto DB "*Project Alecto uses purified databases of Phenoelit and CIRT which were merged and enhanced*. Authorial advise would be to not do that. Primarily dorking of what Alecto is came up with nothing so until proven otherwise - avoid. 

```bash
   cupp.py!                 # Common
      \                     # User
       \   ,__,             # Passwords
        \  (oo)____         # Profiler
           (__)    )\
              ||--|| *      [ Muris Kurgas | j0rgan@remote-exploit.org ]
                            [ Mebus | https://github.com/Mebus/]

usage: cupp.py [-h] [-i | -w FILENAME | -l | -a | -v] [-q]

Common User Passwords Profiler

options:
  -h, --help         show this help message and exit
  -i, --interactive  Interactive questions for user password profiling
  -w FILENAME        Use this option to improve existing dictionary, or WyD.pl output to make some pwnsauce
  -l                 Download huge wordlists from repository
  -a                 Parse default usernames and passwords directly from Alecto DB. Project Alecto uses purified databases of Phenoelit and CIRT which were merged and enhanced
  -v, --version      Show the version of this program.
  -q, --quiet        Quiet mode (don't print banner)
```

## References

[CUPP github](https://github.com/Mebus/cupp)