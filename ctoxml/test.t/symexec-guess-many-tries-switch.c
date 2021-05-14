#include <stdio.h>

int main(void) {
    while (1) {
        switch (getchar()) {
        case (-1|0):
            puts("good bye!");
            return 1;
        case 'A':
            puts("access granted");
            return 0;
        case '\n':
            continue;
        }
    }
}
