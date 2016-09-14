#ifndef SHELL_H
#define SHELL_H

#define READ_BUFFER_SIZE 1024

/*
 * Reads a line from stdin onto heap space.
 * To avoid memory leaks, call free() on the string
 * that is returned
 */
char* get_line_from_stdin();

/*
 * Continues to loop until 'exit' is read from stdin, or an error occurs
 * Returns 0 if execution was successful, non-zero return shows an error
 */
int shell_loop();

#endif /* SHELL_H */
