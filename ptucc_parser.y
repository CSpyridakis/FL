%{
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>	
#include <string.h>
#include "cgen.h"

extern int yylex(void);
extern int line_num;
const char comma[2] = ",";				      	

char* concat(const char *s1, const char *s2){
    char* result;
    if((result = malloc(strlen(s1)+strlen(s2)+1))){
    	strcpy(result, s1);
    	strcat(result, s2);
    	return result;
    }else{
	fprintf(stderr, "oops, malloc failed!"); 
	exit(1);
    } 
}

char* make_C_decl(char* comp_type, char* var_list){
	char* result = NULL;
	// comp_type = "***int[14][3]";
	char* last_asterisk = strrchr(comp_type, '*');
	char* asterisks = NULL;
	char* brackets_part = NULL;
	char* prim_type = NULL;

	if(last_asterisk){ 
		// Get asterisks part
		int asterisks_len = strlen(comp_type) - strlen(last_asterisk) + 1;
		asterisks = (char*) malloc(asterisks_len + 1);
		strncpy(asterisks, comp_type, asterisks_len);
		asterisks[asterisks_len] = '\0';
	}
			  
	// Get brackets part
	brackets_part = strpbrk(comp_type, "[");

	// Get primitive type part 
	if(brackets_part!=NULL && asterisks!=NULL){
		prim_type = (char*) calloc(strlen("double") + 1, sizeof(char));
		int len = (int) (brackets_part - last_asterisk);
		memcpy( prim_type, (last_asterisk+1), len-1 );
		prim_type[sizeof(prim_type) - 1] = '\0';		
	}else if(brackets_part){
		prim_type = (char*) calloc(strlen("double") + 1, sizeof(char));
		int len = (int) (brackets_part - comp_type);
		memcpy( prim_type, comp_type, len );
		prim_type[sizeof(prim_type) - 1] = '\0';					    
	}else if(asterisks){
		prim_type = (char*) calloc(strlen("double") + 1, sizeof(char));
		memcpy( prim_type, (last_asterisk+1), strlen(last_asterisk+1));
		prim_type[sizeof(prim_type) - 1] = '\0';					    
	}else
		prim_type = comp_type;

	
	// Prepare ptr_type to avoid asterisk-checking hassle
	char* ptr_type = NULL;
	if(asterisks) ptr_type = concat(prim_type, asterisks);
	else ptr_type = prim_type;

	// Append brackets part to vars of var_list and get result
	if(brackets_part){

		// Get first var
		char* first_var = strtok(var_list, comma);
		
		/* If second var (next_var) is non-NULL 
		then var_list is a comma-separated list */
		char* next_var = strtok(NULL, comma);
		if(!next_var) result = template("%s %s%s", ptr_type, var_list, brackets_part);
		else{	

			char* var_l_w_b_part = NULL;

			char* comma_and_space = concat(comma, " ");
			char* first_var_w_b = concat(concat(" ", first_var), brackets_part);
			var_l_w_b_part = concat(first_var_w_b, comma_and_space);

			// Init to " {first_var}{brackers_part}, {next_var}{brackets_part}"
			var_l_w_b_part = concat(var_l_w_b_part, next_var);
			var_l_w_b_part = concat(var_l_w_b_part, brackets_part);

				
			/* Walk through rest of var_list, fetch other vars 
			   and construct {next_var}{brackets_part} */
			do{
			  
			  next_var = strtok(NULL, comma);
			  if(next_var){
			  	  var_l_w_b_part = concat(var_l_w_b_part, comma_and_space);
				  var_l_w_b_part = concat(var_l_w_b_part, concat(next_var, brackets_part));
			  }

			}while(next_var);

			result = template("%s %s", ptr_type, var_l_w_b_part);
		}
	
	}else 
		result = template("%s %s", ptr_type, var_list);

  	return concat(result,";\n");
}

char* make_C_param_list(char* type, char* var_list){
	char* result = NULL; 
	
	// Get first var
	char* first_var = strtok(var_list, comma);
	                                        
	/* If second var (next_var) is non-NULL 
	   then var_list is a comma-separated list */
	char* next_var = strtok(NULL, comma);
	if(!next_var) 
		return template("%s %s", type, var_list);
	else{	
		
		// Init to "type first_var, type next_var"
		char* type_and_space = concat(type, " ");
		char* comma_and_space = concat(comma, " ");
        char* first_param = concat(concat(type_and_space, first_var), comma_and_space);
		result = concat(first_param, concat(type_and_space, next_var));
	   	
	   	/* Walk through rest of var_list,
		   fetch other vars and construct C param list */
		do{
		  next_var = strtok(NULL, comma);
		  if(next_var){
			  result = concat(result, comma_and_space);
			  result = concat(result, concat(type_and_space, next_var));
		  }
	     
		}while(next_var);
	
		return result;
	}
	
}

char* make_C_return_type(char* comp_type){
	char* last_asterisk = strrchr(comp_type, '*');
	char* asterisks = NULL;
	char* prim_type = NULL;
	
	if(last_asterisk){ // comp_type starts with "*"	
		
		// Get asterisks part
		int asterisks_len = strlen(comp_type) - strlen(last_asterisk) + 1;
		asterisks = (char*) malloc(asterisks_len + 1);
		strncpy(asterisks, comp_type, asterisks_len);
		asterisks[asterisks_len] = '\0';

		// Get primitive type part 
		prim_type = (char*) calloc(strlen("double") + 1, sizeof(char));
		memcpy( prim_type, (last_asterisk+1), strlen(last_asterisk+1));
		prim_type[sizeof(prim_type) - 1] = '\0';
		
		// Append asterisks part to primitive type part
		prim_type = concat(prim_type, asterisks);					    

	}else
		prim_type = comp_type;

	return prim_type;
}

char* make_parsable_comp_type(char* comp_type, char* bracket_list){
	char* result = NULL;
	int br_l_empty = !strcmp(bracket_list, "");
	if(br_l_empty) result = concat("*", comp_type);
	else result = concat(comp_type, bracket_list);
	return result;
}

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
%type <crepr> statement var_decl var_assign param_var_assign proc_call arguments bracket_list
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
            | declarations var_decl { $$ = template("%s\n%s", $1, $2); }
            | declarations subprogram_decl { $$ = template("%s\n%s", $1, $2); }
	        ;

subprogram_decl: KW_PROC IDENT '(' param_list ')' ';'		{ $$ = template("void %s(%s);", $2, $4 ); }
               | KW_FUNC IDENT '(' param_list ')' ':' compound_type ';' { $$ = template("%s %s(%s);", make_C_return_type($7), $2, $4 ); }
               ;

param_list: param_var_assign					{ $$ = $1; }
          | param_list ';' param_var_assign 			{ $$ = template("%s, %s", $1, $3);  };

var_decl: KW_VAR var_assign { $$ = $2;}
        ;

param_var_assign: %empty { $$ = "";}
	        | var_list ':' type { $$ = make_C_param_list($3, $1); }
	        ;

var_assign: var_assign var_assign { $$ = template("%s%s", $1, $2); }
	  | var_list ':' compound_type ';'  { $$ = make_C_decl($3, $1); }
	      									  	 
          ;
var_list: IDENT
        | var_list ',' IDENT { $$ = template("%s, %s", $1, $3); }
        ; 

compound_type: type
	     | KW_ARRAY bracket_list KW_OF compound_type { $$ = make_parsable_comp_type($4, $2); }
             ;

bracket_list: %empty					  { $$ = ""; };
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

