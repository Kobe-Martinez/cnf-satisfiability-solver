let validVarNames = ["a";"b";"c";"d";"e";"f";"g";"h";"i";"j";"k";"l";"m";"n";"o";"p";"q";"r";"s";"t";"u";"v";"w";"x";"y";"z"];;

let partition (input: string list) (bound : string) : string list list =
  let rec partition_helper acc curr = function
    | [] -> [List.rev curr]
    | h::t ->
        if h = bound then
          List.rev curr :: partition_helper acc [] t
        else
          partition_helper acc (h::curr) t
  in
  partition_helper [] [] input

let buildCNF (input : string list) : (string * string) list list =
  let rec parseClause tokens acc_literals =
    match tokens with
    | ")" :: rest -> List.rev acc_literals, rest  (* End of clause *)
    | "OR" :: rest -> parseClause rest acc_literals  (* Ignore OR *)
    | "NOT" :: var :: rest -> parseClause rest ((var, "NOT") :: acc_literals)  (* Handle negated variable *)
    | var :: rest -> parseClause rest ((var, "") :: acc_literals)  (* Handle positive variable *)
    | _ -> raise (Invalid_argument "Invalid CNF syntax: unexpected token")
  in
  let rec parseFormula tokens acc_clauses =
    match tokens with
    | [] -> List.rev acc_clauses
    | "(" :: rest ->
        let clause, rest' = parseClause rest [] in
        parseFormula rest' (clause :: acc_clauses)
    | "AND" :: rest -> parseFormula rest acc_clauses
    | _ -> raise (Invalid_argument "Invalid CNF syntax: clause must start with '('")
  in
  parseFormula input []
              
  
(* Helper function to filter out variables from a string list *)
let getVariables (input : string list) : string list =
  let rec extractVariables acc = function
    | [] -> acc
    | hd :: tl ->
        if hd = "(" || hd = ")" || hd = "AND" || hd = "OR" || hd = "NOT" || hd = "TRUE" || hd = "FALSE" then
          extractVariables acc tl
        else if hd = "NOT" then
          extractVariables acc (List.tl tl)
        else
          extractVariables (hd :: acc) tl
  in
  List.sort_uniq String.compare (extractVariables [] input)


let rec generateDefaultAssignments (varList : string list) : (string * bool) list =
  match varList with
  | [] -> []
  | h :: t -> (h, false) :: generateDefaultAssignments t

let rec generateNextAssignments (assignList : (string * bool) list) : (string * bool) list * bool = 
  let rec increment = function
    | [] -> [(fst (List.hd assignList), true)], false
    | [(var, value)] when value ->
        [(var, false)], true
    | (var, value)::rest ->
        if value then
          let rest_assignments, carry = increment rest in
          ((var, false)::rest_assignments, carry)
        else
          ((var, true)::rest, false)
  in
  let new_assignments, carry = increment (List.rev assignList) in
  (List.rev new_assignments, carry)
;;
  

let rec lookupVar (assignList : (string * bool) list) (str : string) : bool =
  match assignList with
  | [] -> failwith "Variable not found"
  | (v, b) :: t -> if v = str then b else lookupVar t str

let rec evaluateCNF (t : (string * string) list list) (assignList : (string * bool) list) : bool =
  let eval_clause clause =
    let rec eval_literal = function
      | (v, "") -> lookupVar assignList v
      | (v, "NOT") -> not (lookupVar assignList v)
      | _ -> failwith "Invalid literal"
    in
    List.exists eval_literal clause
  in
  List.for_all (fun clause -> eval_clause clause) t

let satisfy (input : string list) : (string * bool) list =
  let cnf = buildCNF input in
  let variables = getVariables input in
  let default_assignments = generateDefaultAssignments variables in

  let rec find_satisfying_assignment assignments =
    if evaluateCNF cnf assignments then
      assignments
    else
      let next_assignments, carry = generateNextAssignments assignments in
      if carry then
        [("error", true)]
      else
        find_satisfying_assignment next_assignments
  in
  
  find_satisfying_assignment default_assignments
;;