using System;
using System.Collections.Generic;

namespace HowToCsharp
{
    enum State
    {
        Calm,
        Rowdy
    }
    struct Student
    {
        public string name;
        public int grade;

        public Student(string name, int grade=100)
        {
            this.name = name;
            this.grade = grade;
        }
        public override string ToString()
        {
            return $"{name} got a {grade}.";
        }
    }
    interface IClass
    {
        void Status();
    }
    abstract class SampleClass : IClass
    {
        readonly string subject;
        readonly int size;
        protected State state;
        protected static int id = 0;

        public SampleClass(string subject, int size)
        {
            this.subject = subject;
            this.size = size;
            this.state = State.Rowdy;
            id++;
            Program.Println(ToString());
        }
        ~SampleClass()
        {
            Program.Println($"You dropped out of {subject}.");
        }
        public override string ToString()
        {
            return $"Welcome to some class! You are student #{id}.";
        }
        public void Status()
        {
            Program.Println($"This {subject} class has {size} students and is {state}.");
        }
    }
    class MathClass : SampleClass
    {
        public MathClass(int size) : base("Math", size)
        {
            this.state = State.Rowdy;
        }
        public override string ToString()
        {
            return $"Welcome to math class! You are student #{id}.";
        }
    }

    class EnglishClass : SampleClass
    {
        public EnglishClass(int size) : base("English", size)
        {
            this.state = State.Calm;
        }
        public override string ToString()
        {
            return $"Welcome to english class! You are student #{id}.";
        }
    }
    // Class of overrides
    static class Extensions
    {
        public static string Print(this State state)
        {
            return state.ToString().ToLower();
        }
        // Generic Functions
        public static void Print<T>(this T[] arr)
        {
            foreach (T element in arr)
            {
                Console.WriteLine($"{element} ");
            }

            Console.WriteLine();
        }
        public static void Print<T>(this List<T> list)
        {
            list.ForEach(e => Console.WriteLine($"{e} "));
            Console.WriteLine($"count = {list.Count}");
        }
    }
    class Program
    {
        // Functions are conventionally Captialized
        public static void Println(string str="")
        {
            Console.WriteLine(str);
        }
        static void OutSum(int a, int b, out int sum)
        {
            sum = a + b; // ref if we need to read sum
        }
        static int RecursiveSum(int num)
        {
            if (num <= 0)
            {
                throw new ArgumentException("num must be positive");
            }
            else if (num == 1)
            {
                return 1;
            }
            else
            {
                return num + RecursiveSum(num: --num);
            }
        }
        /* Main gets executed first. Namespace is not required and class name doesn't need to
         * match the file name, but all are recommended. Functions must be inside classes.
         */
        static void Main(string[] args)
        {
            Console.WriteLine("Hello C#!");
            Console.WriteLine($"By the way, you're running C# runtime version " +
                $"{typeof(string).Assembly.ImageRuntimeVersion}");

            // Variables
            int myInt = 24;
            double myDouble = -32.7356;
            char myChar = '~';
            bool myBool = true;
            string myString = "This is a reference type.";
            const string nullVar = null;
            State state = State.Calm;
            Student student = new Student("Joe Schmo");

            // Input/Output
            Console.Write("What's your name? ");
            string name = Console.ReadLine();
            Console.WriteLine($"Hey {name}!");
            Console.WriteLine("bool: {0}", myBool);
            Console.WriteLine("null: " + nullVar);
            Console.WriteLine($"state: {state.Print()}");
            Console.WriteLine(student);
            Console.WriteLine(); // prints just a newline

            // Math Operations
            // +, -, *, /, and % behave like normal
            Console.WriteLine($"Adding two numbers: {myInt} + {myDouble} = {myInt + myDouble}");
            Console.WriteLine($"Adding a number and a char: {myInt} + {myChar} = {myInt + myChar}");
            Console.WriteLine($"Adding a number and a string: {myInt} + {myString} = "
                + $"{myInt + myString}");
            Console.WriteLine($"{myDouble} ^ {myInt} = {Math.Pow(myDouble, myInt)}");
            // Don't do 0/0, else you'll get a floating point exception
            Console.WriteLine($"Weird math: 0/0.0 = {0 / 0.0}, sqrt(-1) = {Math.Sqrt(-1)}");
            Console.WriteLine($"Rounding: {myDouble} \u2192 {Math.Round(myDouble, 2)}");
            Console.WriteLine();

            // Logical Operators
            // &&, ||, and ! behave like normal

            // Conditional Operators & Loops
            // if, else if, else, switch, case, do, while, and for behave like normal

            // Functions & Methods
            Println("An easier way to print");
            Println($"{myString} is {myString.Length} characters long");
            Println($"substring(1, 8): {myString.Substring(1, 8)}");
            Println($"indexOf('s'): {myString.IndexOf('s')}");

            int sum = 0;
            OutSum(7, 3, out sum); // initializes sum to 7 + 3 = 10
            Println($"The sum from 0 to {sum} = {RecursiveSum(num: sum)}");
            Println(); // unlike Java, C# supports default parameters

            // Arrays & Lists
            if (args.Length == 0)
            {
                Println("Hmm, you didn't enter any command line arguments.");
            }
            else
            {
                Println("You passed in the following command line arguments:");

                int index = 0;
                foreach (var arg in args) // var = auto
                {
                    Println($"args[{index}] = {arg}");
                    index++;
                }
            }

            int[] nums1 = { 1, 2, 3, 4, 5 };
            int[] nums2 = new int[5];
            Println("Fixed arrays:");
            nums1.Print();
            nums2.Print();

            List<char> fakeString = new List<char>();
            fakeString.AddRange(new char[] { 'a', 't', 'r' });
            fakeString.RemoveAt(0);
            fakeString.Insert(0, 's');
            Println("Dynamic array:");
            fakeString.Print();
            fakeString.Clear();
            Println();

            // Exception Handling
            try
            {
                RecursiveSum(num: -1);
            }
            catch (ArgumentException e)
            {
                Println(e.Message);
            }
            finally
            {
                Println();
            }

            // Classes
            //SampleClass class0 = new SampleClass(); // can't do this, SampleClass is abstract
            MathClass class1 = new MathClass(50);
            EnglishClass class2 = new EnglishClass(30);
            class1.Status();
            class2.Status();
        }
    }
}
