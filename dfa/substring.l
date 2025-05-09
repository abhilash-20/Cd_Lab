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
            else if (c == '1') state = 4;
            else return 0;
            break;
        case 2:
            if (c == '0') state = 0;
            else if (c == '1') state = 3;
            else return 0;
            break;
	case 3:
	    if (c == '0') state = 3;
            else if (c == '1') state = 3;
            else return 0;
            break;
	case 4:
	    if (c == '0') state = 3;
            else if (c == '1') state = 4;
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

            if (state == 3 && valid) {
                printf("The string has substring 101 or 110.\n");
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

