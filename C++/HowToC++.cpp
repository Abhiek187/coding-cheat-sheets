/*
 * HowToC++.cpp
 *
 *  Created on: Aug 17, 2020
 *      Author: Abhiek187
 */

#include <iostream>
#include <string>
#include <cmath>
#include <vector>
#include "HowToC++.h"

// using namespace std; // not good practice
// <iostream>
using std::cout;
using std::cin;
using std::endl;
using std::ostream;
// <string>
using std::string;
// <cmath>
using std::pow;
using std::sqrt;
using std::round;
// <vector>
using std::vector;

// Interface
class Class {
public:
	virtual void status() const = 0;
	virtual ~Class() = default;
};

// Abstract Class
class SampleClass: public Class {
protected:
	string m_subject;
	int m_size;
	State m_state;

public:
	SampleClass(const string &subject, int size, const State &state)
		: m_subject(subject), m_size(size), m_state(state) {}

	~SampleClass() {
		cout << "You dropped out of " << m_subject << ".\n";
	}

	// toString(), can't have virtual friends :(
	friend ostream& operator<<(ostream &out, const SampleClass &c) {
		return c.print(out);
	}

	virtual ostream& print(ostream &out) const {
		out << "Welcome to some class!";
		return out;
	}

	virtual void status() const override {
		string stateStr = this->m_state == 1 ? "rowdy" : "calm";
		cout << "This " + this->m_subject << " class has " << this->m_size
				<< " students and is " << stateStr << ".\n";
	}
};

class MathClass: virtual public SampleClass {
public:
	MathClass(int size): SampleClass{"Math", size, State::rowdy} {
		cout << *this << '\n';
	}

	virtual ostream& print(ostream &out) const override {
		out << "Welcome to math class!";
		return out;
	}
};

class EnglishClass: virtual public SampleClass {
public:
	EnglishClass(int size): SampleClass{"English", size, State::calm} {
		cout << *this << '\n';
	}

	virtual ostream& print(ostream &out) const override {
		out << "Welcome to english class!";
		return out;
	}
};

int add(int a, int b) {
	return a + b;
}

void addPtrs(int *a, int *b, int &sum) {
	sum = *a + *b;
}

int recursiveSum(int num) {
	if (num <= 0) {
		throw "num must be positive";
	} else if (num == 1) {
		return 1;
	} else {
		return num + recursiveSum(num - 1);
	}
}

template <typename T>
void printArr(T *arr, int length) {
	// Length is required since arrays decay into pointers
	for (int i = 0; i < length; ++i) {
		cout << arr[i] << ' ';
	}

	cout << endl;
}

template <typename T>
void printVector(const vector<T> &v) {
	for (const auto elem : v) {
		cout << elem << ' ';
	}

	cout << "size = " << v.size() << '\n';
}

// main gets executed first
int main(int argc, char *argv[])
{
	cout << "Hello C++!\n"; // endl flushes output every time, \n doesn't
	cout << "By the way, you're using C++ version " << __cplusplus << endl;

	// Variables
	int myInt = -13;
	double myDouble(8.2945e1);
	char myChar {'\\'};
	bool myBool = true;
	string myString = "This is a string.";
	State state = State::rowdy;

	// Input/Output
	cout << "What's your name? ";
	string name;
	//cin >> name; // input for anything that's not a string
	// cin.ignore(32767, '\n'); // then it's a good idea to ignore the rest
	getline(cin, name);
	cout << "Hey " << name << "!\n";
	cout << "state: " << state << "\n\n";

	// Math Operations
	cout << "Adding two numbers: " << myInt << " + " << myDouble << " = "
			<< myInt + myDouble << '\n';
	cout << "Adding a number with a char: " << myDouble << " + " << myChar
			<< " = " << myDouble + myChar << '\n';
	cout << "Adding a number with a bool: " << myInt << " + " << myBool << " = "
			<< myInt + myBool << '\n';
	cout << "Dividing two ints: " << myInt << " / 2 = " << myInt / 2 << '\n';
	cout << myDouble << " ^ " << myInt << " = " << pow(myDouble, myInt) << '\n';
	cout << "Weird math: 0/0.0 = " << 0/0.0 << ", sqrt(-1) = " << sqrt(-1) << '\n';
	cout << "Rounding: " << myDouble << " \u2192 " << round(myDouble) << "\n\n";

	// Logical Operators
	// &&, ||, and ! behave like normal

	// Conditional Operators & Loops
	// if, else if, else, switch, case, do, while, and for behave like normal
	cout << myInt << " is " << (!!myInt ? "truthy\n" : "falsy\n");
	cout << 0 << " is " << (!!0 ? "truthy\n\n" : "falsy\n\n");

	// Pointers
	int *myIntPtr = &myInt;
	const int* null = nullptr;
	cout << "myInt is stored in address " << myIntPtr << '\n';
	cout << "It references " << *myIntPtr << '\n';
	*myIntPtr >>= 1; // 1101 (13) -> 0011 (-13) -> 0001 (-7) -> 0111 (7)
	cout << "Now myInt is " << myInt << '\n';
	cout << "The pointer is stored in address " << &myIntPtr << '\n';
	cout << "Be careful what you reference! Else you'll end up with garbage: "
			<< *(myIntPtr + 2) << '\n';
	cout << "null: " << null << "\n\n"; // *null = null pointer exception

	// Functions & Methods
	cout << "Adding numbers: " << myInt << " + " << myInt << " = "
			<< add(myInt, myInt) << '\n';
	int sum = 0;
	addPtrs(myIntPtr, myIntPtr, sum);
	cout << "sum reference resolves to " << sum << '\n';
	cout << myString << " is " << myString.length() << " characters long\n";
	cout << "substr(1, 8): " << myString.substr(1, 8) << '\n';
	cout << "find('s'): " << myString.find('s') << '\n';

	const int max {10};
	cout << "The sum from 1 to " << max << " = " << recursiveSum(max) << "\n\n";

	// Arrays & Vectors
	if (argc == 1) {
		// argv[0] is the executable
		cout << "Hmm, you didn't enter any command line arguments.\n";
	} else {
		cout << "You passed in the following arguments:\n";

		for (int i = 0; i < argc; i++) {
			cout << "argv[" << i << "] = " << argv[i] << '\n';
		}
	}

	bool binary[] { true, false, false, false, true, false, true };
	int binaryLength = sizeof(binary) / sizeof(*binary); // *(arr + i) == arr[i]
	const int zerosLength = 5;
	double zeros[zerosLength] {};
	cout << "Fixed arrays:\n";
	printArr(binary, binaryLength);
	printArr(zeros, zerosLength);

	vector<char> fakeString { 'a', 't', 'r' };
	fakeString.erase(fakeString.begin());
	fakeString.insert(fakeString.begin(), 's');
	cout << "Dynamic array:\n";
	printVector(fakeString);
	fakeString.clear();
	cout << '\n';

	// Exception Handling
	try {
		recursiveSum(-1);
	} catch (const char *err) {
		cout << "Error: " << static_cast<string>(err) << "\n\n";
	} catch (...) {
		cout << "Wow you really broke the function!\n\n";
	}

	// Classes
	// SampleClass is abstract
	//SampleClass class0 = SampleClass("science", 20, STATE_ROWDY);
	MathClass class1 = MathClass(50);
	EnglishClass class2 = EnglishClass(30);
	class1.status();
	class2.status();

	return 0; // remember to return an int!
}
