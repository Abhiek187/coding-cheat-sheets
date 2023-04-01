use rustc_version::version;
use std::collections::HashMap;
use std::env;
use std::fmt::{Debug, Display};
use std::io::{self, Write};

// Derive the default implementation of Debug (to print)
#[derive(Debug)]
enum State {
    Calm,
    Rowdy,
}

struct Student {
    name: String,
    grade: u8,
}

// Interface
trait IClass {
    fn status(&self) {
        println!("Something something classroom...");
    }
}

// 'a = lifetime annotation
struct Class<'a> {
    subject: &'a str,
    size: i32,
    state: State,
}

static mut ID: i32 = 0;

impl<'a> Class<'a> {
    // Associated function (static)
    fn new(subject: &'a str, size: i32, state: State) -> Self {
        let new_class = Class {
            subject,
            size,
            state,
        };
        unsafe { ID += 1 };
        println!("{new_class}");
        return new_class;
    }
}

impl<'a> IClass for Class<'a> {
    fn status(&self) {
        println!(
            "This {} class has {} students and is {:?}.",
            self.subject, self.size, self.state
        );
    }
}

// Destructor
impl<'a> Drop for Class<'a> {
    fn drop(&mut self) {
        println!("You dropped out of {}.", self.subject);
    }
}

// toString()
impl<'a> Display for Class<'a> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "Welcome to {} class! You are student #{}.",
            self.subject,
            unsafe { ID }
        )
    }
}

// Extensions
trait StringUtils {
    fn safe_substring(&self, start: usize, end: usize) -> String;
    fn safe_index_of(&self, char: char) -> Option<usize>;
}

impl StringUtils for str {
    fn safe_substring(&self, start: usize, end: usize) -> String {
        self.chars()
            .skip(start)
            .take(end - start + 1)
            .collect::<String>()
    }

    fn safe_index_of(&self, char: char) -> Option<usize> {
        self.chars().position(|c| c == char)
    }
}

fn add_ptrs(a: &i32, b: &i32, sum: &mut i32) {
    *sum = a + b;
}

/// Recursively sums from 1 to `num`.
///
/// ## Parameters
/// - **num:** The upper limit of the sum (inclusive)
///
/// ## Returns
/// Returns the sum from 1 to `num`, or an error if `num` is nonpositive.
fn recursive_sum(num: i32) -> Result<i32, &'static str> {
    if num <= 0 {
        // Result<T, E> = recoverable, panic!() = unrecoverable
        return Result::Err("num must be positive");
    } else if num == 1 {
        Result::Ok(1) // return expression
    } else {
        Result::Ok(num + recursive_sum(num - 1).unwrap())
    }
}

// Generic Functions
fn print_vector<T>(vec: &Vec<T>)
where
    T: Debug, // or <T: Debug>
{
    println!("{vec:?}");
    println!("size = {}", vec.len());
}

