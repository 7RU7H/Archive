# Rust

[I am not affiliated with Rust organization, btw.](https://docs.google.com/forms/d/e/1FAIpQLSdaM4pdWFsLJ8GHIUFIhepuq0lfTg_b0mJ-hvwPdHa4UTRaAg/viewform)
## Installation and Maintenance

Linux install
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Updating
```bash
rustup update
```

The `rustc`, `cargo`, `rustup` tools are installed to the `~/.cargo/bin`. Beware that `rustup` attempts to configure your `PATH` variable, you may need to set it if it fails. To uninstall  use: `rustup self uninstall`.

## Building Projects

Check cargo version with `cargo --version`
1. Initialise with `cargo init` - if there is no .toml file
1. Build your project with `cargo build`
1. Run your project with `cargo run` 
1. Test your project with `cargo test`
1. Build documentation for your project with `cargo doc`
1. Publish a library to [crates.io](https://crates.io) with `cargo publish`
## Online Tools and Resources

https://play.rust-lang.org/ - awesome online compiler

[The Rust Programming Language](https://doc.rust-lang.org/book/#the-rust-programming-language)

[Rust for Windows, and the *windows* crate](https://learn.microsoft.com/en-us/windows/dev-environment/rust/rust-for-windows)

Noted locally [[TALK-Rust-Fundamentals-for-InfoSec]] 

[jimmychu0807's Gistfor Conversion between String, str, Vec\<u8\>, Vec\<char\> in Rust ](https://gist.githubusercontent.com/jimmychu0807/9a89355e642afad0d2aeda52e6ad2424/raw/4b31997c0bf3602dcd5be258dc7eb6b7db78e4e7/string-conversion.rs) - very useful as you will be doing this alot, because...
```rust
use std::str;

fn main() {
  // -- FROM: vec of chars --
  let src1: Vec<char> = vec!['j','{','"','i','m','m','y','"','}'];
  // to String
  let string1: String = src1.iter().collect::<String>();
  // to str
  let str1: &str = &src1.iter().collect::<String>();
  // to vec of byte
  let byte1: Vec<u8> = src1.iter().map(|c| *c as u8).collect::<Vec<_>>();
  println!("Vec<char>:{:?} | String:{:?}, str:{:?}, Vec<u8>:{:?}", src1, string1, str1, byte1);

  // -- FROM: vec of bytes --
  // in rust, this is a slice
  // b - byte, r - raw string, br - byte of raw string
  let src2: Vec<u8> = br#"e{"ddie"}"#.to_vec();
  // to String
  // from_utf8 consume the vector of bytes
  let string2: String = String::from_utf8(src2.clone()).unwrap();
  // to str
  let str2: &str = str::from_utf8(&src2).unwrap();
  // to vec of chars
  let char2: Vec<char> = src2.iter().map(|b| *b as char).collect::<Vec<_>>();
  println!("Vec<u8>:{:?} | String:{:?}, str:{:?}, Vec<char>:{:?}", src2, string2, str2, char2);

  // -- FROM: String --
  let src3: String = String::from(r#"o{"livia"}"#);
  let str3: &str = &src3;
  let char3: Vec<char> = src3.chars().collect::<Vec<_>>();
  let byte3: Vec<u8> = src3.as_bytes().to_vec();
  println!("String:{:?} | str:{:?}, Vec<char>:{:?}, Vec<u8>:{:?}", src3, str3, char3, byte3);

  // -- FROM: str --
  let src4: &str = r#"g{'race'}"#;
  let string4 = String::from(src4);
  let char4: Vec<char> = src4.chars().collect();
  let byte4: Vec<u8> = src4.as_bytes().to_vec();
  println!("str:{:?} | String:{:?}, Vec<char>:{:?}, Vec<u8>:{:?}", src4, string4, char4, byte4);
}

```
... *"A string slice ( &str ) is made of bytes ( u8 ), and a byte slice ( &\[u8\] ) is made of bytes, so this function converts between the two. Not all byte slices are valid string slices, however: &str requires that it is valid UTF-8. from_utf8() checks to ensure that the bytes are valid UTF-8, and then does the conversion."* - [from_utf8 in std::str - Rust](https://doc.rust-lang.org/std/str/fn.from_utf8.html)
## References

[Rust Trademark Policy Comment Form](https://docs.google.com/forms/d/e/1FAIpQLSdaM4pdWFsLJ8GHIUFIhepuq0lfTg_b0mJ-hvwPdHa4UTRaAg/viewform)
https://play.rust-lang.org/
[The Rust Programming Language](https://doc.rust-lang.org/book/#the-rust-programming-language)
[Rust for Windows, and the *windows* crate](https://learn.microsoft.com/en-us/windows/dev-environment/rust/rust-for-windows)
[Rust Fundamentals for InfoSec w/ Matthew Eidelberg](https://www.youtube.com/watch?v=WOaFrkeszDA)
[jimmychu0807's Gistfor Conversion between String, str, Vec\<u8\>, Vec\<char\> in Rust ](https://gist.githubusercontent.com/jimmychu0807/9a89355e642afad0d2aeda52e6ad2424/raw/4b31997c0bf3602dcd5be258dc7eb6b7db78e4e7/string-conversion.rs) 