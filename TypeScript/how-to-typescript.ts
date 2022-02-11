enum State {
    Calm = "calm",
    Rowdy = "rowdy",
}

interface IClass {
    status(): void;
}

abstract class SampleClass implements IClass {
    protected static id: number = 0;

    // Access modifier declares and initializes member variables (public by default)
    constructor(
        private subject: string,
        private size: number,
        private state: State
    ) {
        SampleClass.id++;
    }

    abstract toString(): string;

    status = () => {
        console.log(
            `This ${this.subject} class has ${this.size} students and is ${this.state}.`
        );
    };
}

class MathClass extends SampleClass {
    constructor(size: number) {
        super("Math", size, State.Rowdy);
        console.log(this.toString());
    }

    toString = (): string =>
        `Welcome to math class! You are student #${SampleClass.id}.`;
}

class EnglishClass extends SampleClass {
    constructor(size: number) {
        super("English", size, State.Calm);
        console.log(this.toString());
    }

    toString = (): string =>
        `Welcome to english class! You are student #${SampleClass.id}.`;
}

const round2 = (num: number): number => Math.round(num * 100) / 100;
const isTruthy = <T>(v: T): string => (!!v ? "truthy" : "falsy");

// Returns a function which returns a number
const myCounter = (): (() => number) => {
    let count = 0; // private variable
    return () => ++count; // no body = return line
};

/**
 * Recursively sums from 1 to `num`.
 *
 * @param {number} num - the upper limit of the sum (inclusive)
 * @returns {number} the sum from 1 to `num`
 * @throws {Exception} if `num` is non-positive
 */
const sumTo = (num: number): number => {
    if (num <= 0) {
        throw "num must be positive";
    } else if (num === 1) {
        return 1;
    } else {
        return num + sumTo(--num);
    }
};

// Helper interface for the method below
interface HasLength {
    length: number;
}

// Parameters must have a length property
const totalLength = <T1 extends HasLength, T2 extends HasLength>(
    t1: T1,
    t2: T2
): number => t1.length + t2.length;

const genericFunc = (
    arg1: any = undefined,
    arg2: any = undefined,
    ...rest: any[]
): void => {
    console.log(`typeof arg1: ${typeof arg1}, typeof arg2: ${typeof arg2}`);
    console.log(`rest instanceof Array? ${rest instanceof Array}`); // typeof array === object
    console.log(`arg1: ${arg1}, arg2: ${arg2}, rest: ${rest}`); // rest defaults to []
};

// Execution starts here
console.log("Hello TypeScript!");

// Variables
const myInt: number = 58; // number includes ints and doubles
const myDouble = Math.PI; // implicitly converted to number
const myString: string = "No chars, just strings";
const myBool: boolean = true;
const state: State = State.Rowdy;
const nullVar: string | null | undefined = null; // no value
const undVar: any = undefined; // doesn't exist

/* Output
 * window.prompt could be used as input, but would be intrusive to the user experience
 */
console.log("state: " + state); // string concatenation

// Math Operations
console.log(`${myInt} ^ ${myDouble} = ${myInt ** myDouble}`); // string interpolation (better)
console.log(`Adding two numbers: ${myInt} + ${myDouble} = ${myInt + myDouble}`);
console.log(
    `Adding a number with a string: ${myInt} + ${myString} = ${
        myInt + myString
    }`
);
console.log(`Weird math: 0/0.0 = ${0 / 0.0}, sqrt(-1) = ${Math.sqrt(-1)}`);
/*console.log(`{} + {} = ${{} + {}}`); // "[object Object][object Object]"
console.log(`{} + [] = ${{} + []}`); // 0
console.log(`[] + {} = ${[] + {}}`); // "[object Object]"
console.log(`[] + [] = ${[] + []}`); // ""*/
console.log(`${myString} + ${undVar} = ${myString + undVar}`);
console.log(`undefined + undefined = ${undVar * 2}`);
console.log(`NaN + undefined = ${NaN + undVar}`);
console.log(`null + undefined = ${nullVar + undVar}`);
/*console.log(`null + null = ${nullVar*2}`); // 0
console.log(`null + NaN = ${nullVar + NaN}`); // NaN*/
console.log(`Rounding: ${myDouble} \u2192 ${round2(myDouble)}`);

// Logical Operators
// &&, ||, and ! behave like normal
console.log(`${myInt} is ${isTruthy(myInt)}`);
console.log(`${nullVar} is ${isTruthy(nullVar)}`);
console.log(`${undVar} is ${isTruthy(undVar)}`);

// Conditional Operators
// if, else if, else, switch, case, do, and while behave like normal (for loops shown in arrays)
console.log(`${nullVar} == ${undVar}? ${nullVar == undVar}`);
console.log(`${nullVar} === ${undVar}? ${nullVar === undVar}`);

// String Methods
console.log(`${myString} is ${myString.length} characters long.`);
console.log(`substring(1, 8): ${myString.substring(1, 8)}`);
console.log(`indexOf('s'): ${myString.indexOf("s")}`);

// Arrays & Tuples (+ Loops)
let myArray: string[] = [];
myArray.push("a");
myArray.splice(1, 0, "t", "r"); // start at index 1, remove 0 elements, and add "t" and "r"
myArray.shift(); // remove first element
myArray.unshift("s"); // add element to the beginning of the array
console.log(myArray.toString());

let myArray2: boolean[] = [true, false, false, false, true, false, true];
myArray2 = myArray2.filter((elem) => elem || !elem).map((elem) => !!elem); // trivial example, I know :P
myArray2.forEach((value, index) =>
    console.log(`myArray2[${index}] = ${value}`)
);

const combinedArray: any[] = [...myArray, ...myArray2]; // spread arrays into one
console.log(combinedArray.join(", "));

const myTuple: [number, boolean, string] = [0, false, "lies"];
for (const tup of myTuple) {
    console.log(tup);
}

// Functions
console.log(`The sum from 1 to ${myInt} is ${sumTo(myInt)}.`);
const counter = myCounter();

for (let i = 0; i < 5; i++) {
    console.log(counter());
}

console.log(`length(myString + myArray) = ${totalLength(myString, myArray)}`);
console.log(`length(myArray + myArray2) = ${totalLength(myArray, myArray2)}`);
console.log(`length(myArray + myTuple) = ${totalLength(myArray, myTuple)}`);
genericFunc(1, "is", true);
genericFunc();
genericFunc(0);
genericFunc(-1.3, "oh", 4, true, "blaze");
const [bool1, bool2, ...bools] = myArray2;
genericFunc(bool1, bool2, bools);

// Objects
const MyObject: object = {
    name: "anonymous",
    grade: 100,
};

const student = Object.create(MyObject);
student.name = "Joe Schmo";
const { name: _name, grade } = student; // window.name is taken
console.log(`${_name} got a ${grade}.`);

// Exception Handling
try {
    sumTo(-1);
} catch (err) {
    console.error(`Error: ${err}`);
} finally {
    console.log("Finally on to classes!");
}

// Classes
//const class0: SampleClass = new SampleClass("Science", 20, State.Rowdy); // SampleClass is abstract
const class1: MathClass = new MathClass(50);
const class2: EnglishClass = new EnglishClass(30);
class1.status();
class2.status();
