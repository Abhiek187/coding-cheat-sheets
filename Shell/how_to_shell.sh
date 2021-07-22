#!/bin/bash
# ^ Shebang to run this script in a bash shell

# No main function here!
echo "Hello Shell!"
echo "By the way, you're using this shell:"
$SHELL --version

# Variables
MY_INT=-83
readonly MY_INT # make the variable constant
MY_DOUBLE=7.55555
MY_BOOL=true
MY_STRING="This is a string."
NULL_VAR=""
unset NULL_VAR # remove the variable

# Input/Output
printf "What's your name? " # don't print a newline
read NAME
echo "Hey $NAME!"
echo "NULL_VAR=$NULL_VAR"
echo "PID = $$"
echo "" # print just a newline

: "Math Operations
Floats aren't support in ((expressions)), so need to use bc (bash calculator)"
echo "Adding two numbers: $MY_INT + $MY_DOUBLE = $(echo "$MY_INT + $MY_DOUBLE" | bc)"
echo "Adding a number with a bool: $MY_INT + $MY_BOOL = $(($MY_INT + $MY_BOOL))"
echo "Adding a number with a string: $MY_INT + $MY_STRING = $($MY_INT + $MY_STRING)"
echo "Dividing two ints: $MY_INT / 2 = $(($MY_INT / 2))"
echo "$MY_DOUBLE ^ $MY_INT = $(echo "$MY_DOUBLE ^ $MY_INT" | bc)"
echo "Weird math: 0/0.0 = $(echo "0 / 0.0" | bc), sqrt(-1) = $(echo "sqrt(-1)" | bc)"
echo -e "Rounding: $MY_DOUBLE \u2192 $(printf "%.2f" $MY_DOUBLE)" # -e to print unicode
echo ""

# Logical Operators
[[ ! $MY_BOOL || $MY_INT -le 0 ]] && echo true || echo false # -le == <=

# Conditional Operators & Loops
# if, else if, else, switch, case, do, while, and for behave like normal?
echo "File: $0"

if [ $# == 0 ]; then
    echo "Hmm you didn't enter any command line arguments."
else
    echo "$# arguments:"
    I=1

    : "$* separates each argument with spaces,
    whereas $@ separates each argument by itself"
    for ARG in $*; do
        echo "\$$I = $ARG"
        ((I++))
    done
fi

# Functions & Methods

# Arrays
MY_ARRAY=(3 -4 8 -5 0 9 -1)
MY_ARRAY[2]="cheese"
echo "MY_ARRAY = ${MY_ARRAY[*]}" # see comment above about * vs @

# Exception Handling

# Classes
