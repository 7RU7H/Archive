
```bash
whatweb -a 3 $ip
```



## Usage 

```bash
WhatWeb - Next generation web scanner version 0.5.5.
Developed by Andrew Horton (urbanadventurer) and Brendan Coles (bcoles).
Homepage: https://www.morningstarsecurity.com/research/whatweb

Usage: whatweb [options] <URLs>

TARGET SELECTION:
  <TARGETs>                     Enter URLs, hostnames, IP addresses, filenames or
                                IP ranges in CIDR, x.x.x-x, or x.x.x.x-x.x.x.x
                                format.
  --input-file=FILE, -i         Read targets from a file. You can pipe
                                hostnames or URLs directly with -i /dev/stdin.

TARGET MODIFICATION:
  --url-prefix                  Add a prefix to target URLs.
  --url-suffix                  Add a suffix to target URLs.
  --url-pattern                 Insert the targets into a URL.
                                e.g. example.com/%insert%/robots.txt

AGGRESSION:
The aggression level controls the trade-off between speed/stealth and
reliability.
  --aggression, -a=LEVEL        Set the aggression level. Default: 1.
  1. Stealthy                   Makes one HTTP request per target and also
                                follows redirects.
  3. Aggressive                 If a level 1 plugin is matched, additional
                                requests will be made.
  4. Heavy                      Makes a lot of HTTP requests per target. URLs
                                from all plugins are attempted.

HTTP OPTIONS:
  --user-agent, -U=AGENT        Identify as AGENT instead of WhatWeb/0.5.5.
  --header, -H                  Add an HTTP header. eg "Foo:Bar". Specifying a
                                default header will replace it. Specifying an
                                empty value, e.g. "User-Agent:" will remove it.
  --follow-redirect=WHEN        Control when to follow redirects. WHEN may be
                                `never', `http-only', `meta-only', `same-site',
                                or `always'. Default: always.
  --max-redirects=NUM           Maximum number of redirects. Default: 10.

AUTHENTICATION:
  --user, -u=<user:password>    HTTP basic authentication.
  --cookie, -c=COOKIES          Use cookies, e.g. 'name=value; name2=value2'.
  --cookie-jar=FILE             Read cookies from a file.

PROXY:
  --proxy                       <hostname[:port]> Set proxy hostname and port.
                                Default: 8080.
  --proxy-user                  <username:password> Set proxy user and password.

PLUGINS:
  --list-plugins, -l            List all plugins.
  --info-plugins, -I=[SEARCH]   List all plugins with detailed information.
                                Optionally search with keywords in a comma
                                delimited list.
  --search-plugins=STRING       Search plugins for a keyword.
  --plugins, -p=LIST            Select plugins. LIST is a comma delimited set
                                of selected plugins. Default is all.
                                Each element can be a directory, file or plugin
                                name and can optionally have a modifier, +/-.
                                Examples: +/tmp/moo.rb,+/tmp/foo.rb
                                title,md5,+./plugins-disabled/
                                ./plugins-disabled,-md5
                                -p + is a shortcut for -p +plugins-disabled.
  --grep, -g=STRING|REGEXP      Search for STRING or a Regular Expression. Shows
                                only the results that match.
                                Examples: --grep "hello"
                                --grep "/he[l]*o/"
  --custom-plugin=DEFINITION    Define a custom plugin named Custom-Plugin,
                                Examples: ":text=>'powered by abc'"
                                ":version=>/powered[ ]?by ab[0-9]/"
                                ":ghdb=>'intitle:abc \"powered by abc\"'"
                                ":md5=>'8666257030b94d3bdb46e05945f60b42'"
                                "{:text=>'powered by abc'}"
  --dorks=PLUGIN                List Google dorks for the selected plugin.

OUTPUT:
  --verbose, -v                 Verbose output includes plugin descriptions.
                                Use twice for debugging.
  --colour,--color=WHEN         control whether colour is used. WHEN may be
                                `never', `always', or `auto'.
  --quiet, -q                   Do not display brief logging to STDOUT.
  --no-errors                   Suppress error messages.

LOGGING:
  --log-brief=FILE              Log brief, one-line output.
  --log-verbose=FILE            Log verbose output.
  --log-errors=FILE             Log errors.
  --log-xml=FILE                Log XML format.
  --log-json=FILE               Log JSON format.
  --log-sql=FILE                Log SQL INSERT statements.
  --log-sql-create=FILE         Create SQL database tables.
  --log-json-verbose=FILE       Log JSON Verbose format.
  --log-magictree=FILE          Log MagicTree XML format.
  --log-object=FILE             Log Ruby object inspection format.
  --log-mongo-database          Name of the MongoDB database.
  --log-mongo-collection        Name of the MongoDB collection.
                                Default: whatweb.
  --log-mongo-host              MongoDB hostname or IP address.
                                Default: 0.0.0.0.
  --log-mongo-username          MongoDB username. Default: nil.
  --log-mongo-password          MongoDB password. Default: nil.
  --log-elastic-index           Name of the index to store results. Default: whatweb
  --log-elastic-host            Host:port of the elastic http interface. Default: 127.0.0.1:9200

PERFORMANCE & STABILITY:
  --max-threads, -t             Number of simultaneous threads. Default: 25.
  --open-timeout                Time in seconds. Default: 15.
  --read-timeout                Time in seconds. Default: 30.
  --wait=SECONDS                Wait SECONDS between connections.
                                This is useful when using a single thread.

HELP & MISCELLANEOUS:
  --short-help                  Short usage help.
  --help, -h                    Complete usage help.
  --debug                       Raise errors in plugins.
  --version                     Display version information.

EXAMPLE USAGE:
* Scan example.com.
  ./whatweb example.com

* Scan reddit.com slashdot.org with verbose plugin descriptions.
  ./whatweb -v reddit.com slashdot.org

* An aggressive scan of wired.com detects the exact version of WordPress.
  ./whatweb -a 3 www.wired.com

* Scan the local network quickly and suppress errors.
  whatweb --no-errors 192.168.0.0/24

* Scan the local network for https websites.
  whatweb --no-errors --url-prefix https:// 192.168.0.0/24

* Scan for crossdomain policies in the Alexa Top 1000.
  ./whatweb -i plugin-development/alexa-top-100.txt \
  --url-suffix /crossdomain.xml -p crossdomain_xml


```