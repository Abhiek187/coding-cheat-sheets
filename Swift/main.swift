import Foundation

enum State {
    case calm, rowdy

    mutating func toggle() {
        // mutating = change self
        self = self == .calm ? .rowdy : .calm
    }
}

/* Structs and classes are very similar in Swift
 * Key differences: struct = value, class = reference;
 * Structs can't inherit each other
 */
struct Student: CustomStringConvertible {
    var name: String = "anonymous"
    var grade: Int = 100

    // toString() of CustomStringConvertible protocol
    var description: String {
        return "\(name) got a \(grade)."
    }
}

// Interface
protocol Class {
    func status()
}

class SampleClass: Class {
    /* Variables are internal by default
     * private = accessible in this class
     * fileprivate = accessible in this file
     * internal = accessible in this module (framework)
     * public = accessible anywhere
     * open (class & class members only) = like public + the ability to subclass and override anywhere
     */
    private var subject: String
    private var size: Int
    private var state: State
    fileprivate static var id = 0 // class vars and funcs can be overridden

    init(subject: String, size: Int, state: State) {
        self.subject = subject
        self.size = size
        self.state = state
        SampleClass.id += 1
    }

    deinit {
        print("You dropped out of \(subject).")
    }

    func status() {
        print("This \(subject) class has \(size) students and is \(state).")
    }
}

final class MathClass: SampleClass, CustomStringConvertible {
    public var description: String {
        return "Welcome to math class! You are student #\(SampleClass.id)."
    }

    init(size: Int) {
        super.init(subject: "math", size: size, state: .rowdy)
        print(self)
    }
}

final class EnglishClass: SampleClass, CustomStringConvertible {
    public var description: String {
        return "Welcome to english class! You are student #\(SampleClass.id)."
    }

    init(size: Int) {
        super.init(subject: "english", size: size, state: .calm)
        print(self)
    }
}

// Extensions
extension Double {
    func round(toPlaces places: Int) -> Double {
        // Outside function: toPlaces, inside function: places
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension String: Error, LocalizedError {
    // Confirm to error protocols to throw a string
    public var errorDescription: String? { return self }

    func substring(start: Int, end: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        return String(self[startIndex..<endIndex])
    }

    func indexOf(_ char: Character) -> Int {
        if let firstIndex = self.firstIndex(of: char) {
            return self.distance(from: self.startIndex, to: firstIndex)
        } else {
            return -1
        }
    }
}

func getSwiftVersion() -> Int {
    #if swift(>=5.0)
    return 5
    #elseif swift(>=4.0)
    return 4
    #elseif swift(>=3.0)
    return 3
    #elseif swift(>=2.0)
    return 2
    #else
    return 1
    #endif
}

/* Overload **
 * prefix = +x, infix = x + y, postfix = x+
 */
infix operator **
func **(lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}

func sumTo(_ num: Int=1) throws -> Int {
    if num <= 0 {
        throw "num must be positive"
    } else if num == 1 {
        return 1
    } else {
        return try! sumTo(num - 1) + num // should not crash
    }
}

// Execution starts here (file must named main.swift)
print("Hello Swift!")
print("By the way, you're running Swift \(getSwiftVersion())")

// Variables
var myInt = -29 // implicitly converts to Int, mutable
let myDouble: Double = 6.84551e1 // explicit typing, constant
let myChar: Character = "🎁" // can be unicode, no single quotes
let myBool: Bool = true
let myString: String = "This is a string."
var state: State = .calm
var student: Student = Student() // b/c student's a struct, make variable var to change its properties
student.name = "Joe Schmo"

// Input/Output
print("What's your name? ", terminator: "") // print without a newline
guard let name = readLine() else {
    // name must have a value, else print error
    fatalError("Failed to get input, exiting...")
}
print("Hey \(name)!")
print("state: \(state) \(myChar)")
state.toggle()
print("now state = \(state)")
print(student)
print() // prints just a newline

// Math Operations
print("Adding two numbers: \(myInt) + \(myDouble) = \(Double(myInt) + myDouble)")
print("\(myInt) + \(myString) = \(String(myInt) + myString)")
print("Dividing two ints: \(myInt) / 2 = \(myInt / 2)")
print("\(myDouble) ^ \(myInt) = \(myDouble ** Double(myInt))")
print("Werid math: 0/0.0 = \(0/0.0), sqrt(-1) = \(sqrt(-1))")
print("Rounding: \(myDouble) \u{2192} \(myDouble.round(toPlaces: 2))")
print()

// Logical Operators
// &&, ||, and ! behave like normal

// Conditional Operators & Loops
// if, else if, and else behave like normal (w/o parentheses)
var i = 0
repeat {
    // Equivalent of do-while loop
    i += 1
    print(i)
} while (i < 5)

for i in (0..<5).reversed() {
    /* Or equivalently:
     * (0...4).reversed(),
     * stride(from: 4, through: 0, by: -1),
     * stride(from: 4, to: -1, by: -1)
     */
    print(i)
}

switch i {
    case 0:
        print("i = 0") // no need to break :D
    case 1, 2:
        print("i = 1 or 2")
    default:
        print("i is something else (\(i))")
}

print()

// Optionals
var maybeBool: Bool? = nil // can be a bool or nil
var willBeDouble: Double! = nil // when read, willBeDouble will be guaranteed a value

if let bool = maybeBool {
    print("maybeBool has a value: \(bool)")
} else {
    print("maybeBool is nil")
}

maybeBool = false
willBeDouble = exp(1) // e
print("describing the optional: \(String(describing: maybeBool))")
print(maybeBool ?? "default value")
print(maybeBool!) // if maybeBool is still nil, the program crashes
print("e = \(willBeDouble!)")
print()

// Functions & Methods (param names)
print("sum(1, 1) = \(try sumTo())") // no named parameter
print("sum(1, 10) = \(try sumTo(10))")
print("\(myString) is \(myString.count) characters long")
print("substring(1, 8) = \(myString.substring(start: 1, end: 8))")
print("indexOf('s') = \(myString.indexOf("s"))")
print()

// Arrays
let fixedArr: [Character] = ["a", "e", "i", "o", "u"]
var dynamicArr: [Bool] = []
dynamicArr += [false, false, true]
dynamicArr.append(false) // add at the end
dynamicArr.remove(at: 1)
dynamicArr.insert(true, at: 0)

print("fixedArr: \(fixedArr)")
print("dynamicArr: \(dynamicArr)")
dynamicArr.removeAll()
print()

// Dictionaries
var myDict: [String: Int] = [:]
myDict = [
    "month": 4,
    "day": 18
]
myDict["year"] = 1994
print("myDict: \(myDict)")

if let ssn = myDict["ssn"] {
    print("You got hacked! #\(ssn)")
} else {
    print("There's no key called ssn.")
}

print()

// Tuples
var myTuple: (x: Double, y: Double) = (0, 1.75) // all properties are predefined
myTuple.x = -3.14 // w/o names: x == .0, y == .1
print("myTuple: \(myTuple)")
print()

// Exception Handling
do {
    _ = try sumTo(-1)
} catch {
    print("Error: \(error.localizedDescription)")
}

print()

// Classes
// SampleClass is abstract
//var class0: SampleClass? = SampleClass(subject: "science", size: 20, state: .rowdy)
var class1: MathClass? = MathClass(size: 50)
var class2: EnglishClass? = EnglishClass(size: 30)
class1?.status()
class2?.status()
// "Force" deninit classes
class1 = nil
class2 = nil
