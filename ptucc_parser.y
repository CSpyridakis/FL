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

%token KW_PROGRAM 
%token KW_BEGIN 
%token KW_END
%token KW_FUNC
%token KW_PROC
%token KW_RESULT
%token <crepr> KW_ARRAY
%token KW_DO
%token KW_GOTO
%token KW_RETURN
%token KW_ELSE
%token KW_IF;
%token <crepr> KW_OF
%token KW_THEN
%token KW_FOR
%token KW_REPEAT
%token KW_UNTIL
%token KW_WHILE
%token KW_TO
%token KW_DOWNTO
%token KW_TRUE
%token KW_FALSE
%token OP_EQ
%token OP_INEQ
%token OP_LT
%token OP_LTE
%token OP_GT
%token OP_GTE
%token OP_AND
%token OP_OR
%token OP_NOT
%token OP_ASSIGN
%token OP_CAST

%start program

%type <crepr> program_decl declarations body statements statement_list param_list
%type <crepr> statement var_decl var_assign proc_call arguments bracket_list
%type <crepr> type arglist var_list expression compound_type subprogram_decl

%%

program: program_decl declarations body '.'   		
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

declarations: %empty 		    { $$ = ""; }
            | declarations var_decl { $$ = template("%s%s", $1, $2 ); }
            | declarations subprogram_decl { $$ = template("%s%s", $1, $2 ); }
	    ;

subprogram_decl: %empty 				{ $$ = ""; }
       | subprogram_decl ';' subprogram_decl 		{ $$ = template("%s;\n%s", $1, $3 ); }
       | KW_PROC IDENT '(' param_list ')'		{ $$ = template("void %s(%s)", $2, $4 ); }
       | KW_FUNC IDENT '(' param_list ')' ':' compound_type  { $$ = template("%s %s(%s)", make_C_comp_type($7), $2, $4 ); }
       ;

param_list: %empty 						{ $$ = "";}
          | param_list ';' param_list 				{ $$ = template("%s, %s", $1, $3);  };
	  | var_list ':' compound_type 				{ $$ = make_C_params(make_C_comp_type($3), $1); }

var_decl: KW_VAR var_assign { $$ = $2;}
        ;

var_assign: %empty 		      { $$ = ""; }
	  | var_assign ';' var_assign { $$ = template("%s;\n%s", $1, $3); }
	  | var_list ':' compound_type  { $$ = make_C_decl($3, $1); }
	      									  	 
          ;
var_list: IDENT
        | var_list ',' IDENT { $$ = template("%s, %s", $1, $3); }
        ; 

compound_type: type
	     | KW_ARRAY bracket_list KW_OF compound_type { $$ = make_parsable_comp_type($4, $2); }
             ;

bracket_list: %empty			  { $$ = ""; };
            | bracket_list '[' POSINT ']' { $$ = template("%s[%s]", $1, $3); }
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

