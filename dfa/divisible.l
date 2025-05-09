%{
#include <stdio.h>

int state = 0;

void reset() {
    state = 0;
}

int check(char c) {
    switch(state) {
        case 0:
            if (c == '0') state = 0;
            else if (c == '1') state = 1;
            else return 0;
            break;
        case 1: 
            if (c == '0') state = 2;
            else if (c == '1') state = 0;
            else return 0;
            break;
        case 2:
            if (c == '0') state = 1;
            else if (c == '1') state = 2;
            else return 0;
            break;
    }
    return 1;
}
%}

%%
[01]+   {
            reset();
            int valid = 1;
            for(int i = 0; yytext[i] != '\0'; i++) {
                if(!check(yytext[i])) {
                    valid = 0;
                    break;
                }
            }

            if (state == 0 && valid) {
                printf("The string is divisible by 3.\n");
            } else {
                printf("Not accepted.\n");
            }
        }
.       { /* Ignore other characters */ }
%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter string: ");
    yylex();
    return 0;
}

