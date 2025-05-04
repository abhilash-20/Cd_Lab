%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// A simple structure to store words
#define MAX_WORDS 100
char* words[MAX_WORDS];
int word_count = 0;

// Function to check if a word is already in the list
int is_word_repeated(char* word) {
    for (int i = 0; i < word_count; i++) {
        if (strcmp(words[i], word) == 0) {
            return 1; // Word is repeated
        }
    }
    return 0; // Word is not repeated
}

// Function to add a word to the list
void add_word(char* word) {
    if (word_count < MAX_WORDS) {
        words[word_count] = strdup(word); // Store a copy of the word
        word_count++;
    }
}
%}

%%

[a-zA-Z0-9]+  {
                    if (is_word_repeated(yytext)) {
                        printf("Repeated word detected: %s\n", yytext);
                    } else {
                        add_word(yytext);
                    }
                }

[ \t\n]+        { /* Skip whitespace characters */ }

.               { /* Ignore any other characters */ }

%%

int main() {
    printf("Enter text: ");
    yylex();  // Start the Lex scanner
    return 0;
}

