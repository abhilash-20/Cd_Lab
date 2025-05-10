%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    char *str;
}

%token <str> BINARY HEX DECIMAL
%token EXIT_CMD INVALID

%%
input:
    /* empty */
    | input line
    ;

line:
    BINARY   { 
                int dec = strtol($1 + 2, NULL, 2);
                printf("Binary to Decimal: %d\n", dec);
                printf("Binary to Hex: 0x%X\n", dec);
             }
  | HEX      { 
                int dec = strtol($1, NULL, 16);
                printf("Hex to Decimal: %d\n", dec);
                printf("Hex to Binary: ");
                for (int i = 15; i >= 0; i--) printf("%d", (dec >> i) & 1);
                printf("\n");
             }
  | DECIMAL  { 
                int dec = atoi($1);
                printf("Decimal to Binary: ");
                for (int i = 15; i >= 0; i--) printf("%d", (dec >> i) & 1);
                printf("\n");
                printf("Decimal to Hex: 0x%X\n", dec);
             }
  | EXIT_CMD { 
                printf("Exiting...\n"); 
                exit(0); 
             }
  | INVALID  { printf("Invalid input\n"); }
  ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(){
    printf("Binary/Decimal/Hex Converter\n");
    printf("Enter the input: ");
    return yyparse();

}
