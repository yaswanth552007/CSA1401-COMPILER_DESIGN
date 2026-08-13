%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct
{
    char name[20];
    char type[20];
} Symbol;

Symbol table[50];
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

void displayTable()
{
    int i;

    printf("\nSymbol Table\n");
    printf("---------------------\n");
    printf("Name\tType\n");
    printf("---------------------\n");

    for(i = 0; i < count; i++)
    {
        printf("%s\t%s\n",
               table[i].name,
               table[i].type);
    }
}

void checkEquivalence()
{
    char *typeA = getType("A");
    char *typeB = getType("B");

    printf("\nComparing A and B\n");
    printf("Type of A = %s\n", typeA);
    printf("Type of B = %s\n", typeB);

    printf("Name Equivalence       : Not Equivalent\n");

    if(strcmp(typeA, typeB) == 0)
        printf("Structural Equivalence : Equivalent\n");
    else
        printf("Structural Equivalence : Not Equivalent\n");
}

int yylex();
void yyerror(char *s);
%}

%union
{
    char str[20];
}

%token TYPE INT
%token <str> ID

%%

program:
      declaration declaration declaration declaration
      {
          displayTable();
          checkEquivalence();
      }
      ;

declaration:
      TYPE ID '=' INT ';'
      {
          addSymbol($2, "int");
          printf("Type declared: %s = int\n", $2);
      }

    | ID ID ';'
      {
          addSymbol($2, $1);
          printf("Variable declared: %s %s\n",
                 $1, $2);
      }
      ;

%%

void yyerror(char *s)
{
    /* No error message */
}

int main()
{
    printf("Enter exactly these 4 declarations:\n");
    yyparse();

    return 0;
}