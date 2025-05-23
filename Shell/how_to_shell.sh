#!/bin/bash
# ^ Shebang to run this script in a bash shell
# Strict mode 
# e = exit on failure, u = check unresolved variables, x = print command, o = exit on pipe failure
# set -euxo pipefail

recursive_sum () {
    # args = $1 $2 ...
    local CSI="\033[" # control sequence introducer
    local RED="1;31m"
    local YELLOW="1;33m"
    local NC="0m" # no color

    if [ $# == 0 ]; then
        echo -e "${CSI}${RED}Error: num not provided${CSI}${NC}"
        return -1 # will underflow to 255
    elif [ $1 -lt 0 ]; then
        echo -e "${CSI}${YELLOW}Warning: num must be positive${CSI}${NC}"
        return -1
    elif [ $1 == 1 ]; then
        return 1
    else
        recursive_sum $(( $1-1 ))
        return $(( $1 + $? ))
    fi
}

sig_handler () {
    echo "Received SIGUSR1"
}

# No main function here!
echo "Hello Shell!"
echo "By the way, you're using this shell:"
$SHELL --version

# Variables
declare -ir MY_INT=-83 # make the variable an integer and readonly (constant)
MY_DOUBLE=7.55555
MY_BOOL=true
MY_STRING="This is a string."
NULL_VAR=""
unset NULL_VAR # remove the variable

# Input/Output
echo -n "What's your name? " # don't print a newline
read NAME
echo "Hey $NAME!"
echo "NULL_VAR=${NULL_VAR:-"null"}" # :- == ?:
echo "PID = $$"
echo "" # print just a newline

: "Math Operations
Floats aren't support in ((expressions)), so need to use bc (bash calculator)
left | right == redirect output from left as input to right"
echo "Adding two numbers: $MY_INT + $MY_DOUBLE = $(echo "$MY_INT + $MY_DOUBLE" | bc)"
echo "Adding a number with a bool: $MY_INT + $MY_BOOL = $(($MY_INT + $MY_BOOL))"
echo "Dividing two ints: $MY_INT / 2 = $(($MY_INT / 2))"
echo "$MY_DOUBLE ^ $MY_INT = $(echo "$MY_DOUBLE ^ $MY_INT" | bc)"
echo "Weird math: 0/0.0 = $(echo "0 / 0.0" | bc), sqrt(-1) = $(echo "sqrt(-1)" | bc)"
echo -e "Rounding: $MY_DOUBLE \u2192 $(printf "%.2f" $MY_DOUBLE)" # -e to enable escaped characters
echo ""

# Logical Operators
# -eq: ==, -ne: !=, -gt: >, -lt: <, -ge: >=, -le: <=
[[ ! $MY_BOOL || $MY_INT -le 0 ]] && echo true || echo false # -le == <=

# Conditional Operators & Loops
echo "File: $0"

case $0 in
    "./how_to_shell.sh") echo "This script is executed in a separate shell."
    ;; # break
    "-bash"|"/bin/bash") echo "This script is executed in the same shell."
    ;;
    *) echo "You executed this file in a unique way." # default
esac

if [ $# == 0 ]; then
    echo "Hmm you didn't enter any command line arguments."
elif [ $# -lt 0 ]
then
    echo "That's not possible."
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

COUNT=5
# Or while [ COUNT -ge 0 ]
until [ $COUNT -lt 0 ]
do
    echo $COUNT
    ((COUNT--))

    if [ $COUNT == 0 ]; then
        echo "Blast off!"
        break
    fi
done

echo ""

# Functions & Methods
echo "$MY_STRING is ${#MY_STRING} characters long."
echo "substring(1, 8): ${MY_STRING:1:8}" # {string:start:length}
# parameter%%pattern: remove everything after 's'
STR_INDEX_OF="${MY_STRING%%s*}"
echo "indexOf('s'): ${#STR_INDEX_OF}"

recursive_sum
echo "recursive_sum() = $?" # $? = return value
recursive_sum -1
echo "recursive_sum(-1) = $?"
recursive_sum 10
echo "recursive_sum(10) = $?"
unset -f recursive_sum # remove the definition of a function
echo ""

# Arrays
MY_ARRAY=(3 -4 8 -5 0 9 -1)
MY_ARRAY[2]="cheese"
echo "MY_ARRAY.length = ${#MY_ARRAY[@]}"
echo "MY_ARRAY = ${MY_ARRAY[*]}" # see comment above about * vs @
echo ""

# Signals
trap sig_handler SIGUSR1
kill -USR1 $$
