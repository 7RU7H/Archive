# Configuring Apache 2

The `apache2` package is disable by default, but a default package for Kali. It is a modular server with external module providing function after being loaded during initialization of apache. These module create  or delete symbolic links in `/etc/apache2/mods-enabled/`, pointing at the actual files (stored in `/etc/apache2/mods-available/`).
```bash
systemctl start apache2
as2enmod _module_ # enable new module
asdismod module # disable module
a2ensite www.domain.com # enable a virtual host
```

Useful modules: 
-  [Full list of standard Apache modules](https://httpd.apache.org/docs/2.4/mod/index.html)
- `libapache-mod-php` - PHP module 
- `ssl` - SSL for HTTPS configured `/etc/apache2/sites-available/default-ssl.conf`
	- See [Apache SSL configuration documentation](https://httpd.apache.org/docs/2.4/mod/mod_ssl.html)

Default configuration:
- Listen on port 80 - configured `/etc/apache2/ports.conf`
- Serves pages from `/var/www/html` - configured `/etc/apache2/sites-enabled/000-default.conf`
Virtual Hosting

Default configuration of for Apache 2 enables name-based virtual hosts, defined in `/etc/apache2/sites-enabled/000-default.conf`. **Be aware**: requests concerning unknown virtual hosts will always be served by the first defined virtual host, which is why the package ships a `000-default.conf` configuration file, which is sorted first among all other files that you might create. Each additional virtual host is described by a file stored in `/etc/apache2/sites-available/`, as `.conf`. Minimal configuration example: 

## Vhosting

Virtual host files stored at: `/srv/$virtualhost-domainname/www/`, defined with the `DocumentRoot` option:
```
<VirtualHost *:80>
ServerName www.kali.org
ServerAlias kali.org
DocumentRoot /srv/www.kali.org/www
</VirtualHost>
```
The above is an example of a miminal configuration of of a few `Directory` blocks, each specifying different behaviours for the server depending of the location the location of the file being served.
```
<Directory /var/www>
Options Includes FollowSymLinks
AllowOverride All
DirectoryIndex index.php index.html index.htm
</Directory>
```
Interactions between `AllOveride` and `Options` directives, also some various `Options` directives. For [CustomLog and ErrorLog Directives](https://httpd.apache.org/docs/2.4/logs.html) follow the link.
-  `AllowOverride All` overrides all but `MultiView`
-  `AllowOverride None` - Disable all options
-   `Options ExecCGI` - indicates that CGI scripts can be executed.
-   `Options FollowSymLinks` - Symbolic links can be followed.
-   `Options SymLinksIfOwnerMatch` - To follow symbolic links, but only when the link and its target have the same owner.
-   `Options Includes` - enables _Server Side Includes_ (SSI). These are directives embedded in HTML pages and executed on the fly for each request.
-   `Options Indexes` - tells the server to list the contents of a directory if the HTTP request sent by the client points to a directory without an index file (that is, when no files mentioned by the `DirectoryIndex` directive exist in this directory).
-   `Options MultiViews` - enables content negotiation; e.i return a web page matching the preferred language as configured in the browser.

## Authentication and Restricting Access
The `.htaccess` contains Apache configuration directives. It has recursive scope to all subdirectories so that any and every request of an element of  the location of the `.htaccess` file (and subdirectories) will be subject to any authenication configurations in the file. Most of the directives that can occur in a `Directory` block are also legal in an `.htaccess` file, comonly restrict `ExecCGI` to restrict program ran by uisers under the web server's identity `www-data`. The `AllowOverride` directive lists all the options that can be enabled or disabled by way of `.htaccess`. `Basic` `AuthType` means no security, **do not use it** - plain text passwords and  protected documents.  
```
Require valid-user
AuthName "Private directory"
AuthType Basic
AuthUserFile /etc/apache2/authfiles/htpasswd-private
```
The `/etc/apache2/authfiles/htpasswd-private` file contains a list of users and passwords, use `htpasswd` to manipulate this file.

The `Require` directive controls access restrictions for a directory recursively. `RequireAll` block with serveral `Require ip $ip` or `Require $X-criteria` is more effective.