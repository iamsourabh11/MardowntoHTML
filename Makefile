test: test.l test.y
	bison -d test.y -Wnone
	flex test.l
	gcc -o test test.tab.c lex.yy.c -lfl 

clean:
	-rm -f test test.tab.c test.tab.h lex.yy.c