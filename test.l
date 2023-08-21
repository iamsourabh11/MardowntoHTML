%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "test.tab.h"


%}

%option noyywrap

num                         [0-9]+
alpha                       [a-zA-Z]
alphanum                    [a-zA-Z0-9]
space                       [ ]
punc                        [@$%^&;"',\\<>\/?`~\.]
bold1                       (\_\_)
bold2                       (\*\*)
italics1                    (\_)
italics2                    (\*)
bolditalics1                (\_\_\_)
bolditalics2_open           (\_\_\*)
bolditalics3_open           (\*\*\_)
bolditalics2_close          (\*_\_)
bolditalics3_close          (\_\*\*)
strikethrough               (\~\~)
nwl                         (\n)
uls1                        (-)
uls2                        (\+)
uls3                        (\*)    

sep1                        (\|--\|)
sep2                        (--\|)*


paragraph                   (\n\n)
text                        ({ALPHANUM}|{PUNC}|{SPACE})*{space}{space}{nwl}

softline                     ((  )\n)




%%
(#{space})                      {return HEADING1;}
(##{space})                     {return HEADING2;}
(###{space})                    {return HEADING3;}
(####{space})                   {return HEADING4;}
(#####{space})                  {return HEADING5;}
(######{space})                 {return HEADING6;}

text                            {return TEXT;}


paragraph                       {return PARAGRAPH;}

softline                        {return LINEBREAK;}

bold1                           {return BOLD1;}
bold2                           {return BOLD2;}
italics1                        {return ITALICS1;}
italics2                        {return ITALICS2;}
bolditalics1                    {return BOLDITALICS1;}
bolditalics2_open               {return BOLDITALICS2_OPEN;}
bolditalics3_open               {return BOLDITALICS3_OPEN;}
bolditalics2_close              {return BOLDITALICS2_CLOSE;}
bolditalics3_close              {return BOLDITALICS3_CLOSE;}

uls1{space}                     {return ULS1;}
uls2{space}                     {return ULS2;}
uls3{space}                     {return ULS3;}


num                             {return NUM;}
(\.)                            {return DOT;}
space                           {return SPACE;}


"|"                             {return PIPE;}

{sep1}{sep2}                    {return TABLE_SEPERATOR;}



"["			                    {return LSQRB;}
"]"			                    {return RSQRB;}
"("			                    {return LB;}
")"			                    {return RB;}
"!"                             {return EXCLAIM;}
nwl                             {return NEWLINE;}



[. | #{7,}{space}]                {return yytext[0];}



%%


