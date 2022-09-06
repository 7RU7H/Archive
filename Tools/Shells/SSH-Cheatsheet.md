# SSH 


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




For other tunnelling and port redirection see [[Port-Redirection-And-Tunneling]]


## References

[Ippsec Video, ~C and references Sans Konami](https://www.youtube.com/watch?v=eojA9k4px-8)
[Sans Using the SSH "Konami Code" (SSH Control Sequences) by Jeff McJunkin](https://www.sans.org/blog/using-the-ssh-konami-code-ssh-control-sequences/)
