open Parsed_ast
open Asm;;

let rec gen_expr expr = 
  match expr with
  | Num (_, n) -> [InsMove ((Con (Con32 n)), (Reg (Reg64 0) ))]
  | Neg (_, n) -> gen_expr n @ [InsNeg (Reg (Reg64 0))]
  | BinOp (_, op, a, b) ->
    let a = gen_expr a in
    let b = gen_expr b in
    let c = a @ [InsPush (Reg (Reg64 0))] @ b @ [InsPop (Reg (Reg64 1))] in
    match op with
    | BinOpAdd -> c @ [InsAdd ((Reg (Reg64 1)), (Reg (Reg64 0)))]
    | BinOpSub -> c @ [InsSub ((Reg (Reg64 1)), (Reg (Reg64 0)))]
    | BinOpMul -> c @ [InsIMul ((Reg (Reg64 1)), (Reg (Reg64 0)), None)]
    | BinOpDiv -> c @ [InsCqo; InsIDiv (Reg (Reg64 1))]
  | _ -> []