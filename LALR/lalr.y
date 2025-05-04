%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
%}

%start input

%token ID

%%

input: E '\n' { printf("Parsed successfully\n"); }
     ;

E : E '+' T     { printf("Reduced E → E + T\n"); }
  | T           { printf("Reduced E → T\n"); }
  ;

T : T '*' F     { printf("Reduced T → T * F\n"); }
  | F           { printf("Reduced T → F\n"); }
  ;

F : '(' E ')'   { printf("Reduced F → (E)\n"); }
  | ID          { printf("Reduced F → id\n"); }
  ;

%%

int main(){
    printf("Enter expression: ");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
