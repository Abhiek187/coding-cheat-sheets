import kotlin.math.log2
import kotlin.math.pow
import kotlin.math.sqrt
import kotlin.system.exitProcess

// Special Classes
enum class State {
	CALM,
	ROWDY; // one of the rare times you need a semicolon

	override fun toString(): String = name.toLowerCase() // one-line return
}

// Data classes come with equals(), hashCode(), toString(), componentN(), copy()
data class Student(var name: String = "anonymous", var grade: Int = 100) {
	override fun toString(): String = "$name got a $grade."
}

// Extensions
fun Double.round(places: Int): Double = String.format("%.${places}f", this).toDouble()

/* Overload **
 * prefix = +x, infix = x + y, postfix = x+
 */
infix fun Int.`**`(exponent: Int): Int = toDouble().pow(exponent).toInt()
infix fun Int.`**`(exponent: Double): Double = toDouble().pow(exponent)
infix fun Double.`**`(exponent: Int): Double = this.pow(exponent)
infix fun Double.`**`(exponent: Double): Double = this.pow(exponent)

fun sumTo(num: Int=1): Int {
	if (num <= 0) {
		throw IllegalArgumentException("num must be positive")
	} else if (num == 1) {
		return 1
	} else {
		return num + sumTo(num - 1)
	}
}

// If running a .kt file, this is where execution would start
fun main(args: Array<String>) {
	println("Hello Kotlin!")
	println("By the way, you're running Kotlin version " + KotlinVersion.CURRENT)

	// Variables
	var myInt = 21 // mutable, implicitly converted to Int
	val myDouble: Double = -0.14597 // constant, explicitly typed
	val myChar: Char = '\t'
	val myBool: Boolean = true
	val myString: String = "This is a string."
	val state: State = State.ROWDY
	val student: Student = Student(name = "Joe Schmo", 94) // named parameter (optional)

	// Input/Output
	print("What's your name? ") // prints w/o a newline
	System.out.flush() // force output to console
	val name = readLine() ?: run {
		// Quit if input reads EOF
		println("Whoops! Couldn't read input. Exiting...")
		exitProcess(status = -1)
	}
	println("Hey $name!")
	println("state: $state, ordinal: ${state.ordinal}, name: ${state.name}") // braces for expressions
	println("student: $student")
	println() // prints just a newline

	// Math Operations
	println("$myInt ^ $myDouble = ${myInt `**` myDouble}")
	println("Weird math: log2(-1) = ${log2(-1.0)}, sqrt(-1) = ${sqrt(-1.0)}, "
		+ "(-1)^0.5 = ${(-1.0).pow(0.5)}")
	println("Rounding: $myDouble \u2192 ${myDouble.round(2)}")
	println()

	// Logical Operators
	// &&, ||, and ! behave like normal

	// Conditional Operators + Loops
	// if, else if, else, do, and while behave like normal
	println(if (myBool) "myBool is true" else "myBool is false") // ternary operator

	// Switch Case
	when (myChar) {
		'\u0000', '\t', '\n', ' ' -> println("myChar is shy") // '\0' is not allowed
		else -> {
			println("myChar = $myChar")
		}
	}

	repeat(3) { println("repeat") }
	args.forEachIndexed { index, arg -> println("args[$index] = $arg") }

	for (i in 0 until 5) {
		// or 0..4
		println(i)
	}

	for (i in 9 downTo 0 step 2) {
		println(i)
	}

	println()

	// Nullables

	// Functions & Methods
	println("sumTo(10) = ${sumTo(10)}")
	println("student's hash code = ${student.hashCode()}")
	println("student component 1: ${student.component1()}") // components start at 1
	println("$myString is ${myString.length} characters long.")
	println("substring(1, 8) = ${myString.substring(1, 8)}")
	println("indexOf('s') = ${myString.indexOf('s')}")
	println()

	// Arrays & ArrayLists
	var fixedArray: CharArray = charArrayOf('s', 't', 'r')

	for ((index, value) in fixedArray.withIndex()) {
		// Eq. to enumerate()
		println("fixedArray[$index] = $value")
	}

	println()

	// Exception Handling
	try {
		sumTo(-1)
	} catch (error: IllegalArgumentException) {
		System.err.println(error) // print to stderr
	} finally {
		println()
	}

	// Classes
}

/* Execution starts here for a .kts file,
 * but we're simulating a .kt file by going straight to main
 */
main(args) // args are the command line arguments
