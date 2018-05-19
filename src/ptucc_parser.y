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
%token KW_IF 
%token KW_OF  
%token KW_FOR 
%token KW_REPEAT 
%token KW_UNTIL 
%token OP_ASSIGN
%token KW_WHILE 
%token KW_TO 
%token KW_DOWNTO 
%token KW_TRUE 
%token KW_FALSE 
%token KW_TYPE 
%token SYM_COL
%token SYM_COMMA
%token SYM_DOT SYM_SEMI
%token <crepr> IDENT 
%token <crepr> POSINT 
%token <crepr> REAL 
%token <crepr> STRING 

	/*---------------TYPE---------------*/
	/* Program */
%type <crepr> declarations statements declarationL basicDeclaration
	
	/* Declerations */
%type <crepr> typelist varlist params compound_type funcStatements procStatements idents paramsList dtype bracket_list brackets fun_proc_comm FunProcStatementsL

	/* Commands */
%type <crepr> special_body commands basicCommand variableAssignment ifStatement special_body_list arglist complexBracketsL repeat_special_body repeat_special_body_list
          
	/* Expressions */
%type <crepr> expression complexBrackets functionCall arglistCall prefixExpression numericExpression binary_op unary_op relationalExpression relational_op logicalExpression logical_op parenthExpression basicExpression primitiveExpression castExpression


	/*------------------------------*/
%left OP_OR
%left OP_AND
%left OP_EQ OP_INEQ OP_LT OP_GT OP_LTE OP_GTE 
%left OP_ADD OP_MINUS
%left OP_MUL OP_DIV OP_MOD
%left SYM_L_P SYM_R_P SYM_L_B SYM_R_B
%nonassoc PREFIX
%nonassoc OP_NOT
%nonassoc KW_THEN
%nonassoc KW_ELSE
%%

