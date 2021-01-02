#include <stdio.h>
#include <stdlib.h>


int main(int argc, char* argv[]) {
    if (argc < 2) printf("usage: mario [numlevels]\n");
    int numlevels = atoi(argv[1]);
    for (int i = 1; i <= numlevels; i++) {
        for (int j = 0; j < i; j++)
            printf("#");
        printf("\n");
    }
}
