// If running a .kt file, this is where execution would start
fun main(args: Array<String>) {
	println("Hello Kotlin!")
	args.forEach { arg -> println(arg) }
}

/* Execution starts here for a .kts file,
 * but we're simulating a .kt file by going straight to main
 */
main(args)
