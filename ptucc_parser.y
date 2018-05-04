%{
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>	
#include <string.h>
#include "cgen.h"

extern int yylex(void);
extern int line_num;

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
		  
	// Get brackets part
	char* brackets_part = strpbrk(comp_type, "[");
	  
	if(brackets_part){
		// Get type part 
	  	int type_part_len = abs(strlen(comp_type) - strlen(brackets_part));
	  	char type[type_part_len+1];
	  	strncpy(type, comp_type, type_part_len);
	  	type[type_part_len] = '\0';
		  	
	  	// Remove "array:" signifier
	  	strcpy(type, strpbrk(type, ":")); 
	  	memmove(type, type+1, strlen(type));

	  	// @TODO (edge-case): 
	  	//       make into a for loop that breaks up (var_list)
	  	//       (when it is a comma-separated list) into 
	  	//       separate declarations
	  	result = template("%s %s;\n", type, strcat(var_list, brackets_part)); 
	  }else{
	  	char* type = strpbrk(comp_type, ":");
	  	if(type){ // comp_type_str starts with ":"
	  		
	  		// Remove "array:" signifier
	  		strcpy(type, strpbrk(type, ":")); 
	  		memmove(type, type+1, strlen(type));

	  		result = template("%s %s;\n", strcat(type,"*"), var_list); 
	  	}
	  	else
		  result = template("%s %s;\n", comp_type, var_list);
	  }

	  return result;  
}

char* make_C_param_list(char* type, char* var_list){
	char* result = NULL; 
	// fprintf(stderr, "VAR_LIST = %s\n", var_list);					
	const char comma[2] = ",";				      	
	// Get first var
	char* first_var = strtok(var_list, comma);
	                                        
	/* If second var (other_var) is non-NULL 
	   then var_list is a comma-separated list */
	char* other_var = strtok(NULL, comma);
	if(!other_var) 
		return template("%s %s", type, var_list);
	else{	
		// fprintf(stderr, " %s\n", other_var);
		// Init to "type first_var, type other_var"
		char* type_and_space = concat(type, " ");
		char* comma_and_space = concat(comma, " ");
                char* first_param = concat(concat(type_and_space, first_var), comma_and_space);
		result = concat(first_param, concat(type_and_space, other_var));
	   	/* Walk through rest of var_list,
		   fetch other vars and construct C param list */
		// fprintf(stderr, "Before While Result:%s\n", result);					   	
		do{
		  other_var = strtok(NULL, comma);
		  if(other_var){
			  result = concat(result, comma_and_space);
			  result = concat(result, concat(type_and_space, other_var));
		  }
	      	  // fprintf(stderr, "In Result:%s\n", result);
		}while(other_var);
	
		return result;
	}
	
}

char* make_C_return_type(char* comp_type){
	char* type = strpbrk(comp_type, ":");
	if(type){ // comp_type_str starts with ":"	
		// Remove "array:" signifier
		strcpy(type, strpbrk(type, ":")); 
		memmove(type, type+1, strlen(type));
			
		return strcat(type,"*");
	}else
		return comp_type;
	
	
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
	     | KW_ARRAY bracket_list KW_OF compound_type { $$ = template(":%s%s", $4, $2); }
             ;

bracket_list: %empty					  { $$ = ""; };
            | bracket_list '[' POSINT ']' { $$ = template("%s[%s]", $1, $3); }
            ; 

type: KW_CHAR { $$ = template("%s", "char"); }
    | KW_INT  { $$ = template("%s", "int"); }
    | KW_REAL { $$ = template("%s", "float"); }
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

