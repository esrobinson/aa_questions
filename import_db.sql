CREATE TABLE users (
	id INTEGER PRIMARY KEY,
	fname VARCHAR(255),
	lname VARCHAR(255)
);

CREATE TABLE questions (
	id INTEGER PRIMARY KEY,
	title VARCHAR(255),
	body VARCHAR(255),
	user_id INTEGER
);

CREATE TABLE question_followers (
	id INTEGER PRIMARY KEY,
	question_id INTEGER,
	user_id INTEGER
);

CREATE TABLE replies (
	id INTEGER PRIMARY KEY,
	question_id INTEGER,
	parent_id INTEGER,
	user_id INTEGER,
	body VARCHAR(255)
);

CREATE TABLE question_likes(
	id INTEGER PRIMARY KEY,
	question_id INTEGER,
	user_id INTEGER
);