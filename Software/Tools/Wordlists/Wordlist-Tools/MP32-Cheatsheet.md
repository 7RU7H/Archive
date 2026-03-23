# MP32 Cheatsheet

MP32 is a *"High-Performance word generator with a per-position configurable charset*"

Examples
```bash
mp32 --custom-charset1='!@#$%^' password?d?1 >> mp32-passwd.lst
```

Usage:
```bash
Usage: mp32 [options]... mask

* Startup:

  -V,  --version             Print version
  -h,  --help                Print help

* Increment:

  -i,  --increment=NUM:NUM   Enable increment mode. 1st NUM=start, 2nd NUM=stop
                             Example: -i 4:8 searches lengths 4-8 (inclusive)

* Misc:

       --combinations        Calculate number of combinations
       --hex-charset         Assume charset is given in hex
  -q,  --seq-max=NUM         Maximum number of multiple sequential characters
  -r,  --occurrence-max=NUM  Maximum number of occurrence of a character

* Resources:

  -s,  --start-at=WORD       Start at specific position
  -l,  --stop-at=WORD        Stop at specific position

* Files:

  -o,  --output-file=FILE    Output-file

* Custom charsets:

  -1,  --custom-charset1=CS  User-defineable charsets
  -2,  --custom-charset2=CS  Example:
  -3,  --custom-charset3=CS  --custom-charset1=?dabcdef
  -4,  --custom-charset4=CS  sets charset ?1 to 0123456789abcdef

* Built-in charsets:

  ?l = abcdefghijklmnopqrstuvwxyz
  ?u = ABCDEFGHIJKLMNOPQRSTUVWXYZ
  ?d = 0123456789
  ?s =  !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
  ?a = ?l?u?d?s
  ?b = 0x00 - 0xff
```