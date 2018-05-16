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

	/*TOKEN*/
%token <crepr> IDENT
%token <crepr> POSINT 
%token <crepr> REAL 
%token <crepr> STRING
%token KW_BOOLEAN
%token KW_REAL
%token KW_CHAR
%token KW_INT
%token KW_VAR
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
%token KW_ELSE
%token KW_IF
%token KW_OF
%token KW_THEN
%token KW_FOR
%token KW_REPEAT
%token KW_UNTIL
%token KW_WHILE
%token KW_TO
%token KW_DOWNTO
%token KW_TRUE
%token KW_FALSE
%token KW_TYPE
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
%token <crepr> OP_CAST_INT
%token <crepr> OP_CAST_REAL
%token <crepr> OP_CAST_BOOL
%token <crepr> OP_CAST_CHAR

	/*TYPE*/
%type <crepr> program_decl d decl type_decl init_type_decl type_assign type_type_assign  statements param_list 
%type <crepr> func_decl proc_decl   
%type <crepr> de decl_kind  var_decl var_type_assign bracket_list init_var_decl param_specifier
%type <crepr> type var_list compound_type var_assign brackets

%type <crepr> special_body

	/* Expressions' types */
%type <crepr> expression complexBracketsL functionCall arglistCall  

	/* Commands */
%type <crepr> commands basicCommand variableAssignment ifStatementMiddle fun_proc_comm func_proc_statements

%left OP_NOT '*' '/' '+' '-' OP_EQ OP_INEQ OP_LT OP_LTE OP_GT OP_GTE OP_AND OP_OR

%%

program: program_decl d KW_BEGIN statements KW_END '.'
{ 
	/* We have a successful parse! 
		Check for any errors and generate output. 
	*/
	if(yyerror_count==0) {
		puts(c_prologue);
		printf("/* program  %s */ \n\n", $1);
		printf("%s\n", $2);		
		printf("int main() {\n\n%s\n\treturn 0;\n}\n",$4);
	}
};

program_decl : KW_PROGRAM IDENT ';'  				{ $$ = $2; 							}
			 ;

d: %empty 											{ $$ = ""; 							}
 | de   											{ $$ = template("%s", $1); 			}
 | d de 											{ $$ = template("%s%s", $1, $2 ); 	}
 ;

de: decl  													   			{ $$ = template("%s", $1); 			}
  | func_decl ';' KW_BEGIN func_proc_statements KW_RETURN KW_END ';' 	{ $$ = template("\n%s{\n%s\nreturn result;\n}\n",$1, $4); }
  | proc_decl ';' KW_BEGIN func_proc_statements KW_END  ';'			   	{ $$ = template("\n%s{\n%s\n}\n",$1, $4); } 
  ;	

decl: decl_kind  									{ $$ = template("%s",$1); 			}
    | decl decl_kind 								{ $$ = template("%s%s", $1, $2 ); 	}
    ;

decl_kind: var_decl 	   							{ $$ = template("%s",$1); 			}
	 | type_decl 									{ $$ = template("%s",$1); 			}
	 ;

type_decl: init_type_decl 							{ $$ = template("%s",$1); 			}
         | type_decl init_type_decl 				{ $$ = template("%s%s",$1, $2); 	}
         ;	

init_type_decl: KW_TYPE type_assign 				{ $$ = template("%s", $2); 			} 
	      	  ; 

type_assign: type_type_assign 						{ $$ = template("%s", $1); 			}
	   | type_assign type_type_assign 				{ $$ = template("%s%s", $1, $2 ); 	}
	   ;

