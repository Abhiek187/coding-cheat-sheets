// forEach value and index
// Array push, pop, slice, map, filter
// Object key best practices, shorthand? (key = value)
// Destructuring, spread & rest operators, arguments
// Closure
console.log("Hello TypeScript!");

// Returns a function which returns a number
const myCounter = (): () => number => {
	let count = 0; // private variable

	return () => {
		return ++count;
	};
};

const counter = myCounter();

for (let i = 0; i < 5; i++) {
	console.log(counter());
}
