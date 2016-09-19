#ifndef SHELL_H
#define SHELL_H

#include "globals.h"

/*
 * Reads a line from stdin onto heap space.
 * To avoid memory leaks, call free() on the string
 * that is returned
 */
char* get_line_from_stdin();

/*
 * Returns a linked list of the parsed commands
 * Use this linked list to execute the commands in the shell
 * !!! Be sure to call ll_destroy() to free memory from list !!!
 */
struct Node* clean_input(char*);

/*
 * Takes a linked list as input.
 * executes commands sequentially as they are found in the linked list
 */
void execute_command(struct Node*);

/*
 * Continues to loop until 'exit' is read from stdin, or an error occurs
 * Returns 0 if execution was successful, non-zero return shows an error
 */
int shell_loop();


#endif /* SHELL_H */
