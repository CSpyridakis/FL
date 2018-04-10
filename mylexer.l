%{
#include <stdio.h>
#include "mylexer.h"
//Lines and characters counters
int lineNum=0;
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
/*TODO FIX IT*/
string '[^'\n]*'


/*Regex*/
keywords {operatorWord}|{delimiterWord}|array|boolean|char|do|else|for|function|goto|if|integer|var|of|while|procedure|program|real|repeat|to|result|return|then|until|downto
/*TODO: REPLACE WITH {chara},{digits}*/
identifiers {chara}[a-zA-Z0-9_]*
integer_positive_constants {digits}
real_positive_constants {digits}[.]{digits}{exp}?
boolean_constants true|false
/*TODO: REPLACE with string*/
constant_strings "\""[0-9a-zA-Z \t\n\r]*"\""
operators ([.]*{operatorChar}[.]*)|{operatorWord}
delimiters ([.]*{delimiterChar}[.]*)|{delimiterWord}
whiteSpace {space}
/*TODO: REPLACE with string*/
comments "(*"[0-9a-zA-Z \t\n\r]*"*)"
/*TODO: REPLACE with string*/
lineComments "//"[0-9a-zA-Z \t\r]*
Nline \n
else [.]*

%%

{keywords} {
	increaseVariables(yytext);
	printf("token KEYWORDS :%s\n",yytext);
	return 0;
}

{identifiers} {
	increaseVariables(yytext);
	printf("token IDENTIFIERS :%s\n",yytext);
	return 0;
}

{integer_positive_constants} {
	increaseVariables(yytext);
	printf("token INTEGER :%s\n",yytext);
	return 0;
}

{real_positive_constants} {
	increaseVariables(yytext);
	printf("token REAL :%s\n",yytext);
	return 0;
}

{boolean_constants} {
	increaseVariables(yytext);
	printf("token BOOLEAN :%s\n",yytext);
	return 0;
}

{constant_strings} {
	increaseVariables(yytext);
	printf("token CONSTANT STRING :%s\n",yytext);
	return 0;
}

{operators} {
	increaseVariables(yytext);
	printf("token OPERATOR :%s\n",yytext);
	return 0;
}

{delimiters} {
	increaseVariables(yytext);
	printf("token DELIMITER :%s\n",yytext);
	return 0;
}

{whiteSpace} {
	increaseVariables(yytext);
	//printf("token WHITE SPACE :%s\n",yytext);
	return 0;
}

{comments} {
	increaseVariables(yytext);
	printf("token  COMMENTS :%s\n",yytext);
	return 0;
}

{lineComments} {
	increaseVariables(yytext);
	printf("token LINE COMMENTS :%s\n",yytext);
	return 0;
}

{Nline}  {
    lineNum++;
}

{else} {
	printf("ERROR on line:%d \n",lineNum);
	return -1;
}

<<EOF>> return EOF;


%%

void main(){
	while(yylex()!=EOF){

	}
	printf("\nCompleted \nlines Num:%d and char Num:%d\n\n",lineNum,charsNum);
}

void increaseVariables(char* text){
	lineNum++;
	charsNum+=strlen(text);
	//TODO: Multiple lines "example \n"
}