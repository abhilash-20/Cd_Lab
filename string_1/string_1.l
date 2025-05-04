%{
#include<stdio.h>
#include<string.h>


void check_string(const char *str);

%}

%%
[01]+ 	{check_string(yytext); }
[^01\n]	{printf ("Invalid input: %s\n",yytext); }
\n	;  /*Ignore newlines */
%%

void check_string(const char *str)
{
	int len=strlen(str);
	if (len<2){
		printf("Rejected: String is too short.\n");
		return;
	}
	if (str[len-1]=='0' && str[len-2]=='0'){
		printf("Accepted: String ends with '00'");
	}
	else{
		printf("Rejected: The string does not end with '00'.\n");
	}
}

int main()
{
	printf("Enter a string: ");
	yylex();
	return 0;
}

int yywrap()
{
	return 1;
}
  
