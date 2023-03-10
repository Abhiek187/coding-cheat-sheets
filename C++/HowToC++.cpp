/*
 * HowToC++.cpp
 *
 *  Created on: Aug 17, 2020
 *      Author: Abhiek187
 */

#include "HowToC++.h"

#include <array>
#include <cmath>
#include <cstddef>
#include <iostream>
#include <string>
#include <vector>

// using namespace std; // not good practice
// <iostream>
using std::cin;
using std::cout;
using std::endl;
using std::ostream;
// <string>
using std::getline;
using std::string;
// <cmath>
using std::pow;
using std::round;
using std::sqrt;
// <array>
using std::array;
// <cstddef>
using std::size_t;
// <vector>
using std::vector;

// Interface
class IClass
{
public:
    virtual void status() const = 0;
    virtual ~IClass() = default;
};

// Abstract Class
class SampleClass : public IClass
{
protected:
    string m_subject;
    int m_size;
    State m_state;
    static int s_id;

public:
    SampleClass(const string &subject, int size, const State &state)
        : m_subject(subject), m_size(size), m_state(state)
    {
        s_id++;
    }

    virtual ~SampleClass()
    {
        cout << "You dropped out of " << m_subject << ".\n";
    }

    // toString(), can't have virtual friends :(
    friend ostream &operator<<(ostream &out, const SampleClass &c);

    virtual ostream &print(ostream &out) const
    {
        out << "Welcome to some class! You are student #" << s_id << '.';
        return out;
    }

    virtual void status() const override final
    {
        string stateStr{this->m_state == State::rowdy ? "rowdy" : "calm"};
        cout << "This " << this->m_subject << " class has " << this->m_size
             << " students and is " << stateStr << ".\n";
    }
};

int SampleClass::s_id = 0;

ostream &operator<<(ostream &out, const SampleClass &c)
{
    return c.print(out);
}

class MathClass final : virtual public SampleClass
{
public:
    MathClass(int size) : SampleClass{"Math", size, State::rowdy}
    {
        cout << *this << '\n';
    }

    virtual ostream &print(ostream &out) const override
    {
        out << "Welcome to math class! You are student #" << s_id << '.';
        return out;
    }
};

class EnglishClass final : virtual public SampleClass
{
public:
    EnglishClass(int size) : SampleClass{"English", size, State::calm}
    {
        cout << *this << '\n';
    }

    virtual ostream &print(ostream &out) const override
    {
        out << "Welcome to english class! You are student #" << s_id << '.';
        return out;
    }
};

int add(int a, int b)
{
    return a + b;
}

void addPtrs(int *a, int *b, int &sum)
{
    sum = (!a && !b) ? 0 : *a + *b; // !a == nullptr
}

int recursiveSum(int num)
{
    if (num <= 0)
    {
        throw "num must be positive";
    }
    else if (num == 1)
    {
        return 1;
    }
    else
    {
        return num + recursiveSum(num - 1);
    }
}

template <typename T>
void printArr(const T *arr, int length)
{
    // Length is required since arrays decay into pointers
    if (arr == nullptr)
    {
        cout << "You didn't pass an array to printArr().\n";
        return;
    }

    for (int i{0}; i < length; ++i)
    {
        cout << arr[i] << ' ';
    }

    cout << endl;
}

template <typename T, size_t size>
void printStdArr(const array<T, size> &arr)
{
    for (const auto &elem : arr)
    {
        cout << elem << ' ';
    }

    cout << "size = " << arr.size() << '\n';
}

template <typename T>
void printVector(const vector<T> &v)
{
    for (const auto &elem : v)
    {
        cout << elem << ' ';
    }

    cout << "size = " << v.size() << ", capacity = " << v.capacity() << '\n';
}

