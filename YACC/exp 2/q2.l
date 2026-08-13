%{
#include "y.tab.h"
#include <string.h>
%}

%%
[a-zA-Z]+    { strcpy(yylval.str, yytext); return ID; }
[ \t]+       ;
\n           return 0;
"+"          return '+';
"*"          return '*';
.            return yytext[0];
%%

int yywrap()
{
    return 1;
}