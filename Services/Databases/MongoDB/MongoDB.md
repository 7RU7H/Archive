[MongoDB](https://en.wikipedia.org/wiki/MongoDB) *is a source-available cross-platform document-oriented database program. Classified as a NoSQL database program, MongoDB uses JSON-like documents with optional schemas.*

[[NoSQL-SQLI]]

Quick and easy client
```bash
curl -O https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.4.7.tgz  
tar xvf mongodb-linux-x86_64-3.4.7.tgz  
cd mongodb-linux-x86_64-3.4.7/bin  
./mongo mongodb://$ip:27107
```

#### MongoDB CheatSheet

[0xsyr0's](https://github.com/0xsyr0/OSCP#mongodb) modified OSCP cheatsheet:

```c
mongo "mongodb://localhost:27017"
```

```c
> use <DATABASE>;
> show dbs;
> show tables;
> show collections;
> db.system.keys.find();
> db.users.find();
> db.getUsers();
> db.getUsers({showCredentials: true});
> db.accounts.find();
> db.accounts.find().pretty();
> use admin;
```

User Password Reset to "12345"
```c
> db.getCollection('users').update({username:"admin"}, { $set: {"services" : { "password" : {"bcrypt" : "$2a$10$n9CM8OgInDlwpvjLKLPML.eizXIzLlRtgCh3GRLafOdR9ldAUh/KG" } } } })
```

One-liner locally to access a database and extract database data and print it in [[JSON]]
```bash
# --eval is a script block to evaluate json
mongo --port $port $database --eval "db.admin.find().forEach(printjson);"
```

Make a valid password
```bash
mkpasswd -m $algo Password1234
```

Replace a password
```bash
mongo --port $port $database --eval 'db.admin.update({"_id":  
ObjectId("$objectID")},{$set:{"$password":"$newPasswordHash"}})'
```


## References

[MongoDB documentation](https://www.mongodb.com/docs/)
[Wikipedia MongoDB](https://en.wikipedia.org/wiki/MongoDB)
[0xsyr0 OSCP cheatsheet](https://github.com/0xsyr0/OSCP#mongodb))