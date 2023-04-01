# This program utilizes all the basic Python functions. It can be translated to other languages for reference.
import sys


# Functions
def fibonacci(n=1):
    """
    Returns the nth fibonacci number

    :param n: the number of calculations
    :return the fibonacci number at each iteration
    """
    a = 0
    b = 1

    for _ in range(n):
        yield a
        a, b = b, a + b


def generic_func(*args, **kwargs):
    print(args)
    print(kwargs)
    print("I would like {} {}\n".format(args[0], kwargs["food"]))


# Classes
class MyClass:
    static_variable = "rowdy"

    def __init__(self, subject="Some random subject"):
        """Constructor"""
        self.subject = subject
        print(self)

    def __str__(self):
        return f"Settle down students! {self.subject} class is in session."

    def status(self):
        """Abstract method"""
        raise NotImplementedError("What class are you taking?")

    def __del__(self):
        """Destructor"""
        print(f"You dropped out of {self.subject}.")


class English(MyClass):
    def __init__(self, size):
        super().__init__("English")
        self.size = size

    def status(self):
        print(
            f"This {self.subject} class is {MyClass.static_variable}. There are {self.size} students in total.")


class Math(MyClass):
    def __init__(self, size):
        super().__init__("Math")
        self.size = size

    def status(self):
        print(
            f"This {self.subject} class is {MyClass.static_variable}. There are {self.size} students in total.")


def check_status(my_class):
    my_class.status()


# The following gets executed first.
if __name__ == "__main__":
    hello_world = "Hello Python World!"
    print(hello_world)
    print(f"By the way, you're using Python version {sys.version}\n")

    """
    Each part of the program will be split into sections like these.
    """
    # Variables
    my_int = 187
    my_float = 98.5
    my_string = "Don't worry about apostrophes with double quotes. "
    x, y = "two", "three"
    my_bool = True
    null_var = None

    # Input/Output
    name = input("What's your name? ")
    print(f"Nice to meet you {name}!")
    print(f"A floating point number can be {my_float:.1f} or {float(7):.4f}")
    print(my_string)
    print("I can print two values simultaneously like this: " + x, y)
    #  print("But don't do this: " + myInt + myString)
    print("I can also insert variables like this %d, or that %.2f, or even this: %s" % (my_int,
                                                                                        my_float, my_string))
    print("Another way to print {s} {s} {s} {s} {f:10.4f}".format(
        s="SPAM", f=my_float))
    print(f"A variable that's null: {null_var}")
    print()  # just a newline

    # Math Operations
    number = 3 + 2 - 9 * 6 / 3 % 8
    power = 2 ** 10
    print(f"number = {number}")
    print(f"power = {power}")
    print(
        f"Adding a number with a bool: {my_float} + {my_bool} = {my_float + my_bool}")
    print(f"({power} / {number}) Float division: {power / number} vs. Int division: {power // number}")
    print(f"Yes even % works: {power} % {number} = {power % number}")
    # Don't do 0/0.0 or sqrt(-1)
    print(f"Rounding is weird... {my_float} ~= {round(my_float)}")
    print(complex(my_int, my_float))

    # List & String methods
    my_list = []
    my_list_2 = [1, 2, 3, 5, 8]
    my_list.append(3)
    my_list.extend([2, 1])
    my_list.pop(-2)  # or my_list.remove(2)
    my_list.sort()
    for number in my_list:
        print(number)
    print()

    print(my_string * 2)
    print("myString is %d characters long" % (len(my_string)))
    print("The apostrophe is found %i characters in." % (my_string.index("'")))
    print("What language was this again? " + hello_world[6:12:1])
    print("Say it again, but backwards: " + hello_world[::-1])
    print("I'm shouting: " + hello_world.upper())
    print("Does myString end with tes? %s" %
          (my_string.endswith("tes")) + "\n")

    print(my_list + my_list_2)
    print(my_list * 3)
    my_string_list = hello_world.split("l")
    print(list(filter(lambda l: len(l) > 0, my_string_list)))
    print()

    # Logical Operators
    # <, <=, >, >=, ==, and != behave like normal
    # is behaves like triple equality (===)
    if 0 is False and 0 == False:
        print("True and False aren't 1 and 0.")
    if 1 == True or 1 is True:
        print("But True and False are subclassed as 1 and 0.")

    # Conditional Operators (no switch or do-while statements)
    print("Is power > number? %i" % (power > number))
    print("Ok, but is myInt = number? %i" % (my_int == number))
    if number != 0 and 3 in my_list:
        print("Congrats! You passed!")
    elif not my_list:
        print("This list is empty.")
    else:
        print("Proofread your work.")
    print(my_int is my_int)
    print(number is power)
    print(not number < 0)
    print("The truth prevails!" if my_bool else "Lying hurts.")
    print()

    # Loops
    for num in range(0, 10, 3):
        print(num)
    for index, letter in enumerate(x):
        print(f"x[{index}] = {letter}")
    for items in zip(my_list, my_list_2):
        print(items)
    while number < 0:
        continue
        # Code unreachable: break
    else:
        print("The while statement finished!")

    # Declaring Functions
    # help(fibonacci)
    for num in fibonacci(10):
        print(f"{num} ", end="")  # print without a newline
    print()
    generic_func(10, 20, 30, food="spaghetti", animal="dog")

    # Declaring Classes
    english_class = English(30)
    math_class = Math(20)
    check_status(english_class)
    check_status(math_class)
    some_class = MyClass()
    try:
        some_class.status()
    except NotImplementedError as e:
        print(f"Error: {e}")
        del some_class
    finally:
        print()

    # Dictionaries
    my_dictionary = {
        "month": 4,
        "day": 15,
        "year": 1994
    }

    my_dictionary["age"] = 19
    print(my_dictionary)
    print(my_dictionary.get("ssn", "private information"))
    for key, value in my_dictionary.items():
        print("My %s is %i" % (key, value))
    del my_dictionary["year"]
    my_dictionary.pop("month")
    print("All I'm left with is the number %i\n" % (my_dictionary["day"]))

    # Tuples
    my_tuple = (True, True, False, True, False, True, True, False, False, True)
    print(my_tuple[6:2:-1])
    print(f"Number of correct answers: {my_tuple.count(True)}")
    print(f"False first appears at index {my_tuple.index(False)}\n")

    # Sets
    my_set_1 = set("Mississippi")
    my_set_1.add(2)  # type: ignore
    my_set_1.add(1)  # type: ignore
    my_set_1.add(1)  # type: ignore
    my_set_1.remove(2)  # type: ignore
    my_set_1.discard("z")  # z doesn't exist
    print(f"set1 = {my_set_1}")
    my_set_2 = set("Minneapolis")
    print(f"set2 = {my_set_2}")
    print(f"set1 | set2 = {my_set_1.union(my_set_2)}")
    print(f"set1 & set2 = {my_set_1.intersection(my_set_2)}")
    print(f"set1 - set2 = {my_set_1.difference(my_set_2)}")
    print(f"set2 - set1 = {my_set_2.difference(my_set_1)}")
    print(f"set1 ^ set2 = {my_set_2.symmetric_difference(my_set_1)}")
    print()
