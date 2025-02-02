# Simple Compiler

## Overview
This project implements a **simple compiler** that processes C-like language source code and generates **x86 assembly code**. The compiler is developed using **Flex (Lexical Analysis)** and **Bison (Syntax Analysis)**, with a backend generating **assembly code** and supporting execution through **NASM**.

## Features
- **Lexical Analysis**: Uses **Flex** to tokenize source code (keywords, operators, identifiers, etc.).
- **Syntax Analysis**: Implements **Bison-based parsing** for parsing grammar rules.
- **Intermediate Code Generation**: Converts parsed structures into stack-based **intermediate representations**.
- **Code Execution Simulation**: Simulates stack-based execution before generating final machine code.
- **Assembly Code Generation**: Translates intermediate representations into **x86 NASM assembly**.
- **Custom I/O Handling**: Implements low-level **I/O functions** for interacting with the generated program.

## File Structure
```
|-- input_file/        # Folder containing input C-like source files
|   |-- test.c         # Example input file
|
|-- output_file/       # Folder containing generated outputs
|   |-- test.asm       # Generated assembly file
|   |-- test.o         # Compiled object file
|   |-- test           # Final executable file
|
|-- src/               # Source code of the compiler
|   |-- display_lex_result  # Executable for displaying lexer results
|   |-- io_tool.c      # Custom I/O functions using x86 inline assembly
|   |-- lex_anal.l     # Flex lexical analyzer definition
|   |-- macro.inc      # NASM macros for generating x86 assembly
|   |-- my_gcc         # Compilation script for generating executable files
|   |-- syn_anal.y     # Bison syntax analyzer (parsing rules)
|
|-- README.txt         # Project documentation
```

## Installation & Usage
### Prerequisites
Ensure you have the following installed on your system:
- **Flex** (for lexical analysis)
- **Bison** (for syntax analysis)
- **GCC** (for compiling the front-end)
- **NASM** (for assembling the final code)

### Compilation Steps
1. **Lexical & Syntax Analysis**
```bash
flex src/lex_anal.l
bison -vdty src/syn_anal.y
gcc -o src/front_end src/lex.yy.c src/y.tab.c
```
2. **Intermediate Code Simulation** (Optional Debugging Step)
```bash
./src/front_end input_file/test.c
```
3. **Assembly Code Generation & Linking**
```bash
./src/my_gcc input_file/test.c
```
4. **Execution**
```bash
./output_file/test
```

## Example
### Input (Source Code)
```c
int main() {
    int a = 5;
    int b = 10;
    int c = a + b;
    print("Sum: %d", c);
    return 0;
}
```
### Generated Assembly (Excerpt)
```assembly
push 5
pop a
push 10
pop b
push a
push b
add
pop c
push c
call print
```

## Contributors
- **Haoqing Liu**

## License
This project is licensed under the MIT License.
