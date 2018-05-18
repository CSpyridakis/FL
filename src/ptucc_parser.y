%{
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>	
#include <string.h>
#include "../include/cgen.h"

extern int yylex(void);
extern int line_num;

%}

%union
{
	char* crepr;
}

%start program

	/*---------------TOKEN---------------*/
%token KW_BOOLEAN KW_REAL KW_CHAR KW_INT KW_VAR KW_PROGRAM KW_BEGIN KW_END KW_FUNC KW_PROC KW_RESULT
%token KW_ARRAY KW_DO KW_GOTO KW_RETURN KW_ELSE KW_IF KW_OF KW_THEN KW_FOR KW_REPEAT KW_UNTIL OP_ASSIGN
%token KW_WHILE KW_TO KW_DOWNTO KW_TRUE KW_FALSE KW_TYPE OP_EQ OP_INEQ OP_LT OP_LTE OP_GT OP_GTE OP_AND OP_OR OP_NOT
%token <crepr> IDENT POSINT REAL STRING OP_CAST_INT OP_CAST_REAL OP_CAST_BOOL OP_CAST_CHAR

	/*---------------TYPE---------------*/
	/* Program */
%type <crepr> declarations statements declarationL basicDeclaration
	
	/* Declerations */
%type <crepr> typelist varlist params compound_type funcStatements procStatements idents paramsList dtype bracket_list brackets fun_proc_comm FunProcStatementsL

	/* Commands */
%type <crepr> special_body commands basicCommand variableAssignment ifStatement special_body_list arglist complexBracketsL
          
	/* Expressions */
%type <crepr> expression complexBrackets functionCall arglistCall 

	/*------------------------------*/
%left "||"
%left "&&"
%left OP_EQ OP_INEQ OP_LT OP_GT OP_LTE OP_GTE 
%left "+" "-"
%left "*" "/" "%"
%nonassoc PREFIX
%nonassoc OP_NOT
%nonassoc THEN
%nonassoc ELSE
%%

program: KW_PROGRAM IDENT ';' declarations KW_BEGIN statements KW_END '.'
{ 
	if(yyerror_count==0) {
		puts(c_prologue);
		printf("/* program  %s */ \n\n", $2);
		printf("%s\n", $4);		
		printf("int main() {\n\n%s\n\treturn 0;\n}\n",$6);
	}
};

declarations: %empty 															{ $$ = ""; 							}
			| declarationL 														{ $$ = template("%s", $1);		 	}
 			;

declarationL: basicDeclaration 													{ $$ = template("%s", $1);		 	}
			| declarationL  basicDeclaration 									{ $$ = template("%s%s", $1, $2); 	}
 			;	

