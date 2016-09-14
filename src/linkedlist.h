#ifndef LINKEDLIST_H
#define LINKEDLIST_H 

#include "globals.h"

struct Node {
    char word[READ_BUFFER_SIZE];
    struct Node* next;
};

/*
 * Call after allocating memory for linked list
 */
void ll_initialize(struct Node*);

/*
 * Push Node to back of linked list
 */
void ll_push_node(struct Node*, char* word);

/*
 * Frees memory from linked list
 */
void ll_destroy(struct Node*);

void ll_print(struct Node*);

#endif /* LINKEDLIST_H */
