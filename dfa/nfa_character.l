/*nfa to check if the third last character is a*/

%{
#include <stdio.h>

int state = 0;

void reset() {
    state = 0;
}

int check(char c) {
    switch(state) {
        case 0:
            if (c == 'a')
            	state = 1;
            break;
        case 1: 
           
            state = 2;
            break;
        case 2:
           
            state = 3;
            break;
	case 3:
	    if (c == 'a') state = 1;
            else state=0;
            break;
    }
    return 1;
}
%}

%%
[ab]+   {
            reset();
            int valid = 1;
            for(int i = 0; yytext[i] != '\0'; i++) {
                if(!check(yytext[i])) {
                    valid = 0;
                    break;
                }
            }

            if (state == 3 && valid) {
                printf("The third last character is 'a'.\n");
            } else {
                printf("false.\n");
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