basicDeclaration: KW_TYPE typelist 	';'														   { $$ = template("%s\n", $2);		 	}
 				| KW_VAR varlist   	';'														   { $$ = template("%s\n", $2);		 	}
 				| KW_FUNC IDENT '(' params ')' ':' compound_type ';' declarations KW_BEGIN funcStatements KW_RETURN KW_END ';' 	  { $$ = template("\n%s %s(%s){\n%s result;\n%s\n%s\nreturn result;\n}\n",$7,$2,$4,$7,$9,$11); }
 				| KW_PROC IDENT '(' params ')' ';' declarations KW_BEGIN procStatements KW_END ';'  							  { $$ = template("\nvoid %s(%s){\n%s\n%s\n}\n",$2,$4,$7,$9); } 
				;

				typelist : IDENT OP_EQ compound_type							{ char* ct = $3;
																				  char* id = $1;
																				  fprintf(stderr, "cur ct:%s\n", ct);	
																				  if(strstr(ct, "FUNCTION") == NULL &&
																					 strstr(ct, "PROCEDURE)") == NULL){
																				  	
																				  	char* C_ct = make_C_comp_type(ct);
																				  	$$ = template("typedef %s %s;\n", C_ct, $1);
																				  
																				  }else{

																				  	if(strstr(ct, "FUNCTION"))
																				  		$$ = template("typedef %s;\n", replace_sub_str(ct, "FUNCTION", id) );
																				  	else if(strstr(ct, "PROCEDURE"))
																				  		$$ = template("typedef %s;\n", replace_sub_str(ct, "PROCEDURE", id) );
																				  }
																				}

						 | typelist ';' IDENT OP_EQ compound_type				{ char* ct = $5;
																				  char* id = $3;
																				  char* secnd_tl = NULL;
																				  fprintf(stderr, "cur ct:%s\n", ct);	
																				  if(strstr(ct, "FUNCTION") == NULL &&
																					 strstr(ct, "PROCEDURE)") == NULL){
																				  	
																				  	char* C_ct = make_C_comp_type(ct);
																				  	secnd_tl = template("typedef %s %s;\n", C_ct, id);
																				  
																				  }else{

																				  	if(strstr(ct, "FUNCTION"))
																				  		secnd_tl = template("typedef %s;\n", replace_sub_str(ct, "FUNCTION", id) );
																				  	else if(strstr(ct, "PROCEDURE"))
																				  		secnd_tl = template("typedef %s;\n", replace_sub_str(ct, "PROCEDURE", id) );
																				  }
						 															$$ = template("%s\n%s", $1, secnd_tl); }
						 ;

				varlist : idents ':'  compound_type								{ char* C_decl = make_C_decl($3, $1); 
																				  $$ = template("%s;\n", C_decl); }
						| varlist ';' idents ':' compound_type					{   char* C_decl = make_C_decl($5, $3); 
																					$$ = template("%s%s;\n", $1, C_decl); }
						;

						idents : IDENT 											{ $$ = template("%s", $1);		 	}
						       | idents ',' IDENT 								{ $$ = template("%s, %s", $1, $3); }
						       ; 


		        params : %empty		    								{ $$ = ""; 							}
		        	   | paramsList										{ $$ = template("%s",$1); 			}
	  				   ;

		  				paramsList : idents ':' compound_type	 				{ char* C_ct = make_C_comp_type($3); char* C_params = make_C_params(C_ct, $1); $$ = template("%s", C_params); }
		  						   | paramsList ';' idents ':' compound_type	{ char* C_ct = make_C_comp_type($5); char* C_params = make_C_params(C_ct, $3); $$ = template("%s,%s", $1, C_params);  	}
		  						   ;

				compound_type: dtype											{ $$ = template("%s", $1);				}
					     	 | KW_ARRAY bracket_list KW_OF compound_type		{ $$ = make_parsable_comp_type($4, $2); }
					     	 | KW_FUNC '(' params ')' ':' compound_type			{ char* C_ct = make_C_comp_type($6);  $$ = template("%s (*FUNCTION)(%s)", C_ct, $3); }
					       	 | KW_PROC '(' params ')' 							{ $$ = template("void (*PROCEDURE)(%s)", $3); } 
					  		 ;

					  		dtype : KW_CHAR 							{ $$ = template("%s", "char"); 		}
				    			  | KW_INT  							{ $$ = template("%s", "int"); 		}
				    		 	  | KW_REAL 							{ $$ = template("%s", "double"); 	}
				    		 	  | KW_BOOLEAN 							{ $$ = template("%s", "int"); 		}
							 	  | IDENT 								{ $$ = template("%s", $1);			}
					  		 	  ;

							bracket_list: %empty  	 					{ $$ = ""; 							} 
										| brackets 						{ $$ = template("%s", $1); 			}
							            ; 

							brackets : '[' POSINT ']'					{ $$ = template("[%s]", $2); 		}
									 | brackets '[' POSINT ']'			{ $$ = template("%s[%s]",$1, $3); 	}
									 ;
								

				       
				funcStatements : %empty		    						 	{ $$ = ""; 							}
							   | FunProcStatementsL	';'						{ $$ = template("%s", $1); 			}
							   ;

				procStatements : %empty		    						 	{ $$ = ""; 							}
							   | FunProcStatementsL							{ $$ = template("%s", $1); 			}
							   ; 

						FunProcStatementsL : fun_proc_comm   						 { $$ = template("%s", $1); 		}
							 	  		   | FunProcStatementsL ';' fun_proc_comm    { $$ = template("%s\n%s", $1,$3); 	}
								    	   ;

