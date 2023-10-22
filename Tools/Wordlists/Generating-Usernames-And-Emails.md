# Generating-Usernames-And-Emails

#### Username Generation for Spraying

Ippsec and 0xDF have used [Username Anarchy](https://github.com/urbanadventurer/username-anarchy.git)
```bash
git clone https://github.com/urbanadventurer/username-anarchy.git
ruby username-anarchy/username-anarchy -i $input.txt -f flast,f.last,first.last,last.first > potential-usernames.txt 
```

Alh4zr3d used namemash.py - downed video can't check which
```bash
curl -L https://gist.githubusercontent.com/superkojiman/11076951/raw/74f3de7740acb197ecfa8340d07d3926a95e5d46/namemash.py -o namemash.py
curl -L https://raw.githubusercontent.com/krlsio/python/main/namemash.py -o namemash.py


python3 namemash.py $input.txt > potential-usernames.txt
```

## Email Generation for Spraying

#### Valid and Invalid email Addresses

[cjaoude reformatted Gist](https://gist.github.com/cjaoude/fd9910626629b53c4d25)
Use: for testing against email regex- [ref: http://codefool.tumblr.com/post/15288874550/list-of-valid-and-invalid-email-addresses](http://codefool.tumblr.com/post/15288874550/list-of-valid-and-invalid-email-addresses)
List of Valid Email Addresses
```
email@example.com
firstname.lastname@example.com
email@subdomain.example.com
firstname+lastname@example.com
email@123.123.123.123
email@[123.123.123.123]
"email"@example.com
1234567890@example.com
email@example-one.com
_______@example.com
email@example.name
email@example.museum
email@example.co.jp
firstname-lastname@example.com

```
List of Strange Valid Email Addresses
```
much.”more\ unusual”@example.com
very.unusual.”@”.unusual.com@example.com
very.”(),:;<>[]”.VERY.”very@\\ "very”.unusual@strange.example.com
```
List of Invalid Email Addresses
```
plainaddress
#@%^%#$@#$@#.com
@example.com
Joe Smith <email@example.com>
email.example.com
email@example@example.com
.email@example.com
email.@example.com
email..email@example.com
あいうえお@example.com
email@example.com (Joe Smith)
email@example
email@-example.com
email@example.web
email@111.222.333.44444
email@example..com
Abc..123@example.com
```
List of Strange Invalid Email Addresses
```
”(),:;<>[\]@example.com
just”not”right@example.com
this\ is"really"not\allowed@example.com
```

#### Generating Wordlists of Email Addresses

If we have a list of potential usernames 
```bash
potential-usernames.txt | awk '{print $1"@<domaingoeshere.tld>"}' > potential-email-addresses.txt
# Appended a subsituted `.` for a `-` - remember to change the domain again!
cat potential-email-addr.txt | awk -F@ '{print $1}' | grep '.' | sed 's/\./-/g' | awk '{print $1"@<domaingoeshere.tld>"}' | tee -a potential-email-addr.txt
```

Valid with [[SMTP-Recon-Cheatsheet]] - `smtp-user-enum` from PentestMonkey is a platinum oldie!  ```
```bash
# Enumerate potiental email addresses for valid ones
smtp-user-enum -M VRFY -U potential-email-addresses.txt -t $TargetIP -p $PORT | tee -a  smtp-user-enum-$PORT.out 
# Then make a file of valid emails
cat smtp-user-enum-25.out | grep exists | awk -F: '{print $2}' | sed 's/ exists//g'| tr -d ' ' > valid-emails.txt
```
## References


[cjaoude reformatted Gist](https://gist.github.com/cjaoude/fd9910626629b53c4d25)
[Username Anarchy](https://github.com/urbanadventurer/username-anarchy.git)
[ref: http://codefool.tumblr.com/post/15288874550/list-of-valid-and-invalid-email-addresses](http://codefool.tumblr.com/post/15288874550/list-of-valid-and-invalid-email-addresses)
