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

-- Update the language of film with film_id 1 to English
UPDATE film
SET language_id = 1
WHERE film_id = 1;

-- Update the language of film with film_id 2 to Spanish
UPDATE film
SET language_id = 2
WHERE film_id = 2;

-- FK is adress_id.  When inserting data into the customer table, we must ensure that the values we insert into the foreign key columns (address_id) exist in the referenced tables. Attempting to insert data with foreign key values that do not exist in the referenced tables will result in a foreign key constraint violation error.

--Drop custumer_ reviews.  It's important to ensure that there are no unintended consequences, especially if the table contains valuable data or if there are dependencies on the table that could be affected.
DROP TABLE customer_review;

--Not returned DVDs
SELECT COUNT(*)
FROM rental
WHERE return_date IS NULL;

--Find outstandinf gilms
SELECT 
    f.title AS film_title,
    f.rental_rate AS rental_rate
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
WHERE 
    r.return_date IS NULL
ORDER BY 
    f.rental_rate DESC
LIMIT 30;

--Friend queery1
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE f.description ILIKE '%sumo wrestler%'
  AND (a.first_name || ' ' || a.last_name) ILIKE '%Penelope Monroe%';

-- Friend queery 2
SELECT title
FROM film
WHERE length < '60' 
  AND rating = 'R'
	AND description ILIKE '%documentary%';

--Friend queeery 3
SELECT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE c.first_name = 'Matthew'
  AND c.last_name = 'Mahan'
  AND p.amount > 4.00
  AND r.return_date BETWEEN '2005-07-28' AND '2005-08-01';

--Friend queery 4
SELECT title
FROM film
WHERE (title ILIKE '%boat%' OR description ILIKE '%boat%')
  AND film_id IN (
    SELECT film_id
    FROM rental
    WHERE customer_id = (
        SELECT customer_id
        FROM customer
        WHERE first_name = 'Matthew'
        AND last_name = 'Mahan'
      )
  )
ORDER BY replacement_cost DESC;




















