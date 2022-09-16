# Responder Cheatsheet




```bash
responder -I $IFACE
```

## Get hashes from Responder.db
On Kali 
```bash
/usr/share/responder
sqlite3 Responder.db
```

```sql
select * from responder
select type,fullhash
```




## References

