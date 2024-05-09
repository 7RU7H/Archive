# Useful_Rust

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

## Rust Fundamentals for InfoSec 

[Rust Fundamentals for InfoSec w/ Matthew Eidelberg](https://www.youtube.com/watch?v=WOaFrkeszDA) excellent Black Hills talk
- Introduction
	- Low level system programming language
	- Can interact directly with hardware
	- Offers
		- Performance
		- Safety
		- Memory Management
		- LLVM Based - can compile to machine op code, which is good for [[Antivirus-Evasion]] and [[EDR-Bypass]]ing
		- Native cross-compatibility - Windows, Linux, OSX 
	- `rustfmt` - format you code!
	- `Clippy` - static analysis for you Rust code while being compiled!	
	- `cargo` - package managers
- Packages
	- Crates
		- Compilation of libraries and executable code in `rust`
		- Facilitates code modularity, re-usability and versioning
		 - Modules
			 - Functions, Types and More..
			 - `WinAPI::UM` for example is modularised
				- `Processsthreadapi` - Module for Windows `processthreads`
				- `Winbase` - Module for Windows Base API
				- `Winnt` - Module defines Window NT types and constants
				- `Memoryapi` - Module for Windows Core Memory
		- All certify modules are documented on [https://docs.rs](https://doc.rs)  
		- Cargo.toml defines 
			- the packages and its dependencies
			- compilation flags
			- author details

Cargo.toml example:
```toml
[package]
name = "syscall"
version = "0.1.0"
edition = "2024"

# https://doc.rust-lang.org/cargo/reference/manifest.html

[dependencies]
libc = "0.2.93"
winapi = {version = "0.3.9", feature =["processthreadapi", "memoryapi", "libloaderapi","psapi","winerror","winbase"] }
rand = "0.8"
ntapi - "0.4.0" 
[dependencies.windows-sys]
version = "0.34.0" 
feeatures = ["Win32_Foundation", "Win32_System_SystemServices", "Win32_System_Memory", "Win32_System_LibraryLoader" ]
compiler_builtins = { version = "0.1.39", optional = true }

```

Rust Code
```bash
# sets up the entire directory tree
cargo new hello
```

```rust
use std::env; // import a sub-module module
use std::fs::{File, write}; // import a multiple functions from submodule
use std::io::Read; 

// crate :: module :: sub-module :: function
winapi::um::memoryapi::VirtualAlloc

fn main() {
	let s1 = String::from("hello");
	let s1 = s1; // s1 is not longer valid after this point -
	// because of Ownership and borrowing 
	println!("{}, world", s2);

}
```

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

Unsafe Flags
- Unsafe Flags can be added to your code:
	- Access raw pointers
	- Manipulating memory directly
	- Accessing shared data across threads
- Unsafe flag is toggle-able within your package!

Attributes
- Applies metadata to some module, crate or lines of code:
	- Controlling visibility
	- Exposing Low-Level functionality of a process when executed
	- Codifying behaviour during compilation
	- Enable accessible to other code languages from Rust
		- `pub extern "C"`  - **Useful for compiling DLLs in a different language!**
			- Pass arguments and return values in a way that is compatible with C
			- Interact with C code, such as when using a C library from Rust
				- `pub` making the function publicly accessible, allowing other languages to call it
			- `#[no_mangle]` - tells the compiler not to mangle the function name
				- Allows other languages to easily call the function using that name
		- `pub extern Pyo3`
			- We can take rust with `impacket` ([[Impacket-Cheatsheet]]) and wrap it in rust! 
	- Compiling behaviour

DLLs example
```rust
use std::ptr::null_mut;
use winapi::um:winuser::MessageBoxA;

#[no_mangle]
pub extern "C" fn CPlApplet() {
	main()
}
#[no_mangle]
pub extern "C" fn Run() {
	main()
}

pub fn main() {
...
}
```

The Cargo.toml
```toml
[package]
name = "DLL";
version = "0.1.0";
edition = "2024";

# https://doc.rust-lang.org/cargo/reference/manifest.html

[dependencies]
winapi = { version = ... }

[lib]
crate-type = ["cdylib"]
```

- Features that stand out
	- `LITCRYPT` and `LITCRYPT2` - OPSEC feature - [[OPSEC]] 
		- These packages the encrypts text using a basic XOR method
		- Protects plain text from static analysis tools
		- `LITCRYPT2` encrypts strings while compiling - encrypting on disk and in memory at runtime, decrypting when required
	- `NTAPI` Crate 
		- Similar to WinApi crate but focuses on Windows NT APIs
		- Access to raw Syscall functions and structure
	- Inline Assembly
		- Like C, allows you to write assembly code directly within your Rust code

Direct Syscall
```rust
// Simple syscall tool to mimic NTAllocVirtualMemory
pub unsafe fn syscall6(
	number: u32,
	arg1: u64,
	arg2: u64,
	arg3: u64,
	arg4: u64,
	arg5: u64,
	arg6: u64,
) -> u64 {
	let output: u64;
	println!("[*] Executing Inline-Assembly");
	asm(
		"sub rsp, 0x36",
		"mov [rsp+0x30], {arg6}",
		"mov [rsp+0x28], {arg5}",
		"syscall",
		"add rsp, 0x38",
		arg5 = in(reg) arg5,
		arg6 = in(reg) arg6,
		in("rax") number,
		in("r10") arg1,
		in("rdx") arg2,
		in("r8") arg3,
		in("r9") arg4,
		lateout("rax") output,
		lateout("rcx") ...,
		lateout("r11") ...		
		);
		output
}
```

LLVM 
- LLVM is a compiler framework for programmatically generating machine-native code

Crates to get start with using Rust in InfoSec
- Azure  https://crates.io/crates/azure_core
- AWS - has lots depending on what service
- Terraform - https://crates.io/crates/cargo-make
- WinAPI - https://crates.io/crates/winapi
- LDAP - https://crates.io/crates/ldap3
- Kerberos - https://crates.io/crates/krb5-src
 
[anvarkangadiyil Medium blog on Error handling](https://medium.com/@anvarkangadiyil/a-beginners-guide-to-error-handling-in-rust-mastering-the-operator-49cdf73003d2)
## References

[Rust Trademark Policy Comment Form](https://docs.google.com/forms/d/e/1FAIpQLSdaM4pdWFsLJ8GHIUFIhepuq0lfTg_b0mJ-hvwPdHa4UTRaAg/viewform)
https://play.rust-lang.org/
[The Rust Programming Language](https://doc.rust-lang.org/book/#the-rust-programming-language)
[Rust for Windows, and the *windows* crate](https://learn.microsoft.com/en-us/windows/dev-environment/rust/rust-for-windows)
[Rust Fundamentals for InfoSec w/ Matthew Eidelberg](https://www.youtube.com/watch?v=WOaFrkeszDA)