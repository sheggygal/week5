-- Database: bootcamp

-- DROP DATABASE IF EXISTS bootcamp;

CREATE DATABASE bootcamp
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Israel.1251'
    LC_CTYPE = 'English_Israel.1251'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Create the students table
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE
);

-- Insert data into the students table
INSERT INTO students (first_name, last_name, birth_date) VALUES
('Marc', 'Benichou', TO_DATE('02/11/1998', 'DD/MM/YYYY')),
('Yoan', 'Cohen', TO_DATE('03/12/2010', 'DD/MM/YYYY')),
('Lea', 'Benichou', TO_DATE('27/07/1987', 'DD/MM/YYYY')),
('Amelia', 'Dux', TO_DATE('07/04/1996', 'DD/MM/YYYY')),
('David', 'Grez', TO_DATE('14/06/2003', 'DD/MM/YYYY')),
('Omer', 'Simpson', TO_DATE('03/10/1980', 'DD/MM/YYYY'));

-- Insert your own data
INSERT INTO students (first_name, last_name, birth_date) VALUES
('Liudmila', 'Shegal', TO_DATE('23/06/1989', 'DD/MM/YYYY'));

-- Fetch all data from the table
SELECT * FROM students;

-- Fetch all students' first names and last names
SELECT first_name, last_name FROM students;

-- Fetch the student with ID equal to 2
SELECT first_name, last_name FROM students WHERE id = 2;

-- Fetch the student whose last name is 'Benichou' AND first name is 'Marc'
SELECT first_name, last_name FROM students WHERE last_name = 'Benichou' AND first_name = 'Marc';

-- Fetch students whose last names are 'Benichou' OR first names are 'Marc'
SELECT first_name, last_name FROM students WHERE last_name = 'Benichou' OR first_name = 'Marc';

-- Fetch students whose first names contain the letter 'a'
SELECT first_name, last_name FROM students WHERE first_name ILIKE '%a%';

-- Fetch students whose first names start with the letter 'a'
SELECT first_name, last_name FROM students WHERE first_name ILIKE 'a%';

-- Fetch students whose first names end with the letter 'a'
SELECT first_name, last_name FROM students WHERE first_name ILIKE '%a';

-- Fetch students whose second to last letter of their first names is 'a'
SELECT first_name, last_name FROM students WHERE first_name ILIKE '%a_';

-- Fetch students whose IDs are equal to 1 AND 3
SELECT first_name, last_name FROM students WHERE id IN (1, 3);

-- Fetch students whose birth dates are equal to or come after 1/01/2000 (show all their info)
SELECT * FROM students WHERE birth_date >= TO_DATE('01/01/2000', 'DD/MM/YYYY');