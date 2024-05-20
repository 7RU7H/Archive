# Cloudfare


[CloudFlare Bypass](https://github.com/Anorov/cloudflare-scrape) - [John Hammond's CTF katana](https://github.com/JohnHammond/ctf-katana)
```python
#!/usr/bin/env python

import cfscrape

url = 'http://yashit.tech/tryharder/'

scraper = cfscrape.create_scraper()
print scraper.get(url).content
```

## References

[CloudFlare Bypass](https://github.com/Anorov/cloudflare-scrape)
[John Hammond's CTF katana](https://github.com/JohnHammond/ctf-katana)