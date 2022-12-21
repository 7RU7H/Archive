
# Secure Coding


## Input Validation

Insufficient input validation is a security concern for web applications. [OWASP](https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html) states that secure input validation: *"is performed to ensure only properly formed data is entering the workflow in an information system, preventing malformed data from persisting in the database and triggering malfunction of various downstream components."*

- Input validation should happen as early as possible in the data flow, preferably as soon as the data is received from the external party
- Data from all potentially untrusted sources should be subject to input validation, including not only Internet-facing web clients but also backend feeds over extranets, from [suppliers, partners, vendors or regulators](https://badcyber.com/several-polish-banks-hacked-information-stolen-by-unknown-attackers/), each of which may be compromised on their own 
- Input Validation should not be used as the _primary_ method of preventing [XSS](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html), [SQL Injection](https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html) and other attacks

It should occur at the:
- Syntactic level
	- Enforce correct syntax of structure fields
- Semantic level
	- Enforce correct of value in specific business context 

Implemented:
- Data type validators
- JSON and XML validation of formattings
- Min and Max Range checks - length
- Array of allowed values to check parametre content
- [[Regular-Expressions]] for any other structured data covering the whole input string and not using "any character" wildcard (such as  `.` or `\s`)


#### File uploads

- Secure directory usage
- File Size Validation
- File Extension Validation
- File Content Validation
- Mime Type Validation
- Content Type Validation
- Request type Validation 
- File renaming
- Malware Scanning


#### Vulnerable Database Access Coding

Databases are a different service and require connection to it from another the service. If an attacker were able to read this sourcecode with hard coded credentials would be a enough in some case to not worry about SQLi. Although seeing that th e source code would unlikely be world readable, understanding [[SQLInjection]] requires  understanding how the another services, like a websites or an applications have to connect and then communicate to the database is key to securing and exploit insecure code. Language specific and insecure coding are both the fault of humans and exist regardless of language used here. Below are examples of vulnerable applicdation coding do not use!
```php
$server="db";
$user="logistics_user";
$pwd="somePass123";
$schema="logistics";

$db=mysqli_connect($server,$user,$pwd,$schema);
// Once a connection is made a query can be sent
// Below are examples of vulnerable applicdation coding do not use
$query="select * from users where id=".$_GET['id'];
$elves_rs=mysqli_query($db,$query);
//
$query="select * from toys where name like '%".$_GET['q']."%' or description like '%".$_GET['q']."%'";
$toys_rs=mysqli_query($db,$query);


```
The `$query` variable is a concatenation of the first string and the output of super global function call `$_GET[]`, meaning is adding it together `a + b` becoming `ab` where `b` is appended to `a`. Beware it will concatenate **any** value regardless of the underlying type, syntax, set of characters, etc. With SQLi it is about break the query syntax of the initial query and then fixing it with the your query or in the case above just making addition queries.

Similiarly in C\# a connection is made with `SqlConnection` and then a `SqlCommand` can be then sent while it also requires a `SqlDataReader` reader to read the output and an exception handler `
`SqlException`.
```csharp
using Microsoft.Data.SqlClient;

namespace sqltest
{
    class Program
    {
        static void Main(string[] args)
        {
            try 
            { 
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
                
                builder.DataSource = "<your_server.database.windows.net>"; 
                builder.UserID = "<your_username>";            
                builder.Password = "<your_password>";     
                builder.InitialCatalog = "<your_database>";
         
                using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {
                    Console.WriteLine("\nQuery data example:");
                    Console.WriteLine("=========================================\n");
                    
                    connection.Open();       

                    String sql = "SELECT name, collation_name FROM sys.databases";

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Console.WriteLine("{0} {1}", reader.GetString(0), reader.GetString(1));
                            }
                        }
                    }                    
                }
            }
            catch (SqlException e)
            {
                Console.WriteLine(e.ToString());
            }
            Console.WriteLine("\nDone. Press enter.");
            Console.ReadLine(); 
        }
    }
}
```
[C sharp - insert code to query database](https://learn.microsoft.com/en-us/azure/azure-sql/database/connect-query-dotnet-core?view=azuresql)


Safer integer protections:
```php
$query="select * from users where id=".intval($_GET['id']);
```

Prepared SQL statements - hardcode prepared fields and a statement
```php
$q = "%".$_GET['q']."%";
$query="select * from toys where name like ? or description like ?";
$stmt = mysqli_prepare($db, $query);
mysqli_stmt_bind_param($stmt, 'ss', $q, $q);
mysqli_stmt_execute($stmt);
$toys_rs=mysqli_stmt_get_result($stmt);
```

So what are doing is:
- Replace string values that are queried with `?` - use hardcoded variables to be call inline later in code
- mysqli_prepare() to prepare query
- mysqli_stmt_bind_param to add in our hardcode variables inline as referenced earlier
- mysqli_stmt_execute() and then mysqli_stmt_get_result() rather than query, because we want execute our query and the result request is also hardcode  


## References

[THM AoC 4](https://tryhackme.com/room/adventofcyber4)
[OWASP Input Validation Cheetsheat](https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html)
[Microsoft Learn - C sharp - insert code to query database](https://learn.microsoft.com/en-us/azure/azure-sql/database/connect-query-dotnet-core?view=azuresql)
[InsiderPHD youtube](https://www.youtube.com/@InsiderPhD)