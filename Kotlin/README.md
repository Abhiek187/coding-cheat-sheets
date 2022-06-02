# Kotlin

![Kotlin Logo](img-kotlin.png)

Kotlin is one of the newest languages on this list. It was released to the public in 2016 as an addition to the Java Virtual Machine. This means Kotlin can be used anywhere Java can be used. But Kotlin has some key advantages over Java, namely that it's more concise, flexible, and null-safe. For these reasons, it has recently become the preferred language for Android development (mimicking what Swift did to Objective-C). Kotlin even leverages JavaScript and Swift libraries for web and iOS development respectively.

## How to Run

Follow the steps [here](https://kotlinlang.org/docs/tutorials/command-line.html) to install Kotlin. Then run the following command:

```bash
kotlinc -script HowToKotlin.kts
```

Note that I chose a `.kts` file for scripting purposes. It's also faster than compiling to a `.jar` file. If you were working with a `.kt` file, you would run the following:

```bash
kotlinc HowToKotlin.kt -include-runtime -d <OUTPUT>.jar
java -jar <OUTPUT>.jar
```

where <OUTPUT> can whatever you want to name the output.

For more on Kotlin, check out the [documentation](https://kotlinlang.org/docs/reference/).
