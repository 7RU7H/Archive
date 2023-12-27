# SaltStack

[Salt / SaltStack](https://en.wikipedia.org/wiki/Salt_(software)) *is a Python-based, [open-source software](https://en.wikipedia.org/wiki/Open-source_software "Open-source software") for event-driven IT automation, remote task execution, and [configuration management](https://en.wikipedia.org/wiki/Configuration_management)* ...uses *the [ZeroMQ](https://en.wikipedia.org/wiki/ZeroMQ "ZeroMQ") messaging library to facilitate the high-speed requirements and built Salt using [ZeroMQ](https://docs.saltproject.io/en/latest/topics/transports/zeromq.html) for all networking layers.*

[Firewall port](https://docs.saltproject.io/en/latest/topics/tutorials/firewall.html)
TCP port 4506 is the master 
TCP port 4505 is the slave  

[ZeroMQ](https://en.wikipedia.org/wiki/ZeroMQ) is a message library and version 2.0 is vulnerable to a RCE. [hackerone: *"pre 2.1 is vulnerable to fuzzing attacks"*](https://hackerone.com/reports/477073). ZeroMQ ZMTP 2.0 has a [packet storm metasploit module](https://packetstormsecurity.com/files/157678/SaltStack-Salt-Master-Minion-Unauthenticated-Remote-Code-Execution.html) for the SaltStack. 

## References

[Firewall port](https://docs.saltproject.io/en/latest/topics/tutorials/firewall.html)
[Wikipedia Salt / SaltStack](https://en.wikipedia.org/wiki/Salt_(software))
[ZeroMQ](https://docs.saltproject.io/en/latest/topics/transports/zeromq.html) 
[Hackerone Report 477073](https://hackerone.com/reports/477073).
[Packet storm - metasploit module](https://packetstormsecurity.com/files/157678/SaltStack-Salt-Master-Minion-Unauthenticated-Remote-Code-Execution.html)