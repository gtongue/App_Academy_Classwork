DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INT NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)

);

INSERT INTO
  users(fname, lname)
VALUES
  ('Edward', 'Bai'),
  ('Garrett', 'Tongue');

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('Question', 'BODY', (SELECT id FROM users WHERE fname = 'Edward')),
  ('Question', '?!', (SELECT id FROM users WHERE fname = 'Garrett')),
  ('Question', '?!', (SELECT id FROM users WHERE fname = 'Garrett')),
  ('Question', '?!', (SELECT id FROM users WHERE fname = 'Garrett'));

INSERT INTO
  replies(question_id, reply_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'Question'), NULL,
  (SELECT id FROM users WHERE fname = 'Garrett'), 'hadhoaisdg'),
  ((SELECT id FROM questions WHERE title = 'Question'), 1,
  (SELECT id FROM users WHERE fname = 'Garrett'), 'reworh');

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  (1, 1),
  (2, 1);

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (1, 1),
  (2, 1),
  (2, 2);
