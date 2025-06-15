# JSON

Reading JSON on the command in a smart way requires [[JQ]]

Extract field with `jq` - [Ipsec.rocks](https://ippsec.rocks)
```bash
jq '.[] | "\(.password) \(.user)"'
```


## .json to Pydantic Conversion

[jsontopydantic](https://jsontopydantic.com/) is a online tool: *JSON to Pydantic is a tool that lets you convert JSON objects into Pydantic models. [JSON](https://www.json.org/json-en.html) is the de-facto data interchange format of the internet, and [Pydantic](https://pydantic-docs.helpmanual.io/) is a library that makes parsing JSON in Python a breeze.?*

## References

[Ippsec.rocks](https://ippsec.rocks)
[jsontopydantic](https://jsontopydantic.com/)