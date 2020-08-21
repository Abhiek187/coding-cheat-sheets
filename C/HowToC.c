#include "HowToC.h"

#include <errno.h>
#include <math.h> // make sure to have -lm at the end of build
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* boolToString(bool b) {
	return b ? "true" : "false";
}

void printUnion(const Shared *s) {
	if (s == NULL) return;
	printf("shared.c = %c, shared.i = %d, shared.d = %lf\n", s->c, s->i, s->d);
}

void printIntArr(int *arr, int length) {
	if (arr == NULL) return;

	for (int i = 0; i < length; i++) {
		printf("dynArr[%d] = %d\n", i, arr[i]);
	}

	printf("\n");
}

int add1(void *ptr) {
	return *((int*) ptr) + 1;
}

void map(void *arrPtr, int size, int (*funcPtr)(void*)) {
	int *arr = (int*) arrPtr;
	for (int i = 0; i < size; i++) {
		arr[i] = funcPtr(arr + i);
	}
}

void sigHandler(int signum) {
	printf("Raised signal #%d: segfault!\n", signum);
	printf("Prepare to see Segmentation fault (core dumped)\n...throughout your C journey.\n");
}

// main gets executed first
int main(int argc, char *argv[]) {
	printf("Hello C!\n");
	printf("By the way, you're running C version %ld\n", __STDC_VERSION__);

	// Variables
	int myInt = 798;
	double myDouble = 6.022e23;
	char myChar = '\'';
	bool myBool = false; // <-- comes with C = false
	State state = ROWDY;
	const void *null = NULL;

	// Input/Output
	printf("What's your name? ");
	char name[MAX_NAME_LENGTH]; // will truncate after 24 chars (to make room for \0)

	if (!fgets(name, sizeof(name), stdin)) {
		fprintf(stderr, "Error: file %s, line %d\n", __FILE__, __LINE__);
		fprintf(stderr, "Oops, something went wrong when inputting your name.\n");
		return -1;
	}

	// Remove the newline at the end of the input
	if (name[strlen(name) - 1] == '\n') {
		name[strlen(name) - 1] = '\0';
	}

	printf("Hi %s!\n", name);
	printf("int: %d, double: %3.3e, char: %c, bool: %d, state: %d, null: %p\n\n", myInt, myDouble,
		myChar, myBool, state, null); // double can also be printed as %.2lf

	printf("sizeof variables:\n");
	printf("bool:\t\t\t%lu bytes\n", sizeof(bool));
	printf("char:\t\t\t%lu bytes\n", sizeof(char));
	printf("wchar_t:\t\t%lu bytes\n", sizeof(wchar_t));
	printf("short:\t\t\t%lu bytes\n", sizeof(short));
	printf("int:\t\t\t%lu bytes\n", sizeof(int));
	printf("long:\t\t\t%lu bytes\n", sizeof(long));
	printf("long long:\t\t%lu bytes\n", sizeof(long long));
	printf("float:\t\t\t%lu bytes\n", sizeof(float));
	printf("double:\t\t\t%lu bytes\n", sizeof(double));
	printf("long double:\t\t%lu bytes\n", sizeof(long double));
	printf("pointer:\t\t%lu bytes\n", sizeof(void*));
	printf("enum:\t\t\t%lu bytes\n", sizeof(State));
	printf("struct (char*+int):\t%lu bytes\n", sizeof(Student));
	printf("union (char+int+double): %lu bytes\n", sizeof(Shared));
	printf("\n"); // prints just a newline

	// Math Operations
	printf("%d + %lf = %lf\n", myInt, myDouble, myInt + myDouble);
	printf("%d + %c = %d\n", myInt, myChar, myInt + myChar);
	printf("%d + %s = %d\n", myInt, boolToString(myBool), myInt + myBool);
	printf("%d + %d = %d\n", myInt, state, myInt + state);
	printf("%d ^ %lf = %lf\n", myInt, myDouble, pow(myInt, myDouble));
	printf("Weird math: 0/0.0 = %lf, sqrt(-1) = %lf\n", 0/0.0, sqrt(-1));
	printf("\n");

	// Logical Operators
	// &&, ||, and ! behave like normal

	// Conditional Operators & Loops
	// else if, else, switch, case, do, while, and for behave like normal
	int i = 0;
	if ((i = myInt % 10) > 5) {
		printf("I can initialize i = %d in the if statement.\n", i);
	}
	printf("\n");

	// Pointers
	double *myDoublePtr = &myDouble;
	printf("myDoublePtr points to %lf in address %p\n", *myDoublePtr, (void*) myDoublePtr);
	*myDoublePtr = PI;
	printf("Now myDouble is %lf\n", myDouble);
	printf("Be careful what you reference, else you'll end up with garbage: %lf\n", myDoublePtr[2]);
	printf("\n");

	// Functions
	Shared shared;
	shared.c = '?';
	printf("With shared.c = ? ...\n");
	printUnion(&shared);
	shared.d = 7.8;
	printf("With shared.d = 7.8 ...\n");
	printUnion(&shared);
	printf("\n");

	// Arrays & "Strings"
	// Always null terminate a string
	char myString[MAX_NAME_LENGTH] = { 'K', 'r', 'i', 's', 'h', 'n', 'a', '\0' }; // "Krishna"
	Student student = { .name = myString, .grade = 94 };
	printf("%s got a %d.\n", student.name, student.grade);
	printf("%s is %ld characters long.\n", myString, strlen(myString));
	int begin = 0, end = 4;
	printf("substring(%d, %d) = %.*s\n", begin, end, end - begin, myString + begin);
	printf("indexOf('s') = %ld\n", strchr(myString, 's') - myString); // strstr finds string
	printf("%s == Krishna? %s\n", myString, boolToString(!strcmp(myString, "Krishna"))); // 0 = true

	if (argc <= 1) {
		// argv[0] is the executable
		printf("Hmm, you didn't enter any command line arguments.\n");
	} else {
		printf("You passed in the following arguments:\n");
		// i declared earlier
		for (i = 0; i < argc; i++) {
			printf("argv[%d] = %s\n", i, argv[i]);
		}
	}

	int size = ARRAY_SIZE;
	int *dynamicArr = malloc(sizeof(int) * size);
	dynamicArr[1] = myInt;
	dynamicArr[4] = (int) myDouble;
	printIntArr(dynamicArr, size);

	size *= 2;
	dynamicArr = realloc(dynamicArr, sizeof(int) * size);
	dynamicArr[5] = (int) myChar;
	dynamicArr[8] = (int) myBool;
	dynamicArr[9] = state;
	printIntArr(dynamicArr, size);

	map(dynamicArr, size, add1);
	printIntArr(dynamicArr, size);
	free(dynamicArr); // always free allocated memory!
	printf("\n");

	// Extras
	printf("How'd you do?\n");
	printf("errno #%d: %s\n", errno, strerror(errno)); // due to over and underflow
	signal(SIGSEGV, sigHandler);
	raise(SIGSEGV); // can be caused by *((int*) 0)

	return 0; // always return some int
}
