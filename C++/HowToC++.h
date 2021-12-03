/*
 * HowToC++.h
 *
 *  Created on: Aug 17, 2020
 *      Author: Abhiek187
 */

#ifndef HOWTOC___H_
#define HOWTOC___H_

#include <array>
#include <string>
#include <vector>

enum class State
{
    calm, // 0
    rowdy // 1
};

struct Student
{
    std::string name{"anonymous"};
    int grade{100};
};

int add(int a, int b);
void addPtrs(int *a, int *b, int *&sum);
int recursiveSum(int num = 0);

template <typename T>
void printArr(const T *arr, int length);
template <typename T, size_t size>
void printStdArr(const std::array<T, size> &arr);
template <typename T>
void printVector(const std::vector<T> &v);

#endif /* HOWTOC___H_ */
