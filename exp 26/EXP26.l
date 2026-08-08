%{
#include<stdio.h>
%}

%%

[a-zA-Z][a-zA-Z0-9._]*@[a-zA-Z0-9.-]+".com"    { printf("Valid Email Address\n"); }

[a-zA-Z][a-zA-Z0-9._]*@[a-zA-Z0-9.-]+".in"     { printf("Valid Email Address\n"); }

[a-zA-Z][a-zA-Z0-9._]*@[a-zA-Z0-9.-]+".org"    { printf("Valid Email Address\n"); }

.+                                             { printf("Invalid Email Address\n"); }

%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter Email Address:\n");
    yylex();
    return 0;
}