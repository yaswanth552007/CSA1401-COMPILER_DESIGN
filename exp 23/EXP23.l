%{
#include<stdio.h>

int line = 1;
%}

%%

.*\n    { printf("%d\t%s", line++, yytext); }

.+      { printf("%d\t%s\n", line++, yytext); }

%%

int yywrap()
{
    return 1;
}

int main()
{
    FILE *fp;

    fp = fopen("sample.c","r");

    if(fp==NULL)
    {
        printf("File not found");
        return 0;
    }

    yyin = fp;
    yylex();

    fclose(fp);

    return 0;
}