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
%token <crepr> KW_IF 
%token <crepr> KW_OF 
%token <crepr> KW_THEN 
%token <crepr> KW_FOR 
%token <crepr> KW_REPEAT 
%token <crepr> KW_UNTIL 
%token <crepr> OP_ASSIGN
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
%token <crepr> IDENT 
%token <crepr> POSINT 
%token <crepr> REAL 
%token <crepr> STRING 
%token <crepr> OP_CAST_INT 
%token <crepr> OP_CAST_REAL 
%token <crepr> OP_CAST_BOOL 
%token <crepr> OP_CAST_CHAR

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

basicDeclaration: KW_TYPE typelist 	';'														   { $$ = template("%s\n", $2);		 	}
 				| KW_VAR varlist   	';'														   { $$ = template("%s\n", $2);		 	}
 				| KW_FUNC IDENT '(' params ')' ':' compound_type ';' declarations KW_BEGIN funcStatements KW_RETURN KW_END ';' 	  { $$ = template("\n%s %s(%s){\n%s result;\n%s\n%s\nreturn result;\n}\n",$7,$2,$4,$7,$9,$11); }
 				| KW_PROC IDENT '(' params ')' ';' declarations KW_BEGIN procStatements KW_END ';'  							  { $$ = template("\nvoid %s(%s){\n%s\n%s\n}\n",$2,$4,$7,$9); } 
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

						 | typelist ';' IDENT OP_EQ compound_type				{ char* ct = $5;
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


statements: %empty				       	{ $$ = ";"; 								}
		  | commands		   			{ $$ = template("%s\n", $1); 			}
		  ;		

commands : basicCommand															{ $$ = template("%s\n", $1); 	  }
		 | commands ';' basicCommand 											{ $$ = template("%s\n%s",$1,$3);  }
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
			 | IDENT ':' statements												{ $$ = template("%s:\n%s",$1,$3);											}/*Label with statements*/
			 | KW_GOTO IDENT													{ $$ = template("goto %s;",$2);												}/*Goto statement*/
			 | functionCall														{ $$ = template("%s;",$1); 	}		
			 ; 

		 variableAssignment: IDENT complexBrackets OP_ASSIGN expression					{ $$ = template("%s%s = %s;",$1,$2,$4);				}
				           ;

					complexBrackets : %empty  										{ $$ = ""; }
									| complexBracketsL								{ $$ = template("%s", $1); }
									; 

					complexBracketsL:  '[' expression ']'							{ $$ = template("[%s]", $2); }
									| complexBracketsL '[' expression ']'			{ $$ = template("%s[%s]",$1,$3);  }
									; 

		 ifStatement : KW_IF expression KW_THEN special_body							{ $$ = template("if(%s)%s",$2,$4); 					}
			 		 | KW_IF expression KW_THEN special_body KW_ELSE special_body 		{ $$ = template("if(%s)%s\nelse{\n%s\n}",$2,$4,$6); }
				     ; 


		functionCall : IDENT '(' arglistCall ')' 						{ 
																	replaceQInSTR($3);
																	if (strcmp($1, "readString")==0){
																		$$ = template("gets()");
																	}else if (strcmp($1, "readInteger")==0){
																		//$$ = template("(int)atoi((char*)gets())");
																		$$ = template("scanf(\"%%d\",&tmp)");
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
																	
																	//$$ = template("%s(%s)",$1,$3);  

																}
			 		;

					arglistCall: %empty 	{ $$ = ""; }
						       |  arglist   { $$ = template("%s",$1);}
						       ;

				    arglist : expression					{ $$ = template("%s",$1);}
		      			    | arglist ',' expression 		{ $$ = template("%s,%s", $1, $3); }
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
repeat_special_body_list : basicCommand 					{ $$ = template("\n%s", $1); }
				 		 | KW_BEGIN statements KW_END ';'	{ $$ = template("{\n%s\n}\n", $2); }
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
			unary_op: '+' 									{ $$ = template("+"); 			   }
			        | '-' 									{ $$ = template("-"); 			   }
			        | OP_NOT 								{ $$ = template("!"); 			   }
			        ;

numericExpression: expression binary_op expression 			{ $$ = template("%s %s %s",$1,$2,$3);  }
		     ;
			binary_op: '+' 									{ $$ = template("+"); 			   }
			         | '-' 									{ $$ = template("-"); 			   }
			         | '/' 									{ $$ = template("/"); 			   }
			         | '*' 									{ $$ = template("*"); 			   }
			         | '%' 									{ $$ = template("%%"); 			   }
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

parenthExpression: '(' expression ')'					{ $$ = template("(%s)",$2);    	   }
		     	  | expression '(' expression ')'		{ $$ = template("%s (%s)",$1,$3);  }
		     	  ;

castExpression: '(' dtype ')' expression				{ $$ = template("(%s)%s",$2,$4);   }

%%