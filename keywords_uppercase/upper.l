%{
#include<stdio.h>
#include<ctype.h>
int i;
%}

keyword main|int|scanf|if|else|while|printf

%%
{
{keyword} {
	for (i=0;i<yyleng;i++){
		printf("%c",toupper(yytext[i]));
	}
	  }	
}
%%

int yywrap() {}

int main()
{
	yyin =fopen("num.c","r");
	yylex();
	return 0;
}