// main gets executed first
fn main() {
    print!("Hello Rust!\n"); // ! = macro
    println!(
        "By the way, you're running Rust version {:?}",
        version() // unwrap() is unsafe
    );

    /* Variables
     * Variables are immutable by default
     */
    let mut my_int = -19; // mut = mutable, i32 = signed 32-bit integer
    let my_double: f64 = 6.555_555e1; // f64 = 64-bit floating point
    let my_char = '👍';
    let my_bool = true;
    let my_string = String::from("This is a string.");
    let null_var: Option<i32> = None;
    let state = State::Rowdy;
    let student = Student {
        name: "Joe Schmo".to_string(),
        grade: 100,
    };

    // Input/Output
    let mut buffer = String::new();
    print!("What's your name? ");
    match io::stdout().flush() {
        Ok(_) => print!(""),
        Err(error) => println!("{error}"),
    }
    io::stdin()
        .read_line(&mut buffer)
        .expect("Failed to get input, exiting...");
    println!("Hey {}!", buffer.trim());
    println!("state: {state:?}");
    println!("{} got a {}.\n", student.name, student.grade);

    // Math Operations
    // +, -, *, /, and % behave like normal
    println!(
        "Adding two numbers: {my_int} + {my_double} = {}",
        my_int as f64 + my_double
    );
    println!(
        "Adding a number with a char: {my_int} + {my_char} = {}",
        my_int + my_char as i32
    );
    println!(
        "Adding a number with a bool: {my_int} + {my_bool} = {}",
        my_int + my_bool as i32
    );
    println!("Dividing two ints: {my_int} / 2 = {}", my_int / 2);
    println!("{my_double} ^ {my_int} = {:e}", my_double.powi(my_int));
    println!(
        "Weird math: 0.0/0.0 = {}, sqrt(-1) = {}",
        0.0 / 0.0,
        (-1 as f32).sqrt()
    );
    println!(
        "Rounding: {my_double} \u{2192} {}",
        (my_double * 100.0).round() / 100.0
    );
    println!(); // prints just a newline

    // Logical Operators
    // &&, ||, and ! behave like normal

    // Conditional Operators & Loops
    // if, else if, else, and while behave like normal
    println!(
        "{}",
        if my_bool {
            "myBool is true"
        } else {
            "myBool is false"
        }
    ); // ternary operator

    match my_int % 2 {
        0 => {
            println!("my_int is even");
        }
        _ => {
            println!("my_int is odd");
        }
    }

    if let Some(_) = null_var {
        println!("null_var isn't null! {}", null_var.unwrap_or(-1));
    } else {
        println!("oops...");
    }

    let mut max = 5;

    // loop == while true
    let result = loop {
        if max <= 0 {
            break max;
        }

        max -= 1;
        println!("max = {max}");
    };

    println!("Ended loop with {result}");

    for i in 0..5 {
        println!("i = {i}");
    }
    println!();

    // Pointers & References
    let my_int_ptr = &mut my_int;
    println!("my_int is stored in address {my_int_ptr:p}");
    println!("It references {}", *my_int_ptr);
    *my_int_ptr >>= 1; // 10011 (19) -> 1101 (-19) -> 10110 (-10) -> 1010 (10)
    println!("Now my_int is {}", *my_int_ptr);
    println!("The pointer is stored in address {:p}", &my_int_ptr);
    println!("null: {null_var:?}"); // None.unwrap() = panic
    println!();

    // Functions & Methods
    println!("{my_string} is {} characters long", my_string.len());
    println!("substring(1, 8): {}", &my_string[1..8]); // &str = slice, &String = string reference
    println!(
        "substring(1, 8) (with unicode safety): {}",
        my_string.safe_substring(1, 8)
    );
    println!("indexOf('s'): {:?}", my_string.find('s'));
    println!(
        "indexOf('s') (with unicode safety): {:?}",
        my_string.safe_index_of('s')
    );

    let mut sum = 10;
    // add_ptrs borrows each argument without taking ownership
    add_ptrs(my_int_ptr, my_int_ptr, &mut sum);
    println!("sum resolves to {sum}");
    max = 10;
    println!(
        "The sum from 1 to {max} = {}",
        recursive_sum(max).unwrap_or(-1)
    );
    println!();

    // Arrays & Vectors
    let args = env::args();
    if args.len() <= 1 {
        println!("Hmm, you didn't enter any command line arguments.");
    } else {
        println!("You passed in the following command line arguments:");

        for (i, arg) in args.enumerate() {
            println!("args[{i}] = {arg}");
        }
    }

    let binary = [true, false, false, false, true, false, true];
    let zeros = [0; 5];
    println!("{binary:?}"); // :#? = pretty print
    println!("{zeros:?}");

    let mut fake_string: Vec<char> = Vec::new();
    fake_string.extend_from_slice(&['a', 't', 'r']); // or vec!['a', 't', 'r']
    fake_string.remove(0);
    fake_string.insert(0, 's');
    println!("Dynamic array:");
    print_vector(&fake_string);
    fake_string.clear();
    println!();

    // HashMaps
    let mut my_dict = HashMap::new();
    my_dict.insert("month", 4);
    my_dict.insert("day", 18);
    my_dict.insert("year", 1994);
    println!("my_dict: {my_dict:?}");

    if my_dict.get("ssn").is_some() {
        println!("You got hacked! {}", my_dict["ssn"]);
    } else {
        println!("There's no key called ssn.");
    }
    println!();

    // Exception Handling
    match recursive_sum(-1) {
        Ok(result) => {
            println!("sum(-1) = {result}");
        }
        Err(error) => {
            eprintln!("Error: {error}"); // print to stderr
        }
    }
    println!();

    // Classes
    let math_class = Class::new("math", 50, State::Rowdy);
    let english_class = Class::new("english", 30, State::Calm);
    math_class.status();
    english_class.status();
}
