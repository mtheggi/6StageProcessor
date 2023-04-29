# Assembler Guide

- Software needed to run assembler: GCC Compiler

## Steps to run Compiler:
1. Create a program in a text file (extension: ".txt") in this same directory as the assembler.
2. Double click on Assembler.exe or Run Assembler.exe using cmd by typing ``Assembler.exe``.
Alternatively, you can open Assembler.cpp on VS code and run the cpp file.
3. Input filename when prompted and hit Enter.
4. If the program was compiled successfully, A "Success" message will be printed and Program.mem will be updated.
5. Otherwise, an error message will be printed indicating the line number causing error and Program.mem will be emptied with a message saying "There is an Error".
6. When the mem file is created successfully, import it to the instruction cache memory during simulation
   
## NOTES: 
- Do not include extension in filename
- make sure that the following options are selected during importing the mem file:
	Load Type: File Only - Address Range: All - File Format: Specified in file
- you can fill the memory with zeros before importing the mem file to avoid undefined behaviour.
	 