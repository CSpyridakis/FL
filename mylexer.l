%{
#include <stdio.h>
#include "mylexer.h"
//Lines and characters counters
int lineNum=1;
int charsNum=0;

void increaseVariables(char* text);

%}


/*Basic */
digit [0-9]
digits [0-9][0-9]*
chara [a-zA-Z]

specialChar [~`@#%^&_{}\\|?]
space [ \t\n\r]+
exp [eE][+-]?{digits}

/*Operators*/
operatorWord div|mod|and|or|not 
operatorChar "+"|"-"|"*"|"/"|"="|"<"|">"|"!"

/*Delimiters*/
delimiterWord begin|end 
delimiterChar ";"|"("|")"|","|"["|"]"|":="|":"|"."

/*TODO CHECKIT*/
allSpecialChars {specialChar}|{operatorChar}|{delimiterChar}


/*Regex*/
keywords {operatorWord}|{delimiterWord}|array|boolean|char|do|else|for|function|goto|if|integer|var|of|while|procedure|program|real|repeat|to|result|return|then|until|downto
/*TODO: REPLACE WITH {chara},{digits}*/
identifiers {chara}[a-zA-Z0-9_]*
integer_positive_constants {digits}
real_positive_constants {digits}[.]{digits}{exp}?
boolean_constants true|false
strings ("\""[^"]*"\"")|("\'"[^']*"\'")
operators ([.]*{operatorChar}[.]*)|{operatorWord}
delimiters ([.]*{delimiterChar}[.]*)|{delimiterWord}
whiteSpace {space}
comments "(*"[^"]*"*)"
lineComments "//"[^"\n]*
Nline [\n]+
else .

%%

{Nline} {
    lineNum+=strlen(yytext);
}

{boolean_constants} {
	charsNum+=strlen(yytext);
	printf("token BOOLEAN: %s\n",yytext);
	return 0;
}

{keywords} {
	charsNum+=strlen(yytext);
	printf("token KEYWORDS: %s\n",yytext);
	return 0;
}

{identifiers} {
	charsNum+=strlen(yytext);
	printf("token IDENTIFIERS: %s\n",yytext);
	return 0;
}

{integer_positive_constants} {
	charsNum+=strlen(yytext);
	printf("token INTEGER: %s\n",yytext);
	return 0;
}

{real_positive_constants} {
	charsNum+=strlen(yytext);
	printf("token REAL: %s\n",yytext);
	return 0;
}

{strings} {
    int i,st=strlen(yytext);
    for(i=0;i<st;i++){
        if(yytext[i]=='\n'){
            lineNum++;
        }
    }
	charsNum+=strlen(yytext);
	printf("token CONSTANT STRING: %s\n",yytext);
	return 0;
}

{operators} {
	charsNum+=strlen(yytext);
	printf("token OPERATOR: %s\n",yytext);
	return 0;
}

{delimiters} {
	charsNum+=strlen(yytext);
	printf("token DELIMITER: %s\n",yytext);
	return 0;
}

{whiteSpace} {
	charsNum+=strlen(yytext);
	//printf("token WHITE SPACE: %s\n",yytext);
	return 0;
}

{comments} {
    int i,st=strlen(yytext);
    for(i=0;i<st;i++){
        if(yytext[i]=='\n'){
            lineNum++;
        }
    }
	charsNum+=strlen(yytext);
	//printf("token  COMMENTS: %s\n",yytext);
	return 0;
}

{lineComments} {
	charsNum+=strlen(yytext);
	//printf("token LINE COMMENTS: %s\n",yytext);
	return 0;
}


<<EOF>> return EOF;

{else} { printf("Unrecognized token %s in line %d \n", yytext,lineNum); }




%%

void main(){
	while(yylex()!=EOF){

	}
	printf("\nCompleted \nlines Num:%d and char Num:%d\n\n",lineNum,charsNum);
}
