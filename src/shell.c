#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#include "shell.h" 
#include "linkedlist.h" 

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
    /*
     * TODO:
     *     Remove spaces after tokens
     */
    struct Node* command_list;
    command_list = malloc(sizeof(command_list));
    ll_initialize(command_list);

    /* Remove spaces before token */ 
    while (buffer[0] == ' ') { 
        int j;
        for (j = 0; buffer[j] != '\0'; ++j) {
            buffer[j] = buffer[j+1];
        } 
    }

    char cmd[READ_BUFFER_SIZE] = {0};
    int cmd_counter = 0;
    for (i = 0; buffer[i] != '\0'; ++i) { 

        /* treat new line char as end of command */
        if (buffer[i] == '\n') {
            buffer[i] = '\0';
            ll_push_node(command_list, cmd);
            ll_print(command_list);
            ll_destroy(command_list);
            return; 

        /* if not space, then build cmd */
        } else if (buffer[i] != ' ') {
            cmd[cmd_counter] = buffer[i];
            cmd_counter++;

        /* when the next command is reached, append it to list */
        } else if ((buffer[i] == ' ') && 
                   (cmd[0] != '\0')   && 
                   (cmd[0] != ' ')){
            ll_push_node(command_list, cmd);
            int j;
            for (j = 0; j < cmd_counter; ++j) {
                cmd[j] = '\0';
            }
            cmd_counter = 0;
        }
    }
}

int shell_loop(void) {
    int exit_status;
    char* input_line; 

    do {
        printf("%c ", '>');

        input_line = get_line_from_stdin();

        clean_input(input_line);

        printf("out: '%s'\n", input_line); 


        exit_status = strcmp(input_line, "exit"); 
        free(input_line);
    } while (exit_status != 0); 

    return 0;
}