// main gets executed first
int main(int argc, char *argv[])
{
    cout << "Hello C++!\n"; // shorthand for std::cout
    // endl flushes output every time, \n doesn't
    cout << "By the way, you're using C++ version " << __cplusplus << endl;

    // Variables
    int myInt = -13;           // copy initialization
    double myDouble(8.2945e1); // direct initialization
    char myChar = {'\\'};      // copy brace initialization
    bool myBool{true};         // direct brace initialization (best way to initialize vars)
    string myString{"This is a string."};
    State state{State::rowdy};
    Student student{"Joe Schmo"};

    // Input/Output
    cout << "What's your name? ";
    string name{};
    // cin >> name; // input for anything that's not a string
    //  cin.ignore(32767, '\n'); // then it's a good idea to ignore the rest
    getline(cin, name);
    cout << "Hey " << name << "!\n";
    cout << "state: " << static_cast<int>(state) << '\n';
    cout << student.name << " got a " << student.grade << ".\n\n";

    // Math Operations
    cout << "Adding two numbers: " << myInt << " + " << myDouble << " = "
         << myInt + myDouble << '\n';
    cout << "Adding a number with a char: " << myDouble << " + " << myChar
         << " = " << myDouble + myChar << '\n';
    cout << "Adding a number with a bool: " << myInt << " + " << myBool << " = "
         << myInt + myBool << '\n';
    cout << "Dividing two ints: " << myInt << " / 2 = " << myInt / 2 << '\n';
    cout << myDouble << " ^ " << myInt << " = " << pow(myDouble, myInt) << '\n';
    cout << "Weird math: 0/0.0 = " << 0 / 0.0 << ", sqrt(-1) = " << sqrt(-1) << '\n';
    cout << "Rounding: " << myDouble << " \u2192 " << round(myDouble) << "\n\n";

    // Logical Operators
    // &&, ||, and ! behave like normal

    // Conditional Operators & Loops
    // if, else if, else, switch, case, do, and while behave like normal
    cout << myInt << " is " << (!!myInt ? "truthy\n" : "falsy\n");
    cout << 0 << " is " << (!!0 ? "truthy\n" : "falsy\n");
    cout << "Multiple looping variables:\n";

    for (int i{0}, j{5}; i < 5; ++i, --j)
    {
        cout << "i = " << i << ", j = " << j << '\n';
    }
    cout << '\n';

    // Pointers
    int *myIntPtr{&myInt};
    constexpr int *const null{nullptr}; // constant value and address
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
    int sum{0};
    addPtrs(myIntPtr, myIntPtr, sum);
    cout << "sum reference resolves to " << sum << '\n';
    cout << myString << " is " << myString.length() << " characters long\n";
    cout << "substr(1, 8): " << myString.substr(1, 8) << '\n';
    cout << "find('s'): " << myString.find('s') << '\n';

    constexpr int max{10};
    cout << "The sum from 1 to " << max << " = " << recursiveSum(max) << "\n\n";

    // Arrays & Vectors
    if (argc <= 1)
    {
        // argv[0] is the executable
        cout << "Hmm, you didn't enter any command line arguments.\n";
    }
    else
    {
        cout << "You passed in the following arguments:\n";

        for (int i{0}; i < argc; i++)
        {
            cout << "argv[" << i << "] = " << argv[i] << '\n';
        }
    }

    bool binary[]{true, false, false, false, true, false, true};
    int binaryLength{sizeof(binary) / sizeof(*binary)}; // *(arr + i) == arr[i]
    constexpr int zerosLength{5};
    double zeros[zerosLength]{};
    cout << "Fixed arrays:\n";
    printArr(binary, binaryLength);
    printArr(zeros, zerosLength);
    array<string, 3> betterArr{"This", "is", "better."};
    printStdArr(betterArr);

    vector<char> fakeString{'a', 't', 'r'};
    fakeString.erase(fakeString.begin());
    fakeString.insert(fakeString.begin(), 's');
    cout << "Dynamic array:\n";
    printVector(fakeString);
    fakeString.clear();
    cout << '\n';

    // Exception Handling
    try
    {
        recursiveSum(-1);
    }
    catch (const char *err)
    {
        cout << "Error: " << err << "\n\n";
    }
    catch (...)
    {
        cout << "Wow you really broke the function!\n\n";
    }

    // Classes
    // SampleClass class0 {"science", 20, State::rowdy}; // SampleClass is abstract
    MathClass class1{50};
    EnglishClass class2{30};
    class1.status();
    class2.status();

    return 0; // remember to return an int!
}
