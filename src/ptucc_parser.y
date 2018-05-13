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
%token <crepr> KW_TYPE
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
%token <crepr> OP_CAST_INT
%token <crepr> OP_CAST_REAL
%token <crepr> OP_CAST_BOOL
%token <crepr> OP_CAST_CHAR

	/*TYPE*/
%type <crepr> program_decl d decl type_decl init_type_decl type_assign type_type_assign  statements statement_list param_list 
%type <crepr> func_decl proc_decl func_def proc_def def subprogram_def subprogram_decl prim_type func_body proc_body
%type <crepr> de decl_kind statement var_decl var_type_assign proc_call arguments bracket_list init_var_decl param_specifier
%type <crepr> type arglist var_list compound_type var_assign brackets

%type <crepr> body special_body main_body 

	/* Expressions' types */
%type <crepr> expression basicExpr complexExpr rawData variable functionCall basicDTV complexDTV exprWithOperators exprWithParenthsis complexBracketsL complexBrackets
%type <crepr> exprWithOneOperator exprWithTwoOperators exprWithOnePrefixOperator exprWithOneLogical numericOperation relationalOperation logicalOperation
%type <crepr> OP_CAST

	/* Commands */
%type <crepr> commands basicCommand commandGroup variableAssignment resultAssignment ifStatement ifStatementMiddle forLoop whileLoop labelStatement gotoStatement returnStatement

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

program_decl : KW_PROGRAM IDENT ';'  				{ $$ = $2; 							}
			 ;

d: de   											{ $$ = template("%s", $1); 			}
 | d de 											{ $$ = template("%s%s", $1, $2 ); 	}
 ;

de: decl  											{ $$ = template("%s", $1); 			}
  | def   											{ $$ = template("%s", $1); 			} 
  ;  	

def: subprogram_def									{ $$ = template("%s", $1); 			}
   ;

subprogram_def: func_def 							{ $$ = template("%s\n", $1); 		}
	      	  | proc_def 							{ $$ = template("%s\n", $1); 		}
	      	  ;

func_def: func_decl ';' body ';' 					{ $$ = template("%s%s", $1, $3); 	}
		;

proc_def: proc_decl ';' body ';' 					{ $$ = template("%s%s", $1, $3); 	}
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

