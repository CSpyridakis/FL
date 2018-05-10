#include <assert.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "cgen.h"

extern int line_num;
int yyerror_count = 0;
const char* c_prologue = "#include \"ptuclib.h\"\n""\n";

void ssopen(sstream* S)
{
	S->stream = open_memstream(& S->buffer, & S->bufsize);
}

char* ssvalue(sstream* S)
{
	fflush(S->stream);
	return S->buffer;
}

void ssclose(sstream* S)
{
	fclose(S->stream);
}


char* template(const char* pat, ...)
{
	sstream S;
	ssopen(&S);

	va_list arg;
	va_start(arg, pat);
	vfprintf(S.stream, pat, arg );
	va_end(arg);

	char* ret = ssvalue(&S);
	ssclose(&S);
	return ret;
}

/* Helper functions */

char* string_ptuc2c(char* P)
{
	/*
		This implementation is 
		***** NOT CORRECT ACCORDING TO THE PROJECT ******
	*/

	/* Just chech and change the first and last characters */
	int Plen = strlen(P);
	assert(Plen>=2);
	P[0] = '"';
	P[Plen-1] = '"';

	return P;
}

/*
	Report errors 
*/
 void yyerror (char const *pat, ...) {
 	va_list arg;
    //fprintf (stderr, "line %d: ", line_num);

    va_start(arg, pat);
    vfprintf(stderr, pat, arg);
    va_end(arg);
    fprintf(stderr, "\n");
    yyerror_count++;
 }

/* 
	String manipulation functions 
*/

char* concat(const char *s1, const char *s2){
    char* result;
    if((result = malloc(strlen(s1)+strlen(s2)+1))){
    	strcpy(result, s1);
    	strcat(result, s2);
    	return result;
    }else{
	fprintf(stderr, "oops, malloc failed!"); 
	exit(1);
    } 
}

char* str_repeat(const char * s, int n) {
  size_t slen = strlen(s);
  char * dest = malloc(n*slen+1);
 
  int i; char * p;
  for ( i=0, p = dest; i < n; ++i, p += slen ) {
    memcpy(p, s, slen);
  }
  *p = '\0';
  return dest;
}

/* 
	C-parsing functions 
*/ 

char* make_C_decl(char* comp_type, char* var_list){
	char* result = NULL;
	char* last_asterisk = strrchr(comp_type, '*');
	char* asterisks = NULL;
	char* brackets_part = NULL;
	// Allocate str with size: max len of our primitive types and set to 0	
	char* prim_type = (char*) calloc(strlen("double") + 1, sizeof(char));

	if(last_asterisk){ 
		// Get asterisks part
		int asterisks_len = strlen(comp_type) - strlen(last_asterisk) + 1;
		asterisks = (char*) malloc(asterisks_len + 1);
		strncpy(asterisks, comp_type, asterisks_len);
		asterisks[asterisks_len] = '\0';
	}
			  
	// Get brackets part
	brackets_part = strpbrk(comp_type, "[");
	
	// Get primitive type part 
	if(brackets_part!=NULL && asterisks!=NULL){
		int len = (int) (brackets_part - last_asterisk);
		memcpy( prim_type, (last_asterisk+1), len-1 );
		prim_type[sizeof(prim_type) - 1] = '\0';		
	}else if(brackets_part){
		int len = (int) (brackets_part - comp_type);
		memcpy( prim_type, comp_type, len );
		prim_type[sizeof(prim_type) - 1] = '\0';					    
	}else if(asterisks){
		memcpy( prim_type, (last_asterisk+1), strlen(last_asterisk+1));
		prim_type[sizeof(prim_type) - 1] = '\0';					    
	}else{
		free(prim_type);
		prim_type = comp_type;
	}
		

	// Prepare ptr_type to avoid asterisk-checking hassle
	char* ptr_type = NULL;
	if(asterisks) ptr_type = concat(prim_type, asterisks);
	else ptr_type = prim_type;

	// Append brackets part to vars of var_list and get result
	if(brackets_part){

		// Get first var
		char* first_var = strtok(var_list, ",");
		
		/* If second var (next_var) is non-NULL 
		then var_list is a comma-separated list */
		char* next_var = strtok(NULL, ",");
		if(!next_var) 
			result = concat(concat(concat(ptr_type, " "), var_list), brackets_part);
		else{	

			char* var_l_w_b_part = NULL;

			char* first_var_w_b = concat(concat(" ", first_var), brackets_part);
			var_l_w_b_part = concat(first_var_w_b, ", ");

			// Init to " {first_var}{brackers_part}, {next_var}{brackets_part}"
			var_l_w_b_part = concat(var_l_w_b_part, next_var);
			var_l_w_b_part = concat(var_l_w_b_part, brackets_part);

				
			/* Walk through rest of var_list, fetch other vars 
			   and construct {next_var}{brackets_part} */
			do{
			  
			  next_var = strtok(NULL, ",");
			  if(next_var){
			  	  var_l_w_b_part = concat(var_l_w_b_part, ", ");
				  var_l_w_b_part = concat(var_l_w_b_part, concat(next_var, brackets_part));
			  }

			}while(next_var);
			
			result = concat(concat(ptr_type, " "), var_l_w_b_part);
		}
	
	}else	
		result = concat(concat(ptr_type, " "), var_list);

  	return result;
}

