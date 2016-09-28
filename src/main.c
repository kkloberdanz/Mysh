#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#include "shell.h"
#include "linkedlist.h"

int main(int argc, char** argv) { 

    if (argc == 2) {
        read_from_file(argv[1]);
    } else if (!shell_loop()) {
        ;
    } else { 
        return 1;
    }

    return 0;
}