type_type_assign: IDENT OP_EQ compound_type ';'		{ char* C_ct = make_C_comp_type($3);
													  
													  if(set_typedef($1, C_ct))
													  	$$ = template("typedef %s %s;\n", C_ct, $1);
													  else
													  	yyerror("Typedef Error!\n"); 
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

subprogram_decl: func_decl 							{ $$ = template("%s", $1); 			}
	       | proc_decl 								{ $$ = template("%s", $1); 			}
	       ; 

func_decl: KW_FUNC IDENT '(' param_list ')' ':' compound_type 	{ 
																	char* C_ct = make_C_comp_type($7); 
																	$$ = template("%s %s(%s)", C_ct , $2, $4 ); 
																}
	 	  ;

proc_decl: KW_PROC IDENT '(' param_list ')'  		{ $$ = template("void %s(%s)", $2, $4 ); }
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
	     	 | subprogram_decl 						{ $$ = template("%s", $1); 			}
	     	 | KW_ARRAY bracket_list KW_OF compound_type { $$ = make_parsable_comp_type($4, $2); }
	  		 ;

type: prim_type 									{  $$ = template("%s", $1); }
	| IDENT 										{	
														if(get_typedef($1)) 
		  													$$ = template("%s", $1);
												  		else 
												  			yyerror("Error! Typedef does not exist..."); 
												  	}
	; 

bracket_list: brackets 								{ $$ = template("%s", $1); 			}
            | bracket_list brackets 				{ $$ = template("%s%s", $1, $2); 	}
            ; 

brackets: %empty  	 								{ $$ = ""; 							}
		| '[' POSINT ']'							{ $$ = template("[%s]", $2); 		}
		;

prim_type: KW_CHAR 									{ $$ = template("%s", "char"); 		}
    | KW_INT  										{ $$ = template("%s", "int"); 		}
    | KW_REAL 										{ $$ = template("%s", "double"); 	}
    | KW_BOOLEAN 									{ $$ = template("%s", "int"); 		}
    ;


/*------------------------------------------------------------------------------------MAIN/FUNCTION/PROCEDURE BODY---------------------------------------------------------------------------------------*/

/*
	--------------
	| TODO LIST: |
	--------------
	1) Tabs fix
*/

body : KW_BEGIN statements KW_END   			{ $$ = template("{\n \n %sreturn result;\n}\n", $2); }
		  ;

special_body: %empty { $$ = ";"; }
			| basicCommand 						{ $$ = template("%s\n", $1); 			}
			| KW_BEGIN statements KW_END 		{ $$ = template("\n{\n\t%s\n}\n", $2); }
		    ;

		statements: %empty				       	{ $$ = ""; 								}
				  | commands		   			{ $$ = template("%s\n", $1); 			}
				  ;


/*---------------------------------------------	EXPRESSIONS		START	 ---------------------------------------------*/
expression : basicExpr																{ $$ = template("%s",$1); 		  }
		   | complexExpr															{ $$ = template("%s",$1); 		  }
		   ;


	/*__________	1.Basic 	__________*/		
	basicExpr : rawData																{ $$ = template("%s",$1); 		  }
			  | variable 															{ $$ = template("%s",$1); 		  }
			  | functionCall														{ $$ = template("%s",$1); 		  }
			  ;

		
			/*...1.1 RAW DATA (POS-INT, POS-REAL, STRING)...*/		
			rawData : POSINT 														{ $$ = template("%s",$1); 		  }
			        | REAL															{ $$ = template("%s",$1); 		  }					
			        | STRING 														{ $$ = template("%s",$1); 		  } /*TODO : Change this function*/
				    ;																

			/*...1.2 Variables ...*/
			variable  : basicDTV 
					  | complexDTV
					  ;

					/*1.2.1 Basic data type variable*/
					basicDTV : IDENT 												{ $$ = template("%s",$1); 		  }
						     ;

					/*1.2.2 Complex data type variable */
					complexDTV : IDENT complexBracketsL 							{ $$ = template("%s%s",$1,$2); 	  }
							   ;

							complexBracketsL : complexBrackets 						{ $$ = template("%s", $1); 		  }
							             	 | complexBracketsL complexBrackets 	{ $$ = template("%s%s", $1, $2);  }
							             	 ; 

							complexBrackets : %empty  								{ $$ = ""; 						  }
									 		| '[' expression ']'					{ $$ = template("[%s]", $2); 	  }
									 		;


			/*...1.3 Functions Calls...*/
			functionCall : IDENT '(' arguments ')' 									{ $$ = template("%s(%s)",$1,$3);  }
						 ;
						
						/*Functions Args*/	
						arguments : %empty											{ $$ = ""; 						  }
				  	  			  | arglist 										{ $$ = $1; 						  }
				  	  			  ;

						arglist: expression											{ $$ = template("%s",$1); }
			      			   | arglist ',' expression 							{ $$ = template("%s,%s", $1, $3); }
			       			   ;	


	/*__________	2.Complex	 __________*/
	complexExpr : exprWithOperators
			    | exprWithParenthsis
			    ;

			/*...2.1 WITH OPERATORS...*/
			exprWithOperators : exprWithOneOperator
							  | exprWithTwoOperators
							  ;

				    /*2.1.1 One operator*/
				    exprWithOneOperator : exprWithOnePrefixOperator
				    					| exprWithOneLogical 
				    					;

					    	/*2.1.1.1 Prefix*/
					    	exprWithOnePrefixOperator : '+' expression 				{ $$ = template("+%s",$2); 		 	}
					    							  | '-' expression 				{ $$ = template("-%s",$2); 		 	}  
					    							  | OP_CAST expression			{ $$ = template("%s%s",$1,$2); 		} 
					    							  ;

					    					OP_CAST : OP_CAST_INT 					{ $$ = template("(int)"); 		 	}
					    						    | OP_CAST_CHAR 					{ $$ = template("(char)");			}
					    						    | OP_CAST_REAL 					{ $$ = template("(float)");			}
					    						    | OP_CAST_BOOL 					{ $$ = template("(int)");			}
					    						    ;


					    	/*2.1.1.2 OneLogical*/
					    	exprWithOneLogical : OP_NOT expression 	   				{ $$ = template("!%s",$2);  		}
					    					   ;	
					    	

				    /*2.1.2 Two operators*/
					exprWithTwoOperators : numericOperation
										 | relationalOperation
										 | logicalOperation
										 ;

							/*------------	Basic Operations Implementation START ------------*/
							numericOperation 	: expression '+' expression 		{ $$ = template("%s + %s",$1,$3);  }
											 	| expression '-' expression 		{ $$ = template("%s - %s",$1,$3);  }
											 	| expression '/' expression 		{ $$ = template("%s / %s",$1,$3);  }
											 	| expression '*' expression 		{ $$ = template("%s * %s",$1,$3);  }
											 	| expression '%' expression 		{ $$ = template("%s % %s",$1,$3);  }
							    			 	;

							relationalOperation : expression OP_EQ   expression 	{ $$ = template("%s == %s",$1,$3); }
											    | expression OP_INEQ expression 	{ $$ = template("%s != %s",$1,$3); }
											    | expression OP_LT   expression 	{ $$ = template("%s < %s",$1,$3);  }
											    | expression OP_LTE  expression 	{ $$ = template("%s <= %s",$1,$3); }
											    | expression OP_GT   expression 	{ $$ = template("%s > %s",$1,$3);  }
											    | expression OP_GTE  expression 	{ $$ = template("%s >= %s",$1,$3); }
											    ;

							logicalOperation    : expression OP_AND  expression 	{ $$ = template("%s && %s",$1,$3); }
											    | expression OP_OR   expression 	{ $$ = template("%s || %s",$1,$3); }
											    ;
							/************	Basic Operations Implementation END ************/


			/*...2.2 WITH PARETHESIS...*/
			exprWithParenthsis 		  : '(' expression ')'						 	{ $$ = template("(%s)",$2);    	   }
							   		  | expression '(' expression ')'				{ $$ = template("%s (%s)",$1,$3);  }
							   		  ; 

/************************************************	EXPRESSIONS		END		 ************************************************/

/*---------------------------------------------		COMMANDS	START	 ---------------------------------------------*/
commands : basicCommand																{ $$ = template("%s",$1); 				}
		 | commandGroup																{ $$ = template("%s",$1);				}
		 ;

	/*__________	1. Basic 	__________*/
	basicCommand : variableAssignment 												{ $$ = template("%s;",$1); 				}
				 | resultAssignment													{ $$ = template("%s;",$1); 				}
				 | ifStatement 														{ $$ = template("%s",$1); 				}
				 | forLoop 															{ $$ = template("%s",$1); 				}
				 | whileLoop 														{ $$ = template("%s",$1); 				}
				 | labelStatement 													{ $$ = template("%s",$1); 				}
				 | gotoStatement 													{ $$ = template("%s;",$1);				}
				 | returnStatement													{ $$ = template("%s;",$1);				}
				 | functionCall														{ $$ = template("%s;",$1); 				}
				 ;
			

			/*------------	Basic Commands Implementation START ------------*/
			variableAssignment : IDENT OP_ASSIGN expression 						{ $$ = template("%s = %s",$1,$3);	  	}
							   | IDENT complexBracketsL OP_ASSIGN expression		{ $$ = template("%s%s = %s",$1,$2,$4);	}
							   ;

			resultAssignment : KW_RESULT OP_ASSIGN expression 						{ $$ = template("result = %s",$3);    	}
							 ;

		 	ifStatement : KW_IF expression KW_THEN special_body ifStatementMiddle	{ $$ = template("if(%s)%s%s",$2,$4,$5); }
		 				;

		 				ifStatementMiddle : %empty 									{ $$ = ""; 	    						}
	 									  | KW_ELSE KW_IF expression KW_THEN special_body ifStatementMiddle { $$ = template("else if(%s)%s%s",$3,$5,$6); }
		 			   					  |	KW_ELSE special_body 					{ $$ = template("else%s",$2); 			}
		 								  ; 

		 	forLoop : KW_FOR variableAssignment KW_TO expression KW_DO special_body 	{ $$ = template("for(%s;%s<%s;%s++)%s",$2,incrementStep($2),$4,incrementStep($2),$6);}
					| KW_FOR variableAssignment KW_DOWNTO expression KW_DO special_body { $$ = template("for(%s;%s>%s;%s--)%s",$2,incrementStep($2),$4,incrementStep($2),$6);}
		 	  	    ; 

		 	whileLoop : KW_WHILE expression KW_DO special_body							 { $$ = template("while(%s)%s",$2,$4); 		 }
		 			  | KW_REPEAT special_body KW_UNTIL expression  				     { $$ = template("do%swhile(!(%s));",$2,$4); }
		 			  ;	
		 			  

		 	labelStatement : IDENT ':'  											{ $$ = template("%s:\n ",$1);		}
		 				   | IDENT ':' commandGroup									{ $$ = template("%s:\n 	%s",$1,$3);	}			
		 				   ;	

		 	gotoStatement : KW_GOTO  IDENT											{ $$ = template("goto %s",$2);		}
		 				  ;

		 	returnStatement : KW_RETURN 											{ $$ = template("return result");	}
		 				    ;
			/***********	Basic Commands Implementation END ***********/


	/*__________	2. Complex	 __________*/
	commandGroup : basicCommand														{ $$ = template("%s",$1);			}
				 | commandGroup ';' basicCommand 									{ $$ = template("%s\n%s",$1,$3);    }
				 ; 
/************************************************	COMMANDS	END		 ************************************************/

%%