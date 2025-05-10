%{
#include "new_converter.tab.h"
%}

%%
0b[01]+         { yylval.str = yytext; return BINARY; }
0x[0-9a-fA-F]+  { yylval.str = yytext; return HEX; }
[0-9]+          { yylval.str = yytext; return DECIMAL; }
exit            { return EXIT_CMD; }
[ \t\n]+        ;   // ignore whitespace
.               { return INVALID; }
%%

int yywrap(){
    return 1;
}
