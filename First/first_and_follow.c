#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 10

char productions[MAX][10];
char firsts[MAX][10];
char follows[MAX][10];
int n;

int isNonTerminal(char symbol) {
    return symbol >= 'A' && symbol <= 'Z';
}

void findFirst(char* result, char symbol);
void addToSet(char* set, char value) {
    if (strchr(set, value) == NULL) {
        int len = strlen(set);
        set[len] = value;
        set[len + 1] = '\0';
    }
}

void findFirst(char* result, char symbol) {
    if (!isNonTerminal(symbol)) {
        addToSet(result, symbol);
        return;
    }

    for (int i = 0; i < n; i++) {
        if (productions[i][0] == symbol) {
            if (productions[i][2] == '\0') {
                addToSet(result, '#'); // epsilon
            } else {
                int j = 2;
                while (productions[i][j] != '\0') {
                    char temp[10] = "";
                    findFirst(temp, productions[i][j]);

                    for (int k = 0; temp[k] != '\0'; k++) {
                        if (temp[k] != '#')
                            addToSet(result, temp[k]);
                    }

                    if (strchr(temp, '#') == NULL)
                        break;
                    j++;
                }
                if (productions[i][j] == '\0') {
                    addToSet(result, '#');
                }
            }
        }
    }
}

void findFollow(char* result, char symbol) {
    if (symbol == productions[0][0]) {
        addToSet(result, '$'); // Start symbol gets $
    }

    for (int i = 0; i < n; i++) {
        char* pos = strchr(productions[i], symbol);
        while (pos != NULL && *(pos + 1) != '\0') {
            char next = *(pos + 1);
            char temp[10] = "";
            findFirst(temp, next);

            for (int k = 0; temp[k] != '\0'; k++) {
                if (temp[k] != '#')
                    addToSet(result, temp[k]);
            }

            if (strchr(temp, '#') != NULL) {
                if (productions[i][0] != symbol)
                    findFollow(result, productions[i][0]);
            }

            pos = strchr(pos + 1, symbol);
        }

        if (productions[i][strlen(productions[i]) - 1] == symbol && productions[i][0] != symbol) {
            findFollow(result, productions[i][0]);
        }
    }
}

int main() {
    printf("Enter number of productions: ");
    scanf("%d", &n);

    printf("Enter productions (e.g., E=TR):\n");
    for (int i = 0; i < n; i++) {
        scanf("%s", productions[i]);
    }

    for (int i = 0; i < n; i++) {
        char nt = productions[i][0];
        char first[10] = "";
        findFirst(first, nt);
        strcpy(firsts[i], first);
    }

    for (int i = 0; i < n; i++) {
        char nt = productions[i][0];
        char follow[10] = "";
        findFollow(follow, nt);
        strcpy(follows[i], follow);
    }

    printf("\nFIRST and FOLLOW sets:\n");
    for (int i = 0; i < n; i++) {
        printf("Non-terminal: %c\n", productions[i][0]);
        printf("FIRST: %s\n", firsts[i]);
        printf("FOLLOW: %s\n\n", follows[i]);
    }

    return 0;
}

