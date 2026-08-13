%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node
{
    char value[20];
    struct Node *left;
    struct Node *right;
} Node;

Node *root;

Node* createNode(char *value, Node *left, Node *right)
{
    Node *newNode = (Node *)malloc(sizeof(Node));

    strcpy(newNode->value, value);
    newNode->left = left;
    newNode->right = right;

    return newNode;
}

void preorder(Node *root)
{
    if(root != NULL)
    {
        printf("%s ", root->value);
        preorder(root->left);
        preorder(root->right);
    }
}

void inorder(Node *root)
{
    if(root != NULL)
    {
        inorder(root->left);
        printf("%s ", root->value);
        inorder(root->right);
    }
}

void postorder(Node *root)
{
    if(root != NULL)
    {
        postorder(root->left);
        postorder(root->right);
        printf("%s ", root->value);
    }
}

void displayTree(Node *root, int space)
{
    int i;

    if(root == NULL)
        return;

    space += 5;

    displayTree(root->right, space);

    printf("\n");

    for(i = 5; i < space; i++)
        printf(" ");

    printf("%s\n", root->value);

    displayTree(root->left, space);
}

int yylex();
void yyerror(char *s);
%}

%code requires {
typedef struct Node Node;
}

%union
{
    char str[20];
    Node *node;
}

%token <str> ID
%type <node> expr input

%left '+'
%left '*'

%%

input:
    expr
    {
        root = $1;
    }
    ;

expr:
      expr '+' expr
      {
          $$ = createNode("+", $1, $3);
      }
    | expr '*' expr
      {
          $$ = createNode("*", $1, $3);
      }
    | ID
      {
          $$ = createNode($1, NULL, NULL);
      }
    ;

%%

void yyerror(char *s)
{
    printf("Invalid Expression\n");
}

int main()
{
    printf("Enter expression: ");
    yyparse();

    printf("\nAbstract Syntax Tree:\n");
    displayTree(root, 0);

    printf("\nPreorder Traversal: ");
    preorder(root);

    printf("\nInorder Traversal: ");
    inorder(root);

    printf("\nPostorder Traversal: ");
    postorder(root);

    printf("\n");

    return 0;
}