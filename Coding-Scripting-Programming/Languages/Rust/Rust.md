# Useful_Rust

## Installation and Maintance
Linux install

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Updating
```bash
rustup update
```

The rustc, cargo, rustup tools are installed to the `~/.cargo/bin`. Beware that rustup attempts to consider your PATH variable, you may need to set it if it fails. To uninstall  use:`rustup self uninstall`.

## Building Projects

Check cargo version with `cargo --version`
1. build your project with `cargo build`
1. run your project with `cargo run` 
1. test your project with `cargo test`
1. build documentation for your project with `cargo doc`
1. publish a library to [crates.io](https://crates.io) with `cargo publish`

## Online Tool

https://play.rust-lang.org/


[The Rust Programming Language](https://doc.rust-lang.org/book/#the-rust-programming-language)
