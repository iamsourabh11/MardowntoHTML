%{
#include <stdio.h>
#include <stdlib.h>



#include <string.h>
extern int yylex(void);
extern int yyparse(void);

void yyerror(char* );







%}

%token HEADING1 HEADING2 HEADING3 HEADING4 HEADING5 HEADING6 PARAGRAPH LINEBREAK
%token BOLD1 BOLD2 ITALICS1 ITALICS2 BOLDITALICS1 BOLDITALICS2_OPEN BOLDITALICS3_OPEN
%token BOLDITALICS2_CLOSE BOLDITALICS3_CLOSE
%token ULS1 ULS2 ULS3 SPACE URL IMAGE OLS
%token LSQRB RSQRB LB RB EXCLAIM  NEWLINE PIPE TABLE_SEPERATOR
%token TEXT 


%start program

%union {
    char* str;
}



%type statement statements heading ordered_list_item unordered_list_item bold
%type italic bold_and_italic hyperlink image whitespace ulstmt hstmt

%%

program: statements
;

statements: statement whitespace statements
    |statement NEWLINE
    
    ;

statement: heading
    | ordered_list_item 
    | unordered_list_item 
    | bold 
    | italic 
    | bold_and_italic 
    | hyperlink 
    | image 
    | textstmt
    ;

heading: hstmt statement
    ;

ordered_list_item: OLS statement
    ;

unordered_list_item: ulstmt statement
    ;

bold: BOLD1 statement BOLD1
    | BOLD2 statement BOLD2
    ;

italic: ITALICS1 statement ITALICS1 
    | ITALICS2 statement ITALICS2 
    ;

bold_and_italic:
    BOLDITALICS1 statement BOLDITALICS1 
    | BOLDITALICS2_OPEN statement BOLDITALICS2_CLOSE 
    | BOLDITALICS3_OPEN statement BOLDITALICS3_CLOSE 
    ;



hyperlink:
    LSQRB statement RSQRB LB URL RB 
    ;

image:
    EXCLAIM LSQRB statement RSQRB LB extra RB 
    ;

textstmt: TEXT
;

hstmt: HEADING1
    | HEADING2
    | HEADING3
    | HEADING4
    | HEADING5
    | HEADING6
;

ulstmt: ULS1
    | ULS2
    | ULS3
;

whitespace: PARAGRAPH 
    | SPACE
    | NEWLINE
    | %empty

;

extra : URL
    | IMAGE
;







%%

void yyerror(char *s){
    fprintf(stderr,"error : %s", s);
}


int main() {
    #ifdef YYDEBUG
             yydebug=1;
    #endif
     // Initialize the lexer and parser here
    yyparse(); // Start parsing
    return 0;
}


