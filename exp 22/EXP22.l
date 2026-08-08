%{
#include <stdio.h>
%}

%%

\<[^>]*\>      { printf("%s\n", yytext); }

.|\n           ;

%%

int yywrap()
{
    return 1;
}

int main()
{
    FILE *fp;

    fp = fopen("sample.html", "r");

    if(fp == NULL)
    {
        printf("File not found!\n");
        return 0;
    }

    yyin = fp;
    yylex();

    fclose(fp);
    return 0;
}