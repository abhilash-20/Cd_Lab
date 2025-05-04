%{
#include <stdio.h>

int paren_count = 0; // Counter for open parentheses
%}

%%

"("         { paren_count++; }

")"         { 
                paren_count--;
                if (paren_count < 0) {
                    printf("Error: Mismatched closing parenthesis\n");
                    paren_count = 0;
                }
            }

[^\(\)\n]+  ;  /* Ignore non-parenthesis characters */

\n          {
                if (paren_count > 0) {
                    printf("Error: Missing %d closing parenthesis\n", paren_count);
                } else {
                    printf("Expression is valid\n");
                }
                paren_count = 0;
            }

%%

int main() {
    printf("Enter an expression (Ctrl+D to stop):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}

