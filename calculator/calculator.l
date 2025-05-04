%{
#include "calculator.tab.h"
%}

%%
[ \t]		; 		//ignore whitespaces
[0-9]+		{ yylval = atoi(yytext); return NUMBER; }
"+"		return '+';
"-"		return '-';
"*"		return '*';
"/"		return '/';
"("		return '(';
")"		return ')';
\n		return '\n';

.		{ printf("Unknown characters: %s\n",yytext); }

%%

int yywrap(){
	return 1;
}
