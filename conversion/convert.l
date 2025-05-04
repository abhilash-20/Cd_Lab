%{
#include "convert.tab.h"
#include <string.h>
%}

%%
b2d                 { return B2D; }
d2b                 { return D2B; }
h2b                 { return H2B; }
b2h                 { return B2H; }
[01]+               { yylval.str = strdup(yytext); return BINARY; }
[0-9]+              { yylval.str = strdup(yytext); return DECIMAL; }
[0-9A-Fa-f]+        { yylval.str = strdup(yytext); return HEX; }
[ \t]+              { /* ignore whitespace */ }
\n                  { return 0; }  // newline signals end of input
.                   { return INVALID; }
%%

int yywrap() {
    return 1;
}

