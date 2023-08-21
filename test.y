%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex(void);
extern int yyparse(void);

void yyerror(char *s){
    fprintf(stderr,"error : %s", s);
}

%}

%token HEADING1 HEADING2 HEADING3 HEADING4 HEADING5 HEADING6 PARAGRAPH LINEBREAK
%token BOLD1 BOLD2 ITALICS1 ITALICS2 BOLDITALICS1 BOLDITALICS2_OPEN BOLDITALICS3_OPEN
%token BOLDITALICS2_CLOSE BOLDITALICS3_CLOSE
%token ULS1 ULS2 ULS3 SPACE DOT
%token LSQRB RSQRB LB RB EXCLAIM  NEWLINE PIPE TABLE_SEPERATOR
%token NUM
%token TEXT


%start statements

%union {
    char* str;
}



%type<str> heading ordered_list_item unordered_list_item bold italic bold_and_italic paragraph  hyperlink image linebreak 

%%


statements: /* empty */
    |statements statement
    |statements last
    
    ;

statement:
    heading
    | ordered_list_item 
    | unordered_list_item 
    | bold 
    | italic 
    | bold_and_italic 
    | paragraph 
    | hyperlink 
    | image 
    ;

heading:
    HEADING1 TEXT linebreak
    | HEADING2 TEXT linebreak
    | HEADING3 TEXT linebreak
    | HEADING4 TEXT linebreak
    | HEADING5 TEXT linebreak
    | HEADING6 TEXT linebreak
    ;

ordered_list_item:
    NUM DOT SPACE TEXT linebreak
    ;

unordered_list_item:
    ULS1 TEXT linebreak
    | ULS2 TEXT linebreak
    | ULS3 TEXT linebreak
    ;

bold:
    BOLD1 TEXT BOLD1 last
    | BOLD2 TEXT BOLD2 last
    ;

italic:
    ITALICS1 TEXT ITALICS1 last
    | ITALICS2 TEXT ITALICS2 last
    ;

bold_and_italic:
    BOLDITALICS1 TEXT BOLDITALICS1 last
    | BOLDITALICS2_OPEN TEXT BOLDITALICS2_CLOSE last
    | BOLDITALICS3_OPEN TEXT BOLDITALICS3_CLOSE last
    ;

paragraph:
    TEXT next
    ;

hyperlink:
    LSQRB TEXT RSQRB LB TEXT RB last
    ;

image:
    EXCLAIM LSQRB TEXT RSQRB LB TEXT RB last
    ;

linebreak:
    LINEBREAK
    ;

next: PARAGRAPH | NEWLINE
;

last : SPACE | NEWLINE | LINEBREAK
;













%%

int main() {
    // Initialize the lexer and parser here
    yyparse(); // Start parsing
    return 0;
}
