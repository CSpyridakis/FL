# Fictional Language to C Trans-compiler 
Simple Trans-compiler implemented for a Theory of Computation course at the Technical University of Crete.
This application trans-compiles code from a fictional language - specifications are available [here](./doc/Project.pdf) - to C programs.

## Dependencies
  1. Flex
  2. Bison


## Usage
<hr>

### 1. To Build in a LINUX-based system, run the command below:
```
$ make
```
### 2. How to Use Trans-compiler:
```
$ ./fl path_to_file.fl
```
<hr>

### Or view Trans-compiler Help Menu for more information:
```
$ ./fl -h
```

### Clean generated files:
```
$ make clean
```

## Known Issues:
* Fix last one shift/reduce conflict on State 38*
* Fix last one reduce/reduce conflict on State 103*

*(make project and see build/ptucc_parser.output for more) 

## IMPORTANT: 
The owner of the initial software is the Technical University of Crete. Its code was given to us during a 'Theory of Computation' course as is, without any warranty. It may or may not had bugs, useless parts of code, or other problems to simulate a real-life scenario. Therefore it had an educational purpose and only. During the course, our job was to understand given sources, identify its components, and implement needed requirements based on that.

