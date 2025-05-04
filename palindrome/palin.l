%{
#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>

// Converts the input string to lowercase and checks if it's a palindrome
bool is_palindrome(const char *str) {
    int len = strlen(str);
    char lower_str[1000];

    for (int i = 0; i < len; i++) {
        lower_str[i] = tolower(str[i]);
    }
    lower_str[len] = '\0';

    for (int i = 0; i < len / 2; i++) {
        if (lower_str[i] != lower_str[len - i - 1]) {
            return false;
        }
    }
    return true;
}
%}

%%
[a-zA-Z]+ {
    if (is_palindrome(yytext)) {
        printf("\"%s\" is a palindrome\n", yytext);
    } else {
        printf("\"%s\" is not a palindrome\n", yytext);
    }
}

.|\n ;  // Ignore all other characters (spaces, punctuation, etc.)
%%

int main() {
    printf("Enter words (Ctrl+D to stop):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}

