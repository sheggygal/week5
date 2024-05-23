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

--All the columns from the “customer” table
SELECT *
FROM customer;

--Display the names (first_name, last_name) using an alias named “full_name”
SELECT 
    first_name || ' ' || last_name AS full_name
FROM 
    customer;

--All the dates that accounts were created
SELECT DISTINCT create_date
FROM customer;

--All the customer details from the customer table, displayed in descending order by their first name
SELECT *
FROM customer
ORDER BY first_name DESC;

-- Film ID, title, description, year of release and rental rate in ascending order according to their rental rate
SELECT film_id, title, description, release_year, rental_rate
FROM film
ORDER BY rental_rate ASC;

--Get the address, and the phone number of all customers living in the Texas district
SELECT a.address, a.phone
FROM customer c
JOIN address a ON c.address_id = a.address_id
WHERE a.district = 'Texas';

--All movie details where the movie id is either 15 or 150
SELECT *
FROM film
WHERE film_id IN (15, 150);

-- If your favorite movie exists in the database
SELECT film_id, title, description, length, rental_rate
FROM film
WHERE title = 'Trainspotting';

--Get the film ID, title, description, length and the rental rate of all the movies starting with the two first letters 
SELECT film_id, title, description, length, rental_rate
FROM film
WHERE LEFT(title, 2) = LEFT('Trainspotting', 2);

--10 cheapest moovies
SELECT film_id, title, rental_rate
FROM film
ORDER BY rental_rate ASC
LIMIT 10;

--11 - 20 cheapest moovies 
SELECT film_id, title, rental_rate
FROM film
WHERE rental_rate NOT IN (
    SELECT rental_rate
    FROM film
    ORDER BY rental_rate ASC
    LIMIT 10
)
ORDER BY rental_rate ASC
LIMIT 10;

--Join the data in the customer table and the payment table
SELECT 
    c.first_name,
    c.last_name,
    p.amount,
    p.payment_date
FROM 
    customer c
JOIN 
    payment p ON c.customer_id = p.customer_id
ORDER BY 
    p.payment_id;

--Get all the movies which are not in inventory
SELECT f.*
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE i.inventory_id IS NULL;

--Which city is in which country
SELECT c.city, co.country
FROM city c
JOIN country co ON c.country_id = co.country_id;

--get the customer’s id, names (first and last), the amount and the date of payment ordered by the id of the staff member who sold them the dvd
SELECT 
    c.customer_id,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    p.amount,
    p.payment_date,
    s.staff_id
FROM 
    customer c
JOIN 
    payment p ON c.customer_id = p.customer_id
JOIN 
    staff s ON p.staff_id = s.staff_id
ORDER BY 
    s.staff_id;









