# CNF Satisfiability Solver


This project is a SAT Solver for Boolean CNF Expressions, implemented in OCaml. It parses a given Boolean formula in Conjunctive Normal Form (CNF), generates all possible variable assignments, and determines whether the formula is satisfiable. The solver provides a satisfying assignment if one exists, or reports unsatisfiability otherwise.

Key features include:

Parsing and tokenizing CNF formulas.
Evaluating logical expressions based on variable assignments.
Generating all possible variable combinations using an efficient backtracking algorithm.
This tool is ideal for exploring SAT-solving techniques and understanding the fundamentals of Boolean logic evaluation.


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

The input is a list of strings representing a Boolean formula in CNF

- Tokens include:

```bash
       * Logical operators: AND, OR, NOT
       * Parentheses: (, )
       * Variables: single-letter strings (e.g., a, b, c)
       * Boolean literals: TRUE, FALSE
```

  
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

Helper Function:

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
