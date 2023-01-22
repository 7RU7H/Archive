
Wordlists are often a stumbling point for beginners, as a resource it is easy to overlook the importance of refining the ways to getting the most out of list making and lists given the disconnect between CTFs (for good reason) and the real world. In the Web Bug Bounty sphere it seems that this is mostly a solved problem as it is a requirement to finding the servers hosting the applications that have bugs in massive organisations. Unfortunately much of that community is very secretive for obvious reasons, but the methods are not really and generally with Bug Bounty it about going the next few logicl steps beyond the defaults and the expected average. 

This article covers password, email and subdomain wordlists generation, collection, curation, manipulation techniques and tools as well as the default list publicly avaliable. 

This very work in progress. - And will probably segment out by password, subdomain and email and anything else.

This will be the case till I dredge up old resources, work through my own methodology and watch some more talks, etc.


## Default Lists

Although default list are sometime enough they can often provide a base dictionary of *"most historically successful"*

[Assetnote.Wordlists](https://github.com/assetnote/wordlists)
[Assetnote.io](https://wordlists.assetnote.io/)

## Collection and Curation Tooling

With all collection comes the requirement for curation, both in collecting too much just to ensure scope of collection is wide enough to obtain the words that are potential most relevant, but also curating to remove excessive additions, duplicates, format standardisation, etc. For the former task there are many great maintained tools online and for the latter there is alot that can be done with the CLI and/or a scripting language like Python or Ruby; or at speed with Golang strings and strconv libraries.

[[Cewl-Cheatsheet]]


## Permutation

Yassine Aboukir recommends [ripgen](https://github.com/resyncgg/ripgen), a Rust-based high performance domain permutation generator. Also resolves these with [dnsx](https://github.com/projectdiscovery/dnsx) (grabbing the A records, filtering the unnecessary CDNs) and then probes active servers with [httpx](https://github.com/projectdiscovery/httpx). 


## References


[Assetnote.Wordlists](https://github.com/assetnote/wordlists)
[Assetnote.io](https://wordlists.assetnote.io/)

