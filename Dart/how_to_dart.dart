import 'dart:io' show Platform, stdin, stdout;
import 'dart:math';

/* extends vs. abstract vs. implements vs. with:
 * extends can only inherit one base class, where the methods can be overriden
 * abstract classes can define their methods, but cannot be instantiated
 * implements inherits the interface, where all methods must be defined...
 * ...in dart, interfaces can have definitions, and if they're not abstract,...
 * ...can also be instantiated
 * with is used with mixins, which can be added to other classes
 * multiple mixins can be implemented, like interfaces, but can't be...
 * ...instantiated like with abstract classes
 * unlike abstract classes, mixin methods can't be overriden since they...
 * ...aren't extended
 * if the same method name appears in multiple mixins, the definition in the...
 * ...last mixin will be used since each mixin overrides any equivalent methods
 * tl;dr: base class: {override: yes, instantiate: yes}
 * abstract class: {override: yes, instantiate: no}
 * interface: {override: yes, instantiate: yes if not abstract}
 * mixin: {override: no unless multiple mixins, instantiate: no}
 */
enum State {
  calm,
  rowdy,
}

// An abstract class that is treated like an interface
abstract class Class {
  void status();
}

abstract class SampleClass implements Class {
  final String subject;
  final int size;
  // Private members have underscores
  State _state = State.rowdy;
  static int _id = 0;

  // Named arguments
  SampleClass({required this.subject, required this.size}) {
    _id++;
    print(this);
  }

  @override
  String toString() => 'Welcome to some class! You are student #$_id.';

  @override
  void status() {
    print('This $subject class has $size students and is ${_state.text()}.');
  }
}

class MathClass extends SampleClass {
  MathClass({required int size})
      : super(
          subject: 'Math',
          size: size,
        ) {
    this._state = State.rowdy;
  }

  @override
  String toString() =>
      'Welcome to math class! You are student #${SampleClass._id}.';
}

class EnglishClass extends SampleClass {
  EnglishClass({required int size})
      : super(
          subject: 'English',
          size: size,
        ) {
    this._state = State.calm;
  }

  @override
  String toString() =>
      'Welcome to english class! You are student #${SampleClass._id}.';
}

/// Recursively sums from 1 to [num].
///
/// Throws an [Exception] if [num] is non-positive.
int recursiveSum(int num) {
  if (num <= 0) {
    throw 'num must be positive';
  } else if (num == 1) {
    return 1;
  } else {
    return num + recursiveSum(num - 1);
  }
}

// Naming an extension will allow it to be imported to other files
extension StateEx on State {
  String text() => this.toString().split('.').last;
}

// main gets executed first, void is optional
void main(List<String> args) {
  print('Hello Dart!'); // single quotes by convention
  print('By the way, you\'re running Dart version ${Platform.version}');

  // Variables
  const int myInt = -47; // const = compile-time constant
  final double myDouble = pi * e; // final = run-time constant
  bool myBool = true;
  String myString = 'This is a string.';
  var nullVar = null; // var = dynamic
  dynamic anything = 3; // dynamic = any time
  anything -= myDouble;
  State state = State.calm;

  // Input/Output
  stdout.write('What\'s your name? '); // print without a newline
  String? name = stdin.readLineSync(); // ? = nullable
  print('Hey ${name ?? '👻'}!');
  print('null variable: $nullVar');
  print('dynamic variable: $anything');
  print('state: $state');
  print(''); // print just a newline

  // Math Operations
  // +, -, *, /, and % behave like normal
  print('Adding two numbers: $myInt + $myDouble = ${myInt + myDouble}');
  print('Multiplying a string with an int: $myString * 2 = ${myString * 2}');
  print('Dividing two ints: $myInt ~/ 2 = ${myInt ~/ 2}');
  print('$myDouble ^ $myInt = ${pow(myDouble, myInt)}');
  print(
      'Weird math: 2/0 = ${2 / 0}, 0/0.0 = ${0 / 0.0}, sqrt(-1) = ${sqrt(-1)}');
  print('Rounding: $myDouble \u2192 ${myDouble.toStringAsFixed(12)}');
  print('');

  // Logical Operators
  // &&, ||, and ! behave like normal
  print('Is myBool a num? ${myBool is num}');
  print('Is anything a double? ${anything is double}');
  print('');

  // Conditional Operators & Loops
  // if, else if, else, switch, case, do, while, and for behave like normal

  // Functions & Methods
  print('$myString is ${myString.length} characters long');
  print('substring(1, 8): ${myString.substring(1, 8)}');
  print('indexOf(\'s\'): ${myString.indexOf('s')}');

  const int max = 10;
  print('The sum from 0 to $max = ${recursiveSum(max)}');
  print('');

  // Arrays
  if (args.isEmpty) {
    print('Hmm, you didn\'t enter any command line arguments.');
  } else {
    print('You passed in the following command line arguments:');

    int index = 0;
    for (String arg in args) {
      print('args[$index] = ${arg}');
      index++;
    }
  }

  List<bool> myArray = [true, true, false, true, true, true, false];
  myArray.addAll([false, true, false]);
  myArray.removeAt(0);
  myArray.insert(0, false);
  print(myArray);
  myArray.clear();
  print('');

  // Maps
  Map<String, dynamic> myMap = {
    'item': 'Pizza',
    'quantity': 3,
    'price': 4.99,
    'onSale': false,
  };
  myMap.addAll({
    'toppings': ['Pepperoni', 'Spinach', 'Mushrooms'],
    'fresh': true,
  });
  myMap.remove('onSale');
  print(myMap);
  myMap.clear();
  print('');

  // Sets
  Set<int> set1 = Set();
  set1.addAll({
    1,
    2,
    3,
    4,
    5,
  });
  Set<int> set2 = {
    4,
    5,
    6,
    7,
    8,
  };
  print('set1 = $set1');
  print('set2 = $set2');
  print('set1 ∪ set2 = ${set1.union(set2)}');
  print('set1 ∩ set2 = ${set1.intersection(set2)}');
  print('set1 − set2 = ${set1.difference(set2)}');
  print('set2 − set1 = ${set2.difference(set1)}');
  print('');

  // Exception Handling
  try {
    recursiveSum(-1);
  } catch (e) {
    print(e);
  } finally {
    print('');
  }

  // Classes
  // SampleClass class0 = SampleClass(size: 0, subject: ''); // can't do this, SampleClass is abstract
  MathClass class1 = MathClass(size: 50);
  EnglishClass class2 = EnglishClass(size: 30);
  class1.status();
  class2.status();
}
