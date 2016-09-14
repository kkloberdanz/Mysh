#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#include "shell.h"

int main(int argc, char** argv) {

    if (!shell_loop()) {
        return 0;
    } else { 
        return 1;
    }
}

