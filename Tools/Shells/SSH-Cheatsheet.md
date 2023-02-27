# SSH Cheatsheet


## SSH Client Escape Sequences

[Sans Using the SSH "Konami Code" (SSH Control Sequences) by Jeff McJunkin](https://www.sans.org/blog/using-the-ssh-konami-code-ssh-control-sequences/)

```bash
# Note that escapes are only recognized immediately after newline
~. # terminate connection (and any multiplexed sessions)_
~B # send a BREAK to the remote system_
~C # open a command line_
~R # request rekey_
~V/v # decrease/increase verbosity (LogLevel)_
~^Z # suspend ssh_
~# # list forwarded connections_
~& # background ssh (when waiting for connections to terminate)_
~? # this message_
~~ # send the escape character by typing it twice_

```

For other tunnelling and port redirection see [[Port-Redirection-And-Tunneling]]:
```bash
# A = Attacker, B = Pivot host, C = Server

# Remote Port Forwarding
# A 3389 -> B -> 3389 C
ssh attacker@1.1.1.1 -R 3389:3.3.3.3:3389 -N
# Local Port Forwarding
# A 80 <- B 80 <- C
ssh attacker@1.1.1.1 -L *:80:127.0.0.1:80 -N
# Dynamic Port Forwarding and SOCKS
# Do not rely on Windows Hosting an SSH server!
# In the /etc/proxychain* file
[ProxyList]
socks4  127.0.0.1 9050
# SSH back to your machine start a client to proxifier with matching port in the proxychains* file 
ssh tunneluser@1.1.1.1 -R 9050 -N
proxychains <commands go here> # beware of some tool not work through or are very slow as a result of proxying traffic through a socks proxy

```

sshfs is a util that uses FUSE and SSH to mount a remote directory as a local one. 
```bash
apt-get install sshfs # debian
brew install sshfs # mac osx
yum install fuse-sshfs # red hat
pacman -S sshfs # arch

sshfs user@remotehost: /remotedir localdir
```


## References

[Ippsec Video, ~C and references Sans Konami](https://www.youtube.com/watch?v=eojA9k4px-8)
[Sans Using the SSH "Konami Code" (SSH Control Sequences) by Jeff McJunkin](https://www.sans.org/blog/using-the-ssh-konami-code-ssh-control-sequences/)