statement: labeled_statement
		| compound_statement
		| expression_statement
		| selection_statement
		| iteration_statement
		| jump_statement
		;

labeled_statement
	: IDENTIFIER ':' statement
	;

compound_statement
	: KW_BEGIN KW_END
	| KW_BEGIN block_item_list KW_END  
	;

block_item_list
	: block_item
	| block_item_list block_item
	;

block_item
	: declarations
	| statement
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	;

expression_statement
	: ';'
	| expression ';'
	;

selection_statement
	: KW_IF '(' expression ')' statement
	| KW_IF '(' expression ')' statement ELSE statement
	;

iteration_statement: KW_FOR variableAssignment KW_TO expression KW_DO special_body 	{ $$ = template("for(%s %s < %s; %s++)%s",$2,idenName($2),$4,idenName($2),$6);	}/*For loop ++*/
	  | KW_FOR variableAssignment KW_DOWNTO expression KW_DO special_body{ $$ = template("for(%s %s > %s; %s--)%s",$2,idenName($2),$4,idenName($2),$6); }/*For loop --*/
	  | KW_WHILE expression KW_DO special_body							{ $$ = template("while(%s)%s",$2,$4); 		 								}/*While loop*/
	  | KW_REPEAT special_body KW_UNTIL expression  				    	{ $$ = template("do%swhile( !(%s) );",$2,$4); 								}/*Repeat*/
	  ; 

jump_statement
	: GOTO IDENTIFIER ';'
	| RETURN ';'
	| RETURN expression ';'
	;

primary_expression
	: IDENT
	| CONSTANT
	| STRING_LITERAL
	| '(' expression ')'
	;

postfix_expression
	: primary_expression
	| postfix_expression '[' expression ']'
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression '.' IDENTIFIER
	| postfix_expression PTR_OP IDENTIFIER
	| postfix_expression INC_OP
	| postfix_expression DEC_OP
	| '(' type_name ')' '{' initializer_list '}'
	| '(' type_name ')' '{' initializer_list ',' '}'
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

unary_expression
	: postfix_expression
	| INC_OP unary_expression
	| DEC_OP unary_expression
	| unary_operator cast_expression
	| SIZEOF unary_expression
	| SIZEOF '(' type_name ')'
	;

unary_operator
	: '&'
	| '*'
	| '+'
	| '-'
	| '~'
	| '!'
	;

cast_expression
	: unary_expression
	| '(' type_name ')' cast_expression
	;

multiplicative_expression
	: cast_expression
	| multiplicative_expression '*' cast_expression
	| multiplicative_expression '/' cast_expression
	| multiplicative_expression '%' cast_expression
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression
	;

shift_expression
	: additive_expression
	| shift_expression LEFT_OP additive_expression
	| shift_expression RIGHT_OP additive_expression
	;

relational_expression
	: shift_expression
	| relational_expression '<' shift_expression
	| relational_expression '>' shift_expression
	| relational_expression LE_OP shift_expression
	| relational_expression GE_OP shift_expression
	;

equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression
	| equality_expression NE_OP relational_expression
	;

and_expression
	: equality_expression
	| and_expression '&' equality_expression
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression AND_OP inclusive_or_expression
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expression
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	;

assignment_operator
	: '='
	| MUL_ASSIGN
	| DIV_ASSIGN
	| MOD_ASSIGN
	| ADD_ASSIGN
	| SUB_ASSIGN
	| LEFT_ASSIGN
	| RIGHT_ASSIGN
	| AND_ASSIGN
	| XOR_ASSIGN
	| OR_ASSIGN
	;

constant_expression
	: conditional_expression
	;


%%