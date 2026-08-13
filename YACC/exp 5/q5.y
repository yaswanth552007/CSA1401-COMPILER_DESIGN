%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct
{
    char name[30];
    char type[10];
} Symbol;

Symbol table[20];
int count = 0;

void addSymbol(char *name, char *type)
{
    strcpy(table[count].name, name);
    strcpy(table[count].type, type);
    count++;
}

char* getType(char *name)
{
    int i;

    for(i = 0; i < count; i++)
    {
        if(strcmp(table[i].name, name) == 0)
            return table[i].type;
    }

    return "unknown";
}

void checkAssignment(char *left, char *right)
{
    char *leftType = getType(left);
    char *rightType = getType(right);

    printf("\nAssignment: %s = %s\n", left, right);
    printf("Left Type  = %s\n", leftType);
    printf("Right Type = %s\n", rightType);

    if(strcmp(leftType, rightType) == 0)
    {
        printf("No type conversion required.\n");
    }
    else if(strcmp(leftType, "float") == 0 &&
            strcmp(rightType, "int") == 0)
    {
        printf("Type conversion: int -> float\n");
        printf("Implicit coercion performed successfully.\n");
    }
    else
    {
        printf("Type mismatch.\n");
    }

    printf("Final type of %s = %s\n", left, leftType);
}

int yylex();
void yyerror(char *s);
%}

%union
{
    char str[30];
}

%token FLOAT INT
%token <str> ID

%%

program:
      declarations assignment
      {
          printf("\nProgram processed successfully.\n");
      }
      ;

declarations:
      declarations declaration
    | declaration
    ;

declaration:
      FLOAT ID ';'
      {
          addSymbol($2, "float");
          printf("Declared: float %s\n", $2);
      }

    | INT ID ';'
      {
          addSymbol($2, "int");
          printf("Declared: int %s\n", $2);
      }
      ;

assignment:
      ID '=' ID ';'
      {
          checkAssignment($1, $3);
      }
      ;

%%

void yyerror(char *s)
{
    printf("Syntax Error\n");
}

int main()
{
    printf("Enter program:\n");
    yyparse();

    return 0;
}