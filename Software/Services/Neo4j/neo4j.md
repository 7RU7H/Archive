# neo4j


Per shell session start with
```bash
ulimit -n 40000 # increase history
# THEN
sudo neo4j console
# THEN goto localhost:7474
```
Default credentials
- `USER: neo4j`
- `PASS: neo4j`
[neo4j.com/docs Change Password](https://neo4j.com/docs/operations-manual/current/configuration/password-and-user-recovery/)


Also it can be run with [[Docker]] - [notes.vulndev.io/wiki/redteam/misc/tools](https://notes.vulndev.io/wiki/redteam/misc/tools)
```
docker run --env NEO4J_AUTH=neo4j/xct -p7687:7687 neo4j
```



## References

[neo4j.com/docs Change Password](https://neo4j.com/docs/operations-manual/current/configuration/password-and-user-recovery/)
[notes.vulndev.io/wiki/redteam/misc/tools](https://notes.vulndev.io/wiki/redteam/misc/tools)