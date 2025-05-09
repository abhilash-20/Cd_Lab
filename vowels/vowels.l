%{
int v=0,c=0;
%}

%%
{
[aeiouAEIOU]	{++v;}
[a-zA-Z&&^aeiouAEIOU]	{++c;}
}
\n	{return 0;}
%%

int yywrap() {}
int main()
{
	printf("Enter a line of words: ");
	yylex();
	printf("No of vowels =%d, No of consonants=%d\n",v,c);
	return 0;
}
