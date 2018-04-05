%{
#include <stdio.h>

//Lines and characters counters
int lineNum=0;
int charsNum=0;

void increaseVariables(char* text);

%}


/*Basic */
digit [0-9]
digits [1-9][0-9]*
char [a-zA-Z]
specialChar [~`@#%^&_{}\\|?]
space [ \t\n\r]+

/*Operators*/
operatorChar [+-*//=<>!]
operatorWord div|mod|and|or|not

/*Delimiters*/
delimiterWord begin|end
delimiterChar ";"|"("|")"|","|"["|"]"|":="|":"|"."

allSpecialChars {specialChar}|{operatorChar}|{delimiterChar}

string [{digit}{char}{allSpecialChars}{space}]*

exp [eE][+-]?{digits}


/*Regex*/
keywords {operatorWord}|{delimiterWord}|array|boolean|char|do|else|for|function|goto|if|integer|var|of|while|procedure|program|real|repeat|to|result|return|then|until|downto
identifiers {char}[{char}{digit}_]*
integer_positive_constants [0]|{digits}
real_positive_constants (0|{digits})[.][0-9]+{exp}?
boolean_constants true|false
constant_strings "\""{string}"\""
operators [{operatorChar}{operatorWord}]
delimiters [{delimiterChar}{delimiterWord}]
whiteSpace [{space}{escapeChar}]
comments "(*"{string}"*)"
lineComments "//"{string}
else [.]*


%%

{keywords} {
	//increaseVariables(yytext);
	printf("token KEYWORDS :%s\n",yytext);
	//return 0;
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
	printf("token WHITE SPACE :%s\n",yytext);
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

{else} {
	printf("ERROR on line:%d \n",lineNum);
	return -1;
}

%%

void main(){
	while (1==1){
		yylex();	
	}
	
}

void increaseVariables(char* text){
	lineNum++;
	charsNum+=strlen(text);
	//TODO: Multiple lines "example \n"
}