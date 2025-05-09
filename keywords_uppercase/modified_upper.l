%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>
%}

%option noyywrap

KEYWORD    main|int|scanf|if|else|while|printf

%%

{KEYWORD}  {
    for (int i = 0; i < yyleng; i++) {
        printf("%c", toupper(yytext[i]));
    }
}

[^\n\t ]+   { printf("%s", yytext); }     // Non-keywords
[ \t\n]+    { printf("%s", yytext); }     // Whitespace, preserve formatting

%%

int main() {
    printf("Enter your code (Ctrl+D to end):\n");
    yylex();
    return 0;
}

