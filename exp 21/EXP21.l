%{
#include <stdio.h>

int vowels = 0, consonants = 0;
%}

%%

[aAeEiIoOuU]                 { vowels++; }

[a-zA-Z]                     { consonants++; }

[ \t\n]                      ;

.                             ;

%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter a word or sentence:\n");
    yylex();

    printf("\nNumber of Vowels = %d\n", vowels);
    printf("Number of Consonants = %d\n", consonants);

    return 0;
}