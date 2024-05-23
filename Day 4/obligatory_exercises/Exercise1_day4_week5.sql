-- Database: actors

-- DROP DATABASE IF EXISTS actors;

CREATE DATABASE actors
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Israel.1251'
    LC_CTYPE = 'English_Israel.1251'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    price INT
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);

INSERT INTO items (name, price) VALUES
('Small Desk', 100),
('Large Desk', 300),
('Fan', 80);

INSERT INTO customers (firstname, lastname) VALUES
('Greg', 'Jones'),
('Sandra', 'Jones'),
('Scott', 'Scott'),
('Trevor', 'Green'),
('Melanie', 'Johnson');

-- All items, ordered by price (lowest to highest)
SELECT *
FROM items
ORDER BY price ASC;

--Items with a price above 80 (80 included), ordered by price (highest to lowest)
SELECT *
FROM items
WHERE price >= 80
ORDER BY price DESC;

--The first 3 customers in alphabetical order of the first name (A-Z)
SELECT firstname, lastname
FROM customers
ORDER BY firstname ASC
LIMIT 3;

--All last names (no other columns!), in reverse alphabetical order (Z-A)
SELECT lastname
FROM customers
ORDER BY lastname DESC;
