%{
#include <stdio.h>
#include <string.h>

char *reserved_words[] = { "int", "float", "if", "else", "while", "for", "return", "void", "char", NULL };

int is_reserved(char *word) {
    int i = 0;
    while (reserved_words[i] != NULL) {
        if (strcmp(word, reserved_words[i]) == 0)
            return 1;  // It's a reserved word
        i++;
    }
    return 0;  // Not a reserved word
}
%}

%%
[a-zA-Z_][a-zA-Z0-9_]*   { 
                            if (is_reserved(yytext))
                                printf("Reserved Word: %s\n", yytext);
                            else
                                printf("User Defined Identifier: %s\n", yytext);
                         }
[ \t\n]+                 { /* Ignore whitespace */ }
.                        { printf("Invalid character: %s\n", yytext); }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}

