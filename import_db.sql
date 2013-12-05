CREATE TABLE users (
	id INTEGER PRIMARY KEY,
	fname VARCHAR(255),
	lname VARCHAR(255)
);

CREATE TABLE questions (
	id INTEGER PRIMARY KEY,
	title VARCHAR(255),
	body VARCHAR(255),
	user_id INTEGER,

	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
	id INTEGER PRIMARY KEY,
	user_id INTEGER,
	question_id INTEGER,

	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
	id INTEGER PRIMARY KEY,
	user_id INTEGER,
	question_id INTEGER,
	parent_id INTEGER,
	body VARCHAR(255),

	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (parent_id) REFERENCES replies(id), --ask if this is foreign
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes(
	id INTEGER PRIMARY KEY,
	user_id INTEGER,
	question_id INTEGER,

	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE tags (
  id INTEGER PRIMARY KEY,
	body VARCHAR(255)
);

CREATE TABLE question_tags (
  id INTEGER PRIMARY KEY,
  tag_id INTEGER,
  question_id INTEGER,

  FOREIGN KEY (tag_id) REFERENCES tags(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);



INSERT INTO
	users (fname, lname)
VALUES
	('Eric', 'Robinson'),
	('Wenbo', 'Chang'),
	('New', 'User');

INSERT INTO
	questions (title, body, user_id)
VALUES
	('Ruby?', 'How do I Ruby?', 1),
	('Rubdgdfghy?', 'How do sgfdgsdfI Ruby?', 1),
	('SQL?', 'Query?', 2);

INSERT INTO
	question_followers (question_id, user_id)
VALUES
	(1, 2),
	(1, 1),
	(2, 2);

INSERT INTO
	replies (question_id, parent_id, user_id, body)
VALUES
	(1, NULL, 2, 'Good question.'),
	(1, 1, 1, 'I know, it is a good question.');

INSERT INTO
	question_likes (user_id, question_id)
VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(1,1),
	(1,1);

INSERT INTO
	tags (body)
VALUES
	('ruby');

INSERT INTO
  question_tags (tag_id, question_id)
VALUES
  (1, 1);