char* make_C_params(char* type, char* var_list){
	char* result = NULL; 
	char* first_var = strtok(var_list, ",");                   
	char* next_var = strtok(NULL, ",");

	if(!next_var) 
		result = concat(concat(type, " "), var_list);
	else{	
		/* If next_var is non-NULL 
		   then var_list is a comma-separated list */

		// Init to "type first_var, type next_var"
		char* type_and_space = concat(type, " ");
        	char* first_param = concat(concat(type_and_space, first_var), ", ");
		result = concat(first_param, concat(type_and_space, next_var));
	   	
	   	/* Walk through rest of var_list, fetch other vars 
	           and construct C param list */
		do{
		  next_var = strtok(NULL, ",");
		  if(next_var){
			  result = concat(result, ", ");
			  result = concat(result, concat(type_and_space, next_var));
		  }
		}while(next_var);
	
		return result;
	}
	
}

char* make_C_comp_type(char* comp_type){
	char* last_asterisk = strrchr(comp_type, '*');
	char* brackets = strpbrk(comp_type, "[");
	char* asterisks = NULL;
	char* C_comp_type = NULL;
	// Allocate str with size: max len of our primitive types and set to 0
	char* prim_type = (char*) calloc(strlen("double") + 1, sizeof(char));

	if(last_asterisk){ 
		// Get asterisks part
		int asterisks_len = strlen(comp_type) - strlen(last_asterisk) + 1;
		asterisks = (char*) malloc(asterisks_len + 1);
		strncpy(asterisks, comp_type, asterisks_len);
		asterisks[asterisks_len] = '\0';
		
		if(brackets){
			// Get primitive type part
			memcpy( prim_type, (last_asterisk+1),  brackets - last_asterisk - 1 );			
			prim_type[sizeof(prim_type) - 1] = '\0';
			// Append prefix asterisks
			C_comp_type = concat(prim_type, asterisks);			
			
			// Calculate postfix asterisks 
			int i;
			for (i=0; brackets[i]; brackets[i]=='[' ? i++ : *brackets++);
			int this_many_ptrs = i;			
			char* ptrs = str_repeat("*", this_many_ptrs);
			
			// and append			
			C_comp_type = concat(C_comp_type, ptrs);
		}
		else{	
			// Get primitive type part		
			memcpy( prim_type, (last_asterisk+1), strlen(last_asterisk+1));
			prim_type[sizeof(prim_type) - 1] = '\0';			
			
			// Append asterisks 
			C_comp_type = concat(prim_type, asterisks);
		}

	}else{

		if(brackets){
			// Get primitive type part
			memcpy( prim_type, comp_type, brackets - comp_type);
			prim_type[sizeof(prim_type) - 1] = '\0';

			// Calculate postfix asterisks 
			int i;
			for (i=0; brackets[i]; brackets[i]=='[' ? i++ : *brackets++);
			int this_many_ptrs = i;
			char* ptrs = str_repeat("*", this_many_ptrs);
			
			// and append			
			C_comp_type = concat(prim_type, ptrs);
			
		}
		else	
			C_comp_type = comp_type;
	}
	
	
	return C_comp_type;
}

/* 
	General parsing functions 
*/

char* make_parsable_comp_type(char* comp_type, char* bracket_list){
	char* result = NULL;
	int br_l_empty = !strcmp(bracket_list, "");
	if(br_l_empty) result = concat("*", comp_type);
	else result = concat(comp_type, bracket_list);
	return result;
}

/* 
	Typedef utilities
*/

#define MAXTYPEDEF 32
char* typedef_table[MAXTYPEDEF][2]; 
int typedef_table_size = MAXTYPEDEF-1;

/* 
	Typedef getters-setters
*/

int set_typedef(char* name, char* def)
{	
	/* Check to see if typedef already defined */
	int i;
	
	for(i=0; i<typedef_table_size; i++) {
		char* table_entry = typedef_table[i][0];		
		if(table_entry){
			if(!strcmp(table_entry, name)) {
				/* found ! */
				fprintf(stderr, "Typedef already defined...\n");
				return 0;
				// free(name);
				// free(typedef_table[i][1]);
				// typedef_table[i][1] = def;
				// break;
			}
		}
	
	}
	if(i<typedef_table_size)
		return 1;
	else if(typedef_table_size < MAXTYPEDEF) {
		/* new entry */
		
		assert(i==typedef_table_size);
		typedef_table[i][0] = name;
		typedef_table[i][1] = def;
		typedef_table_size++;
		 
		return 1;
	}
	else
		return 0;
}

char* get_typedef(char* name)
{
	for(int i=0;i<typedef_table_size; i++) {
		if(strcmp(typedef_table[i][0], name)==0)
			return typedef_table[i][1];
	}
	return NULL;
}
