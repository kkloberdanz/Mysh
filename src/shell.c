#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <sys/stat.h>

#include "shell.h" 
#include "linkedlist.h" 

void read_from_file(char* batchFile){
    FILE *fp;
    char buffer[READ_BUFFER_SIZE];

    fp = fopen(batchFile, "r");
    char c = 'a';
    int i = 0;
    while (c != EOF) {
        struct Node* cmd_list = calloc(READ_BUFFER_SIZE, 
                                       sizeof(struct Node));
        ll_initialize(cmd_list);
        c = fgetc(fp);
        buffer[i] = c;
        if (c == '\n') {

            cmd_list = clean_input(buffer);

            if (cmd_list == NULL) {
                fprintf(stderr, 
                        "error: Expecting a linked list, recived NULL\n");
                exit(EXIT_FAILURE);
            }

            printf("> ");
            ll_print(cmd_list);
            execute_command(cmd_list);
            ll_destroy(cmd_list);
            i=0;
        } else {
            i++;
        }

        if (i >= READ_BUFFER_SIZE) {
            fprintf(stderr, 
                    "Buffer overflow at get_line_from_stdin()\n");

            while(c != '\n'){
                c = getchar();
            } 

            int j;
            for (j = 0; j < READ_BUFFER_SIZE; ++j) {
                buffer[0] = '\0';
            } 
        }
    }
    fclose(fp);
}

char* get_line_from_stdin() {
    char c = 'a';
    char* buffer = calloc(READ_BUFFER_SIZE, sizeof(char));

    int i; 
    for(i = 0; (i < READ_BUFFER_SIZE) && (c != '\n'); ++i) {
        c = getchar();
        buffer[i] = c;
    }

    if (i >= READ_BUFFER_SIZE) {
        fprintf(stderr, "Buffer overflow at get_line_from_stdin()\n");

        while(c != '\n'){
            c = getchar();
        }

        free(buffer);
        return NULL;
    }

    return buffer;
}

/*
char* get_line_from_stdin() {
    char c = 'a';
    char* buffer = calloc(READ_BUFFER_SIZE, sizeof(char));

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
*/

struct Node* clean_input(char* buffer) {
    int i;
    struct Node* command_list;
    command_list = malloc(sizeof(struct Node));
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
            return command_list;

        } else if (buffer[i] == '>') {
            ll_push_node(command_list, ">");

        } else if (buffer[i] == '&') {
            ll_push_node(command_list, "&");

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
    return NULL; /* This should never happen! */
}

void run_command_as_child_process(char** command) { 
    int rc = fork();

    if ((rc < 0)) { 
        fprintf(stderr, "error: fork failed\n");
        exit(EXIT_FAILURE);

    } else if (rc == 0) {
        execvp(*command, command);
        fprintf(stderr, "error: '%s': no such command\n", *command); 
        exit(EXIT_FAILURE);

    } else {
        wait(NULL);
    }

    int i;
    for (i = 0; command[i] != NULL; ++i) {
        free(command[i]);
    }
}

void redirect_output_to_file(char** command, char* output_filename) { 
    int output_file = open(output_filename, 
                           O_RDWR|O_CREAT,
                           0600);

    if (output_file == -1) { 
        fprintf(stderr, 
                "error: could not open file to redirect\n");
    } 

    int save_output_file = dup(fileno(stdout));

    if (dup2(output_file, fileno(stdout)) == -1) { 
        fprintf(stderr, "error: could not redirect stdout\n");
    }

    run_command_as_child_process(command);

    fflush(stdout); 
    close(output_file);

    dup2(save_output_file, fileno(stdout)); 
    close(save_output_file); 
}

void execute_command(struct Node* start_of_command_list) {

    struct Node* current_command;
    for (current_command = start_of_command_list->next;
         current_command != NULL;
         current_command = current_command->next) { 

        if ( strcmp(current_command->word, "exit") == 0) {
            exit(EXIT_SUCCESS);

        } else if ( strcmp(current_command->word, "cd") == 0) { 
            if (current_command->next != NULL) {
                current_command = current_command->next;
                struct stat st;
                if (stat(current_command->word, &st) == 0) {
                    chdir(current_command->word);

                } else if (current_command->word[0] == '\0') {
                    chdir(getenv("HOME"));

                } else {
                    fprintf(stderr, "error: '%s' no such directory\n", 
                            current_command->word);
                }
            } else {
                chdir(getenv("HOME"));
            }

        } else if ( strcmp(current_command->word, "pwd") == 0) {
            char  tmp_buff[MAX_PATH_LEN];
            char* cwd = getcwd(tmp_buff, MAX_PATH_LEN);
            if (cwd != NULL) {
                fprintf(stdout, "%s\n", cwd);
            }

        } else {
            /*
             * TODO:
             *     Handle &
             */

            char output_filename[READ_BUFFER_SIZE];
            output_filename[0] = '\0';

            char* command[READ_BUFFER_SIZE];

            int i = 0;
            while (1) {
                if (strcmp(current_command->word, ">") != 0) {
                    command[i] = strdup(current_command->word);
                } else {
                    strcat(output_filename, current_command->next->word);

                    // check if multiple files specifed, this is not
                    // allowed ('&' is ok!)
                    if ((current_command->next->next != NULL) && 
                        (strcmp(current_command->next->next->word, "&") != 0)) {
                        printf(current_command->next->next->word);
                        fprintf(stderr,
                                "error: cannot redirect to multiple files\n");
                        return;
                    }
                    break;
                }

                if (current_command->next != NULL) {
                    current_command = current_command->next;
                } else {
                    break;
                }
                i++;
            }
            command[i+1] = NULL;

            // Redirect output
            if (output_filename[0] != '\0') {
                redirect_output_to_file(command, output_filename);
                break;

            // Not redirecting stdout, run as normal
            } else { 
                run_command_as_child_process(command);
            }
        }
    }
}

int shell_loop(void) {
    int exit_status;
    char* input_line; 
    struct Node* cmd_list;

    char curr_dir[READ_BUFFER_SIZE];
    char curr_usr[READ_BUFFER_SIZE];
    char hostname[READ_BUFFER_SIZE];

    while (1) {

        gethostname(hostname, READ_BUFFER_SIZE);
        getlogin_r(curr_usr, READ_BUFFER_SIZE);
        getcwd(curr_dir, READ_BUFFER_SIZE);

        printf("[%s@%s %s]$ ", curr_usr, hostname ,curr_dir);

        input_line = get_line_from_stdin();

        cmd_list = clean_input(input_line);
        if (cmd_list == NULL) {
            return EXIT_FAILURE;
        }

        //printf("out: '%s'\n", input_line); 

        //ll_print(cmd_list);
        execute_command(cmd_list);

        
        exit_status = strcmp(input_line, "exit"); 
        free(input_line);
        ll_destroy(cmd_list);

        if (exit_status == 0) {
            break;
        }
    }

    return 0;
}
