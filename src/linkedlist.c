#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "linkedlist.h"
#include "globals.h"

void ll_initialize(struct Node* head) {
    head->next = NULL;
}

void ll_push_node(struct Node* head, char* word) {
    while (head->next != NULL) {
        head = head->next;
    }
    head->next = malloc(sizeof(struct Node));
    head = head->next;
    head->next = NULL;

    int i;
    for (i = 0; word[i] != '\0'; ++i) {
        head->word[i] = word[i];
    }
    head->word[i] = '\0'; 
}

void ll_print(struct Node* head) {

    if (head == NULL) {
        printf("[]\n");
        return;
    }

    while (head->next != NULL) {
        printf("%s, ", head->next->word);
        head = head->next;
    }
    printf("\n");
    //printf("%s]\n", head->word); 
} 

void ll_destroy(struct Node* head) {
    if (head->next != NULL) {
        ll_destroy(head->next);
        free(head);
        return;
    }
    free(head);
}