type_type_assign: IDENT OP_EQ compound_type ';'		{ char* ct = $3;
													  char* id = $1;
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
				;

var_decl: init_var_decl 							{ $$ = template("%s",$1); 			}
		| var_decl init_var_decl 					{ $$ = template("%s%s", $1, $2 ); 	}
        ;

init_var_decl: KW_VAR var_assign 					{ $$ = template("%s", $2); 			} 
	     	 ;

var_assign: var_type_assign 						{ $$ = template("%s", $1); 			}
	  | var_assign var_type_assign 					{ $$ = template("%s%s", $1, $2 ); 	}
	  ; 

var_type_assign: var_list ':' compound_type ';'  	{ 
														char* C_decl = make_C_decl($3, $1); 
														$$ = template("%s;\n", C_decl); 
													}
	       		; 

func_decl: KW_FUNC '(' param_list ')' ':' compound_type			{   char* C_ct = make_C_comp_type($6); 
																	$$ = template("%s (*FUNCTION)(%s)", C_ct, $3); }
		 | KW_FUNC IDENT '(' param_list ')' ':' compound_type 	{ 
																	char* C_ct = make_C_comp_type($7); 
																	$$ = template("%s %s(%s)", C_ct , $2, $4 ); 
																}
	 	  ;

proc_decl: KW_PROC '(' param_list ')' 				{ $$ = template("void (*PROCEDURE)(%s)", $3); } 
		 | KW_PROC IDENT '(' param_list ')'  		{ $$ = template("void %s(%s)", $2, $4 ); }
         ;

param_list: param_specifier	 						{ $$ = template("%s",$1); 			}
          | param_list param_specifier				{ $$ = template("%s%s", $1, $2);  	}
	  
	  	  ;

param_specifier: %empty 							{ $$ = "";							}
	       | var_list ':' compound_type     		{ 
	       												char* C_ct = make_C_comp_type($3); 
	       												char* C_params = make_C_params(C_ct, $1);
	       												$$ = template("%s", C_params); 
	       											}
	
	       | var_list ':' compound_type ';' 		{ 
	       												char* C_ct = make_C_comp_type($3);
					          							char* C_params = make_C_params(C_ct, $1);
						  								$$ = template("%s, ", C_params); 
						  							}
	       ; 

var_list: IDENT
        | var_list ',' IDENT 						{ $$ = template("%s, %s", $1, $3); }
        ; 

compound_type: type 								{ $$ = template("%s", $1); 			}
	     	 | func_decl 							{ $$ = template("%s", $1); 			}
	       	 | proc_decl 								{ $$ = template("%s", $1); 			}
	     	 | KW_ARRAY bracket_list KW_OF compound_type { $$ = make_parsable_comp_type($4, $2); }
	  		 ;

type: KW_CHAR 									{ $$ = template("%s", "char"); 		}
    | KW_INT  										{ $$ = template("%s", "int"); 		}
    | KW_REAL 										{ $$ = template("%s", "double"); 	}
    | KW_BOOLEAN 									{ $$ = template("%s", "int"); 		}
	| IDENT 										{ $$ = template("%s", $1); }
	; 

bracket_list: brackets 								{ $$ = template("%s", $1); 			}
            | bracket_list brackets 				{ $$ = template("%s%s", $1, $2); 	}
            ; 

brackets: %empty  	 								{ $$ = ""; 							}
		| '[' POSINT ']'							{ $$ = template("[%s]", $2); 		}
		;

/*------------------------------------------------------------------------------------MAIN/FUNCTION/PROCEDURE BODY---------------------------------------------------------------------------------------*/

/*
	--------------
	| TODO LIST: |
	--------------
	1) Tabs fix
*/

special_body: %empty { $$ = ";"; }
			| basicCommand 						{ $$ = template("\n%s", $1); 			}
			| KW_BEGIN statements KW_END 		{ $$ = template("\n{\n%s\n}\n", $2); }
		    ;

		func_proc_statements : %empty		    						{ $$ = ""; 								}
							 | fun_proc_comm   ';' 						{ $$ = template("%s", $1); 			}
							 | func_proc_statements fun_proc_comm  ';'  { $$ = template("%s\n%s", $1,$2); 		}
							 ;

		statements: %empty				       	{ $$ = ""; 								}
				  | commands		   			{ $$ = template("%s\n", $1); 			}
				  ;


expression : POSINT 							{ $$ = template("%s",$1); 		   }
		   | REAL								{ $$ = template("%s",$1); 		   }					
		   | STRING 							{ $$ = template("%s",$1); 		   } /*TODO : Change this function*/
		   | IDENT complexBracketsL 			{ $$ = template("%s%s",$1,$2); 	   }
		   | functionCall						{ $$ = template("%s",$1); 		   }
		   | '+' expression 					{ $$ = template("+%s",$2); 		   }
		   | '-' expression 					{ $$ = template("-%s",$2); 		   }  
		   | OP_NOT expression 	   				{ $$ = template("!%s",$2);  	   }
		   | expression '+' expression 			{ $$ = template("%s + %s",$1,$3);  }
		   | expression '-' expression 			{ $$ = template("%s - %s",$1,$3);  }
		   | expression '/' expression 			{ $$ = template("%s / %s",$1,$3);  }
		   | expression '*' expression 			{ $$ = template("%s * %s",$1,$3);  }
		   | expression '%' expression 			{ $$ = template("%s % %s",$1,$3);  }
		   | expression OP_EQ   expression 		{ $$ = template("%s == %s",$1,$3); }
		   | expression OP_INEQ expression 		{ $$ = template("%s != %s",$1,$3); }
		   | expression OP_LT   expression 		{ $$ = template("%s < %s",$1,$3);  }
		   | expression OP_LTE  expression 		{ $$ = template("%s <= %s",$1,$3); }
		   | expression OP_GT   expression 		{ $$ = template("%s > %s",$1,$3);  }
		   | expression OP_GTE  expression 		{ $$ = template("%s >= %s",$1,$3); }
		   | expression OP_AND  expression 		{ $$ = template("%s && %s",$1,$3); }
		   | expression OP_OR   expression 		{ $$ = template("%s || %s",$1,$3); }
		   | '(' expression ')'					{ $$ = template("(%s)",$2);    	   }
		   | expression '(' expression ')'		{ $$ = template("%s (%s)",$1,$3);  }		
		   ;


			complexBracketsL : %empty  										{ $$ = ""; 						  }
							 | '[' expression ']'							{ $$ = template("[%s]", $2); 	  }
							 | complexBracketsL '[' expression ']'			{ $$ = template("%s[%s]",$1,$3);  }
							 ; 

			functionCall : IDENT '(' arglistCall ')' 						{ $$ = template("%s(%s)",$1,$3);  }
						 ;

						arglistCall: %empty 								{ $$ = ""; 	    				}
							   | expression								    { $$ = template("%s",$1);		  }
			      			   | arglistCall ',' expression 				{ $$ = template("%s,%s", $1, $3); }
			      			   
			       			   ;	

commands : basicCommand
		 | commands ';' basicCommand 										{ $$ = template("%s\n%s",$1,$3);  }
		 ;


fun_proc_comm:variableAssignment
		 | KW_RESULT OP_ASSIGN expression 									{ $$ = template("result = %s;",$3);    										}/*Result assignment*/
		 | KW_IF expression KW_THEN special_body ifStatementMiddle			{ $$ = template("if(%s)%s%s",$2,$4,$5); 									}/*If statement*/
		 | KW_FOR variableAssignment KW_TO expression KW_DO special_body 	{ $$ = template("for(%s %s < %s; %s++)%s",$2,idenName($2),$4,idenName($2),$6);	}/*For loop ++*/
		 | KW_FOR variableAssignment KW_DOWNTO expression KW_DO special_body{ $$ = template("for(%s %s > %s; %s--)%s",$2,idenName($2),$4,idenName($2),$6); }/*For loop --*/
		 | KW_WHILE expression KW_DO special_body							{ $$ = template("while(%s)%s",$2,$4); 		 								}/*While loop*/
		 | KW_REPEAT special_body KW_UNTIL expression  				    	{ $$ = template("do%swhile( !(%s) );",$2,$4); 								}/*Repeat*/
		 | IDENT ':'  														{ $$ = template("%s:\n",$1);												}/*Empty Label*/
		 | IDENT ':' commands												{ $$ = template("%s:\n%s",$1,$3);											}/*Label with statements*/		
		 | KW_GOTO IDENT													{ $$ = template("goto %s;",$2);												}/*Goto statement*/
		 | functionCall														{ $$ = template("%s;",$1); 	}		
		 ; 

basicCommand : variableAssignment
		 | KW_RESULT OP_ASSIGN expression 									{ $$ = template("result = %s;",$3);    										}/*Result assignment*/
		 | KW_IF expression KW_THEN special_body ifStatementMiddle			{ $$ = template("if(%s)%s%s",$2,$4,$5); 									}/*If statement*/
		 | KW_FOR variableAssignment KW_TO expression KW_DO special_body 	{ $$ = template("for(%s %s < %s; %s++)%s",$2,idenName($2),$4,idenName($2),$6);	}/*For loop ++*/
		 | KW_FOR variableAssignment KW_DOWNTO expression KW_DO special_body{ $$ = template("for(%s %s > %s; %s--)%s",$2,idenName($2),$4,idenName($2),$6); }/*For loop --*/
		 | KW_WHILE expression KW_DO special_body							{ $$ = template("while(%s)%s",$2,$4); 		 								}/*While loop*/
		 | KW_REPEAT special_body KW_UNTIL expression  				    	{ $$ = template("do%swhile( !(%s) );",$2,$4); 								}/*Repeat*/
		 | IDENT ':'  														{ $$ = template("%s:\n",$1);												}/*Empty Label*/
		 | IDENT ':' commands												{ $$ = template("%s:\n%s",$1,$3);											}/*Label with statements*/		
		 | KW_GOTO IDENT													{ $$ = template("goto %s;",$2);												}/*Goto statement*/
		 | KW_RETURN 														{ $$ = template("return result;");											}/*Return*/
		 | functionCall														{ $$ = template("%s;",$1); 													}/*Function call*/
		 ;

		 variableAssignment: IDENT complexBracketsL OP_ASSIGN expression	{ $$ = template("%s%s = %s;",$1,$2,$4);										}/*Variable assignment*/
				           ;

		 ifStatementMiddle : %empty 										{ $$ = ""; 	    							 }
	 	 				   | KW_ELSE KW_IF expression KW_THEN special_body ifStatementMiddle  { $$ = template("else if(%s)%s%s",$3,$5,$6); }
		    			   | KW_ELSE special_body 							{ $$ = template("else%s",$2); 				 }
						   ; 

%%