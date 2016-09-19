CC = gcc
CFLAGS = -O2 -Wall -Wextra -Wpedantic
BUILD_DIR = Build

#OBJS = $(BUILD_DIR)/main.o $(BUILD_DIR)/ls.o $(BUILD_DIR)/cd.o $(BUILD_DIR)/exit.o $(BUILD_DIR)/pwd.o $(BUILD_DIR)/wait.o $(BUILD_DIR)/find.o

OBJS = $(BUILD_DIR)/main.o $(BUILD_DIR)/shell.o $(BUILD_DIR)/linkedlist.o

mysh: $(OBJS)
	$(CC) -o Bin/mysh $(CFLAGS) $(OBJS) 

$(BUILD_DIR)/main.o: main.c
	$(CC) $(CFLAGS) -o $(BUILD_DIR)/main.o -c main.c

$(BUILD_DIR)/shell.o: shell.c shell.h
	$(CC) $(CFLAGS) -o $(BUILD_DIR)/shell.o -c shell.c

$(BUILD_DIR)/linkedlist.o: linkedlist.c linkedlist.h
	$(CC) $(CFLAGS) -o $(BUILD_DIR)/linkedlist.o -c linkedlist.c

clean:
	rm -rf Bin/*
	rm -rf Build/*

