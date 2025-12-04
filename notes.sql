-----------------------------
CREATE DATBASE shop_db;
USE shop_db;

CREATE TABLE users(
    ID INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(15) NOT NULL    ,
    last_name VARCHAR(15) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    credit DECIMAL,
    average_post_number FLOAT,
    created_at DATE,
    creation_time DATETIME,
    comment TEXT,
    status BOOLEAN DEFAULT 1,
);

-----------------------------
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE
);

INSERT IGNORE INTO users (email) VALUES (NULL);  -- ERROR: cannot be NULL
INSERT IGNORE INTO users (email) VALUES ('a@a.com');
INSERT IGNORE INTO users (email) VALUES ('a@a.com'); -- ERROR: duplicate entry
-----------------------------

CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    name VARCHAR(50)
);

INSERT INTO users (id, email, name)
VALUES (1, 'a@a.com', 'Alice');

INSERT INTO users (id, email, name)
VALUES (1, 'a@a.com', 'Alice Updated')
ON DUPLICATE KEY UPDATE
    name = VALUES(name);

-----------------------------
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    status VARCHAR(20) DEFAULT 'active'
);

INSERT INTO users (name, status) VALUES ('Alice', DEFAULT);
-----------------------------

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO users (name) VALUES
('Carol'),
('Alice'),
('Bob'),
('David');

SELECT * FROM users
ORDER BY name ASC
LIMIT 2;
-----------------------------

ALTER TABLE users
ADD COLUMN email VARCHAR(100) DEFAULT 'unknown@example.com';

ALTER TABLE users
MODIFY COLUMN name VARCHAR(100);

ALTER TABLE users
ADD CONSTRAINT unique_email UNIQUE (email);

ALTER TABLE users
DROP INDEX unique_email;

ALTER TABLE users
DROP COLUMN email;

-----------------------------
CREATE TABLE account (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    balance DECIMAL(10,2)
);

INSERT INTO account (name, balance) VALUES
('Alice', 50),
('Bob', 30),
('Carol', 20),
('Alice', 80);

SELECT COUNT(*) AS total_accounts FROM account;

SELECT COUNT(DISTINCT name) AS total_customers FROM account;

SELECT SUM(balance) AS total_amount FROM account;


SELECT AVG(balance) AS avg_amount FROM account;

SELECT MIN(balance) AS smallest_order,
       MAX(balance) AS largest_order
       
FROM account;

-----------------------------
DROP DATABASE test_db;
DROP DATABASE test_db;
-----------------------------
CREATE DATABASE test_db;
USE test_db;

CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    balance DECIMAL(10,2)
);

INSERT INTO accounts (name, balance) VALUES
('Alice', 50),
('Bob', 30),
('Carol', 20),
('Alice', 800);

START TRANSACTION; --ACID

UPDATE accounts SET balance = balance - 100 WHERE name='Alice';

UPDATE accounts SET balance = balance + 100 WHERE name='Bob';

COMMIT;
--If Transaction A updates a row, Transaction B trying to update the same row must wait until Transaction A commits or rolls back.
