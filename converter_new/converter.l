%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int binaryToDecimal(char *bin) {
    int dec = 0;
    while (*bin) {
        dec = dec * 2 + (*bin++ - '0');
    }
    return dec;
}

void decimalToBinary(int num) {
    if (num == 0) {
        printf("0\n");
        return;
    }
    char bin[32];
    int i = 0;
    while (num > 0) {
        bin[i++] = (num % 2) + '0';
        num /= 2;
    }
    for (int j = i - 1; j >= 0; j--) {
        putchar(bin[j]);
    }
    printf("\n");
}
%}

%%
binary-to-decimal[ \t]+[01]+ {
    char bin[100];
    sscanf(yytext, "binary-to-decimal %s", bin);
    printf("Decimal: %d\n", binaryToDecimal(bin));
}
decimal-to-binary[ \t]+[0-9]+ {
    int num;
    sscanf(yytext, "decimal-to-binary %d", &num);
    printf("Binary: ");
    decimalToBinary(num);
}
binary-to-hex[ \t]+[01]+ {
    char bin[100];
    sscanf(yytext, "binary-to-hex %s", bin);
    printf("Hex: %X\n", binaryToDecimal(bin));
}
hex-to-binary[ \t]+[a-fA-F0-9]+ {
    char hex[100];
    sscanf(yytext, "hex-to-binary %s", hex);
    int dec = (int)strtol(hex, NULL, 16);
    printf("Binary: ");
    decimalToBinary(dec);
}
exit {
    printf("Exiting...\n");
    exit(0);
}
.|\n  ;
%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter conversion (type 'exit' to quit):\n");
    while (1) yylex();
    return 0;
}
