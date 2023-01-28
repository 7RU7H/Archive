
The [Elastic stack](https://www.elastic.co/elastic-stack/) feature four main components:
1. Elastic Search - full-text search and analytics engine used to store JSON-formated documents; for data also store, analyse, perform correlation on with supported RESTFul API
2. Logstash - data processing engine for apply the `filter` on it or normalizing log data from a `input` source before it sent to another `output` destination - `Input{} Filter{} Output{}`
3. Beats - used to ship/transfer data from endpoints to elasticsearch.
4. Kibana - web-based data visualization GUI

Beats -> Logstash -> Elasticsearch <--> Kibana

#### Discover Tab

Create a Filter
`Add Filters -> Select a field Field -> Operator -> Save`

Search

Time Filter
``

## Securing ELK

See [[Hacking-ELK]]

## References

[THM ELK 101 room](https://tryhackme.com/room/investigatingwithelk101)
[Logz.io Complete Guide to ELK stack](https://logz.io/learn/complete-guide-elk-stack/)
[Wikipedia Elastic Search](https://en.wikipedia.org/wiki/Elasticsearch)
[Elastic Official Documentation]