%{
#include <stdio.h>
%}

%%
[a-zA-Z_][a-zA-Z0-9_]*   { printf("Valid variable name: %s\n", yytext); }
[0-9][a-zA-Z0-9_]*	 {printf("Invalid variable name: %s\n",yytext); }
.|\n                     { }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}

