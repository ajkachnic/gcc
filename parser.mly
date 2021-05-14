%{
  open Parsed_ast
%}

%token <int> INT
%token PLUS
%token MINUS 
%token MUL 
%token DIV 
%token EQ 
%token NE 
%token LT 
%token LE 
%token SEMICOLON
%token EOF

%start program

%type <Parsed_ast.program> program
%type <Parsed_ast.expr> expr

%left PLUS MINUS
%left MUL DIV

%%

program:
| e=separated_list(SEMICOLON, expr) { e }

expr:
| i=INT { Num($startpos, i) }
| e1=expr op=bin_op e2=expr { BinOp($startpos, op, e1, e2) }

%inline
bin_op:
| PLUS { BinOpAdd }
| MINUS { BinOpSub }
| MUL { BinOpMul }
| DIV { BinOpDiv }
| EQ { BinOpEq }
| NE { BinOpNotEq }
| LT { BinOpLess }
| LE { BinOpLessEq }