# Neo4j-And-Bloodhound Guide

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
[Sharphound](https://github.com/BloodHoundAD/BloodHound/tree/master/Collectors) is the collector that gathers all the information about the 
network and compresses it into a zip file. You can then import this data and view a map of the AD domain. This very import to see weak points like DCsyncs, Usernames, Trusts. Given compatibility best to get the newest version, replace `v1.0.4` if required.

```bash
cd /tmp; curl https://github.com/BloodHoundAD/SharpHound/releases/download/v1.0.4/SharpHound-v1.0.4.zip -oL SharpHound.zip
```

```powershell
.\SharpHound.exe -c all
```

## Bloodhound
```bash
bloodhound --no-sandbox
```


## Mapping the Pwnable Path to DC
Things to do
1. Enter username owned -> `Right Click Node -> Mark User as Owned`
1. Explore Queries
1. `Right Click <connection between two nodes> -> Abuse Info` (Abuse Info uses Powerview)

Useful place to start from experience:
2. Show Path from Kerberoastable
3. Shortest Path from Owned Principals - Show nested group policy of pwned account
