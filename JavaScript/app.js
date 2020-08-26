/* Enable strict mode: This will enforce rules such as declaring variables, not deleting variables,
 * and preventing reserved keywords from being overriden.
 * Note: This file will primarily focus on ES6 syntax.
 */
"use strict";

// Retrieve the DOM elements (use const or let, not var)
const checkbox = document.getElementById("dark-mode");
const submitButton = document.querySelector(".submit-button");
const response = document.querySelector(".name-response");
const timeSpan = document.querySelector("time");
const alertButton = document.querySelector(".alert-button");
const table = document.querySelector(".table"); // only selects one element
const th = Array.from(document.getElementsByTagName("th")); // converts HTMLCollection to Array
const td = Array.from(document.getElementsByTagName("td"));
const canvas = document.querySelector("canvas");
const codeBlock = document.querySelector(".code-block");
const details = document.querySelector(".details");
const detailsText = document.querySelector(".details-text");
const htmlImg = document.querySelector(".html-img");
const link = document.querySelector(".link");

// DOM elements that change in dark mode
const darkModeElements = [document.body, response, table, canvas, codeBlock, htmlImg, link];

// Number of states in the details animation
let currentState = 0;
let interval = null;

// Event listeners
alertButton.addEventListener("click", () => alert("An alert popped up!"));

submitButton.addEventListener("click", event => {
	// Anonymous function
	event.preventDefault(); // don't add a query to the web address
	const name = event.target.previousElementSibling.value; // event.target === submitButton

	if (name === "") {
		response.style.display = "none"; // hide response text
	} else {
		response.textContent = `Hey ${name}!`; // string interpolation
		response.style.display = "inline"; // make text visible
	}
});

details.addEventListener("toggle", () => {
	if (details.open) {
		// Start the animation (will start after 1 second)
		interval = setInterval(detonate, 1000); // 2nd parameter is in milliseconds
	} else {
		// Stop the animation
		clearInterval(interval);
		currentState = 0; // reset to initial state
		detailsText.textContent = "This message will self-destruct in 3...";
	}
});

// Arrow functions
const detonate = () => {
	currentState++;

	switch (currentState) {
		case 1:
			detailsText.textContent += "2...";
			break;
		case 2:
			detailsText.textContent += "1...";
			break;
		default:
			detailsText.textContent = "\u{1F4A5}\u{1F4A3}\u{1F4A5}"; // explosions!
			clearInterval(interval); // stop animation there
	}
};

const toggleTableDarkMode = () => {
	// Apply class change to each th and td element
	th.forEach(h => h.classList.toggle("dark"));
	td.forEach(d => d.classList.toggle("dark"));
};

const toggleDarkMode = () => {
	// Triggered when dark mode checkbox is clicked
	for (const element of darkModeElements) {
		element.classList.toggle("dark");

		// == equality with type conversion, === types must match
		if (element === table) {
			toggleTableDarkMode();
		} else if (element === canvas) {
			const color = element.classList.contains("dark") ? "cyan" : "red";
			drawCircle(color);
		}
	}
};

const fetchJSON = async () => {
	// Network requests are asynchronous
	try {
		const response = await fetch("../JSON/how_to_json.json");
		const data = await response.json(); // JSON converts nicely to a JavaScript object
		console.log(data);
	} catch (err) {
		console.error(`Error: ${err}`);
	}
};

// Functions that get called on startup
const getCurrentDate = () => {
	// Display current date in the local time zone
	const date = new Date(); // new creates an object, w/o new is just a string
	// Format date string as Weekday, Month Day, Year
	const dateOptions = { weekday: "long", year: "numeric", month: "long", day: "numeric" };
	timeSpan.textContent = date.toLocaleDateString("en-US", dateOptions);
	// Format datetime as YYYY-MM-DD; regular year is year - 1900, month starts at 0
	let monthString = (date.getMonth() + 1).toString();
	// Month needs to be 2 digits
	if (monthString.length < 2) {
		monthString = 0 + monthString;
	}

	const datetime = `${date.getFullYear()}-${monthString}-${date.getDate()}`;
	timeSpan.dateTime = datetime;
};

const drawCircle = color => {
	const context = canvas.getContext("2d");
	context.clearRect(0, 0, canvas.width, canvas.height); // clear canvas first
	const center = { x: canvas.width / 2, y: canvas.height / 2 };

	context.beginPath();
	context.strokeStyle = color;
	context.arc(center.x, center.y, 100, 0, 2 * Math.PI); // x, y, radius, start & end angle
	context.fillStyle = color;
	context.fill();
	context.stroke();
};

// Print to the console with CSS styles
console.log("%cCongrats, you found the developer console! Type any JavaScript below.",
	"font-size: 1.5em; color: red");
getCurrentDate();
drawCircle("red");
fetchJSON();
