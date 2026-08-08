%{
#include <stdio.h>
%}

%%

[A-Z]+      { printf("%s\n", yytext); }

[ \t\n]+    ;

.           ;

%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter the text:\n");
    yylex();
    return 0;
}