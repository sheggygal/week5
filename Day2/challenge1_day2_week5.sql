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

CREATE TABLE actors(
 actor_id SERIAL PRIMARY KEY,
 first_name VARCHAR (50) NOT NULL,
 last_name VARCHAR (100) NOT NULL,
 age DATE NOT NULL,
 number_oscars SMALLINT NOT NULL
)

INSERT INTO actors (first_name, last_name, age, number_oscars)
VALUES('Matt','Damon','08/10/1970', 5);

INSERT INTO actors (first_name, last_name, age, number_oscars)
VALUES('George','Clooney','06/05/1961', 2);

INSERT INTO actors (first_name, last_name, age, number_oscars) VALUES
('Meryl', 'Streep', TO_DATE('22/06/1949', 'DD/MM/YYYY'), 3),
('Leonardo', 'DiCaprio', TO_DATE('11/11/1974', 'DD/MM/YYYY'), 1);

SELECT COUNT(*) FROM actors;

-- Attempt to insert an actor with a blank first_name (NULL)
INSERT INTO actors (first_name, last_name, age, number_oscars) VALUES
(NULL, 'Smith', TO_DATE('15/05/1990', 'DD/MM/YYYY'), 0);

-- The outcome would be ERROR:  null value in column "last_name" violates not-null constraint


