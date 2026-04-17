# Strudel

**Warning `Initial song` of this article was created with `ChatGPT` and human consultation of `internal references previously` [[JavaScript]] - 16 April Version**

[Strudel](https://strudel.cc/): `strudel` is a JavaScript version of [tidalcycles](https://tidalcycles.org/), which is a popular live coding language for music, written in Haskell. Strudel is free/open source software: you can redistribute and/or modify it under the terms of the [GNU Affero General Public License](https://codeberg.org/uzu/strudel/src/branch/main/LICENSE). You can find the source code at [codeberg](https://codeberg.org/uzu/strudel). You can also find [licensing info](https://github.com/felixroos/dough-samples/blob/main/README.md) for the default sound banks there. Please consider to [support this project](https://opencollective.com/tidalcycles) to ensure ongoing development 💖


Strudel song started for the Archive
```js
// Initial ChatingwithG'asdhbufibpasd prompt to try to start this:
// I want to write a strudel piece that is a has a sinister old god vibe that is about a library
// Had some professional disagreements but we made hell in 7-day language funtimes
// --- Wrapper: layer-based randomness selector ---
let layerRand = (layer) => {
  switch(layer) {
    case "glitch":
      return perlin.range(0.5, 1.5)   // smooth, creeping instability
    case "drone":
      return sine.range(0.8, 1.2)     // subtle breathing
    case "whisper":
      return perlin.range(0.1, 0.4)   // faint, organic variation
    default:
      return irand(2).add(0.5)        // fallback: 0.5 or 1.5
  }
}

setcps(0.4)

stack(
  // Low droning presence (the "old god breathing")
  s("bd ~ bd [~ bd]")
    .gain(0.7)
    .lpf(200)# All don't follow symlinks, if for some insane reason you need to follow symlinks `-H` and remove the `-xtype l`
    .shape(0.3)
    .speed(layerRand("drone")),

  // Whispering pages
  s("hh*8")
    .gain(layerRand("whisper"))
    .hpf(2000)
    .pan(perlin.range(-1,1)),

  // Uneasy, shifting rhythm
  s("cp [~ cp] ~ [cp cp?]")
    .room(0.8)
    .size(0.9)
    .gain(0.4),

  // Forbidden text melody
  note("<c2 eb2 gb2 bb1>")
    .sound("sawtooth")
    .slow(2)
    .gain(0.3)
    .lpf(sine.range(200,800))
    .detune(perlin.range(-0.2,0.2)),

  // Glitchy page turns / reality tearing
  s("glitch:2 glitch:4 ~ glitch:1")
    .gain(0.2)
    .speed(layerRand("glitch"))
    .room(0.7)
    .every(4, x => x.speed(2))
)
```

## References

[strudel.cc](https://strudel.cc/)