%{
#include <stdio.h>
#include <string.h>
%}

%%

[^\n]*\?      { printf("This is a Question.\n"); }
[^\n]+        { printf("This is a Statement.\n"); }

%%

int main() {
    printf("Enter text: ");
    yylex();  // Call the Lex scanner to process input
    return 0;
}

