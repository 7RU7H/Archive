# Hijacking Remote Technology Repositories


An example given in the [THM OWASP top 10 2021 updated room](https://tryhackme.com/room/owasptop102021) is that of remotely calling a library remotely instead of locally, with out validating origin or download 
```html
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
```

The remediation:
- [Subresource Integrity (SRI)](https://www.srihash.org/) to create a SRI hash
```html
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
```

## References

[THM OWASP top 10 2021 updated room](https://tryhackme.com/room/owasptop102021)
[Subresource Integrity (SRI)](https://www.srihash.org/)