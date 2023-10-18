-- Data Manipulation Language (DML)

-- Add a row of data to a table
-- Syntax: INSERT INTO table_name(col_name_1, col_name_2, etc) VALUES (val_1, val_2, etc)

SELECT *
FROM blog_user;


INSERT INTO blog_user(
	username,
	password_hash,
	email_address,
	first_name,
	last_name
) VALUES (
	'brians',
	'ldsjkfhdsjkfhdsjkfh',
	'brians@codingtemple.com',
	'Brian',
	'Stanton'
);

SELECT *
FROM blog_user;

SELECT nextval('blog_user_user_id_seq');

-- Insert another user
-- ORDER MATTERS!
INSERT INTO blog_user(
	last_name,
	password_hash,
	middle_name,
	email_address,
	username,
	first_name
) VALUES (
	'Stodder',
	'vnidslfjioejfkdsl',
	'Awesome',
	'sarahs@codingtemple.com',
	'sstodder',
	'Sarah'
);

SELECT *
FROM blog_user;


SELECT *
FROM category;

-- Insert Values Only
-- Syntax: INSERT INTO table_name VALUES (val_1, val_2, etc)
-- Follows the original order that the columns were added
INSERT INTO category VALUES (
	1, 
	'Business', 
	'A bunch of suits talking about boring things'
);

SELECT *
FROM category;


-- Because we put in the first category with the manual entry of ID 1, the serial default did not call
-- nextval on the sequence, so it will *initially throw an error if we try to insert a new category.
INSERT INTO category (
	category_name, 
	description 
) VALUES (
	'Programming',
	'Cool good looking people talking about interesting things'
);

SELECT *
FROM category;


-- Insert Multiple rows of data in one command
-- Syntax: INSERT INTO table_name(col_1, col_2, etc) VALUES (val_a_1, val_a_2, etc), (val_b_1, val_b_2, etc.)
SELECT *
FROM post;

INSERT INTO post(
	title,
	body,
	user_id
) VALUES (
	'Hello World', 
	'This is the body of the post.',
	1
),(
	'Another Post', 
	'Here is another post in the post table.',
	1
),(
	'Hump Day!',
	'Happy Wednesday my dudes!',
	5
);

SELECT *
FROM post;


-- Try to add a post with a user that does not exist
--INSERT INTO post(
--	title, 
--	body, 
--	user_id
--) VALUES (
--	'Hi', 
--	'Will this work?', 
--	123 -- blog_user WITH ID 123 does not exist! will throw an error
--);

INSERT INTO blog_user(
	username,
	password_hash,
	email_address,
	first_name,
	last_name 
) VALUES (
	'mickey',
	'dsfkdshfkdsfjk',
	'mickey.mouse@disney.com',
	'Mickey',
	'Mouse'
),(
	'minnie',
	'dklsfhjsdklfhkdl;fjds',
	'minnie.mouse@disney.com',
	'Minnie',
	'Mouse'
);

SELECT *
FROM blog_user;

-- To update existing data in a table
-- Syntax: UPDATE table_name SET col_1 = val_1, col_2 = val_2, etc. WHERE condition

UPDATE blog_user
SET middle_name = 'Danger'
WHERE user_id = 1;

SELECT *
FROM blog_user;


UPDATE blog_user
SET middle_name = 'The'
WHERE email_address LIKE '%disney.com';


SELECT *
FROM category;

-- Alter the category table to add a color column
ALTER TABLE category
ADD COLUMN color VARCHAR(7);


-- An UPDATE/SET without a WHERE, all of the rows are updated
UPDATE category
SET color = '#db6e14';

SELECT *
FROM category;

-- Set multiple columns in one command
SELECT *
FROM post;

UPDATE post
SET title = 'Updated Title', body = 'This is the updated body'
WHERE post_id = 5;

SELECT *
FROM post
ORDER BY post_id;


-- DELETE

-- Syntax: DELETE FROM table_name WHERE condition
-- WHERE is not required but HIGHLY RECOMMENDED *without WHERE every row will be deleted

SELECT *
FROM blog_user
ORDER BY user_id;

DELETE FROM blog_user
WHERE user_id >= 6;

SELECT *
FROM blog_user;

-- A DELETE FROM without a WHERE will delete all rows
SELECT *
FROM category;

DELETE FROM category;


SELECT *
FROM post;

DELETE FROM blog_user
WHERE user_id = 5;


-- To make it so that when we delete a row, it will delete any rows in related tables that reference that row
-- We will add ON DELETE CASCADE to the foreign key constraint

ALTER TABLE post 
DROP CONSTRAINT post_user_id_fkey;

ALTER TABLE post 
ADD FOREIGN KEY(user_id) REFERENCES blog_user(user_id) ON DELETE CASCADE;


SELECT *
FROM blog_user;
SELECT *
FROM post;

DELETE FROM blog_user
WHERE user_id = 5;

SELECT *
FROM blog_user;

SELECT *
FROM post;