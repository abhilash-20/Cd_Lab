%{
#include <stdio.h>
%}

%%

\<[a-zA-Z][a-zA-Z0-9]*\>     { printf("Valid HTML tag: %s\n", yytext); }

\<[^a-zA-Z][^>]*\>           { printf("Invalid tag: %s (starts with non-letter)\n", yytext); }

\<[a-zA-Z0-9]*               { printf("Invalid tag: %s (missing '>')\n", yytext); }

.|\n                        ; // Ignore everything else

%%

int main() {
    printf("Enter HTML tags (Ctrl+D to stop):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
