# TODO

Intel Assembly Instructions
Regexs
Attacking Kerberos
put this somewhere:
https://highon.coffee/blog/penetration-testing-tools-cheat-sheet/
https://github.com/adon90/pentest_compilation
https://github.com/rewardone/OSCPRepo

Battlegrounds

Assimilate: at ftp
https://github.com/pythonmaster41/Go-For-OSCP

ffuf/wfuzz 
httpx-toolkit
https://github.com/frohoff/ysoserial

windows-concept simplified and more concise

update and improve https://github.com/ihack4falafel/OSCP/blob/master/Documents/SQL%20Injection%20Cheatsheet.md

make a go version [source](https://github.com/ihack4falafel/OSCP/blob/master/BASH/CronJobChecker.sh_
```bash
#!/bin/bash

#---------------------------------------------------------------------------------#

# Name = Cron Job Checker #

# Author = @ihack4falafel #

# Date = 12/16/2017 #

# Reference = https://www.youtube.com/watch?v=K9DKULxSBK4 #

# Usage = chmod +x CronJobChecker.sh && ./CronJobChecker.sh #

#---------------------------------------------------------------------------------#

IFS=$'\n'

# Check list of running processes

old_proc=$(ps -eo command)

# Look for newly created processes

while true; do

new_proc=$(ps -eo command)

diff <(echo "$old_proc") <(echo "$new_proc") | grep [\<\>]

sleep 1

old_proc=$new_proc

done
```

