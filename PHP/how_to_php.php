<?php
// Enum (prior to PHP 8.1)
abstract class State
{
    const Calm = 0;
    const Rowdy = 1;
}

interface IClass
{
    public function status();
}

abstract class SampleClass implements IClass
{
    private $subject;
    private $size;
    protected $state;
    static $id = 0;

    // public by default
    function __construct($subject, $size)
    {
        $this->subject = $subject;
        $this->size = $size;
        $this->state = State::Rowdy;
        self::$id++;
        echoln($this);
    }

    function __destruct()
    {
        echoln("You dropped out of {$this->subject}.");
    }

    function __toString()
    {
        return "Welcome to some class! You are student #" . self::$id . ".";
    }

    function status()
    {
        echoln("This {$this->subject} class has {$this->size} students and is {$this->state}.");
    }
}

// Final class cannot be overridden
final class MathClass extends SampleClass
{
    function __construct($size)
    {
        parent::__construct("Math", $size);
        $this->state = State::Rowdy;
    }

    function __toString()
    {
        return "Welcome to math class! You are student #" . self::$id . ".";
    }
}

final class EnglishClass extends SampleClass
{
    function __construct($size)
    {
        parent::__construct("English", $size);
        $this->state = State::Calm;
    }

    function __toString()
    {
        return "Welcome to english class! You are student #" . self::$id . ".";
    }
}

/**
 * Recursively sums from 1 to `num`.
 * 
 * @param int $num the upper limit of the sum (inclusive)
 * @return int the sum from 1 to `num`
 * @throws InvalidArgumentException if `num` is non-positive
 */
function recursiveSum($num)
{
    if ($num <= 0) {
        throw new InvalidArgumentException("num must be positive");
    } else if ($num === 1) {
        return 1;
    } else {
        return $num + recursiveSum($num - 1);
    }
}

function echoln($str = "")
{
    echo $str . PHP_EOL;
}

// No main function here!
echo "Hello PHP!" . PHP_EOL; // PHP_EOL = newline
echoln("By the way, you're running PHP version " . phpversion());

// Variables
$myInt = 24;
$myDouble = -32.7356;
$myChar = '~';
$myBool = true;
$myString = "This is a reference type.";
define("NULL_VAR", null); // constant
$state = State::Calm;

// Input/Output
$name = readline("What's your name? ");
echoln("Hey $name!");
echoln("bool: {$myBool}"); // safer to use {}
echoln("null: " . NULL_VAR);
echoln("state: {$state}");

echoln("\$_GET = " . print_r($_GET));
echoln("\$_POST = " . print_r($_POST));
echoln("\$_COOKIE = " . print_r($_COOKIE));
echoln(); // prints just a newline

// Math Operations
// +, -, *, /, and % behave like normal
echoln("Adding two numbers: {$myInt} + {$myDouble} = " . ($myInt + $myDouble));
echoln("Adding a number and a char: {$myInt} + {$myChar} = " . ($myInt + $myChar));
echoln("Adding a number and a bool: {$myInt} + {$myBool} = " . ($myInt + $myBool));
echoln("Adding a number and a string: {$myInt} + {$myString} = " . ($myInt + $myString));
echoln("{$myDouble} ^ {$myInt} = " . ($myDouble ** $myInt));
echoln("Weird math: 0/0 = " . (0 / 0) . ", sqrt(-1) = " . sqrt(-1));
echoln("Rounding: {$myDouble} \xE2\x86\x92 " . round($myDouble, 2));
echoln();

// Logical Operators
// &&, ||, and ! behave like normal
// <> === !=
// xor
// and and or have lower precedence than =, but not && and ||

// Conditional Operators & Loops
// if, else, switch, case, do, while, and for behave like normal
if ($myDouble < 0) {
    echoln("my_double is negative");
} elseif ($myDouble > 0) {
    echoln("my_double is positive");
} else {
    echoln("my_double is 0");
}
echoln();

// Functions & Methods
echoln("An easier way to print");
echoln("{$myString} is " . strlen($myString) . " characters long");
echoln("substring(1, 8): " . substr($myString, 1, 7));
echoln("indexOf('s'): " . strpos($myString, "s"));

define("MAX", 10);
echoln("The sum from 1 to " . MAX . " = " . recursiveSum(MAX));
echoln();

// Arrays
if ($argc === 1) {
    echoln("Hmm, you didn't enter any command line arguments.");
} else {
    echoln("You passed in the following command line arguments:");

    $index = 0;
    foreach ($argv as $arg) {
        echoln("args[{$index}] = {$arg}");
        $index++;
    }
}

$nums1 = array(1, 2, 3, 4, 5);
$nums2 = [];
echoln("Fixed arrays:");
echoln(print_r($nums1));
echoln("count = " . count($nums1));
echoln(print_r($nums2));
echoln();

// Associative Arrays
$myDict = ["month" => 4, "day" => 18];
$myDict["year"] = 1994;

foreach ($myDict as $key => $value) {
    echoln("{$key} = {$value}");
}

if (array_key_exists("ssn", $myDict)) {
    echoln("You got hacked! {$myDict["ssn"]}");
} else {
    echoln("There's no key called ssn.");
}
echoln();

// Exception Handling
try {
    recursiveSum(-1);
} catch (InvalidArgumentException $e) {
    echoln($e);
} finally {
    echoln();
}

// Classes
//$class0 = new SampleClass("science", 20, State::Rowdy); // can't do this, SampleClass is abstract
$class1 = new MathClass(50);
$class2 = new EnglishClass(30);
$class1->status();
$class2->status();
