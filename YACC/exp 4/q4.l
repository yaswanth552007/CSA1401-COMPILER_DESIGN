%{
#include "y.tab.h"
#include <string.h>
%}

%%

"type"      { return TYPE; }
"int"       { return INT; }

[a-zA-Z_][a-zA-Z0-9_]* {
    strcpy(yylval.str, yytext);
    return ID;
}

"="         { return '='; }
";"         { return ';'; }

[ \t\n]+    ;

.           { return yytext[0]; }

%%

int yywrap()
{
    return 1;
}