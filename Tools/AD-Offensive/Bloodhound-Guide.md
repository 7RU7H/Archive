# Bloodhound Guide

# Considerations...

- **Beware the bugs! - Git clone bloodhound and sharphound**
- **BloodHound  is awesome but sometimes manually parsing data with JQ can net passwords** 
	-  [[JQ]] improvements from [Manually Parse Bloodhound Data with JQ to Create Lists of Potentially Vulnerable Users and Computers](https://www.youtube.com/watch?v=o3W4H0UfDmQ)


## Getting the most out of the visualisation 

Change `Settings -> Edge Label Display & Node Label Display -> [both] to Always Display`, may improve infomation visibility, but that may require reconfiguration in dense graphs - larger networks displayed in graph format by bloodhound.

- Bloodhound Debug mode to show Cipher Query
`Settings -> Tick Debug Mode`

1. Change the Layout! - Why? - Because you want to escalate or move laterally, viewing the network in both ways can help when the graph is very dense with information
	- Directed Graphs have a direction, showing connections in linear chain
	- Hierarchical Graph show nestings within Heirarchies, showing connection via Privilege
2. Drag stuff around! - Why? - Because Bloodhound does not optimise the positioning
3. Click the Edges! - Why? Because the edges in some queries provide exploitation methodology
4. Use Filters - Why? At some point you just want to display very specific information, filters, filters, filters. 

#### Node Info
-   **Overview** - Provides summaries information such as the number of active sessions the account has and if it can reach high-value targets.  
-   **Node Properties** - Shows information regarding the AD account. 
-   **Extra Properties** - Provides more detailed AD information.
-   **Group Membership** - Shows information regarding the groups that the account is a member of.  
-   **Local Admin Rights** - Provides information on domain-joined hosts where the account has administrative privileges.  
-   **Execution Rights** - Provides information on special privileges.  
-   **Outbound Control Rights** - Shows information regarding AD objects where this account has permissions to modify their attributes.  
-   **Inbound Control Rights** -  Provides information regarding AD objects that can modify the attributes of this account.


#### Mapping the Pwnable Path to DC
Things to do
1. Enter username owned -> `Right Click Node -> Mark User as Owned`
1. Explore Queries
1. `Right Click <connection between two nodes> -> Abuse Info` (Abuse Info uses Powerview)

Useful place to start from experience:
2. Show Path from Kerberoastable
3. Shortest Path from Owned Principals - Show nested group policy of pwned account

#### Custom Queries

Bloodhound query - `Click -> "Create Custom Query" in the Analysis tab in Bloodhound`


```js
// Which machine accounts have administrative permissions over another
MATCH p=(c1:Computer)-[r1:MemberOf*1..]->(g:Group)-[r2:AdminTo]->(n:Computer) RETURN p
```



## SharpHound

[Sharphound](https://github.com/BloodHoundAD/BloodHound/tree/master/Collectors) is the collector that gathers all the information about the network and compresses it into a zip file. You can then import this data and view a map of the AD domain. This very import to see weak points like DCsyncs, Usernames, Trusts. Given compatibility best to get the newest version, replace `v1.0.4` if required.

[Flangvik/SharpCollection](https://github.com/Flangvik/SharpCollection) is  a github repo that contains ..*"
Nightly builds of common C# offensive tools, fresh from their respective master branches built and released in a CDI fashion using Azure DevOps release pipelines."* containing sharphound at the various dot net versions


```bash
cd /tmp; curl https://github.com/BloodHoundAD/SharpHound/releases/download/v1.0.4/SharpHound-v1.0.4.zip -oL SharpHound.zip
```

- Sharphound.ps1 = Powershell - good for AV evasion as it is loaded in memory, but is unmaintained 
- Sharphound.exe 
- Azurehound.ps1 = for Microsoft Azure

```powershell
.\SharpHound.exe -c all
SharpHound.exe -c DCOnly
# dc only is pretty quiet comparitive to all, all will try out-of-scope machine, all machines in the domain..
# Do not spawn SharpHound binary, common Alert 
--NoSaveCache 
```

```batch
Sharphound.exe --CollectionMethods <Methods> --Domain <domain> --ExcludeDCs
```

Remote, Non Domain-Joined - Beware Windows Security!
```powershell
# configure DNS
notepad %SYSTEMROOT%\System32\drivers\etc\hosts
# Start a shell in user context of compromised account locally
runas /netonly /user:$domain\$user cmd.exe
# Run SharpHound.exe
.\SharpHound.exe -c all -d $domain --DomainController $DC_IP
```
[Ippsec Active](https://www.youtube.com/watch?v=jUc1J31DNdw)

## FoxIt Remote Python 

[Python Ingestor](https://github.com/fox-it/BloodHound.py)

```bash
python3 bloodhound.py -c all -dc dc01.domain.com -u <users> -p <password> -ns $IP
```

```bash
python3 bloodhound.py --dns-tcp -c all -d domain.tld -ns 10.10.10.10 -u $compromisedUser -p 'password'
```


## BloodHound

[For detailed official documentation](https://bloodhound.readthedocs.io/en/latest/data-analysis/bloodhound-gui.html)

Start neo4j with enough history not to tank and die.
```bash
ulimit -n 40000 # increase history
# THEN
sudo neo4j console
# THEN goto localhost:7474
```
For more [[Neo4j]] related information follow the link

Beware importanting data is stored and retain after exiting. Comply with data protection and any data destruction policies, but also if you don't want to get confused by any old data - `Database Info -> Scroll to the bottom of the list -> Clear Database`.

```bash
bloodhound --no-sandbox
```

## References

[Docs](https://bloodhound.readthedocs.io/en/latest/data-analysis/bloodhound-gui.html)
[Ippsec Active](https://www.youtube.com/watch?v=jUc1J31DNdw)
[For detailed official documentation](https://bloodhound.readthedocs.io/en/latest/data-analysis/bloodhound-gui.html)
[Python Ingestor](https://github.com/fox-it/BloodHound.py)
[Sharphound](https://github.com/BloodHoundAD/BloodHound/tree/master/Collectors)
[Flangvik/SharpCollection](https://github.com/Flangvik/SharpCollection) 
[Ippsec: Manually Parse Bloodhound Data with JQ to Create Lists of Potentially Vulnerable Users and Computers](https://www.youtube.com/watch?v=o3W4H0UfDmQ)