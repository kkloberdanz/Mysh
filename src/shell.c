#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#include "shell.h"

char* get_line_from_stdin() {
    char c = 'a';
    char* buffer = malloc(sizeof(char) * READ_BUFFER_SIZE);

    int i; 
    for(i = 0; (i < READ_BUFFER_SIZE) && (c != '\n'); ++i) {
        c = getchar();
        buffer[i] = c;
    }

    if (i >= READ_BUFFER_SIZE) {
        fprintf(stderr, "Buffer overflow at get_line_from_stdin()\n");
        exit(EXIT_FAILURE);
    }

    buffer[i] = '\0'; 
    return buffer;
}

int shell_loop(void) {
    int exit_status, i;
    char* input_line; 

    do {
        printf("%c ", '>');

        input_line = get_line_from_stdin();

        printf("out: %s\n", input_line); 

        free(input_line);

        exit_status = strcmp(input_line, "exit\n"); 
    } while (exit_status != 0); 

    return 0;
}
