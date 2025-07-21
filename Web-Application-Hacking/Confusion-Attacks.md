# Confusion Attacks


Confusion Attacks, coined by [Orange Tsai blog: Confusion Attacks: Exploiting Hidden Semantic Ambiguity in Apache HTTP Server!](https://blog.orange.tw/posts/2024-08-confusion-attacks-en/) also presented at [Black Hat USA 2024](https://www.blackhat.com/us-24/briefings/schedule/index.html#confusion-attacks-exploiting-hidden-semantic-ambiguity-in-apache-http-server-pre-recorded-40227) 

Apache-Httpd is a large modularised implementation of a web server. The scale of this modularisation has over time led to differences in ... data 
#### Filename Confusion

**Truncation**: *"`r->filename` should represent a filesystem path, however, in Apache HTTP Server, some modules treat it as a URL."* - [Orange Tsai blog; Confusion Attacks: Filename Confusion](https://blog.orange.tw/posts/2024-08-confusion-attacks-en/#%F0%9F%94%A5-1-Filename-Confusion). This example given being from `mod_rewrite` module *"**while rewriting the target paths, `mod_rewrite` forcefully treats all results as a URL**, truncating the path after a question mark `%3F`"*
- Path truncation 
- Mislead RewriteFlag Assignment

**ACL Bypass**: *"the authentication and access control bypass is caused by the inconsistent semantic of `r->filename` among the modules"*. This example given being from `mod_proxy` module, importantly the issues araise from *"different components interact — especially the case when most modules by default treat the `r->filename` as a filesystem path*".

*A classic example is when sysadmins use the `Files` directive to restrict a single file,* but then have the default PHP-FPM installed. The proxy module `SetHandler` directive can then bypass the file directive..  and *"since the backend receives the filename in a strange format, PHP-FPM has to handle this behaviour specially"*; Organe Tsai real world GitHub examples where Files directive have been used and can be bypassed:
- `phpinfo()`
- `.htaccess`
- `xmlrpc.php`
- CLI tools preventing access

#### `DocumentRoot` Confusion

[Orange Tsai blog; Confusion Attacks: DocumentRoot Confusion](https://blog.orange.tw/posts/2024-08-confusion-attacks-en/#%F0%9F%94%A5-2-DocumentRoot-Confusion)
#### Handler Confusion

## References

[Orange Tsai blog: Confusion Attacks: Exploiting Hidden Semantic Ambiguity in Apache HTTP Server!](https://blog.orange.tw/posts/2024-08-confusion-attacks-en/)
[Black Hat USA 2024 presentation](https://www.blackhat.com/us-24/briefings/schedule/index.html#confusion-attacks-exploiting-hidden-semantic-ambiguity-in-apache-http-server-pre-recorded-40227)