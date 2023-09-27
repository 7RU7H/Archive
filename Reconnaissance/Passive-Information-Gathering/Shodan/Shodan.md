# Shodan

I am too poor for shodan, one day this section will be full of cool stuff.


The below are apparently powerful shodan queries discuss in the Nahamsec2023 convention talk: [The Power of Shodan: Leveraging Shodan for Critical Vulnerabilities | @GodFatherOrwa](https://www.youtube.com/watch?v=WgMGLlpznao)
```python
# Domains by ssl
ssl."$organisationName"

# by specific hostname
ssl.cert.subject.CN "$hostname"
-> dropdown http title

ssl.cert.subject.CN http.title "Invalid URL"
```

## References

[The Power of Shodan: Leveraging Shodan for Critical Vulnerabilities | @GodFatherOrwa](https://www.youtube.com/watch?v=WgMGLlpznao)