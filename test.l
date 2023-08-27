%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "test.tab.h"       //This file is created when the bison file is compiled.


%}


/*
 The %option noyywrap directive is used in Flex specifications to indicate
 that the generated lexer should not include the default yywrap which returns 1
 to indicate that scanning should stop, and because I don't want the default behaviour
 of ending file I used the %option noywrap.
*/
%option noyywrap

num                         [0-9]+                             
alpha                       [a-zA-Z]
alphanum                    [a-zA-Z0-9]
space                       [ ]
punc                        [@$%^&;"',\\<>\/?`\-!]
bold1                       (__)
bold2                       (\*\*)
italics1                    (\_)
italics2                    (\*)
bolditalics1                (___)
bolditalics2_open           (__\*)
bolditalics3_open           (\*\*_)
bolditalics2_close          (\*__)
bolditalics3_close          (_\*\*)
uls1                        ^\-{space}
uls2                        ^\+{space}
uls3                        ^\*{space}   
olst                        ^{num}\.{space}
sep1                        (\|{space}([\-]{2,}){space}\|)
sep2                        ({space}([\-]{2,}){space}\|)*
float                       ({num}(\.)?{num})
text                        ({alpha}|[\#]{7,}|[\'\"\.\?])({alphanum}|{punc}|\.|[\#]{1,})*  
floattext                   ({text}|{float})
line                        {floattext}({space}{floattext})*
url                         https?:\/\/{text}\/?




%%
^#{space}                    {return HEADING1;}
^##{space}                   {return HEADING2;}
^###{space}                  {return HEADING3;}
^####{space}                 {return HEADING4;}
^#####{space}                {return HEADING5;}
^######{space}               {return HEADING6;}
{space}                      {return SPACE;}
{uls2}                       {return ULS2;}
{line}                       {yylval.str = strdup(yytext); return TEXT;}
"~~"                         {return STRIKETHROUGH;}
^"\-"{3,}                    {return HORIZONTAL;}
^[>]                         {return BLOCKQUOTE;}
{bold1}                      {return BOLD1;}
{bold2}                      {return BOLD2;}
{italics1}                   {return ITALICS1;}
{italics2}                   {return ITALICS2;}
{bolditalics1}               {return BOLDITALICS1;}
{bolditalics2_open}          {return BOLDITALICS2_OPEN;}
{bolditalics3_open}          {return BOLDITALICS3_OPEN;}
{bolditalics2_close}         {return BOLDITALICS2_CLOSE;}
{bolditalics3_close}         {return BOLDITALICS3_CLOSE;}
{uls1}                       {return ULS1;}
{uls3}                       {return ULS3;}
{olst}                       {return OLS;}
{sep1}{sep2}                 {return SEPERATOR;}
{url}                        {yylval.str = strdup(yytext); return URL;}
"|"                          {return PIPE;}
"["			                 {return LSQRB;}
"]"			                 {return RSQRB;}
"("			                 {return LB;}
")"			                 {return RB;}
"!["                         {return EXCLAIM;}
\n                           {return NEWLINE;}


%%



