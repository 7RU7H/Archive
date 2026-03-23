# Cewl

*"CeWL (Custom Word List generator) is a ruby app which spiders a given URL, up to a specified depth, and returns a list of words which can then be used for password crackers such as John the Ripper. Optionally, CeWL can follow external links."* [Kali tools](https://www.kali.org/tools/cewl/)
```bash
# To spider a site and write all words to a file
cewl -w <file> <url>

# To spider a site and follow links to other sites

cewl -o <url>

# To spider a site with user-agent
cewl -u <user-agent> <url>

# To spider a site for a given depth and minimum word length
cewl -d <depth> -m <min word length> <url>

# Get all alphanumeric words with a minimum length of 8
cewl -m 8 --with-numbers <url>

# To spider a site and include a count for each word
cewl -c <url>

# To spider a site inluding meta data and separate the meta_data words
cewl -a -meta_file <file> <url>

# To spider a site and store email adresses in a separate file
cewl -e -email_file <file> <url>
```

If an auth page is present, the list above might not work properly, try to bypass the auth by specifying username and password, encrypted auth:
```bash
cewl https://example.com/login.php --auth_type digest --auth_user <admin> --auth_pass <password>
```

Try to bypass the auth by specifying username and password, base64 auth
```bash
cewl http://example.com/login.php --auth_type basic --auth_user <admin> --auth_pass <password>
```

## Usage

```bash
CeWL 5.5.2 (Grouping) Robin Wood (robin@digi.ninja) (https://digi.ninja/)
Usage: cewl [OPTIONS] ... <url>

    OPTIONS:
        -h, --help: Show help.
        -k, --keep: Keep the downloaded file.
        -d <x>,--depth <x>: Depth to spider to, default 2.
        -m, --min_word_length: Minimum word length, default 3.
        -o, --offsite: Let the spider visit other sites.
        --exclude: A file containing a list of paths to exclude
        --allowed: A regex pattern that path must match to be followed
        -w, --write: Write the output to the file.
        -u, --ua <agent>: User agent to send.
        -n, --no-words: Don't output the wordlist.
        -g <x>, --groups <x>: Return groups of words as well
        --lowercase: Lowercase all parsed words
        --with-numbers: Accept words with numbers in as well as just letters
        --convert-umlauts: Convert common ISO-8859-1 (Latin-1) umlauts (ä-ae, ö-oe, ü-ue, ß-ss)
        -a, --meta: include meta data.
        --meta_file file: Output file for meta data.
        -e, --email: Include email addresses.
        --email_file <file>: Output file for email addresses.
        --meta-temp-dir <dir>: The temporary directory used by exiftool when parsing files, default /tmp.
        -c, --count: Show the count for each word found.
        -v, --verbose: Verbose.
        --debug: Extra debug information.

        Authentication
        --auth_type: Digest or basic.
        --auth_user: Authentication username.
        --auth_pass: Authentication password.

        Proxy Support
        --proxy_host: Proxy host.
        --proxy_port: Proxy port, default 8080.
        --proxy_username: Username for proxy, if required.
        --proxy_password: Password for proxy, if required.

        Headers
        --header, -H: In format name:value - can pass multiple.

    <url>: The site to spider.
```

## References

[kali tools](https://www.kali.org/tools/cewl/)
[adrewjkerr](https://github.com/andrewjkerr/security-cheatsheets/blob/master/cewl)
[PAvOps](https://github.com/PAvOps/Cheatsheets/blob/master/cewl)
[mivang](https://github.com/mivang/cheatsheets/blob/master/cewl)
[gopye](https://github.com/gopye/Cheatsheets/blob/master/cewl)