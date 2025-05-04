%{
#include <stdio.h>
%}

%%
([a-zA-Z0-9_\.\-]+)@([a-zA-Z0-9\-]+)\.([a-zA-Z]{2,6})  {
    printf("Valid Email Address: %s\n", yytext);
}
[^ \t\n]+ {
    printf("Invalid Email Address: %s\n", yytext);
}
[ \t\n] ; // Ignore whitespace
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}

