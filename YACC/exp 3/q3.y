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
%type <value> E T F

%left '+'
%left '*'

%%

input:
    E
    {
        printf("\nFinal Result = %d\n", $1);
    }
    ;

E:
      E '+' T
      {
          $$ = $1 + $3;
          printf("E -> E + T : %d + %d = %d\n",
                 $1, $3, $$);
      }
    | T
      {
          $$ = $1;
          printf("E -> T : %d\n", $$);
      }
    ;

T:
      T '*' F
      {
          $$ = $1 * $3;
          printf("T -> T * F : %d * %d = %d\n",
                 $1, $3, $$);
      }
    | F
      {
          $$ = $1;
          printf("T -> F : %d\n", $$);
      }
    ;

F:
      NUMBER
      {
          $$ = $1;
          printf("F -> NUMBER : %d\n", $$);
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