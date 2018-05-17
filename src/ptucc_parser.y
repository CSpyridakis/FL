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
%token KW_BOOLEAN KW_REAL KW_CHAR KW_INT KW_VAR KW_PROGRAM KW_BEGIN KW_END KW_FUNC KW_PROC KW_RESULT
%token KW_ARRAY KW_DO KW_GOTO KW_RETURN KW_ELSE KW_IF KW_OF KW_THEN KW_FOR KW_REPEAT KW_UNTIL OP_ASSIGN
%token KW_WHILE KW_TO KW_DOWNTO KW_TRUE KW_FALSE KW_TYPE OP_EQ OP_INEQ OP_LT OP_LTE OP_GT OP_GTE OP_AND OP_OR OP_NOT
%token <crepr> IDENT POSINT REAL STRING OP_CAST_INT OP_CAST_REAL OP_CAST_BOOL OP_CAST_CHAR

	/*TYPE*/
%type <crepr> statements params func_decl proc_decl bracket_list compound_type brackets funcStatements procStatements
%type <crepr> declerations declarationL basicDecleration typelist varlist idents dtype paramsList FunProcStatementsL

	/* Expressions' types */
%type <crepr> expression complexBracketsL functionCall arglistCall  

	/* Commands' types */
%type <crepr> special_body commands basicCommand variableAssignment ifStatementMiddle fun_proc_comm

%left OP_NOT '*' '/' '+' '-' OP_EQ OP_INEQ OP_LT OP_LTE OP_GT OP_GTE OP_AND OP_OR

%%

program: KW_PROGRAM IDENT ';' declerations KW_BEGIN statements KW_END '.'
{ 
	if(yyerror_count==0) {
		puts(c_prologue);
		printf("/* program  %s */ \n\n", $2);
		printf("%s\n", $4);		
		printf("int main() {\n\n%s\n\treturn 0;\n}\n",$6);
	}
};

declerations: %empty 															{ $$ = ""; 							}
			| declarationL 														{ $$ = template("%s", $1);		 	}
 			;

declarationL: basicDecleration 													{ $$ = template("%s", $1);		 	}
			| declarationL  basicDecleration 									{ $$ = template("%s%s", $1, $2); 	}
 			;	

basicDecleration: KW_TYPE typelist 	';'														   { $$ = template("%s\n", $2);		 	}
 				| KW_VAR varlist   	';'														   { $$ = template("%s\n", $2);		 	}
 				| KW_FUNC IDENT '(' params ')' ':' compound_type ';' declerations KW_BEGIN funcStatements KW_RETURN KW_END ';' 	  { $$ = template("\n%s %s(%s){\n%s result;\n%s\n%s\nreturn result;\n}\n",$7,$2,$4,$7,$9,$11); }
 				| KW_PROC IDENT '(' params ')' ';' declerations KW_BEGIN procStatements KW_END ';'  							  { $$ = template("\nvoid %s(%s){\n%s\n%s\n}\n",$2,$4,$7,$9); } 
				;
										
				typelist : IDENT OP_EQ compound_type							{ $$ = template("typedef %s %s",$1,$3); }
						 | typelist ';' IDENT OP_EQ compound_type				{ $$ = template("%s\ntypedef %s %s", $1, $3, $5); }
						 ;

				varlist : idents ':'  compound_type								{ $$ = template("%s %s;", $3, $1); }
						| varlist ';' idents ':' compound_type					{ $$ = template("%s\n%s %s;", $1, $5, $3); }
						;

						idents : IDENT 											{ $$ = template("%s", $1);		 	}
						       | idents ',' IDENT 								{ $$ = template("%s, %s", $1, $3); }
						       ; 
				       
				func_decl : KW_FUNC '(' params ')' ':' compound_type			{ char* C_ct = make_C_comp_type($6);  $$ = template("%s (*FUNCTION)(%s)", C_ct, $3); }
						 | KW_FUNC IDENT '(' params ')' ':' compound_type 		{ char* C_ct = make_C_comp_type($7);  $$ = template("%s %s(%s)", C_ct , $2, $4 ); }
					 	 ;

				proc_decl : KW_PROC '(' params ')' 								{ $$ = template("void (*PROCEDURE)(%s)", $3); } 
						  | KW_PROC IDENT '(' params ')'  						{ $$ = template("void %s(%s)", $2, $4 ); }
				          ;

				funcStatements : %empty		    						 	{ $$ = ""; 							}
							   | FunProcStatementsL	';'						{ $$ = template("%s", $1); 			}
							   ;

				procStatements : %empty		    						 	{ $$ = ""; 							}
							   | FunProcStatementsL							{ $$ = template("%s", $1); 			}
							   ; 

						FunProcStatementsL : fun_proc_comm   						 { $$ = template("%s", $1); 			}
							 	  		   | FunProcStatementsL ';' fun_proc_comm    { $$ = template("%s\n%s", $1,$3); 	}
								    	   ;

				        params : %empty		    								{ $$ = ""; 							}
				        	   | paramsList										{ $$ = template("%s",$1); 			}
	  	  					   ;

	  	  				paramsList : idents ':' compound_type	 				{ char* C_ct = make_C_comp_type($3); char* C_params = make_C_params(C_ct, $1); $$ = template("%s", C_params); }
	  	  						   | paramsList ';' idents ':' compound_type	{ char* C_ct = make_C_comp_type($5); char* C_params = make_C_params(C_ct, $3); $$ = template("%s,%s", $1, C_params);  	}
	  	  						   ;

						compound_type: dtype
							     	 | func_decl 								{ $$ = template("%s", $1); 			}
							       	 | proc_decl 								{ $$ = template("%s", $1); 			}
							     	 | KW_ARRAY bracket_list KW_OF compound_type{ $$ = make_parsable_comp_type($4, $2); }
							  		 ;

							  		dtype : KW_CHAR 							{ $$ = template("%s", "char"); 		}
						    			  | KW_INT  							{ $$ = template("%s", "int"); 		}
						    		 	  | KW_REAL 							{ $$ = template("%s", "double"); 	}
						    		 	  | KW_BOOLEAN 							{ $$ = template("%s", "int"); 		}
									 	  | IDENT 								{ $$ = template("%s", $1);			}
							  		 	  ;

									bracket_list: brackets 						{ $$ = template("%s", $1); 			}
									            | bracket_list brackets 		{ $$ = template("%s%s", $1, $2); 	}
									            ; 

									brackets: %empty  	 						{ $$ = ""; 							}
											| '[' POSINT ']'					{ $$ = template("[%s]", $2); 		}
											;

