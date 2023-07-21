# Call Swift from C(++)
---
Examples of how to write functions in Swift that can be compiled into a dynamic library and linked into a C executable by `clang`.

## Getting started
---
You will need the following software installed on your computer:
1. The Swift 5 compiler, callable as `swiftc`.
2. `clang`. Tested with clang 14 on macOS and Linux.

## Building
---
Compile `print_num.swift` and `print_num.c` into a single executable with:
```bash
./swift_cpp_link.sh
```
Then run with `./print_num`.

`swift_cpp_link.sh` takes the following actions:
1. complies the Swift code in `print_num.swift` which has a shared stateful array, and some functions accessible from C that modify or print the state of the `.shared` static struct.
2. It then dumps `print_num.c` into an object file, and then 
3. links `print_num.o` to the Swift dynamic lib and produces a valid executable.