#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#define SIZE 5

int main(int argc, char *argv[]) {
    //printf("bool:\t\t%lu bytes\n", sizeof(bool));
    printf("char:\t\t%lu bytes\n", sizeof(char));
    printf("wchar_t:\t%lu bytes\n", sizeof(wchar_t));
    //printf("char16_t:\t%lu bytes\n", sizeof(char16_t)); // C++11 only
    //printf("char32_t:\t%lu bytes\n", sizeof(char32_t)); // C++11 only
    printf("short:\t\t%lu bytes\n", sizeof(short));
    printf("int:\t\t%lu bytes\n", sizeof(int));
    printf("long:\t\t%lu bytes\n", sizeof(long));
    printf("long long:\t%lu bytes\n", sizeof(long long)); // C++11 only
    printf("float:\t\t%lu bytes\n", sizeof(float));
    printf("double:\t\t%lu bytes\n", sizeof(double));
    printf("long double:\t%lu bytes\n", sizeof(long double));

    return 0;
}
