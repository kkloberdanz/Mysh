#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#include "shell.h" 

char* get_line_from_stdin() {
    char c = 'a';
    char* buffer = malloc(sizeof(char) * READ_BUFFER_SIZE);

    /*
     * TODO:
     *     Rewrite so that if READ_BUFFER_SIZE is exceeded, more
     *     memory is allocated to buffer
     */
    int i; 
    for(i = 0; (i < READ_BUFFER_SIZE) && (c != '\n'); ++i) {
        c = getchar();
        buffer[i] = c;
    }

    if (i >= READ_BUFFER_SIZE) {
        fprintf(stderr, "Buffer overflow at get_line_from_stdin()\n");
        exit(EXIT_FAILURE);
    }

    return buffer;
}

void clean_input(char* buffer) { 
    int i;
    for (i = 0; buffer[i] != '\0'; ++i) {
        if (buffer[i] == '\n') {
            buffer[i] = '\0';
            return;
        }
    }
}

int shell_loop(void) {
    const char* exit_str = "exit";
    int exit_status;
    char* input_line; 

    do {
        printf("%c ", '>');

        input_line = get_line_from_stdin();

        clean_input(input_line);

        printf("out: '%s'\n", input_line); 


        exit_status = strcmp(input_line, exit_str); 
        free(input_line);
    } while (exit_status != 0); 

    return 0;
}
