%{
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>	
#include <string.h>
#include "cgen.h"

extern int yylex(void);
extern int line_num;

%}

%union
{
	char* crepr;
}


%token <crepr> IDENT
%token <crepr> POSINT 
%token <crepr> REAL 
%token <crepr> STRING
%token <crepr> KW_BOOLEAN
%token <crepr> KW_REAL
%token <crepr> KW_CHAR
%token <crepr> KW_INT
%token <crepr> KW_VAR

%token <crepr> KW_PROGRAM 
%token <crepr> KW_BEGIN 
%token <crepr> KW_END
%token <crepr> KW_FUNC
%token <crepr> KW_PROC
%token <crepr> KW_RESULT
%token <crepr> KW_ARRAY
%token <crepr> KW_DO
%token <crepr> KW_GOTO
%token <crepr> KW_RETURN
%token <crepr> KW_ELSE
%token <crepr> KW_IF;
%token <crepr> KW_OF
%token <crepr> KW_THEN
%token <crepr> KW_FOR
%token <crepr> KW_REPEAT
%token <crepr> KW_UNTIL
%token <crepr> KW_WHILE
%token <crepr> KW_TO
%token <crepr> KW_DOWNTO
%token <crepr> KW_TRUE
%token <crepr> KW_FALSE
%token <crepr> OP_EQ
%token <crepr> OP_INEQ
%token <crepr> OP_LT
%token <crepr> OP_LTE
%token <crepr> OP_GT
%token <crepr> OP_GTE
%token <crepr> OP_AND
%token <crepr> OP_OR
%token <crepr> OP_NOT
%token <crepr> OP_ASSIGN
%token <crepr> OP_CAST

%start program

%type <crepr> program_decl d decl type_decl init_type_decl type_assign type_type_assign body statements statement_list param_list 
%type <crepr> func_decl proc_decl
%type <crepr> de decl_kind statement var_decl var_type_assign proc_call arguments bracket_list init_var_decl param_specifier
%type <crepr> type arglist var_list expression compound_type subprogram_decl var_assign subprogram_decl_kind brackets

%%

program: program_decl d body '.'   		
{ 
	/* We have a successful parse! 
		Check for any errors and generate output. 
	*/
	if(yyerror_count==0) {
		puts(c_prologue);
		printf("/* program  %s */ \n\n", $1);
		printf("%s\n", $2);		
		printf("int main() %s \n", $3);
		
	}
};

program_decl : KW_PROGRAM IDENT ';'  	{ $$ = $2; };

d: de   { $$ = template("%s",$1); }
 | d de { $$ = template("%s%s", $1, $2 ); }
 ;

de: decl  { $$ = template("%s",$1); }
  // | def   { $$ = template("%s",$1); } 
  ;  

// def: subprogram_def	{ $$ = template("%s",$1); }
   // ;

// subprogram_def: ;

decl: decl_kind  { $$ = template("%s",$1); }
    | decl decl_kind { $$ = template("%s%s", $1, $2 ); }
    ;

decl_kind: var_decl 	   { $$ = template("%s",$1); }
         | subprogram_decl { $$ = template("%s",$1); }
	 | type_decl { $$ = template("%s",$1); }
	 ;

type_decl: init_type_decl { $$ = template("%s",$1); }
         | type_decl init_type_decl { $$ = template("%s",$1); }
         ;	

init_type_decl: "type" type_assign { $$ = template("%s", $2); } 
	      ; 

type_assign: type_type_assign { $$ = template("%s", $1); }
	   | type_assign type_type_assign { $$ = template("%s%s", $1, $2 ); }
	   ;

type_type_assign: IDENT '=' compound_type //{ set_typedef($1);
					  //  char* C_typedef = make_C_typedef($3, $1);
					  //  $$ = template("%s", C_typedef); } 
		;

var_decl: init_var_decl { $$ = template("%s",$1); }
	| var_decl init_var_decl { $$ = template("%s%s", $1, $2 ); }
        ;

init_var_decl: KW_VAR var_assign { $$ = template("%s", $2);} 
	     ;

var_assign: var_type_assign { $$ = template("%s", $1); }
	  | var_assign var_type_assign { $$ = template("%s%s", $1, $2 ); }
	  ; 

var_type_assign: var_list ':' compound_type ';'  { char* C_decl = make_C_decl($3, $1);
						   $$ = template("%s;\n", C_decl); }
	       ; 

subprogram_decl: subprogram_decl_kind { $$ = template("%s",$1); }
	       | subprogram_decl subprogram_decl_kind { $$ = template("%s%s", $1, $2 ); }
	       ;

subprogram_decl_kind: func_decl { $$ = template("%s",$1); }
	       	    | proc_decl { $$ = template("%s",$1); }
                    ;

func_decl: KW_FUNC IDENT '(' param_list ')' ':' compound_type ';' 	{ char* C_comp_type = make_C_comp_type($7);
							       	          $$ = template("%s %s(%s);\n", C_comp_type , $2, $4 ); }
	 ;

proc_decl: KW_PROC IDENT '(' param_list ')' ';' { $$ = template("void %s(%s);\n", $2, $4 ); }
         ;

param_list: param_specifier	 	{ $$ = template("%s",$1); }
          | param_list param_specifier	{ $$ = template("%s%s", $1, $2);  };
	  
	  ;

param_specifier: %empty 			{ $$ = "";}
	       | var_list ':' compound_type     { char* C_comp_type = make_C_comp_type($3);
					          char* C_params = make_C_params(C_comp_type, $1);
						  $$ = template("%s", C_params); }
	
	       | var_list ':' compound_type ';' { char* C_comp_type = make_C_comp_type($3);
					          char* C_params = make_C_params(C_comp_type, $1);
						  $$ = template("%s, ", C_params); }
	       ; 

var_list: IDENT
        | var_list ',' IDENT { $$ = template("%s, %s", $1, $3); }
        ; 

compound_type: type { $$ = template("%s", $1); }
	     | KW_ARRAY bracket_list KW_OF compound_type { $$ = make_parsable_comp_type($4, $2); }
	  // | IDENT {char* type_def = get_typedef($1);
	  //	      if(type_def) ... ;
	  //	      else yyerror(); }
	     ;

bracket_list: brackets { $$ = template("%s", $1); }
            | bracket_list brackets { $$ = template("%s%s", $1, $2); }
            ; 

brackets: %empty  	 { $$ = ""; }
	| '[' POSINT ']' { $$ = template("[%s]", $2); }
	;

type: KW_CHAR { $$ = template("%s", "char"); }
    | KW_INT  { $$ = template("%s", "int"); }
    | KW_REAL { $$ = template("%s", "double"); }
    | KW_BOOLEAN { $$ = template("%s", "int"); }
    ;

body : KW_BEGIN statements KW_END   	{ $$ = template("{\n %s \n }\n", $2); };

statements: %empty				        	{ $$ = ""; };
statements: statement_list		   		{ $$ = $1; };

statement_list: statement                     
			  | statement_list ';' statement  { $$ = template("%s%s", $1, $3); }; 


statement: proc_call  						{ $$ = template("	%s;\n", $1); };

proc_call: IDENT '(' arguments ')' 			{ $$ = template("%s(%s)", $1, $3); };

arguments : %empty								{ $$ = ""; }
	  | arglist 						{ $$ = $1; };

arglist: expression							{ $$ = $1; }
       | arglist ',' expression 			{ $$ = template("%s,%s", $1, $3);  };

expression: POSINT 							/* Default action: $$ = $1 */
          | REAL							
          | STRING 							{ $$ = string_ptuc2c($1); };

%%

