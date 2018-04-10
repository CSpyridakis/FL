%{
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include "ptucc_parser.tab.h"
#include "cgen.h"

int line_num = 1;

/* 
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

%}

DATA_TYPE integer|boolean|char|real
ID [a-zA-Z_][0-9a-zA-Z_]*
DIGIT  [0-9]
NUMBER  {DIGIT}{DIGIT}*
DECIMAL ("."{NUMBER})|({NUMBER}("."{NUMBER}?)?)
REAL    {DECIMAL}([eE][+-]?{NUMBER})?
STRING  '[^']*'|\"[^\"]*\"


%x comment
%x macro

%%

"true"|"false" 	{ yyerror("token BOOLEAN: %s\n", yytext); }

begin   { yyerror("token DELIM_BEGIN: %s\n", yytext); return KW_BEGIN; }
end	    { yyerror("token DELIM_END: %s\n", yytext); return KW_END; }
";"		{ yyerror("token DELIM_SEMICOLON: %s\n", yytext); return ';'; }
"("		{ yyerror("token DELIM_L_PARENTH: %s\n", yytext); return '(';}
")"		{ yyerror("token DELIM_R_PARENTH: %s\n", yytext); return ')';}
","		{ yyerror("token DELIM_COMMA: %s\n", yytext); }
"["		{ yyerror("token DELIM_L_BRACKET: %s\n", yytext); }
"]"		{ yyerror("token DELIM_R_BRACKET: %s\n", yytext); }
":"		{ yyerror("token DELIM_COLON: %s\n", yytext); }
"."		{ yyerror("token DELIM_FULLSTOP: %s\n", yytext); return '.'; }

"+" 	{ yyerror("token OP_ADD: %s\n", yytext); return '+';  }
"-"		{ yyerror("token OP_SUBTRACT: %s\n", yytext); return '-'; }
"*"		{ yyerror("token OP_MULTIPLY: %s\n", yytext); return '*'; }
"/"		{ yyerror("token OP_DIVIDE: %s\n", yytext); return '/'; }
div	    { yyerror("token OP_DIV: %s\n", yytext); }
mod	    { yyerror("token OP_MOD: %s\n", yytext); }

"="		{ yyerror("token OP_EQ: %s\n", yytext); }
"<>"	{ yyerror("token OP_INEQ: %s\n", yytext); } 
"<"		{ yyerror("token OP_LT: %s\n", yytext); }
"<="	{ yyerror("token OP_LTE: %s\n", yytext); }
">"		{ yyerror("token OP_GT: %s\n", yytext); }
">="	{ yyerror("token OP_GTE: %s\n", yytext); }

and		{ yyerror("token OP_AND: %s\n", yytext); }
or 		{ yyerror("token OP_OR: %s\n", yytext); }
not		{ yyerror("token OP_NOT: %s\n", yytext); }
"&&"	{ yyerror("token OP_AND: %s\n", yytext); }
"||"	{ yyerror("token OP_OR: %s\n", yytext); }
"!"		{ yyerror("token OP_NOT: %s\n", yytext); }

":="	{ yyerror("token OP_ASSIGNMENT: %s\n", yytext); }

"("{DATA_TYPE}")" 	{ yyerror("token OP_LT: %s\n", yytext); }

function { yyerror("token KEYWORD_FUNCTION: %s\n", yytext); }
procedure { yyerror("token KEYWORD_PROCED: %s\n", yytext); }
result { yyerror("token KEYWORD_RESULT: %s\n", yytext); }
array { yyerror("token KEYWORD_ARRAY: %s\n", yytext); }
do { yyerror("token KEYWORD_DO: %s\n", yytext); }
goto { yyerror("token KEYWORD_GOTO: %s\n", yytext); }
program	{ yyerror("token KEYWORD_PROGRAM"); return KW_PROGRAM; }
return { yyerror("token KEYWORD_RETURN: %s\n", yytext); }
boolean { yyerror("token KEYWORD_BOOLEAN: %s\n", yytext); }
else { yyerror("token KEYWORD_ELSE: %s\n", yytext); }
if { yyerror("token KEYWORD_IF: %s\n", yytext); }
of { yyerror("token KEYWORD_OF: %s\n", yytext); }
real { yyerror("token KEYWORD_REAL: %s\n", yytext); }
then { yyerror("token KEYWORD_THEN: %s\n", yytext); }
char { yyerror("token KEYWORD_CHAR: %s\n", yytext); }
for { yyerror("token KEYWORD_FOR: %s\n", yytext); }
integer { yyerror("token KEYWORD_INTEGER: %s\n", yytext); }
repeat { yyerror("token KEYWORD_REPEAT: %s\n", yytext); }
until { yyerror("token KEYWORD_UNTIL: %s\n", yytext); }
var { yyerror("token KEYWORD_VAR: %s\n", yytext); }
while { yyerror("token KEYWORD_WHILE: %s\n", yytext); }
to { yyerror("token KEYWORD_TO: %s\n", yytext); }
downto { yyerror("token KEYWORD_DOWNTO: %s\n", yytext); }


@defmacro[ \r\t]+       BEGIN(macro);
<macro>{ID}             {	
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


{ID}  					{  
						   char* def = get_macro(yytext);
						   
						   if(def==NULL) {
						   		yyerror("token IDENTIFIER: %s\n", yytext );
						   		yylval.crepr = strdup(yytext);
						   		return IDENT;
						   	}
		   
						   for(int i=strlen(def); i>0; i--) {
						   	  unput(def[i-1]);
						   }
						} 						
{NUMBER}				{ yyerror("token INTEGER: %s\n", yytext); yylval.crepr = strdup(yytext); return POSINT; }
{REAL}					{ yyerror("token REAL: %s\n", yytext); yylval.crepr = strdup(yytext); return REAL; }
{STRING}				{ yyerror("token STRING: %s\n", yytext); yylval.crepr = strdup(yytext); return STRING; }

"//".*		
"(*"					BEGIN(comment);
<comment>[^*\n]*        /* eat anything that's not a '*' */
<comment>"*"+[^*)\n]*   /* eat up '*'s not followed by ')'s */
<comment>\n             ++line_num;
<comment>"*"+")"        BEGIN(INITIAL);


[ \r\t]					/* skip whitespace */
\n 						++line_num;
<<EOF>> 				return EOF;

.        { yyerror("Unrecognized token %s in line %d \n", yytext, line_num); }

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