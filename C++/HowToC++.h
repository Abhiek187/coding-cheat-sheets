/*
 * HowToC++.h
 *
 *  Created on: Aug 17, 2020
 *      Author: Abhiek187
 */

#ifndef HOWTOC___H_
#define HOWTOC___H_

#include <vector>
using std::vector;

enum State {
	calm, // 0
	rowdy // 1
};

int add(int a, int b);
void addPtrs(int *a, int *b, int *&sum);
int recursiveSum(int num);

template <typename T>
void printArr(T *arr, int length);
template <typename T>
void printVector(const vector<T> &v);

#endif /* HOWTOC___H_ */
