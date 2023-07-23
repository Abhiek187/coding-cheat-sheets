import scala.io.StdIn.readLine
import scala.math.BigDecimal
import scala.math.pow
import scala.math.sqrt

// Extend Enum to get name()
enum State extends Enum[State]:
    case CALM, ROWDY

    override def toString(): String = name().toLowerCase // one-line return
end State

// Struct
// Case classes come with equals(), hashCode(), toString(), copy(), etc.
case class Student(name: String = "anonymous", grade: Int = 100) {
    override def toString(): String = s"$name got a $grade."
}

// Interface
trait Class {
    // Unit == void
    def status(): Unit =
        // Default implementation
        println("Something something classroom...")
}

// Companion object: contains static variables & methods
object SampleClass:
    var id = 0
end SampleClass

// Need to put val/var before parameters to make them member variables
abstract class SampleClass(
    private val subject: String,
    private val size: Int,
    private val state: State
) extends Class:
    // Constructor body
    SampleClass.id += 1

    // Open methods can be overridden
    override def toString(): String = s"Welcome to some class! You are student #${SampleClass.id}."

    override def status() =
        println(s"This $subject class has $size students and is $state.")
end SampleClass

// Classes are final by default
class MathClass(size: Int) extends SampleClass(subject = "math", size = size, state = State.ROWDY):
    println(this)

    override def toString(): String = s"Welcome to math class! You are student #${SampleClass.id}."
end MathClass

class EnglishClass(size: Int) extends SampleClass(subject = "english", size = size, state = State.CALM):
    println(this)

    override def toString(): String = s"Welcome to english class! You are student #${SampleClass.id}."
end EnglishClass

extension (d: Double)
    def **(exponent: Double): Double = pow(d, exponent)
    def round(places: Int): Double = BigDecimal(d).setScale(2, BigDecimal.RoundingMode.HALF_UP).toDouble

/**
 * Recursively sums from 1 to [num].
 *
 * @throws IllegalArgumentException if [num] is non-positive
 */
def sumTo(num: Int=1): Int =
    if num <= 0 then
        throw IllegalArgumentException("num must be positive")
    else if num == 1 then
        1
    else
        num + sumTo(num - 1)

// Generic Functions
// main gets executed first
@main def HowToScala(args: String*): Unit = {
    println("Hello Scala!")
    // Scala 3 uses Scala 2 as-is, hence why the versionString returns 2
    println(s"By the way, you're running Scala version ${util.Properties.versionString}")

    // Variables
    var myInt = 21 // mutable, implicitly converted to Int
    val myDouble: Double = -0.14597 // constant, explicitly typed
    val myChar = '\t'
    val myBool = true
    val myString = "This is a string."
    val state = State.ROWDY
    val student = Student(name = "Joe Schmo", grade = 94) // named parameter (optional)

    // Input/Output
    print("What's your name? ") // prints w/o a newline
    val name = readLine()
    println(s"Hey $name!")

    println(s"state: $state, ordinal: ${state.ordinal}, name: ${state.name()}")
    println(s"student: $student")
    println() // prints just a newline

    // Math Operations
    // +, -, *, /, and % behave like normal
    println(s"Adding two numbers: $myInt + $myDouble = ${myInt + myDouble}")
    println(s"Adding a number and a char: $myInt + $myChar = ${myInt + myChar}")
    println(s"Dividing two ints: $myInt / 2 = ${myInt / 2}")
    println(s"$myInt ^ $myDouble = ${myInt ** myDouble}")
    // Don't do 0/0, else you'll get a floating point exception
    println(s"Weird math: 0/0.0 = ${0/0.0}, sqrt(-1) = ${sqrt(-1.0)}, (-1)^0.5 = ${-1.0 ** 0.5}")
    println(s"Rounding: $myDouble \u2192 ${myDouble.round(2)}")
    println()

    // Logical Operators
    // &&, ||, and ! behave like normal

    // Conditional Operators & Loops
    // No do-while loops
    println(if myBool then "myBool is true" else "myBool is false") // ternary operator

    // Switch Case
    myChar match {
        case '\u0000' | '\t' | '\n' | ' ' => println("myChar is shy") // '\0' is not allowed
        case _ => {
            println("myChar = $myChar")
        }
    }

    var i = 0

    while i < 3 do
        print(s"$i ")
        i += 1
    println()

    // to = inclusive, until = exclusive
    for i <- 0 until 5
    do
        print(s"$i ")
    println()

    for i <- 9 to 0 by -2 do print(s"$i ")
    println('\n') // print 2 newlines
    
    // Options
    var maybeInt: Option[Int] = None
    println(s"maybeInt = $maybeInt")
    maybeInt = Some(myInt)
    println(s"maybeInt = ${maybeInt.map(num => num * 2).getOrElse("still None")}")

    // Functions & Methods
    println(s"sumTo(10) = ${sumTo(10)}")
    println(s"student's hash code = ${student.hashCode()}")
    println(s"$myString is ${myString.length} characters long.")
    println(s"substring(1, 8) = ${myString.substring(1, 8)}")
    println(s"indexOf('s') = ${myString.indexOf('s')}")
    println()

    // Arrays
    if args.isEmpty then
        println("Hmm, you didn't enter any command line arguments.")
    else
        args.zipWithIndex.foreach { case(arg, index) => println(s"args[$index] = $arg") }

    // Lists == LinkedLists
    val nums1 = List(1, 2, 3, 4, 5)
    val nums2 = Nil // Nil == empty list
    println(nums1)
    println(nums2)
    
    val numPairs = for {
        n1 <- nums1
        n2 <- 1 to 5
        if n1 + n2 > 5
    } yield (n1, n2)
    println(s"numPairs = $numPairs")

    val numMapReduce = nums1.map(num => num * 2).filter(_ < 10).reduce((a, b) => a + b)
    println(s"numMapReduce = $numMapReduce")

    var fakeString = List('a', 't', 'r')
    fakeString = fakeString.drop(1)
    fakeString = 's' +: fakeString // append to the beginning
    println(s"fakeString has ${fakeString.length} characters.")
    println(fakeString)
    println()

    // HashMaps
    var myDict = Map(
        "month" -> 4,
        "day" -> 18
    )
    myDict = myDict + ("year" -> 1994) // no +=
    println(myDict)

    if myDict.contains("ssn") then
        println(s"You got hacked! ${myDict("ssn")}")
    else
        println("There's no key called ssn.")
    println()

    // Exception Handling
    try {
        sumTo(-1)
    } catch {
        case error: IllegalArgumentException => System.err.println(error) // print to stderr
    } finally {
        println()
    }

    // Classes
    //val class0 = SampleClass("science", 20, State.ROWDY) // SampleClass is abstract
    val class1 = MathClass(size = 50)
    val class2 = EnglishClass(size = 30)
    class1.status()
    class2.status()
}
