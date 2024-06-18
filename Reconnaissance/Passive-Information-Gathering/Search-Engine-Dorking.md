# Search-Engine Dorking



Defined as the use of search strings and operators to refine search results.

Tools to assist 
- [Exploitdb has a Google Hacking Database of clever searches](https://www.exploit-db.com/google-hacking-database)
- https://dorksearch.com/

Google Dorking:
![](refinegooglehacking-tech.png)

DuckDuckGo:
![ddg-dork](Images/ddg-dorking.png)
[DuckDuckGo Search Syntax](https://help.duckduckgo.com/duckduckgo-help-pages/results/syntax/)
[Google's Refine web searches](https://support.google.com/websearch/answer/2466433)
[Google's Advanced Search](https://www.google.com/advanced_search)
[Bing's Advanced Search Options](https://support.microsoft.com/en-us/topic/advanced-search-options-b92e25f1-0085-4271-bdf9-14aaea720930)

## Exploit DB Google Hacking Database
[Exploit-db 's google-hacking-database](https://www.exploit-db.com/google-hacking-database) is powerful community driven database for advanced searches.

-   **Footholds**  
    Consider [GHDB-ID: 6364](https://www.exploit-db.com/ghdb/6364) as it uses the query `intitle:"index of" "nginx.log"` to discover Nginx logs and might reveal server misconfigurations that can be exploited.
-   **Files Containing Usernames**  
    For example, [GHDB-ID: 7047](https://www.exploit-db.com/ghdb/7047) uses the search term `intitle:"index of" "contacts.txt"` to discover files that leak juicy information.
-   **Sensitive Directories**  
    For example, consider [GHDB-ID: 6768](https://www.exploit-db.com/ghdb/6768), which uses the search term `inurl:/certs/server.key` to find out if a private RSA key is exposed.
-   **Web Server Detection**  
    Consider [GHDB-ID: 6876](https://www.exploit-db.com/ghdb/6876), which detects GlassFish Server information using the query `intitle:"GlassFish Server - Server Running"`.
-   **Vulnerable Files**  
    For example, we can try to locate PHP files using the query `intitle:"index of" "*.php"`, as provided by [GHDB-ID: 7786](https://www.exploit-db.com/ghdb/7786).
-   **Vulnerable Servers**  
    For instance, to discover SolarWinds Orion web consoles, [GHDB-ID: 6728](https://www.exploit-db.com/ghdb/6728) uses the query `intext:"user name" intext:"orion core" -solarwinds.com`.
-   **Error Messages**  
    Plenty of useful information can be extracted from error messages. One example is [GHDB-ID: 5963](https://www.exploit-db.com/ghdb/5963), which uses the query `intitle:"index of" errors.log` to find log files related to errors.

from [THM Red Team Recon](https://tryhackme.com/room/redteamrecon)

## Bing

From 2022 Bing became more relevant in the Search Engine. 
From [Advanced search options - support.microsoft.com](https://support.microsoft.com/en-gb/topic/advanced-search-options-b92e25f1-0085-4271-bdf9-14aaea720930):

| Symbol   | Function                                                                                                                                |
| -------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| +        | Finds webpages that contain all the terms that are preceded by the + symbol. Also allows you to include terms that are usually ignored. |
| " "      | Finds the exact words in a phrase.                                                                                                      |
| ()       | Finds or excludes webpages that contain a group of words.                                                                               |
| AND or & | Finds webpages that contain all the terms or phrases.                                                                                   |
| NOT or – | Excludes webpages that contain a term or phrase.                                                                                        |
| OR or \| | Finds webpages that contain either of the terms or phrases.                                                                             |
**Notes:** 

- By default, all searches are AND searches.
- You must capitalize the NOT and OR operators. Otherwise, Bing will ignore them as stop words, which are commonly occurring words and numbers that are omitted to speed a full-text search.
- Stop words and all punctuation marks, except for the symbols noted in this topic, are ignored unless they are surrounded by quotation marks or preceded by the + symbol.
- **Only the first 10 terms are used to get search results.**
- Term grouping and Boolean operators are supported in the following preferred order:
- Because OR is the operator with lowest precedence, enclose OR terms in parentheses when combined with other operators in a search.
- Some features and functionality described here may not be available in your country or region.
1. ()
2. ""
3. NOT – +
4. AND &
5. OR |

From [Advanced search keywords - https://support.microsoft.com](https://support.microsoft.com/en-gb/topic/advanced-search-keywords-ea595928-5d63-4a0b-9c6b-0b769865e78a):

| Keyword                                            | Definition                                                                                                                                                                                                                                                                                                                          | Example                                                                                                                                                                                                                                       |
| -------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| _contains:_                                        | Keeps results focused on sites that have links to the file types that you specify.                                                                                                                                                                                                                                                  | To search for websites that contain links to Windows Media Audio (.wma) files, type music _contains:wma_                                                                                                                                      |
| _ext:_                                             | Returns only webpages with the filename extension that you specify.                                                                                                                                                                                                                                                                 | To find reports created only in DOCX format, type your subject, followed by _ext:docx_.                                                                                                                                                       |
| _filetype:_                                        | Returns only webpages created in the file type that you specify.                                                                                                                                                                                                                                                                    | To find reports created in PDF format, type your subject, followed by _filetype:pdf_.                                                                                                                                                         |
| _inanchor:_   <br>or _inbody:_   <br>or _intitle:_ | These keywords return webpages that contain the specified term in the metadata, such as the anchor, body, or title of the site, respectively. Specify only one term per keyword. You can string multiple keyword entries as needed.                                                                                                 | To find webpages that contain “msn” in the anchor, and the terms “spaces” and “magog” in the body, type _inanchor:msn inbody:spaces inbody:magog._                                                                                            |
| _ip:_                                              | Finds sites that are hosted by a specific IP address. The IP address must be a dotted quad address. Type the _ip:_ keyword, followed by the IP address of the website                                                                                                                                                               | Type _IP:207.46.249.252._                                                                                                                                                                                                                     |
| _language:_                                        | Returns webpages for a specific language. Specify the language code directly after the language: keyword.                                                                                                                                                                                                                           | To see webpages only in English about antiques, type "antiques" _language:en_.                                                                                                                                                                |
| _loc:_   <br>or _location:_                        | Returns webpages from a specific country or region. Specify the country or region code directly after the loc: keyword. To focus on two or more languages, use a logical _OR_ to group the languages.                                                                                                                               | To see webpages about sculpture from the U.S. or Great Britain, type sculpture (_loc:US OR loc:GB_). For a list of language codes that you can use with Bing, see Country, region, and language codes.                                        |
| _prefer:_                                          | Adds emphasis to a search term or another operator to help focus the search results.                                                                                                                                                                                                                                                | To find results about football but that primarily pertain to the organization, type football _prefer:_organization.                                                                                                                           |
| _site:_                                            | Returns webpages that belong to the specified site. To focus on two or more domains, use a logical OR to group the domains. You can use site: to search for web domains, top level domains, and directories that are not more than two levels deep. You can also search for webpages that contain a specific search word on a site. | To see webpages about heart disease from the BBC or CNN websites, type "heart disease" (site:bbc.co.uk OR site:cnn.com). To find webpages about the PC version of Halo on the Microsoft website, type _site:www.microsoft.com/games/pc halo_. |
| _feed:_                                            | Finds RSS or Atom feeds on a website for the terms you search for.                                                                                                                                                                                                                                                                  | To find RSS or Atom feeds about football, type _feed:football_.                                                                                                                                                                               |
| hasfeed:                                           | Finds webpages that contain an RSS or Atom feed on a website for the terms you search for.                                                                                                                                                                                                                                          | To find webpages on the New York Times website that contain RSS or Atom feeds, type _site:www.nytimes.com hasfeed:football_.                                                                                                                  |
| url:                                               | Checks whether the listed domain or web address is in the Bing index.                                                                                                                                                                                                                                                               | To verify that the Microsoft domain is in the index, type _url:microsoft.com_.                                                                                                                                                                |

**Notes:** 
- Don't include a space after the colon in these keywords.
- Some features and functionality described here may not be available in your country or region.

[Olga Zarr blog](https://seosly.com/blog/bing-search-operators/#define) claims these also are keywords and wildcards work
define:
domain:
imagesize:
`*` as wildcard - this seems to work

## Others

- Use “`ext:php`” and “`inurl:?`” along with the domain to find `.php` files with a question mark in the url
- Disclosed Bugs
	- `site:openbugbounty.org inurl:reports intext:"yahoo.com"`

## Location of Data

- Code left dumped/left on pastebin, jsfiddle, and codebeautify


## References
[Wiki](https://en.wikipedia.org/wiki/Google_hacking)
[DuckDuckGo Search Syntax](https://help.duckduckgo.com/duckduckgo-help-pages/results/syntax/)
[Google's Refine web searches](https://support.google.com/websearch/answer/2466433)
[Google's Advanced Search](https://www.google.com/advanced_search)
[Bing's Advanced Search Options](https://support.microsoft.com/en-us/topic/advanced-search-options-b92e25f1-0085-4271-bdf9-14aaea720930)
[THM Red Team Recon](https://tryhackme.com/room/redteamrecon)
[Exploit-db 's google-hacking-database](https://www.exploit-db.com/google-hacking-database)
[Mike Takahashi 5+ Google Dorks](Use “`ext:php`” and “`inurl:?`” along with the domain to find `.php` files with a question mark in the url:)
[Advanced search options - support.microsoft.com](https://support.microsoft.com/en-gb/topic/advanced-search-options-b92e25f1-0085-4271-bdf9-14aaea720930)