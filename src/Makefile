C++ = gcc
CFLAGS = -O2 -Wall -Wextra -Wpedantic
BUILD_DIR = Build

#OBJS = $(BUILD_DIR)/main.o $(BUILD_DIR)/ls.o $(BUILD_DIR)/cd.o $(BUILD_DIR)/exit.o $(BUILD_DIR)/pwd.o $(BUILD_DIR)/wait.o $(BUILD_DIR)/find.o

OBJS = $(BUILD_DIR)/main.o $(BUILD_DIR)/shell.o

mysh: $(OBJS)
	$(C++) -o Bin/mysh $(CFLAGS) $(OBJS) 

$(BUILD_DIR)/main.o: main.c
	$(C++) $(CFLAGS) -o $(BUILD_DIR)/main.o -c main.c

$(BUILD_DIR)/shell.o: shell.c shell.h
	$(C++) $(CFLAGS) -o $(BUILD_DIR)/shell.o -c shell.c

clean:
	rm -rf Bin/*
	rm -rf Build/*

