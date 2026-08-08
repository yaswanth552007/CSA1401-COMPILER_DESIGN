%{
#include<stdio.h>

int macro = 0, header = 0;
%}

%%
"#define"          { macro++; }
"#include".*       { header++; }
.|\n               ;
%%

int yywrap()
{
    return 1;
}

int main()
{
    yyin = fopen("sample1.c", "r");

    if(yyin == NULL)
    {
        printf("File not found\n");
        return 0;
    }

    yylex();

    printf("Number of Macros = %d\n", macro);
    printf("Number of Header Files = %d\n", header);

    fclose(yyin);
    return 0;
}