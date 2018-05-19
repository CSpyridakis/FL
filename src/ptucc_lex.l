%{
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include "ptucc_parser.tab.h"
#include "../include/cgen.h"

int line_num = 1;

/* 	TODO: Just ONE macro with MAXMACRO?


	A primitive macro facility:
	just one macro is allowed to be defined! 
*/
#define MAXMACRO 32
char* mactable[MAXMACRO][2];
int mactable_size = 0;

/* Return 1 on success, 0 on failure (macro table full) */
int set_macro(char* name, char* def);

/* Return def for macro, or NULL if no such macro is defined. */
char* get_macro(char* name);


/* Destination of debug prints.	*/
#define destPrint stderr
#define DEBUG 1
%}

	/*	BASIC TYPES	 */
DATA_TYPE integer|boolean|char|real
ID [a-zA-Z_][0-9a-zA-Z_]*
DIGIT  [0-9]
NUMBER  {DIGIT}{DIGIT}*
DECIMAL ("."{NUMBER})|({NUMBER}("."{NUMBER}?)?)
REAL    {DECIMAL}([eE][+-]?{NUMBER})?
STRING  '[^']*'|\"[^\"]*\"

%x comment
%x macro

/*	Flex Rules	*/
%%

	/* 1. Keywords */
begin   	{ if(DEBUG){fprintf(destPrint,  "token DELIM_BEGIN: %s\n",	 		yytext);}     	return KW_BEGIN;  }
end	    	{ if(DEBUG){fprintf(destPrint,  "token DELIM_END: %s\n",		 	yytext);}   	return KW_END;	  }
function 	{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_FUNCTION: %s\n",		yytext);} 		return KW_FUNC;   }
procedure 	{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_PROCED: %s\n", 		yytext);}  		return KW_PROC;   }
result 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_RESULT: %s\n", 		yytext);} 	 	return KW_RESULT; }
array 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_ARRAY: %s\n", 		yytext);} 		return KW_ARRAY;  }
do 			{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_DO: %s\n", 			yytext);} 		return KW_DO; 	  }
goto 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_GOTO: %s\n", 		yytext);} 		return KW_GOTO;   }
program		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_PROGRAM: %s\n", 		yytext);}   	return KW_PROGRAM;}
return 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_RETURN: %s\n", 		yytext);} 	 	return KW_RETURN; }
boolean 	{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_BOOLEAN: %s\n", 		yytext);} 	 	return KW_BOOLEAN;}
else 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_ELSE: %s\n", 		yytext);} 		return KW_ELSE;   }
if 			{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_IF: %s\n", 			yytext);} 		return KW_IF; 	  } 
of 			{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_OF: %s\n", 			yytext);} 		return KW_OF; 	  }
real 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_REAL: %s\n", 		yytext);} 		return KW_REAL;   }
then 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_THEN: %s\n", 		yytext);} 		return KW_THEN;   }
char 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_CHAR: %s\n", 		yytext);} 		return KW_CHAR;   }
for 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_FOR: %s\n", 			yytext);} 		return KW_FOR;    }
integer 	{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_INTEGER: %s\n", 		yytext);}   	return KW_INT;    }
repeat 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_REPEAT: %s\n", 		yytext);} 	 	return KW_REPEAT; }
until 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_UNTIL: %s\n", 		yytext);} 		return KW_UNTIL;  }
var 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_VAR: %s\n", 			yytext);} 		return KW_VAR;    }
while 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_WHILE: %s\n", 		yytext);} 		return KW_WHILE;  } 
to 			{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_TO: %s\n", 			yytext);} 		return KW_TO;     }
downto 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_DOWNTO: %s\n", 		yytext);} 	 	return KW_DOWNTO; }
type 		{ if(DEBUG){fprintf(destPrint,  "token KEYWORD_TYPE: %s\n", 		yytext);} 		return KW_TYPE;   }

	/* 3. Pos-int */
{NUMBER} { if(DEBUG){fprintf(destPrint,  "token INTEGER: %s\n", 				yytext);} yylval.crepr = strdup(yytext); return POSINT; }

	/* 4. Pos-real */
{REAL}	 { if(DEBUG){fprintf(destPrint,  "token REAL: %s\n",   	 				yytext);} yylval.crepr = strdup(yytext); return REAL;   }

	/* 5. Bool-const */
true  	 { if(DEBUG){fprintf(destPrint,  "token KEYWORD_TRUE: %s\n",   			yytext);}    	return KW_TRUE;   }
false 	 { if(DEBUG){fprintf(destPrint,  "token KEYWORD_FALSE: %s\n", 			yytext);} 		return KW_FALSE;  }


	/* 6. Strings */
{STRING} { if(DEBUG){fprintf(destPrint,  "token STRING: %s\n",   				yytext);} yylval.crepr = strdup(yytext); return STRING; }

	/* 7. Operators */
"+" 	 { if(DEBUG){fprintf(destPrint,  "token OP_ADD: %s\n",   				yytext);} 		  return '+';       }
"-"		 { if(DEBUG){fprintf(destPrint,  "token OP_SUB: %s\n",    				yytext);} 		  return '-';       }
"*"		 { if(DEBUG){fprintf(destPrint,  "token OP_MUL: %s\n",    				yytext);} 		  return '*';       }
"/"|div	 { if(DEBUG){fprintf(destPrint,  "token OP_DIV: %s\n",    				yytext);} 	   	  return '/';       }
mod	     { if(DEBUG){fprintf(destPrint,  "token OP_MOD: %s\n",    				yytext);} 	   	  return '%';       }
"="		 { if(DEBUG){fprintf(destPrint,  "token OP_EQ: %s\n",     				yytext);}      	  return OP_EQ;     }
"<>"	 { if(DEBUG){fprintf(destPrint,  "token OP_INEQ: %s\n",   				yytext);}	  	  return OP_INEQ;   } 
"<"		 { if(DEBUG){fprintf(destPrint,  "token OP_LT: %s\n",     				yytext);}      	  return OP_LT;     }
"<="	 { if(DEBUG){fprintf(destPrint,  "token OP_LTE: %s\n",    				yytext);}  		  return OP_LTE;    }
">"		 { if(DEBUG){fprintf(destPrint,  "token OP_GT: %s\n",     				yytext);}   	  return OP_GT;     }
">="	 { if(DEBUG){fprintf(destPrint,  "token OP_GTE: %s\n",    				yytext);}  		  return OP_GTE;    }
and|"&&" { if(DEBUG){fprintf(destPrint,  "token OP_AND: %s\n",    				yytext);}     	  return OP_AND;    }
or|"||"  { if(DEBUG){fprintf(destPrint,  "token OP_OR: %s\n",     				yytext);}         return OP_OR;     }
not|"!"	 { if(DEBUG){fprintf(destPrint,  "token OP_NOT: %s\n",    				yytext);}         return OP_NOT;    }
":="	 { if(DEBUG){fprintf(destPrint,  "token OP_ASSIGN: %s\n", 				yytext);}  		  return OP_ASSIGN; }


	/* 8. Delimiters */
";"		{ if(DEBUG){fprintf(destPrint,  "token DELIM_SEMICOLON: %s\n", 			yytext);} 			return ';';		}
"("		{ if(DEBUG){fprintf(destPrint,  "token DELIM_L_PARENTH: %s\n",			yytext);} 			return '(';		}
")"		{ if(DEBUG){fprintf(destPrint,  "token DELIM_R_PARENTH: %s\n", 			yytext);} 			return ')';		}
","		{ if(DEBUG){fprintf(destPrint,  "token DELIM_COMMA: %s\n", 	 			yytext);}     		return ',';		}
"["		{ if(DEBUG){fprintf(destPrint,  "token DELIM_L_BRACKET: %s\n", 			yytext);} 			return '[';		}
"]"		{ if(DEBUG){fprintf(destPrint,  "token DELIM_R_BRACKET: %s\n", 			yytext);} 			return ']';		}
":"		{ if(DEBUG){fprintf(destPrint,  "token DELIM_COLON: %s\n", 	 			yytext);} 	    	return ':';		}
"."		{ if(DEBUG){fprintf(destPrint,  "token DELIM_FULLSTOP: %s\n",  			yytext);}       	return '.';		}

	/* 9. Whitespace */
[ \r\t]					/* skip whitespace */

	/* 10. Line Comments */ 
"//".*					/* skip Line Comments */


	/* 11. Multiple line comments */
"(*"					BEGIN(comment);
<comment>[^*\n]*        /* eat anything that's not a '*' */
<comment>"*"+[^*)\n]*   /* eat up '*'s not followed by ')'s */
<comment>\n             ++line_num;
<comment>"*"+")"        BEGIN(INITIAL);


	/* 2. Identifiers */
{ID}  	{  	
			char* def = get_macro(yytext);
						   
			if(def==NULL) {
				if(DEBUG){fprintf(destPrint,  "token IDENTIFIER: %s\n", yytext );}
				yylval.crepr = strdup(yytext);
				return IDENT;
		 	}
		         
			for(int i=strlen(def); i>0; i--) {
				unput(def[i-1]);
			}
		} 		


@defmacro[ \r\t]+    BEGIN(macro);
<macro>{ID} 	{	
					/* Store macro name */
					char* name = strdup(yytext);
					char* def = NULL;
					size_t deflen = 0;
					char c;

					FILE* deff = open_memstream(&def, &deflen);

					while((c=input())!='\n')
				   		fputc(c, deff);
					fclose(deff);

					if(!set_macro(name, def))
						yyerror("lexer error: failed to define macro '%s'\n", name);
					BEGIN(INITIAL);
				};


\n 						++line_num;
<<EOF>> 				return EOF;

.        	{ yyerror("Unrecognized token %s in line %d \n", yytext, line_num); }

%%

int set_macro(char* name, char* def)
{
	/* Check to see if macro already defined, and redefine it. */
	int i;
	for(i=0; i<mactable_size; i++) {
		if(strcmp(mactable[i][0], name)==0) {
			/* found ! */
			free(name);
			free(mactable[i][1]);
			mactable[i][1] = def;
			break;
		}
	}
	if(i<mactable_size)
		return 1;
	else if(mactable_size < MAXMACRO) {
		/* new entry */
		assert(i==mactable_size);
		mactable[i][0] = name;
		mactable[i][1] = def;
		mactable_size++;
		return 1;
	}
	else
		return 0;
}

char* get_macro(char* name)
{
	for(int i=0;i<mactable_size; i++) {
		if(strcmp(mactable[i][0], name)==0)
			return mactable[i][1];
	}
	return NULL;
}