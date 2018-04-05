flex:
	flex mylexer.l
	gcc -o mylexer lex.yy.c -lfl
	./mylexer 
