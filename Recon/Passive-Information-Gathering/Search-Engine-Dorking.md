# Search-Engine Dorking/Hacking

Defined as the use of search strings and operators to refine search results. [Exploitdb has a Google Hacking Database of clever searches](https://www.exploit-db.com/google-hacking-database)

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

## References
[Wiki](https://en.wikipedia.org/wiki/Google_hacking)
[DuckDuckGo Search Syntax](https://help.duckduckgo.com/duckduckgo-help-pages/results/syntax/)
[Google's Refine web searches](https://support.google.com/websearch/answer/2466433)
[Google's Advanced Search](https://www.google.com/advanced_search)
[Bing's Advanced Search Options](https://support.microsoft.com/en-us/topic/advanced-search-options-b92e25f1-0085-4271-bdf9-14aaea720930)
[THM Red Team Recon](https://tryhackme.com/room/redteamrecon)
[Exploit-db 's google-hacking-database](https://www.exploit-db.com/google-hacking-database)