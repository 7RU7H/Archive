# Neo4j-And-Bloodhound Guide

**Beware the bugs! - Git clone bloodhound and sharphound**

## Startup:

### Per shell session start with
```bash
ulimit -n 40000 
# THEN
sudo neo4j console
# THEN goto localhost:7474
```
Default credentials
USER: neo4j
PASS: neo4j

## SharpHound
[Sharphound](https://github.com/BloodHoundAD/BloodHound/tree/master/Collectors) is the collector that gathers all the information about the network and compresses it into a zip file. You can then import this data and view a map of the AD domain. This very import to see weak points like DCsyncs, Usernames, Trusts. Given compatibility best to get the newest version, replace `v1.0.4` if required.

```bash
cd /tmp; curl https://github.com/BloodHoundAD/SharpHound/releases/download/v1.0.4/SharpHound-v1.0.4.zip -oL SharpHound.zip
```

- Sharphound.ps1 = Powershell - good for AV evasion as it is loaded in memory, but is unmaintained 
- Sharphound.exe 
- Azurehound.ps1 = for Microsoft Azure


```powershell
.\SharpHound.exe -c all
```

```batch
Sharphound.exe --CollectionMethods <Methods> --Domain <domain> --ExcludeDCs
```

## Bloodhound
[For detailed official documentation](https://bloodhound.readthedocs.io/en/latest/data-analysis/bloodhound-gui.html)

Beware importanting data is stored and retain after exiting. Comply with data protection and any data destruction policies, but also if you don't want to get confused by any old data - `Database Info -> Scroll to the bottom of the list -> Clear Database`.

```bash
bloodhound --no-sandbox
```

## Getting the most out of the Visualisation 

1. Change the Layout! - Why? - Because you want to escalate or move laterally, viewing the network in both ways can help when the graph is very dense with information
	- Directed Graphs have a direction, showing connections in linear chain
	- Hierarchical Graph show nestings within Heirarchies, showing connection via Privilege
2. Drag stuff around! - Why? - Because Bloodhound does not optimise the positioning
3. Click the Edges! - Why? Because the edges in some queries provide exploitation methodology
4. Use Filters - Why? At some point you just want to display very specific information, filters, filters, filters. 

## Node Info
-   **Overview** - Provides summaries information such as the number of active sessions the account has and if it can reach high-value targets.  
-   **Node Properties** - Shows information regarding the AD account. 
-   **Extra Properties** - Provides more detailed AD information.
-   **Group Membership** - Shows information regarding the groups that the account is a member of.  
-   **Local Admin Rights** - Provides information on domain-joined hosts where the account has administrative privileges.  
-   **Execution Rights** - Provides information on special privileges.  
-   **Outbound Control Rights** - Shows information regarding AD objects where this account has permissions to modify their attributes.  
-   **Inbound Control Rights** -  Provides information regarding AD objects that can modify the attributes of this account.


## Mapping the Pwnable Path to DC
Things to do
1. Enter username owned -> `Right Click Node -> Mark User as Owned`
1. Explore Queries
1. `Right Click <connection between two nodes> -> Abuse Info` (Abuse Info uses Powerview)

Useful place to start from experience:
2. Show Path from Kerberoastable
3. Shortest Path from Owned Principals - Show nested group policy of pwned account


## References
[Docs](https://bloodhound.readthedocs.io/en/latest/data-analysis/bloodhound-gui.html)