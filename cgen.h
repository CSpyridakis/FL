#ifndef CGEN_H
#define CGEN_H

/*
	String streams are handy for using standard C-library
	functions to produce formatted strings.
*/
typedef struct sstream
{
	char *buffer;
	size_t bufsize;
	FILE* stream;
} sstream;

void ssopen(sstream* S);
char* ssvalue(sstream* S);
void ssclose(sstream* S);


/*
 	This function takes the same arguments as printf,
 	but returns a new string with the output value in it.
 */
char* template(const char* pat, ...);

/*
	This is the function used to report errors in the translation.
*/
void yyerror(char const* pat, ...);

/*
	This is set to the number of calls to yyerror
 */
extern int yyerror_count;


/* This is output at the head of a c program. */
extern const char* c_prologue;

/*
  Make a C string literal out of a PTUC string literal.
  Return the corrected string (maybe the same as P).
*/
char* string_ptuc2c(char* P);

/* 
	String manipulation functions 
*/

///
//  Concatenate two strings (memory-wisely) 
///
char* concat(const char *s1, const char *s2);

/* 
	C-formatting functions 
*/ 
char* make_C_decl(char* comp_type, char* var_list);
char* make_C_params(char* type, char* var_list);
char* make_C_comp_type(char* comp_type);


/* 
	General parsing functions	
*/ 
char* make_parsable_comp_type(char* comp_type, char* bracket_list);



#endif
