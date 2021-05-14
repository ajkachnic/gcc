(* A fake assembly instruction set *)
(* Based off http://flint.cs.yale.edu/cs421/papers/x86-asm/asm.html *)
type register =
  | Reg64 of int
  | Reg32 of int
  | Reg16 of int
  | Reg8 of int

and immediate =
  | Con32 of int
  | Con16 of int
  | Con8 of int

and memory = int

and operand =
  | Reg of register
  | Mem of memory
  | Con of immediate

type reg_mem = 
  | Reg of register
  | Mem of memory

type instruction = 
  | InsMove of operand * operand (* Move *)
  | InsPush of operand (* Push to stack *)
  | InsPop of operand (* Pop off of stack *)
  | InsAdd of operand * reg_mem
  | InsSub of operand * reg_mem
  | InsIMul of operand * operand * operand option (* Integer multiplication *)
  | InsIDiv of reg_mem  (* Integer division *)
  (* Bitwise ops *)
  | InsAnd of operand * reg_mem
  | InsOr of operand * reg_mem
  | InsXor of operand * reg_mem
  | InsNot of reg_mem
  | InsNeg of reg_mem (* Negate *)
  (* Shift left/right *)
  | InsShl of operand * reg_mem
  | InsShr of operand * reg_mem
  | InsSar of operand * reg_mem
  (* Control flow *)
  | InsJmp of string
  (* Conditional jumps *)
  | InsJe of string  (* Jump when equal*)
  | InsJne of string (* Jump when not equal *)
  | InsJz of string  (* Jump when last result was zero *)
  | InsJg of string  (* Jump when greater than *)
  | InsJge of string (* Jump when greater than or equat to*)
  | InsJl of string  (* Jump when less than *)
  | InsJle of string (* Jump when less than or equal to*)
  | InsCmp of operand * reg_mem (* Compare *)
  | InsCall of string
  | InsRet
  (* Misc *)
  | InsCqo
