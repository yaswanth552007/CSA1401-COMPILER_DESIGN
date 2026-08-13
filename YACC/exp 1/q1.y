%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(char *s);
%}

%union
{
    int value;
}

%token <value> NUMBER
%type <value> expr

%left '+'
%left '*'

%%

input:
    expr
    {
        printf("Result = %d\n", $1);
    }
    ;

expr:
      expr '+' expr
      {
          $$ = $1 + $3;
      }
    | expr '*' expr
      {
          $$ = $1 * $3;
      }
    | NUMBER
      {
          $$ = $1;
      }
    ;

%%

void yyerror(char *s)
{
    printf("Invalid Expression\n");
}

int main()
{
    printf("Enter arithmetic expression: ");
    yyparse();
    return 0;
}