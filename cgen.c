#include <assert.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "cgen.h"

extern int line_num;
int yyerror_count = 0;
const char* c_prologue = "#include \"ptuclib.h\"\n""\n";
const char comma[2] = ",";

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
	C-formatting functions 
*/ 

char* make_C_decl(char* comp_type, char* var_list){
	char* result = NULL;
	// comp_type = "***int[14][3]";
	char* last_asterisk = strrchr(comp_type, '*');
	char* asterisks = NULL;
	char* brackets_part = NULL;
	char* prim_type = NULL;

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
		prim_type = (char*) calloc(strlen("double") + 1, sizeof(char));
		int len = (int) (brackets_part - last_asterisk);
		memcpy( prim_type, (last_asterisk+1), len-1 );
		prim_type[sizeof(prim_type) - 1] = '\0';		
	}else if(brackets_part){
		prim_type = (char*) calloc(strlen("double") + 1, sizeof(char));
		int len = (int) (brackets_part - comp_type);
		memcpy( prim_type, comp_type, len );
		prim_type[sizeof(prim_type) - 1] = '\0';					    
	}else if(asterisks){
		prim_type = (char*) calloc(strlen("double") + 1, sizeof(char));
		memcpy( prim_type, (last_asterisk+1), strlen(last_asterisk+1));
		prim_type[sizeof(prim_type) - 1] = '\0';					    
	}else
		prim_type = comp_type;

	
	// Prepare ptr_type to avoid asterisk-checking hassle
	char* ptr_type = NULL;
	if(asterisks) ptr_type = concat(prim_type, asterisks);
	else ptr_type = prim_type;

	// Append brackets part to vars of var_list and get result
	if(brackets_part){

		// Get first var
		char* first_var = strtok(var_list, comma);
		
		/* If second var (next_var) is non-NULL 
		then var_list is a comma-separated list */
		char* next_var = strtok(NULL, comma);
		if(!next_var) result = template("%s %s%s", ptr_type, var_list, brackets_part);
		else{	

			char* var_l_w_b_part = NULL;

			char* comma_and_space = concat(comma, " ");
			char* first_var_w_b = concat(concat(" ", first_var), brackets_part);
			var_l_w_b_part = concat(first_var_w_b, comma_and_space);

			// Init to " {first_var}{brackers_part}, {next_var}{brackets_part}"
			var_l_w_b_part = concat(var_l_w_b_part, next_var);
			var_l_w_b_part = concat(var_l_w_b_part, brackets_part);

				
			/* Walk through rest of var_list, fetch other vars 
			   and construct {next_var}{brackets_part} */
			do{
			  
			  next_var = strtok(NULL, comma);
			  if(next_var){
			  	  var_l_w_b_part = concat(var_l_w_b_part, comma_and_space);
				  var_l_w_b_part = concat(var_l_w_b_part, concat(next_var, brackets_part));
			  }

			}while(next_var);

			result = template("%s %s", ptr_type, var_l_w_b_part);
		}
	
	}else 
		result = template("%s %s", ptr_type, var_list);

  	return result;
}

char* make_C_params(char* type, char* var_list){
	char* result = NULL; 
	
	// Get first var
	char* first_var = strtok(var_list, comma);
	                                        
	/* If second var (next_var) is non-NULL 
	   then var_list is a comma-separated list */
	char* next_var = strtok(NULL, comma);
	if(!next_var) 
		return template("%s %s", type, var_list);
	else{	
		
		// Init to "type first_var, type next_var"
		char* type_and_space = concat(type, " ");
		char* comma_and_space = concat(comma, " ");
        	char* first_param = concat(concat(type_and_space, first_var), comma_and_space);
		result = concat(first_param, concat(type_and_space, next_var));
	   	
	   	/* Walk through rest of var_list,
		   fetch other vars and construct C param list */
		do{
		  next_var = strtok(NULL, comma);
		  if(next_var){
			  result = concat(result, comma_and_space);
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
	// Allocate to max and set to 0
	char* prim_type = (char*) calloc(strlen("double") + 1, sizeof(char));
	fprintf(stderr, "~~~~INITIAL TYPE:%s\n", comp_type);
	// fprintf(stderr, "~~~~RETURN TYPE:%s\n", C_comp_type);

	if(last_asterisk){ // comp_type starts with "*"	
		
		// Get asterisks part
		int asterisks_len = strlen(comp_type) - strlen(last_asterisk) + 1;
		asterisks = (char*) malloc(asterisks_len + 1);
		strncpy(asterisks, comp_type, asterisks_len);
		asterisks[asterisks_len] = '\0';
		
		/* Get primitive type part (might contain brackets)
		   & append appropriate number of asteriks */
		if(brackets){
			fprintf(stderr, "@@@@@@@@@@@@@\n");
			memcpy( prim_type, (last_asterisk+1),  brackets - last_asterisk - 1 );			
			prim_type[sizeof(prim_type) - 1] = '\0';
			// Append prefix asterisks
			C_comp_type = concat(prim_type, asterisks);			
			
			// Append postfix asterisks 
			int b_ptr_num = strlen(brackets)/BRACKETS_SIZE;
			char* b_ptrs = str_repeat("*", b_ptr_num);
			C_comp_type = concat(C_comp_type, b_ptrs);
		}
		else{			
			memcpy( prim_type, (last_asterisk+1), strlen(last_asterisk+1));
			prim_type[sizeof(prim_type) - 1] = '\0';			
			// Append asterisks 
			C_comp_type = concat(prim_type, asterisks);			
			
		}

	}else{
		/* Get primitive type part (might contain brackets)
		   & append appropriate number of asteriks */
		if(brackets){
			memcpy( prim_type, comp_type, brackets - comp_type +1);
			prim_type[sizeof(prim_type) - 1] = '\0';
			
			// Append postfix asterisks 
			int b_ptr_num = strlen(brackets)/BRACKETS_SIZE;
			char* b_ptrs = str_repeat("*", b_ptr_num);
			C_comp_type = concat(prim_type, b_ptrs);
		}
		else	
			C_comp_type = comp_type;
	}
	
	
	return C_comp_type;
}

char* make_parsable_comp_type(char* comp_type, char* bracket_list){
	char* result = NULL;
	int br_l_empty = !strcmp(bracket_list, "");
	if(br_l_empty) result = concat("*", comp_type);
	else result = concat(comp_type, bracket_list);
	return result;
}