statements: %empty				       	{ $$ = ""; 								}
		  | commands		   			{ $$ = template("%s\n", $1); 			}
		  ;

special_body: %empty { $$ = ";"; }
			| basicCommand 						{ $$ = template("\n%s", $1); 			}
			| KW_BEGIN statements KW_END 		{ $$ = template("\n{\n%s\n}\n", $2); }
		    ;

expression : POSINT 							{ $$ = template("%s",$1); 		   }
		   | REAL								{ $$ = template("%s",$1); 		   }					
		   | STRING 							{ $$ = template("%s",$1); 		   } /*TODO : Change this function*/
		   | IDENT complexBracketsL 			{ $$ = template("%s%s",$1,$2); 	   }
		   | KW_TRUE 							{ $$ = template("1");	 		   }
		   | KW_FALSE							{ $$ = template("0"); 			   }
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
		  /* | '(' dtype ')' expression			{ $$ = template("(%s)%s",$2,$4);   }*/
		   ;

			complexBracketsL : %empty  										{ $$ = ""; 						  }
							 | '[' expression ']'							{ $$ = template("[%s]", $2); 	  }
							 | complexBracketsL '[' expression ']'			{ $$ = template("%s[%s]",$1,$3);  }
							 ; 

			functionCall : IDENT '(' arglistCall ')' 						{ 
																				replaceQInSTR($3);
																				if (strcmp($1, "readString")==0){
																					$$ = template("gets()");
																				}else if (strcmp($1, "readInteger")==0){
																					$$ = template("atoi(gets())");
																				}else if (strcmp($1, "readReal")==0){
																					$$ = template("atof(gets())");
																				}else if (strcmp($1, "writeString")==0){
																					$$ = template("puts(%s)",$3);
																				}else if (strcmp($1, "writeInteger")==0){
																					$$ = template("printf(\"%%d\",%s)",$3);
																				}else if (strcmp($1, "writeReal")==0){
																					$$ = template("printf(\"%%f\",%s)",$3);
																				}else{
																					$$ = template("%s(%s)",$1,$3);  
																				}
																			}
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
		 | KW_IF expression KW_THEN special_body ifStatementMiddle KW_ELSE special_body { $$ = template("if(%s)%s%selse{\n%s\n}",$2,$4,$5,$7); 									}/*If statement*/
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
						   ; 

%%