#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/wait.h>

#include "shell.h" 
#include "linkedlist.h" 

char* get_line_from_stdin() {
    char c = 'a';
    char* buffer = calloc(READ_BUFFER_SIZE, sizeof(char));

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

struct Node* clean_input(char* buffer) {
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
            //printf("Pushing: '%s'\n", cmd);
            return command_list;
            /*
            ll_print(command_list);
            ll_destroy(command_list);
            */

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
            //printf("Pushing: '%s'\n", cmd);
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
        printf("This should not print\n"); 

    } else {
        int wc = wait(NULL);
    } 
}

void execute_command(struct Node* start_of_command_list) {

    struct Node* current_command;
    for (current_command = start_of_command_list->next;
         current_command != NULL;
         current_command = current_command->next) {

        //printf("cmd: '%s'\n", current_command->word);

        /*
         * TODO:
         *     current_command->word holds the string that needs to
         *     be executed.
         *
         *     Perhaps do strcmp over a series of if else's to detect
         *     characters such as '&' and '>' (Assuming these need to
         *     be treated differently), then use fork() and execvp() * *
         *     with the other commands.
         *     
         */

        if ( strcmp(current_command->word, "exit") == 0) {
            return;

        } else if ( strcmp(current_command->word, "cd") == 0) { 
            if (current_command->next != NULL) {
                current_command = current_command->next;
                chdir(current_command->word);
            } else {
                chdir(getenv("HOME"));
            }

        } else {
            /*
             * TODO:
             *     Handle > and & here
             */

            //char* command = calloc(READ_BUFFER_SIZE, sizeof(char));
            char* output_filename = calloc(READ_BUFFER_SIZE, sizeof(char));
            output_filename[0] = '\0';

            char* command[READ_BUFFER_SIZE];

            int i = 0;
            while (1) {
                if (strcmp(current_command->word, ">") != 0) {
                    /*
                    strcat(command, current_command->word);
                    strcat(command, " ");
                    */
                    //strcpy(command[i], current_command->word);
                    command[i] = strdup(current_command->word);
                } else {
                    strcat(output_filename, current_command->next->word);
                    /*
                     * TODO:
                     *     check if more files given
                     */
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

            /*
             * Redirect output
             */
            /*
            if (output_filename[0] != '\0') {
				int out = open("cout.log", O_RDWR|O_CREAT|O_APPEND, 0600);
				if (-1 == out) { perror("opening cout.log"); return 255; }

				int err = open("cerr.log", O_RDWR|O_CREAT|O_APPEND, 0600);
				if (-1 == err) { perror("opening cerr.log"); return 255; }

				int save_out = dup(fileno(stdout));
				int save_err = dup(fileno(stderr));

				if (-1 == dup2(out, fileno(stdout))) { perror("cannot redirect stdout"); return 255; }
				if (-1 == dup2(err, fileno(stderr))) { perror("cannot redirect stderr"); return 255; }

				//puts("doing an ls or something now");
                system("ls");

				fflush(stdout); close(out);
				fflush(stderr); close(err);

				dup2(save_out, fileno(stdout));
				dup2(save_err, fileno(stderr));

				close(save_out);
				close(save_err);

				puts("back to normal output");

                break;
            }
            */

            run_command_as_child_process(command);
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

        ll_print(cmd_list);
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
