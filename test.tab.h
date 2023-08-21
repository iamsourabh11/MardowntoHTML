/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_TEST_TAB_H_INCLUDED
# define YY_YY_TEST_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    HEADING1 = 258,                /* HEADING1  */
    HEADING2 = 259,                /* HEADING2  */
    HEADING3 = 260,                /* HEADING3  */
    HEADING4 = 261,                /* HEADING4  */
    HEADING5 = 262,                /* HEADING5  */
    HEADING6 = 263,                /* HEADING6  */
    PARAGRAPH = 264,               /* PARAGRAPH  */
    LINEBREAK = 265,               /* LINEBREAK  */
    BOLD1 = 266,                   /* BOLD1  */
    BOLD2 = 267,                   /* BOLD2  */
    ITALICS1 = 268,                /* ITALICS1  */
    ITALICS2 = 269,                /* ITALICS2  */
    BOLDITALICS1 = 270,            /* BOLDITALICS1  */
    BOLDITALICS2_OPEN = 271,       /* BOLDITALICS2_OPEN  */
    BOLDITALICS3_OPEN = 272,       /* BOLDITALICS3_OPEN  */
    BOLDITALICS2_CLOSE = 273,      /* BOLDITALICS2_CLOSE  */
    BOLDITALICS3_CLOSE = 274,      /* BOLDITALICS3_CLOSE  */
    ULS1 = 275,                    /* ULS1  */
    ULS2 = 276,                    /* ULS2  */
    ULS3 = 277,                    /* ULS3  */
    SPACE = 278,                   /* SPACE  */
    DOT = 279,                     /* DOT  */
    LSQRB = 280,                   /* LSQRB  */
    RSQRB = 281,                   /* RSQRB  */
    LB = 282,                      /* LB  */
    RB = 283,                      /* RB  */
    EXCLAIM = 284,                 /* EXCLAIM  */
    NEWLINE = 285,                 /* NEWLINE  */
    PIPE = 286,                    /* PIPE  */
    TABLE_SEPERATOR = 287,         /* TABLE_SEPERATOR  */
    NUM = 288,                     /* NUM  */
    TEXT = 289                     /* TEXT  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 25 "test.y"

    char* str;

#line 102 "test.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_TEST_TAB_H_INCLUDED  */
