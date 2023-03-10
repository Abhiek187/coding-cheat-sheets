package main

// Tabs are preferred over spaces with go fmt
import (
	"bufio"
	"errors"
	"fmt"
	"math"
	"os"
	"runtime"
	"strconv"
	"strings"
)

// Enum
type State int

const (
	Calm State = iota // 0, 1, 2, ...
	Rowdy
)

// Uppercase = exported, lowercase = private
type Student struct {
	Name  string
	Grade int
}

// toString()
func (s Student) String() string {
	return fmt.Sprintf("%v got a %v.", s.Name, s.Grade)
}

// Interfaces end in -er
type Classer interface {
	Status()
}

// Static (global) variable
var id = 0 // := is not allowed in the global scope

type Class struct {
	subject string
	size    int
	state   State
}

func NewClass(subject string, size int) *Class {
	class := new(Class)
	class.subject = subject
	class.size = size
	id++
	fmt.Println(class)
	return class
}

func (this Class) String() string {
	return "Welcome to " + this.subject + " class! You are student #" + strconv.Itoa(id) + "."
}

func (this Class) Status() {
	stateStr := "rowdy"
	if this.state == Calm {
		stateStr = "calm"
	}

	fmt.Printf("This %v class has %v students and is %v.\n", this.subject, this.size, stateStr)
}

func NewMathClass(size int) *Class {
	class := NewClass("Math", size)
	class.state = Rowdy
	return class
}

func NewEnglishClass(size int) *Class {
	class := NewClass("English", size)
	class.state = Calm
	return class
}

// Recursively sums from 1 to num. Returns an error if num <= 0
func recursiveSum(num int) (int, error) {
	if num <= 0 {
		return 0, errors.New("num must be positive")
	} else if num == 1 {
		return 1, nil
	} else {
		sum, _ := recursiveSum(num - 1)
		return num + sum, nil
	}
}

func collectArgs(chars ...byte) ([]byte, int) {
	return chars, len(chars)
}

// The main function in the main package gets executed first
func main() {
	fmt.Println("Hello Go!")
	fmt.Printf("By the way, you're using Go version %s\n", runtime.Version())

	// Variables
	// All variables declared must be used, otherwise replace with _
	var myInt int = -47
	var myDouble = 2.8745e1
	var myChar byte = '$'
	myBool := true
	const myString string = "This is a string."
	var state State = Rowdy
	student := Student{"Joe Schmo", 100}

	// Input/Output
	reader := bufio.NewReader(os.Stdin)
	fmt.Print("What's your name? ")
	name, _ := reader.ReadString('\n')
	// %v = default type (see https://pkg.go.dev/fmt for reference)
	fmt.Printf("Hey %v!\n", strings.TrimSpace(name)) // remove newline from input
	fmt.Println("bool:", myBool)
	fmt.Println("state:", state)
	fmt.Printf("%+v\n", student)
	fmt.Println() // prints just a newline

	// Math Operations
	// +, -, *, /, and % behave like normal
	fmt.Printf("Adding two numbers: %v + %v = %v\n", myInt, myDouble, myDouble+float64(myInt))
	fmt.Printf("Adding a number and a char: %v + %v = %v\n", myInt, myChar, myInt+int(myChar))
	fmt.Printf("%v ^ %v = %v\n", myDouble, myInt, math.Pow(myDouble, float64(myInt)))
	fmt.Printf("Weird math: sqrt(-1) = %v\n", math.Sqrt(-1))
	fmt.Printf("Rounding: %v \u2192 %v\n", myDouble, math.Round(myDouble*100)/100)
	fmt.Println()

	// Logical Operators
	// &&, ||, and ! behave like normal

	// Conditional Operators & Loops
	// if, else if, and else behave like normal
	i := 0
	switch i {
	case 0:
		fmt.Println("case 0")
		fallthrough
	case 1:
		fmt.Println("case 1")
		fallthrough
	default:
		fmt.Println("default")
	}

	// While loop (no do-while loops)
	for i < 3 {
		i++
		fmt.Println("i =", i)
	}
	fmt.Println()

	// Pointers
	var myIntPtr = &myInt
	var null *int = nil
	fmt.Printf("myInt is stored in address %v\n", myIntPtr)
	fmt.Printf("It references %v\n", *myIntPtr)
	*myIntPtr >>= 1 // 101111 (47) -> 010001 (-47) -> 101000 (-24) --> 011000 (24)
	fmt.Printf("Now myInt is %v\n", myInt)
	fmt.Printf("The pointer is stored in address %v\n", &myIntPtr)
	fmt.Printf("null: %v\n\n", null) // *null = null pointer exception

	// Functions & Methods
	fmt.Printf("%v is %v characters long\n", myString, len(myString))
	fmt.Println("substring(1, 8):", myString[1:8])
	fmt.Println("indexOf('s'):", strings.Index(myString, "s"))

	max := 10
	sum, _ := recursiveSum(max)
	fmt.Printf("The sum from 1 to %v = %v\n", max, sum)
	chars, count := collectArgs('a', 'e', 'i', 'o', 'u')
	fmt.Printf("I collected %v chars: %v\n\n", count, chars)

	// Arrays & Slices
	args := os.Args

	if len(args) <= 1 {
		// args[0] is the executable
		fmt.Println("Hmm, you didn't enter any command line arguments.")
	} else {
		fmt.Println("You passed in the following command line arguments:")

		for index, arg := range args {
			fmt.Printf("args[%v] = %v\n", index, arg)
		}
	}

	nums1 := [5]int{1, 2, 3, 4, 5}
	var nums2 [5]int
	fmt.Println("Fixed arrays:")
	fmt.Println(nums1)
	fmt.Println(nums2)

	fakeString := []string{"a", "t", "r"}
	fakeString = append(fakeString[1:])               // remove the first element
	fakeString = append([]string{"s"}, fakeString...) // insert at index 0
	fmt.Println("Dynamic array:", fakeString)
	fakeString = nil // clear the slice
	fmt.Println()

	// Maps
	myMap := map[string]int{
		"month": 9,
		"day":   8,
		"time":  1_000_000_000,
	}
	myMap["year"] = 2001
	delete(myMap, "time")
	fmt.Println(myMap)
	myMap = nil
	fmt.Println()

	// Exception Handling
	sum, err := recursiveSum(-1)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println()

	// Classes
	var class1 Classer = NewMathClass(50)
	var class2 Classer = NewEnglishClass(30)
	class1.Status()
	class2.Status()
}
