#ifndef HOWTOC_H
#define HOWTOC_H

#include <stdbool.h>

#define MAX_NAME_LENGTH 25
#define PI 3.14159265358979323846
#define ARRAY_SIZE 5

typedef enum _State {
	CALM = 0,
	ROWDY = 1
} State; // can declare as State instead of enum _State

typedef struct {
	char *name;
	int grade;
} Student;

typedef union {
	char c;
	int i;
	double d;
} Shared;

const char* boolToString(bool b);
void printUnion(const Shared *s);
void printIntArr(int *arr, int length);
int add1(void *ptr);
void map(void *arr, int size, int (*funcPtr)(void*));
void sigHandler(int signum);

#endif
