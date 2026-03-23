# Steghide

Install
```bash
sudo pacman -S steghide # Arch AUR btw !!
sudo apt install steghide # Ubuntu/Linux Mint
```

Limitations being [websites.umass.edu steghide](https://websites.umass.edu/Techbytes/tag/steghide/) *"limited amount of ‘cover’ files – JPEG, BMP, WAV, and AU."* **Authorial opinion**: at least webp is not for the sake of all Malware Analysts' blood pressures.

Embedding a file example
```bash
# Quietly, force and without embedding meta data use steghide to 
steghide embed -ef $file_to_embed.txt -cf $cover_file -p "passphrases are better than passwords" -z $1_to_9_compression_levels -e rijndael-256 -f -K -q
```


Usage:
```bash
steghide
steghide version 0.5.1

the first argument must be one of the following:
 embed, --embed          embed data
 extract, --extract      extract data
 info, --info            display information about a cover- or stego-file
   info <filename>       display information about <filename>
 encinfo, --encinfo      display a list of supported encryption algorithms
 version, --version      display version information
 license, --license      display steghide\'s license
 help, --help            display this usage information

embedding options:
 -ef, --embedfile        select file to be embedded
   -ef <filename>        embed the file <filename>
 -cf, --coverfile        select cover-file
   -cf <filename>        embed into the file <filename>
 -p, --passphrase        specify passphrase
   -p <passphrase>       use <passphrase> to embed data
 -sf, --stegofile        select stego file
   -sf <filename>        write result to <filename> instead of cover-file
 -e, --encryption        select encryption parameters
   -e <a>[<m>]|<m>[<a>]  specify an encryption algorithm and/or mode
   -e none               do not encrypt data before embedding
 -z, --compress          compress data before embedding (default)
   -z <l>                 using level <l> (1 best speed...9 best compression)
 -Z, --dontcompress      do not compress data before embedding
 -K, --nochecksum        do not embed crc32 checksum of embedded data
 -N, --dontembedname     do not embed the name of the original file
 -f, --force             overwrite existing files
 -q, --quiet             suppress information messages
 -v, --verbose           display detailed information

extracting options:
 -sf, --stegofile        select stego file
   -sf <filename>        extract data from <filename>
 -p, --passphrase        specify passphrase
   -p <passphrase>       use <passphrase> to extract data
 -xf, --extractfile      select file name for extracted data
   -xf <filename>        write the extracted data to <filename>
 -f, --force             overwrite existing files
 -q, --quiet             suppress information messages
 -v, --verbose           display detailed information

options for the info command:
 -p, --passphrase        specify passphrase
   -p <passphrase>       use <passphrase> to get info about embedded data

To embed emb.txt in cvr.jpg: steghide embed -cf cvr.jpg -ef emb.txt
To extract embedded data from stg.jpg: steghide extract -sf stg.jpg
```

2024 implemented algorithms for `-e` flag  (I have yet to find a way to pick a specific mode)
```bash
steghide encinfo
encryption algorithms:
<algorithm>: <supported modes>...
cast-128: cbc cfb ctr ecb ncfb nofb ofb
gost: cbc cfb ctr ecb ncfb nofb ofb
rijndael-128: cbc cfb ctr ecb ncfb nofb ofb
twofish: cbc cfb ctr ecb ncfb nofb ofb
arcfour: stream
cast-256: cbc cfb ctr ecb ncfb nofb ofb
loki97: cbc cfb ctr ecb ncfb nofb ofb
rijndael-192: cbc cfb ctr ecb ncfb nofb ofb
saferplus: cbc cfb ctr ecb ncfb nofb ofb
wake: stream
des: cbc cfb ctr ecb ncfb nofb ofb
rijndael-256: cbc cfb ctr ecb ncfb nofb ofb
serpent: cbc cfb ctr ecb ncfb nofb ofb
xtea: cbc cfb ctr ecb ncfb nofb ofb
blowfish: cbc cfb ctr ecb ncfb nofb ofb
enigma: stream
rc2: cbc cfb ctr ecb ncfb nofb ofb
tripledes: cbc cfb ctr ecb ncfb nofb ofb
```

[websites.umass.edu steghide](https://websites.umass.edu/Techbytes/tag/steghide/)  article recommend `shred` to destroy message file
```bash
shred -z msg.pdf
#  to delete it automatically
shred -zu msg.pdf
```

#### References

[websites.umass.edu steghide](https://websites.umass.edu/Techbytes/tag/steghide/) 
[Medium arpit arora article](https://medium.com/@ece11106.sbit/steghide-tool-ec74edd69de4)