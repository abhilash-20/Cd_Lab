%{
#include "lalr.tab.h"
%}

%%

[a-zA-Z]  { return ID; }
[+]       { return '+'; }
[*]       { return '*'; }
[(]       { return '('; }
[)]       { return ')'; }
[ \t\n]   ;  // ignore whitespace
.         { return yytext[0]; }

%%

int yywrap() { return 1; }
