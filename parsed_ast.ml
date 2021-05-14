type loc = Lexing.position

and bin_op =
  | BinOpAdd
  | BinOpSub
  | BinOpMul
  | BinOpDiv
  | BinOpEq
  | BinOpNotEq
  | BinOpLess
  | BinOpLessEq

and expr =
  | BinOp of loc * bin_op * expr * expr
  | Neg   of loc * expr
  | Num   of loc * int 

type program = expr list