-- Database: dvdrental

-- DROP DATABASE IF EXISTS dvdrental;

CREATE DATABASE dvdrental
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Israel.1251'
    LC_CTYPE = 'English_Israel.1251'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

--List of languages
SELECT language_id, name
FROM language;

--List of all films joined with their languages – select the following details : film title, description, and language name
SELECT 
    f.title AS film_title,
    f.description AS film_description,
    l.name AS language_name
FROM 
    film f
JOIN 
    language l ON f.language_id = l.language_id;

--All languages, even if there are no films in those languages
SELECT 
    f.title AS film_title,
    f.description AS film_description,
    l.name AS language_name
FROM 
    language l
LEFT JOIN 
    film f ON l.language_id = f.language_id;

--Create a new table called new_film
CREATE TABLE new_film (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT INTO new_film (name) VALUES
('Trainspotting'),
('Jaws'),
('Shining');

CREATE TABLE customer_review (
    review_id SERIAL PRIMARY KEY,
    film_id INTEGER REFERENCES new_film(id) ON DELETE CASCADE,
    language_id INTEGER REFERENCES language(language_id),
    title VARCHAR(255),
    score INTEGER CHECK (score >= 1 AND score <= 10),
    review_text TEXT,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customer_review (film_id, language_id, title, score, review_text)
VALUES 
(1, 1, 'Great Trainspotting', 9, 'This film was amazing! Highly recommended.'),
(2, 1, 'Good Jaws', 7, 'Enjoyed watching Jaws. It was entertaining.'),
(3, 1, 'Disappointing Shining', 4, 'Shining did not meet my expectations. Disappointed with the storyline.');

--Delete one of the films, review disappears
DELETE FROM new_film WHERE id = 1;
SELECT*
FROM customer_review





