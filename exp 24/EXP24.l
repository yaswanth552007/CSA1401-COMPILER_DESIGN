%{
#include<stdio.h>

FILE *fp;
int comments = 0;
%}

%%

"//".*      { comments++; }

"/*"([^*]|\n)*"*/"    { comments++; }

.|\n        { fputc(yytext[0], fp); }

%%

int yywrap()
{
    return 1;
}

int main()
{
    FILE *in;

    in = fopen("input.c","r");
    fp = fopen("output.c","w");

    if(in==NULL)
    {
        printf("Input file not found\n");
        return 0;
    }

    yyin = in;
    yylex();

    printf("Number of comment lines = %d\n", comments);

    fclose(in);
    fclose(fp);

    return 0;
}