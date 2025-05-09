%{
#include<stdio.h>
#include<stdlib.h>

void yyerror(const char *s);

int yylex();
%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%right UMINUS

%%

input:
     input expr '\n' { printf("Result: %d\n", $2); }
   | /*empty*/
   ;

expr:
    expr '+' expr { $$=$1+$3; }
  | expr '-' expr { $$=$1-$3; }
  | expr '*' expr { $$=$1*$3; }
  | expr '/' expr
	{
		if($3==0)
		{
			yyerror("Division by Zero");
			$$=0;
		}
		else{
			$$=$1/$3; 
	    }
        }
  | '-' expr %prec UMINUS {$$=-$2; }
  | '(' expr ')'       {$$ = $2; }
  | NUMBER             {$$ = $1; }
  ;

%%

void yyerror(const char *s){
	fprintf(stderr,"Error: %s\n",s);
}

int main(){
	printf("Enter an arithmetic expression:\n");
	yyparse();
	return 0;
}


