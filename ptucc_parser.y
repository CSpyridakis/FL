%{
#include <stdarg.h>
#include <stdio.h>	
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

%token KW_PROGRAM 
%token KW_BEGIN 
%token KW_END
%token KW_FUNC
%token KW_PROC
%token KW_RESULT
%token KW_ARRAY
%token KW_DO
%token KW_GOTO
%token KW_RETURN
%token KW_BOOLEAN
%token KW_ELSE
%token KW_IF;
%token KW_OF
%token KW_REAL
%token KW_THEN
%token KW_CHAR
%token KW_FOR
%token KW_INT
%token KW_REPEAT
%token KW_UNTIL
%token KW_VAR
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

%type <crepr> program_decl body statements statement_list
%type <crepr> statement proc_call arguments
%type <crepr> arglist expression

%%

program:  program_decl body  '.'   		
{ 
	/* We have a successful parse! 
		Check for any errors and generate output. 
	*/
	if(yyerror_count==0) {
		puts(c_prologue);
		printf("/* program  %s */ \n\n", $1);
		printf("int main() %s \n", $2);
	}
};


program_decl : KW_PROGRAM IDENT ';'  	{ $$ = $2; };

body : KW_BEGIN statements KW_END   	{ $$ = template("{\n %s \n }\n", $2); };

statements: 				        	{ $$ = ""; };
statements: statement_list		   		{ $$ = $1; };

statement_list: statement                     
			  | statement_list ';' statement  { $$ = template("%s%s", $1, $3); }; 


statement: proc_call  						{ $$ = template("%s;\n", $1); };

proc_call: IDENT '(' arguments ')' 			{ $$ = template("%s(%s)", $1, $3); };

arguments :									{ $$ = ""; }
	 	  | arglist 						{ $$ = $1; };

arglist: expression							{ $$ = $1; }
       | arglist ',' expression 			{ $$ = template("%s,%s", $1, $3);  };

expression: POSINT 							/* Default action: $$ = $1 */
          | REAL							
          | STRING 							{ $$ = string_ptuc2c($1); };

%%

