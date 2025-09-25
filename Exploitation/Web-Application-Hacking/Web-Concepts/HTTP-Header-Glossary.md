# HTTP Header Glossary


#### X

[[Bypassing-Rate-Limits]]

```
X-Forwarded-For: IP
X-Forwarded-Host: IP
X-Client-IP: IP 
X-Remote-IP: IP
X-Remote-Addr: IP
X-Host: IP
```



#### Sec-Fetch-Dest
The **`Sec-Fetch-Dest`** [fetch metadata request header](https://developer.mozilla.org/en-US/docs/Glossary/Fetch_metadata_request_header) indicates the request's _destination_. That is the initiator of the original fetch request, which is where (and how) the fetched data will be used.
```
Sec-Fetch-Dest: audio
Sec-Fetch-Dest: audioworklet
Sec-Fetch-Dest: document
Sec-Fetch-Dest: embed
Sec-Fetch-Dest: empty
Sec-Fetch-Dest: font
Sec-Fetch-Dest: frame
Sec-Fetch-Dest: iframe
Sec-Fetch-Dest: image
Sec-Fetch-Dest: manifest
Sec-Fetch-Dest: object
Sec-Fetch-Dest: paintworklet
Sec-Fetch-Dest: report
Sec-Fetch-Dest: script
Sec-Fetch-Dest: serviceworker
Sec-Fetch-Dest: sharedworker
Sec-Fetch-Dest: style
Sec-Fetch-Dest: track
Sec-Fetch-Dest: video
Sec-Fetch-Dest: worker
Sec-Fetch-Dest: xslt
```

`audio` - The destination is audio data. This might originate from an HTML [`<audio>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio) tag.
`audioworklet` - The destination is data being fetched for use by an audio worklet. This might originate from a call to [`audioWorklet.addModule()`](https://developer.mozilla.org/en-US/docs/Web/API/Worklet/addModule "audioWorklet.addModule()").
`document` - The destination is a document (HTML or XML), and the request is the result of a user-initiated top-level navigation (e.g. resulting from a user clicking a link).
`embed` - The destination is embedded content. This might originate from an HTML [`<embed>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/embed) tag.
`empty` - The destination is the empty string. This is used for destinations that do not have their own value. For example `fetch()`, [`navigator.sendBeacon()`](https://developer.mozilla.org/en-US/docs/Web/API/Navigator/sendBeacon), [`EventSource`](https://developer.mozilla.org/en-US/docs/Web/API/EventSource), [`XMLHttpRequest`](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest), [`WebSocket`](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket), etc.
`font` - The destination is a font. This might originate from CSS [`@font-face`](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face).
`frame` - The destination is a frame. This might originate from an HTML [`<frame>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/frame) tag.
`iframe` - The destination is an iframe. This might originate from an HTML [`<iframe>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe) tag.
`image` - The destination is an image. This might originate from an HTML [`<image>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/image), SVG [`<image>`](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/image), CSS [`background-image`](https://developer.mozilla.org/en-US/docs/Web/CSS/background-image), CSS [`cursor`](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor), CSS [`list-style-image`](https://developer.mozilla.org/en-US/docs/Web/CSS/list-style-image), etc.
`manifest` - The destination is a manifest. This might originate from an HTML [<link rel=manifest>](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types/manifest).
`object` - The destination is an object. This might originate from an HTML [`<object>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/object) tag.
`paintworklet` - The destination is a paint worklet. This might originate from a call to [`CSS.PaintWorklet.addModule()`](https://developer.mozilla.org/en-US/docs/Web/API/Worklet/addModule "CSS.PaintWorklet.addModule()").
`report` - The destination is a report (for example, a content security policy report).
`script` - The destination is a script. This might originate from an HTML [`<script>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script) tag or a call to [`WorkerGlobalScope.importScripts()`](https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalScope/importScripts).
`serviceworker` - The destination is a service worker. This might originate from a call to [`navigator.serviceWorker.register()`](https://developer.mozilla.org/en-US/docs/Web/API/ServiceWorkerContainer/register "navigator.serviceWorker.register()").
`sharedworker` - The destination is a shared worker. This might originate from a [`SharedWorker`](https://developer.mozilla.org/en-US/docs/Web/API/SharedWorker).
`style` - The destination is a style. This might originate from an HTML [<link rel=stylesheet>](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link) or a CSS [`@import`](https://developer.mozilla.org/en-US/docs/Web/CSS/@import).
`track` - The destination is an HTML text track. This might originate from an HTML [`<track>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/track) tag.
`video` - The destination is video data. This might originate from an HTML [`<video>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/video) tag.
`worker` - The destination is a [`Worker`](https://developer.mozilla.org/en-US/docs/Web/API/Worker).
`xslt` - The destination is an XSLT transform.


#### Sec-Fetch-Mode
The **`Sec-Fetch-Mode`** [fetch metadata request header](https://developer.mozilla.org/en-US/docs/Glossary/Fetch_metadata_request_header) indicates the [mode](https://developer.mozilla.org/en-US/docs/Web/API/Request/mode) of the request.
```
Sec-Fetch-Mode: cors # 
Sec-Fetch-Mode: navigate
Sec-Fetch-Mode: no-cors
Sec-Fetch-Mode: same-origin
Sec-Fetch-Mode: websocket
```
`cors` - The request is a [CORS protocol](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) request.
`navigate` - The request is initiated by navigation between HTML documents.
`no-cors` - The request is a no-cors request (see [`Request.mode`](https://developer.mozilla.org/en-US/docs/Web/API/Request/mode#value)).
`same-origin` - The request is made from the same origin as the resource that is being requested.
`websocket` - The request is being made to establish a [WebSocket](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API) connection.


#### Sec-Fetch-Site
The **`Sec-Fetch-Site`** [fetch metadata request header](https://developer.mozilla.org/en-US/docs/Glossary/Fetch_metadata_request_header) indicates the relationship between a request initiator's origin and the origin of the requested resource.
```
Sec-Fetch-Site: cross-site
Sec-Fetch-Site: same-origin
Sec-Fetch-Site: same-site
Sec-Fetch-Site: none
```

`cross-site` - The request initiator and the server hosting the resource have a different site (i.e. a request by "potentially-evil.com" for a resource at "example.com").
`same-origin` - The request initiator and the server hosting the resource have the same [origin](https://developer.mozilla.org/en-US/docs/Glossary/Origin) (same scheme, host and port).
`same-site` - The request initiator and the server hosting the resource have the same scheme, domain and/or subdomain, but not necessarily the same port.
`none` - This request is a user-originated operation. For example: entering a URL into the address bar, opening a bookmark, or dragging-and-dropping a file into the browser window.


#### Sec-Fetch-User

The **`Sec-Fetch-User`** [fetch metadata request header](https://developer.mozilla.org/en-US/docs/Glossary/Fetch_metadata_request_header) is only sent for requests initiated by user activation, and its value will always be `?1`.
```
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: same-origin
Sec-Fetch-User: ?1
```



## References
[Appsec Monkey Fetch-MetaArticle](https://www.appsecmonkey.com/blog/fetch-metadata)
[Mozilla Sec-Fetch-Dest](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Sec-Fetch-Dest)
[Mozilla Sec-Fetch-Mode](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Sec-Fetch-Mode)
[Mozilla Sec-Fetch-User](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Sec-Fetch-User)
