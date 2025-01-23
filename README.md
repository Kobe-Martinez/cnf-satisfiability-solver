# CNF Satisfiability Solver

## Overview


This project implements a Conjunctive Normal Form (CNF) satisfiability solver in OCaml. It parses a given Boolean formula in CNF, generates truth assignments for the variables, and determines if there is a satisfying assignment. 


## Table of Contents

- [Features](#features)
- [Usage](#usage)
- [Code Structure](#code-structure)
- [Requirements](#requirements)
- [File Output](#file-output)
- [License](#license)
- [Important Note](#important-note)


## Features

```bash
- Parse CNF Input:
       * Converts a CNF Boolean formula into a structured representation
       * Handles conjunctions (AND), disjunctions (OR), and negations (NOT)
- Variable Management:
       * Extracts variables from the input formula
       * Generates default truth assignments for all variables
- Truth Assignment Generation:
       * Iteratively generates all possible truth assignments for variables
       * Stops when a satisfying assignment is found
- CNF Evaluation:
       * Evaluates if a given truth assignment satisfies the CNF formula
```


## Usage

##### Input Format:

The input is a list of strings representing a Boolean formula in CNF.

- Tokens include:
       * Logical operators: ```bash AND ```, ```bash OR ```, ```bash NOT ```
       * Parentheses: ```bash ( ```, ```bash ) ```
       * Variables: single-letter strings (e.g.: ```bash a ```, ```bash b ```, ```bash c ```)
       * Boolean literals: ```bash TRUE ```, ```bash FALSE ```
  
##### Example Input:

```bash
let input = ["("; "NOT"; "a"; "OR"; "b"; ")"; "AND"; "("; "c"; "OR"; "NOT"; "d"; ")"]
```

This corresponds to the formula:

```bash
(NOT a OR b) AND (c OR NOT d)
```

##### Key Function:


```bash
let result = satisfy input;;


(* Output: A satisfying assignment or an error if none exists *)
```


## Code Structure

Core Functions:

```bash
1. partition:

       * Partitions the input based on a specified delimiter
       * Useful for grouping tokens into meaningful components

2. buildCNF:

       * Parses the input into a structured CNF representation

3. getVariables:

       * Extracts and returns a sorted list of unique variables from the input

4. generateDefaultAssignments:

       * Generates a list of default truth assignments (false) for each variable

5. generateNextAssignments:

       * Produces the next truth assignment in binary order

6. evaluateCNF:

       * Evaluates if a given truth assignment satisfies the CNF

7. satisfy:

       * Finds and returns a satisfying assignment for the CNF if one exists
```

Helper Functions:

```bash
       * lookupVar: Retrieves the value of a variable in the current assignment
```


## Requirements

```bash
- OCaml compiler (e.g., ocamlc)

- Basic OCaml standard library (no external dependencies)
```


## File Output

The code does not currently write to an output file. However, results are returned as OCaml values that can be printed or logged by the user. Example output:

```bash
[("a", true); ("b", false); ("c", true); ("d", false)]
```
 

## License

This project is licensed under the MIT License. See the LICENSE file for details.


## Important Note

```bash
- This solver assumes that the input follows the correct CNF format. Invalid input may result in runtime errors

- The solver is not optimized for very large CNF formulas and may encounter performance constraints
```
