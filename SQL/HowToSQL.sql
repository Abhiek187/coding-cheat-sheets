/* List of best-selling games
 * from the Microsoft Store
 */
-- Create
CREATE DATABASE IF NOT EXISTS HowToSQL;
USE HowToSQL;

CREATE TABLE IF NOT EXISTS games (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name TEXT NOT NULL,
	ratings INTEGER,
	price REAL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS reviews (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	game TEXT NOT NULL,
	day DATE,
	title TEXT,
	stars INTEGER NOT NULL,
	review TEXT
);

INSERT INTO games (name, ratings)
	VALUES ("Phantasy Star Online 2", 939);
INSERT INTO games (name, ratings, price)
	VALUES ("Minecraft", 57636, 29.99);
INSERT INTO games (name, ratings, price)
	VALUES ("ROBLOX", 1939, 0);
INSERT INTO games (name, ratings, price)
	VALUES ("Microsoft Flight Simulator", 51, 119.99);
INSERT INTO games (name, ratings, price)
	VALUES ("Candy Crush Soda Saga", 1996, 0);
INSERT INTO games (name, ratings, price)
	VALUES ("Caesars Casino", 1837, 0);

INSERT INTO reviews (game, day, title, stars, review)
	VALUES ("Phantasy Star Online 2", "2020-07-08", "garbage store", 1, "Microsoft store doesn't work for ****");
INSERT INTO reviews (game, day, title, stars, review)
	VALUES ("Phantasy Star Online 2", "2020-08-03", "Store issue", 5, "The game itself is amazing. It's just the Microsoft Store breaks the game sometimes");
INSERT INTO reviews (game, day, title, stars, review)
	VALUES ("Phantasy Star Online 2", "2020-07-24", "garbo", 1, "Deserves nothing more than one star if you give it more you are not very smart. That's why games don't get fixed. Worst launch in history lol. if I restart my pc it uninstalls the game Update: Still broken unfortunately, talked to Microsoft in a call and chat, even screen shared to get them to uninstall the game, after they failed (which led to another of many restores) they blamed sega for the issues, don't spend money like I did spend quite a bit and also just got prem because seemed like the game was fine then it broke again of course and now cant seem to play at all. ac is non refundable so ya know.");
INSERT INTO reviews (game, day, title, stars, review)
	VALUES ("Minecraft", "2020-08-14", "our family favorite", 5, "this game is awesome because I can play, and my 7 & 6 year old can play...and we all have fun!! They can play together or by themselves...but the best is that we can all 3 play together. It makes for hours of fun. The cross platform is great. I play on a laptop, 1 kid on a switch, the other kid on a tablet or ps4. It's the best hours of pass time during quarantine for us. Especially because the game doesn't get boring...you can build endlessly, or work for it in survival. This game actually even taught my 7 year old to read and write lol. From wanting to chat so bad, she eventually learned how to read it and type it. It boosts their creativity, and my youngest has gained confidence of being able to learn and teach mommy some things. I have not one bad thing to say!!");
INSERT INTO reviews (game, day, title, stars, review)
	VALUES ("Minecraft", "2020-08-12", "Minecraft a holy experience.", 5, "This game is the pure embodiment of heavenly light and holy entertainment. It must have be forged in the heart of a dying star. This game is the purest form of gaming to ever exist. I have been blessed to have received this game as a gift. Bless Mojang, Microsoft, Notch and every one who has ever worked on this game. I am honored to have played this game as it has changed my life for good. Thank you, and god bless you all.");
INSERT INTO reviews (game, day, title, stars, review)
	VALUES ("Minecraft", "2020-08-13", "Amazing", 5, "its better then fortnite");
INSERT INTO reviews (game, day, title, stars, review)
	VALUES ("ROBLOX", "2020-06-11", "VERY GOOD BUT SOME SMALL PROBLEMS", 5, "BEST GAME EVER I PLAY DID 3.5 HOURS EVERYDAY except I HATE the chat area you can't even type NUMBERS??!?!?!?!?!?!!");
INSERT INTO reviews (game, day, stars, review)
	VALUES ("ROBLOX", "2020-06-10", 5, "THERE IS NEVER BEST GAME AND PRO GAME!!!!!!");
INSERT INTO reviews (game, day, title, stars, review)
	VALUES ("ROBLOX", "2020-08-09", "AMAZING APP", 5, "I really like this game. It kills time and is really fun.");
INSERT INTO reviews (game, day, title, stars, review)
	VALUES ("Candy Crush Soda Saga", "2020-08-06", "Wonderful", 5, "Love it. Being home bound I play a lot.");
INSERT INTO reviews (game, day, stars, review)
	VALUES ("Candy Crush Soda Saga", "2020-07-30", 5, "fun");
INSERT INTO reviews (game, day, title, stars, review)
	VALUES ("Candy Crush Soda Saga", "2020-08-14", "Great Fun kinda got harder", 5, "Running out of turns lol");
INSERT INTO reviews (game, day, title, stars, review)
	VALUES ("Caesars Casino", "2019-06-18", "GOOD TIMES", 5, "FUN FUN FUN");
INSERT INTO reviews (game, day, stars, review)
	VALUES ("Caesars Casino", "2019-06-05", 5, "Great graphics");
INSERT INTO reviews (game, day, title, stars, review)
	VALUES ("Caesars Casino", "2019-05-19", "Can't win if you don't play!", 5, "The different slots or great!");

-- Read
SELECT * FROM games;
SELECT * FROM reviews
	LIMIT 5;

SELECT name, ratings AS "reviews"
	FROM games
	WHERE ratings BETWEEN 1000 AND 3000
	OR price = 0
	ORDER BY ratings DESC;
SELECT game, stars, review
	FROM reviews
	WHERE review LIKE "%great%";
SELECT game, COUNT(*) AS "total_reviews"
	FROM reviews
	GROUP BY game
	HAVING COUNT(*) > 0;
SELECT game, AVG(stars) AS "average_rating"
	FROM reviews
	GROUP BY game;

SELECT games.name, games.price, reviews.day, reviews.title, reviews.stars
	FROM games
	JOIN reviews -- inner join
	ON games.name = reviews.game
	WHERE title IS NOT NULL;

-- Update
UPDATE reviews
	SET stars = 3
	WHERE title = "Great Fun kinda got harder";

-- Delete
DELETE FROM reviews
	WHERE title IS NULL;

DROP TABLE games;
DROP TABLE reviews;
DROP DATABASE HowToSQL;
