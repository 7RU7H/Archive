# Brutespray Cheatsheet
## About
Brute-Forcing from Nmap output - Automatically attempts default credentials on found services.

Created by: Shane Young/@t1d3nio && Jacob Robles/@shellfail

## # Installation
Git clone and `pip install -r requirements.txt`
On Kali: `apt-get install brutespray`

## Uses
Can take an entire network range and its relative open services and try [[Wordlists]] of users `-U` and passwords `-P` or single instances of users `-u` and passwords `-p`.

```bash
python brutespray.py --file nmap.gnmap -u admin -P /usr/share/wordlist/rockyou.txt --threads 5 --hosts 5`
```
For specific services add: `--service ftp,ssh,telnet`

## Usage
```bash
usage: brutespray [-h] [-f FILE] [-o OUTPUT] [-s SERVICE] [-t THREADS] [-T HOSTS] [-U USERLIST] [-P PASSLIST] [-u USERNAME] [-p PASSWORD] [-c] [-i] [-m] [-q]

Usage: python brutespray.py <OPTIONS>

options:
  -h, --help            show this help message and exit

Menu Options:
  -f FILE, --file FILE  GNMAP, JSON or XML file to parse
  -o OUTPUT, --output OUTPUT
                        Directory containing successful attempts
  -s SERVICE, --service SERVICE
                        specify service to attack
  -t THREADS, --threads THREADS
                        number of medusa threads
  -T HOSTS, --hosts HOSTS
                        number of hosts to test concurrently
  -U USERLIST, --userlist USERLIST
                        reference a custom username file
  -P PASSLIST, --passlist PASSLIST
                        reference a custom password file
  -u USERNAME, --username USERNAME
                        specify a single username
  -p PASSWORD, --password PASSWORD
                        specify a single password
  -c, --continuous      keep brute-forcing after success
  -i, --interactive     interactive mode
  -m, --modules         dump a list of available modules to brute
  -q, --quiet           supress banner
```
