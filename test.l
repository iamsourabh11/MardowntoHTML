%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "test.tab.h"

extern int yyval;


%}

%option noyywrap

num                         [0-9]
alpha                       [a-zA-Z]
alphanum                    [a-zA-Z0-9]
space                       [ ]
punc                        [@$%^&;"',\\<>\/?`~]
bold1                       (__)
bold2                       (\*\*)
italics1                    (\_)
italics2                    (\*)
bolditalics1                (___)
bolditalics2_open           (__\*)
bolditalics3_open           (\*\*_)
bolditalics2_close          (\*__)
bolditalics3_close          (_\*\*)

uls1                        (\-{space})
uls2                        (\+{space})
uls3                        (\*{space})   
olst                        ({num}\.{space})
sep1                        (\|\-\-\|)
sep2                        (\-\-\|)*

text                         ({alpha}|{punc}|\.|\#{7,}|{space}|{space}{2}\n)*



paragraph                   (\n\n)

softline                     ({space}{space}\n)
url                          (http)(s?:)(\/\/[a-zA-Z\-\.]+\.[a-zA-Z]+)
image                        ([a-zA-Z0-9\/]+\.[a-zA-Z]+)




%%
^"# "                          {return HEADING1;}
^"## "                         {return HEADING2;}
^"### "                        {return HEADING3;}
^"#### "                       {return HEADING4;}
^"##### "                      {return HEADING5;}
^"###### "                    {return HEADING6;}

{space}                           {return SPACE;}

{softline}                        {return LINEBREAK;}

{uls2}                            {return ULS2;}

{text}                            {return TEXT;}
{paragraph}                       {return PARAGRAPH;}



{bold1}                           {return BOLD1;}
{bold2}                           {return BOLD2;}
{italics1}                        {return ITALICS1;}
{italics2}                        {return ITALICS2;}
{bolditalics1}                    {return BOLDITALICS1;}
{bolditalics2_open}               {return BOLDITALICS2_OPEN;}
{bolditalics3_open}               {return BOLDITALICS3_OPEN;}
{bolditalics2_close}              {return BOLDITALICS2_CLOSE;}
{bolditalics3_close}              {return BOLDITALICS3_CLOSE;}

{uls1}                            {return ULS1;}

{uls3}                            {return ULS3;}
{olst}                             {return OLS;}




{url}                             {return URL;}
{image}                             {return IMAGE;}



"["			                      {return LSQRB;}
"]"			                      {return RSQRB;}
"("			                      {return LB;}
")"			                      {return RB;}
"!"                               {return EXCLAIM;}
(\n)                               {return NEWLINE;}


%%


