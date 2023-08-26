%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex(void);
extern int yyparse(void);
extern char* yytext;

void yyerror(char* );

int olflag=0;
int ulflag=0;
int linkflag=1;
int tableflag=1;
int paraflag=1;

void mutex()
{
    if(olflag==1 )
    {
        printf("</ol>");

        olflag=0;
    }
}

void signal()
{
    if(ulflag==1 )
    {
        printf("</ul>");

        ulflag=0;
    }
}



%}



%token HEADING1 HEADING2 HEADING3 HEADING4 HEADING5 HEADING6 PARAGRAPH LINEBREAK
%token BOLD1 BOLD2 ITALICS1 ITALICS2 BOLDITALICS1 BOLDITALICS2_OPEN BOLDITALICS3_OPEN
%token BOLDITALICS2_CLOSE BOLDITALICS3_CLOSE
%token ULS1 ULS2 ULS3 SPACE IMAGE OLS HORIZONTAL STRIKETHROUGH
%token LSQRB RSQRB LB RB EXCLAIM  NEWLINE PIPE SEPERATOR 
%token<str> TEXT URL


%start program

%union {
    char* str;
}



%type<str> block headingblock orderedlistblock unorderedlistblock boldblock
%type<str> italicsblock bolditalicsblock hyperlinkblock imageblock types  textblock horizontallineblock strikethroughblock

%%

program: join {printf("<!DOCTYPE html>");printf("<html><title>Markdown To HTML</title><head></head><body><style>table, th, td {border:1px solid black;}</style><p>");}       
                            
                            cluster 

                            {printf("</P></body></html>");}
;

cluster: block join cluster    

    |    block NEWLINE                      

    |    NEWLINE {signal();mutex();if(paraflag==1) printf("</p><p>");} cluster

    |    SPACE {printf("<br>");paraflag=0;} cluster                    
           
    
    ;

block: headingblock       

    |  orderedlistblock 

    |  unorderedlistblock 

    |  boldblock     

    |  italicsblock      

    |  bolditalicsblock     

    |  hyperlinkblock     

    |  imageblock     

    |  textblock   

    |  tableblock

    |  strikethroughblock

    |  horizontallineblock


    ;

headingblock: {signal();mutex();printf("</p>");} HEADING1 {printf("<h1>");} block  {printf("</h1>");printf("<p>");} 

    |         {signal();mutex();printf("</p>");} HEADING2 {printf("<h2>");} block  {printf("</h2>");printf("<p>");} 

    |         {signal();mutex();printf("</p>");} HEADING3 {printf("<h3>");} block  {printf("</h3>");printf("<p>");} 

    |         {signal();mutex();printf("</p>");} HEADING4 {printf("<h4>");} block  {printf("</h4>");printf("<p>");} 

    |         {signal();mutex();printf("</p>");} HEADING5 {printf("<h5>");} block  {printf("</h5>");printf("<p>");} 

    |         {signal();mutex();printf("</p>");} HEADING6 {printf("<h6>");} block  {printf("</h6>");printf("<p>");} 
;
    ;

orderedlistblock:   {signal();if(olflag==0) printf("</p><ol>");olflag=1;}OLS {printf("<li>");}    block     {printf("</li>");}      

unorderedlistblock: {mutex();if(ulflag==0) printf("</p><ul>");ulflag=1;}ultypes {printf("<li>");} block     {printf("</li>");} 
    ;

boldblock: BOLD1  {printf("<strong>");} block BOLD1     {printf("</strong>");}

    | BOLD2 {printf("<strong>");} block BOLD2           {printf("</strong>");}
    ;

italicsblock: ITALICS1 {printf("<i>");} block ITALICS1      {printf("</i>");}

    |         ITALICS2 {printf("<i>");} block ITALICS2      {printf("</i>");}

    ;

bolditalicsblock: BOLD2 ITALICS2 {printf("<i><strong>");} block BOLD2 ITALICS2                 {printf("</strong></i>");}

    |             BOLDITALICS2_OPEN {printf("<i><strong>");} block BOLDITALICS2_CLOSE          {printf("</strong></i>");}
    
    |             BOLDITALICS3_OPEN {printf("<strong><i>");} block BOLDITALICS3_CLOSE          {printf("</strong></i>");}

    ;



hyperlinkblock:
    LSQRB  {linkflag=0;} block  RSQRB LB URL {linkflag=1;} RB            {printf("<a href=\"%s\"> %s </a>",$6,$3);}         
    ;

imageblock:
    EXCLAIM {linkflag=0;}  block  RSQRB LB types {linkflag=1;}  RB       {printf("<img src=\"%s\" alt=\" %s \">",$6,$3);}          
    ;





ultypes: ULS1
    |    ULS2
    |    ULS3
    ;

join: SPACE      
    | NEWLINE          
    | %empty    
    ;

types:  URL     {$$=$1;}
    |   textblock   
    ;


tableblock: {signal();mutex();printf("</p>");} PIPE {signal();mutex();printf("</p>");tableflag=0;} {printf("<table><tr>");} firstrow SEPERATOR NEWLINE tablebody  {printf("</table><p>");} 
    ;

firstrow:  extraspace textblock extraspace PIPE {printf("<th>%s</th>",$2);} firstrow
    |      extraspace textblock extraspace PIPE {printf("<th>%s</th></tr>",$2);} NEWLINE
    ;


tablebody:  PIPE {printf("<tr>");} body 
    |       %empty
    ;

body:   extraspace  textblock extraspace  PIPE {printf("<td>%s</td>",$2);} body 
    |   extraspace  textblock extraspace  PIPE {printf("<td>%s</td>",$2);} NEWLINE {printf("</tr>");} tablebody {tableflag=1;}
    ;

strikethroughblock : STRIKETHROUGH {printf("<del> ");} block  {printf(" </del>");} STRIKETHROUGH 
                   ;

horizontallineblock : HORIZONTAL {printf("<hr>");}
                    ;



textblock: {paraflag=1;} TEXT  { if(linkflag!=0 && tableflag!=0) printf("%s",$2);$$=$2;}
         ;


extraspace: SPACE extraspace
          | %empty

; 





%%


void yyerror(char *s){
    fprintf(stderr,"error : %s", s);
}


int main() {
     #ifdef YYDEBUG
             yydebug=1;
     #endif
     //Initialize the lexer and parser here
    yyparse(); // Start parsing
    return 0;
}


