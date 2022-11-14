# Server Side Template Injection
*Server-side template injection is a vulnerability where the attacker injects malicious input into a template in order  
to execute commands on the server.*

Template engines create static template files for reuse in an application used to display dynamically generated content on a web page. They replace variables inside a template file with actual dynamic values for a client. Insecure implementation of a template engine leads to this vulnerablity.

![](sttimethod.png)

## Identification Process

`{SSTI}` ->  Accept OR Error

First: `${7*7}`  or `#{7*7}`

Accept | Error
--- | ---
Int	| String		
`{{7*7}}` | `a{*comment*}b`

If Int then `{{7*7}}`:

Accept | Error
--- | ---
`{{7*'7'}}` | Not Vulnerable

If `{{7*7}}` and `{{7*'7'}}`  then:

Accept | Error
--- | ---
Jinja2, Twig | Unknown

If String then `a{*comment*}b`:

Accept | Error
--- | ---
Smarty | `${"z".join("ab")}`


If String Error then `${"z".join("ab")}`:

Accept | Error
--- | ---
Mako | Unknown

```bash
${7*7}
{{7*7}}
a{*comment*}b
{{7*'7'}}
${"z".join("ab")}
```

Some other payloads
```
${}
{{}}
<%= %>
${7/0}
{{7/0}}
<%= 7/0 %>
${foobar}
{{foobar}}
<%= foobar %>
${7*7}
{{7*7}}
#{7*7}
```


## Payloads
[PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings//tree/master/Server Side Template Injection)

## References
[THM room](https://tryhackme.com/room/learnssti)
[flask/jinja2](https://medium.com/@nyomanpradipta120/ssti-in-flask-jinja2-20b068fdaeee)
[pequalsnp](https://pequalsnp-team.github.io/cheatsheet/flask-jinja2-ssti)
[jayaye15](https://jayaye15.medium.com/jinja2-server-side-template-injection-ssti-9e209a6bbdf6)