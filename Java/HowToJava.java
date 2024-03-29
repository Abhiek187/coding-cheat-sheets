import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

enum State {
    CALM, ROWDY;

    @Override // not required, but helpful
    public String toString() {
        return name().toLowerCase();
    }
}

interface Class {
    default void status() {
        // Default implementation, implicitly public
        System.out.println("Something something classroom...");
    }
}

abstract class SampleClass implements Class {
    private final String subject;
    private final int size;
    protected State state;
    static int id = 0;

    public SampleClass(String subject, int size) {
        this.subject = subject;
        this.size = size;
        this.state = State.ROWDY;
        SampleClass.id++;
        System.out.println(this);
    }

    @Override
    public String toString() {
        return "Welcome to some class! You are student #" + id + ".";
    }

    @Override
    public void status() {
        System.out.println("This " + this.subject + " class has " + this.size + " students and is " + this.state + ".");
    }
}

// Final class cannot be overridden
final class MathClass extends SampleClass {
    public MathClass(int size) {
        super("Math", size);
        this.state = State.ROWDY;
    }

    @Override
    public String toString() {
        return "Welcome to math class! You are student #" + id + ".";
    }
}

final class EnglishClass extends SampleClass {
    public EnglishClass(int size) {
        super("English", size);
        this.state = State.CALM;
    }

    @Override
    public String toString() {
        return "Welcome to english class! You are student #" + id + ".";
    }
}

public class HowToJava {
    public static void println(String str) {
        System.out.println(str);
    }

    /**
     * Recursively sums from 1 to <code>num</code>.
     * 
     * @param num the upper limit of the sum (inclusive)
     * @return the sum from 1 to <code>num</code>
     * @throws IllegalArgumentException if <code>num</code> is non-positive
     */
    public static int recursiveSum(int num) throws IllegalArgumentException {
        if (num <= 0) {
            throw new IllegalArgumentException("num must be positive");
        } else if (num == 1) {
            return 1;
        } else {
            return num + recursiveSum(--num);
        }
    }

    // Generic Functions
    public static <T> void printArr(T[] arr) {
        for (T element : arr) {
            System.out.print(element + " ");
        }

        println("");
    }

    public static <T> void printList(List<T> list) {
        list.forEach(e -> System.out.print(e + " "));
        println("size = " + list.size());
    }

    public static <K, V> void printMap(Map<K, V> map) {
        System.out.println(map);
        println("size = " + map.size());
    }

    /*
     * This main function gets executed first Since this class is public, it must
     * match the file name
     *
     * public = can be called anywhere (not restricted by class or inherited
     * classes), static = can be called without an instance (i.e. HowToJava.main
     * instead of (new HowToJava()).main), void = the function returns nothing, main
     * = the name of the function, args = command line arguments
     */
    public static void main(String[] args) {
        System.out.println("Hello Java!");
        System.out.println("By the way, you're using Java version " + System.getProperty("java.version"));

        // Variables
        int myInt = -13;
        double myDouble = 8.2945e1;
        char myChar = '\\';
        boolean myBool = true;
        String myString = "This is a reference type.";
        final String nullVar = null; // final = constant
        State state = State.CALM;

        // Input/Output
        Scanner reader = new Scanner(System.in);
        System.out.print("What's your name? ");
        String name = reader.nextLine();
        System.out.println("Hey " + name + "!");
        String formattedStr = String.format(
                "Or if you want to be fancy, hi %s! " + "Your int = %d, double = %.2f, char = %c, and bool = %b.", name,
                myInt, myDouble, myChar, myBool);
        System.out.println(formattedStr);
        System.out.println("null variable: " + nullVar);
        System.out.println("state: " + state);
        System.out.println(); // prints just a newline
        // Remember to close the scanner when you're done!
        reader.close();

        // Math Operations
        // +, -, *, /, and % behave like normal
        System.out.println("Adding two numbers: " + myInt + " + " + myDouble + " = " + (myInt + myDouble));
        System.out.println("Adding a number and a char: " + myInt + " + " + myChar + " = " + (myInt + myChar));
        System.out.println("Adding a number and a string: " + myInt + " + " + myString + " = " + (myInt + myString));
        System.out.println("Dividing two ints: " + myInt + " / 2 = " + myInt / 2);
        System.out.println(myDouble + " ^ " + myInt + " = " + Math.pow(myDouble, myInt));
        // Don't do 0/0, else you'll get a floating point exception
        System.out.println("Weird math: 0/0.0 = " + 0 / 0.0 + ", sqrt(-1) = " + Math.sqrt(-1));
        formattedStr = String.format("Rounding: %f \u2192 %.2f", myDouble, myDouble);
        System.out.println(formattedStr);
        System.out.println();

        // Logical Operators
        // &&, ||, and ! behave like normal
        String hello1 = new String("hello");
        String hello2 = new String("hello");
        formattedStr = String.format("%s == %s? %b, %s.equals(%s)? %b", hello1, hello2, hello1 == hello2, hello1,
                hello2, hello1.equals(hello2));
        System.out.println(formattedStr);
        System.out.println();

        // Conditional Operators & Loops
        System.out.println(nullVar == null ? "nullVar is null" : "nullVar isn't null");

        if (myInt % 3 == 0) {
            System.out.println("myInt is divisible by 3");
        } else if (myInt % 3 == 1) {
            System.out.println("off by 1");
        } else {
            System.out.println("off by 2");
        }

        int num = 1;
        do {
            System.out.println(num);
            num += 2;
        } while (num < 10);

        for (num = 9; num > 0; num /= 2) {
            System.out.println(num);
        }

        System.out.println();

        // Functions & Methods
        println("An easier way to print");
        println(myString + " is " + myString.length() + " characters long");
        println("substring(1, 8): " + myString.substring(1, 8));
        println("indexOf('s'): " + myString.indexOf('s'));

        int max = 10;
        println("The sum from 0 to " + max + " = " + recursiveSum(max));
        println(""); // but not perfect...

        // Arrays & Lists
        if (args.length == 0) {
            System.out.println("Hmm, you didn't enter any command line arguments.");
        } else {
            System.out.println("You passed in the following command line arguments:");

            int index = 0;
            for (String arg : args) {
                System.out.println("args[" + index + "] = " + arg);
                index++;
            }
        }

        Integer[] nums1 = { 1, 2, 3, 4, 5 }; // must be Integer, not int, for generics
        Integer[] nums2 = new Integer[5];
        println("Fixed arrays:");
        printArr(nums1);
        printArr(nums2);

        List<Character> fakeString = new ArrayList<>();
        fakeString.addAll(Arrays.asList('a', 't', 'r'));
        fakeString.remove(0);
        fakeString.add(0, 's');
        println("Dynamic array:");
        printList(fakeString);
        fakeString.clear();
        println("");

        // HashMaps
        Map<String, Integer> myDict = new HashMap<>();
        myDict.putAll(Map.of("month", 4, "day", 18));
        myDict.put("year", 1994);
        printMap(myDict);

        if (myDict.containsKey("ssn")) {
            println("You got hacked! " + myDict.get("ssn"));
        } else {
            println("There's no key called ssn.");
        }
        println("");

        // Exception Handling
        try {
            recursiveSum(-1);
        } catch (IllegalArgumentException e) {
            println(e.getMessage());
        } finally {
            println("");
        }

        // Classes
        // SampleClass class0 = new SampleClass(); // SampleClass is abstract
        MathClass class1 = new MathClass(50);
        EnglishClass class2 = new EnglishClass(30);
        class1.status();
        class2.status();
    }
}