program: KW_PROGRAM IDENT SYM_SEMI declarations KW_BEGIN statements KW_END SYM_DOT
{ 
	if(yyerror_count==0) {
		fprintf(stderr,"Trans-Compiled in C!");
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

basicDeclaration: KW_TYPE typelist 	SYM_SEMI														   { $$ = template("%s\n", $2);		 	}
 				| KW_VAR varlist   	SYM_SEMI														   { $$ = template("%s\n", $2);		 	}
 				| KW_FUNC IDENT SYM_L_P params SYM_R_P SYM_COL compound_type SYM_SEMI declarations KW_BEGIN funcStatements KW_RETURN KW_END SYM_SEMI 	  { $$ = template("\n%s %s(%s){\n%s result;\n%s\n%s\nreturn result;\n}\n",$7,$2,$4,$7,$9,$11); }
 				| KW_PROC IDENT SYM_L_P params SYM_R_P SYM_SEMI declarations KW_BEGIN procStatements KW_END SYM_SEMI  							  { $$ = template("\nvoid %s(%s){\n%s\n%s\n}\n",$2,$4,$7,$9); } 
				;

				typelist : IDENT OP_EQ compound_type							{ char* ct = $3;
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

						 | typelist SYM_SEMI IDENT OP_EQ compound_type				{ char* ct = $5;
																				  char* id = $3;
																				  char* secnd_tl = NULL;	
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

				varlist : idents SYM_COL  compound_type								{ char* C_decl = make_C_decl($3, $1); 
																				  $$ = template("%s;\n", C_decl); }
						| varlist SYM_SEMI idents SYM_COL compound_type					{   char* C_decl = make_C_decl($5, $3); 
																					$$ = template("%s%s;\n", $1, C_decl); }
						;

						idents : IDENT 											{ $$ = template("%s", $1);		 	}
						       | idents SYM_COMMA IDENT 								{ $$ = template("%s, %s", $1, $3); }
						       ; 


		        params : %empty		    								{ $$ = ""; 							}
		        	   | paramsList										{ $$ = template("%s",$1); 			}
	  				   ;

		  				paramsList : idents SYM_COL compound_type	 				{ char* C_ct = make_C_comp_type($3); char* C_params = make_C_params(C_ct, $1); $$ = template("%s", C_params); }
		  						   | paramsList SYM_SEMI idents SYM_COL compound_type	{ char* C_ct = make_C_comp_type($5); char* C_params = make_C_params(C_ct, $3); $$ = template("%s,%s", $1, C_params);  	}
		  						   ;

				compound_type: dtype											{ $$ = template("%s", $1);				}
					     	 | KW_ARRAY bracket_list KW_OF compound_type		{ $$ = make_parsable_comp_type($4, $2); }
					     	 | KW_FUNC SYM_L_P params SYM_R_P SYM_COL compound_type			{ char* C_ct = make_C_comp_type($6);  $$ = template("%s (*FUNCTION)(%s)", C_ct, $3); }
					       	 | KW_PROC SYM_L_P params SYM_R_P 							{ $$ = template("void (*PROCEDURE)(%s)", $3); } 
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

							brackets : SYM_L_B POSINT SYM_R_B					{ $$ = template("[%s]", $2); 		}
									 | brackets SYM_L_B POSINT SYM_R_B			{ $$ = template("%s[%s]",$1, $3); 	}
									 ;
								

				       
				funcStatements : %empty		    						 	{ $$ = ""; 							}
							   | FunProcStatementsL	SYM_SEMI						{ $$ = template("%s", $1); 			}
							   ;

				procStatements : %empty		    						 	{ $$ = ""; 							}
							   | FunProcStatementsL							{ $$ = template("%s", $1); 			}
							   ; 

						FunProcStatementsL : fun_proc_comm   						 { $$ = template("%s", $1); 		}
							 	  		   | FunProcStatementsL SYM_SEMI fun_proc_comm    { $$ = template("%s\n%s", $1,$3); 	}
								    	   ;


statements: %empty				       	{ $$ = ";"; 								}
		  | commands		   			{ $$ = template("%s\n", $1); 			}
		  ;		

commands : basicCommand															{ $$ = template("%s\n", $1); 	  }
		 | commands SYM_SEMI basicCommand 											{ $$ = template("%s\n%s",$1,$3);  }
		 ;

basicCommand : fun_proc_comm													{ $$ = template("%s",$1); 			}
			 | KW_RETURN 														{ $$ = template("return result;");	}/*Return*/
		 	 ;

fun_proc_comm: variableAssignment
			 | KW_RESULT OP_ASSIGN expression 									{ $$ = template("result = %s;",$3);    										}/*Result assignment*/
			 | ifStatement 														{ $$ = template("%s", $1); 			}
			 | KW_FOR variableAssignment KW_TO expression KW_DO special_body 	{ $$ = template("for(%s %s < %s; %s++)%s",$2,idenName($2),$4,idenName($2),$6);	}/*For loop ++*/
			 | KW_FOR variableAssignment KW_DOWNTO expression KW_DO special_body{ $$ = template("for(%s %s > %s; %s--)%s",$2,idenName($2),$4,idenName($2),$6); }/*For loop --*/
			 | KW_WHILE expression KW_DO special_body							{ $$ = template("while(%s)%s",$2,$4); 		 								}/*While loop*/
			 | KW_REPEAT repeat_special_body KW_UNTIL expression  				    	{ $$ = template("do%swhile( !(%s) );",$2,$4); 								}/*Repeat*/
			 | IDENT SYM_COL statements												{ $$ = template("%s:\n%s",$1,$3);											}/*Label with statements*/
			 | KW_GOTO IDENT													{ $$ = template("goto %s;",$2);												}/*Goto statement*/
			 | functionCall														{ $$ = template("%s;",$1); 	}		
			 ; 

		 variableAssignment: IDENT complexBrackets OP_ASSIGN expression					{ $$ = template("%s%s = %s;",$1,$2,$4);				}
				           ;

					complexBrackets : %empty  										{ $$ = ""; }
									| complexBracketsL								{ $$ = template("%s", $1); }
									; 

					complexBracketsL:  SYM_L_B expression SYM_R_B							{ $$ = template("[%s]", $2); }
									| complexBracketsL SYM_L_B expression SYM_R_B			{ $$ = template("%s[%s]",$1,$3);  }
									; 

		 ifStatement : KW_IF expression KW_THEN special_body							{ $$ = template("if(%s)%s",$2,$4); 					}
			 		 | KW_IF expression KW_THEN special_body KW_ELSE special_body 		{ $$ = template("if(%s)%s\nelse{\n%s\n}",$2,$4,$6); }
				     ; 


		functionCall : IDENT SYM_L_P arglistCall SYM_R_P 						{ 
																	replaceQInSTR($3);
																	// if (strcmp($1, "readString")==0){
																	// 	$$ = template("gets()");
																	// }else if (strcmp($1, "readInteger")==0){
																	// 	//$$ = template("(int)atoi((char*)gets())");
																	// 	$$ = template("scanf(\"%%d\",&tmp)");
																	// }else if (strcmp($1, "readReal")==0){
																	// 	$$ = template("atof(gets())");
																	// }else if (strcmp($1, "writeString")==0){
																	// 	$$ = template("puts(%s)",$3);
																	// }else if (strcmp($1, "writeInteger")==0){
																	// 	$$ = template("printf(\"%%d\",%s)",$3);
																	// }else if (strcmp($1, "writeReal")==0){
																	// 	$$ = template("printf(\"%%f\",%s)",$3);
																	// }else{
																	// 	$$ = template("%s(%s)",$1,$3);  
																	// }
																	
																	$$ = template("%s(%s)",$1,$3);  

																}
			 		;

					arglistCall: %empty 	{ $$ = ""; }
						       |  arglist   { $$ = template("%s",$1);}
						       ;

				    arglist : expression						{ $$ = template("%s",$1);}
		      			    | arglist SYM_COMMA expression 		{ $$ = template("%s,%s", $1, $3); }
		      			    ;	


special_body: %empty { $$ = ";"; }
			| special_body_list { $$ = template("%s", $1); }
		    ;
special_body_list: basicCommand 					{ $$ = template("\n%s", $1); }
				 | KW_BEGIN statements KW_END 		{ $$ = template("{\n%s\n}\n", $2); }
				 ;

repeat_special_body : %empty { $$ = ";"; }
					| repeat_special_body_list { $$ = template("%s", $1); }
		     		;
repeat_special_body_list : basicCommand 						{ $$ = template("\n%s", $1); }
				 		 | KW_BEGIN statements KW_END SYM_SEMI	{ $$ = template("{\n%s\n}\n", $2); }
						 ;



expression: basicExpression					{ $$ = template("%s",$1); 		   }
	      | prefixExpression				{ $$ = template("%s",$1); 		   }
	      | numericExpression				{ $$ = template("%s",$1); 		   }
	      | relationalExpression			{ $$ = template("%s",$1); 		   }
	      | logicalExpression				{ $$ = template("%s",$1); 		   }
	      | parenthExpression				{ $$ = template("%s",$1); 		   }
	  	  | castExpression					{ $$ = template("%s",$1); 		   }
	      | KW_RESULT						{ $$ = template("result"); 		   }
	      | functionCall					{ $$ = template("%s",$1); 		   }
	      ;

		basicExpression : primitiveExpression				{ $$ = template("%s",$1); 		   }
					    | IDENT complexBrackets 			{ $$ = template("%s%s",$1,$2); 	   }
					    ;

				primitiveExpression : POSINT 				{ $$ = template("%s",$1); 		   }
							        | REAL					{ $$ = template("%s",$1); 		   }					
							        | STRING 				{ $$ = template("%s",$1); 		   } 
							        | KW_TRUE 				{ $$ = template("1");	 		   }
							        | KW_FALSE				{ $$ = template("0"); 			   }
							        ;

prefixExpression: unary_op expression %prec PREFIX			{ $$ = template("%s%s",$1,$2); 	   }
				;	
			unary_op: OP_ADD 								{ $$ = template("+"); 			   }
			        | OP_MINUS 								{ $$ = template("-"); 			   }
			        | OP_NOT 								{ $$ = template("!"); 			   }
			        ;

numericExpression: expression binary_op expression 			{ $$ = template("%s %s %s",$1,$2,$3);  }
		     ;
			binary_op: OP_ADD 								{ $$ = template("+"); 			   }
			         | OP_MINUS 							{ $$ = template("-"); 			   }
			         | OP_DIV 								{ $$ = template("/"); 			   }
			         | OP_MUL 								{ $$ = template("*"); 			   }
			         | OP_MOD 								{ $$ = template("%%"); 			   }
			         ;

relationalExpression: expression relational_op expression 	{ $$ = template("%s %s %s",$1,$2,$3); }
				     ; 
			relational_op: OP_EQ 							{ $$ = template("=="); 			   }
						 | OP_INEQ 							{ $$ = template("!="); 			   }
						 | OP_LT 							{ $$ = template("<"); 			   }
						 | OP_LTE 							{ $$ = template("<="); 			   }
						 | OP_GT 							{ $$ = template(">"); 			   }
						 | OP_GTE 							{ $$ = template(">="); 			   }
						 ;

logicalExpression: expression logical_op expression 		{ $$ = template("%s %s %s",$1,$2,$3); }
 				  ;
 	   logical_op : OP_AND 									{ $$ = template("&&"); 			   }
          		  | OP_OR 									{ $$ = template("||"); 			   }
          		  ;

parenthExpression: SYM_L_P expression SYM_R_P				{ $$ = template("(%s)",$2);    	   }
		     	  | expression SYM_L_P expression SYM_R_P	{ $$ = template("%s (%s)",$1,$3);  }
		     	  ;

castExpression: SYM_L_P dtype SYM_R_P expression			{ $$ = template("(%s)%s",$2,$4);   }

%%