
-- Create new database


-- Create Tables ...Code from: Activities > 01 > Resources > schema.sql
DROP TABLE IF EXISTS actor;
DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS customer_list;
DROP TABLE IF EXISTS film;
DROP TABLE IF EXISTS film_actor;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS rental;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS store;


CREATE TABLE actor (
  actor_id integer NOT NULL,
  first_name character varying(45) NOT NULL,
  last_name character varying(45) NOT NULL,
  last_update timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE address (
  address_id integer NOT NULL,
  address character varying(50) NOT NULL,
  address2 character varying(50),
  district character varying(20) NOT NULL,
  city_id smallint NOT NULL,
  postal_code character varying(10),
  phone character varying(20) NOT NULL,
  last_update timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE city (
  city_id integer NOT NULL,
  city character varying(50) NOT NULL,
  country_id smallint NOT NULL,
  last_update timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE country (
    country_id integer NOT NULL,
    country character varying(50) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE customer (
  customer_id integer NOT NULL,
  store_id smallint NOT NULL,
  first_name character varying(45) NOT NULL,
  last_name character varying(45) NOT NULL,
  email character varying(50),
  address_id smallint NOT NULL,
  activebool boolean DEFAULT true NOT NULL,
  create_date date DEFAULT ('now'::text)::date NOT NULL,
  last_update timestamp without time zone DEFAULT now(),
  active integer
);

CREATE TABLE customer_list (
  id integer NOT NULL,
  name character varying(50) NOT NULL,
  address character varying(50) NOT NULL,
  zip_code character varying(10),
  phone character varying(20) NOT NULL,
  city character varying(50) NOT NULL,
  country character varying(50) NOT NULL,
  notes character varying(50) NOT NULL,
  sid integer NOT NULL
);

CREATE TABLE film (
  film_id integer NOT NULL,
  title character varying(255) NOT NULL,
  description text,
  release_year integer,
  language_id smallint NOT NULL,
  original_language_id smallint,
  rental_duration smallint DEFAULT 3 NOT NULL,
  rental_rate numeric(4,2) DEFAULT 4.99 NOT NULL,
  length smallint,
  replacement_cost numeric(5,2) DEFAULT 19.99 NOT NULL,
  rating TEXT,
  last_update timestamp without time zone DEFAULT now() NOT NULL,
  special_features text[],
  fulltext tsvector NOT NULL
);

CREATE TABLE film_actor (
  actor_id smallint NOT NULL,
  film_id smallint NOT NULL,
  last_update timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE inventory (
  inventory_id integer NOT NULL,
  film_id smallint NOT NULL,
  store_id smallint NOT NULL,
  last_update timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE payment (
  payment_id integer NOT NULL,
  customer_id smallint NOT NULL,
  staff_id smallint NOT NULL,
  rental_id integer NOT NULL,
  amount numeric(5,2) NOT NULL,
  payment_date timestamp without time zone NOT NULL
);

CREATE TABLE rental (
  rental_id integer NOT NULL,
  rental_date timestamp without time zone NOT NULL,
  inventory_id integer NOT NULL,
  customer_id smallint NOT NULL,
  return_date timestamp without time zone,
  staff_id smallint NOT NULL,
  last_update timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE staff (
  staff_id integer NOT NULL,
  first_name character varying(45) NOT NULL,
  last_name character varying(45) NOT NULL,
  address_id smallint NOT NULL,
  email character varying(50),
  store_id smallint NOT NULL,
  active boolean DEFAULT true NOT NULL,
  username character varying(16) NOT NULL,
  password character varying(40),
  last_update timestamp without time zone DEFAULT now() NOT NULL,
  picture bytea
);

CREATE TABLE store (
    store_id integer NOT NULL,
    manager_staff_id smallint NOT NULL,
    address_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);



SELECT * FROM actor LIMIT 100;
SELECT * FROM address LIMIT 100;
SELECT * FROM city LIMIT 100;
SELECT * FROM country LIMIT 100;
SELECT * FROM customer LIMIT 100;
SELECT * FROM customer_list LIMIT 100;
SELECT * FROM film LIMIT 100;
SELECT * FROM film_actor LIMIT 100;
SELECT * FROM inventory LIMIT 100;
SELECT * FROM payment LIMIT 100;
SELECT * FROM rental LIMIT 100;
SELECT * FROM staff LIMIT 100;
SELECT * FROM store LIMIT 100;



-- Copy code from: Activities > 01 > Resources > pagila-schema.sql
--   Paste into pgAdmin
--   Run


-- Copy code from: Activities > 01 > Resources > pagila-insert-data.sql
--   Paste into pgAdmin
--   Run


--ACTIVITY 2-----------------------------------------------------------------

-- Select everything from film table
SELECT * FROM film;

-- Count the amount of film_id's in film table
SELECT COUNT(film_id) FROM film;

-- Create an alias
SELECT COUNT(film_id) AS "Total films"
FROM film;

-- Group by rating and aggregate the film_id count
SELECT rating, COUNT(film_id) AS "Total films"
FROM film
GROUP BY rating;

-- Select the average rental duration
SELECT AVG(rental_duration)
FROM film;

-- Create an Alias
SELECT AVG(rental_duration) AS "Average rental period"
FROM film;

-- Group by the rental duration, average the rental rate and give alias
SELECT rental_duration, AVG(rental_rate) AS "Average rental rate"
FROM film
GROUP BY rental_duration;

-- Find the rows with the minimum rental rate
SELECT rental_duration, MIN(rental_rate) AS "Min rental rate"
FROM film
GROUP BY rental_duration;

-- Find the rows with the maximum rental rate
SELECT rental_duration, MAX(rental_rate) AS "Max rental rate"
FROM film
GROUP BY rental_duration;

--ACTIVITY 3---------------------------------------------------

-- 1. What is the average cost to rent a film in the Sakila stores?
SELECT AVG(rental_rate) AS "Average rental rate"
FROM film;

-- 2. What is the average rental cost of films by rating? On average, what is the cheapest rating of films to rent? Most expensive?
SELECT rating, AVG(rental_rate) AS "Average rental rate"
FROM film
GROUP BY rating;

-- 3. How much would it cost to replace all the films in the database?
SELECT SUM(replacement_cost) AS "Total replacement cost"
FROM film;

-- 4. How much would it cost to replace all the films in each ratings category?
SELECT rating, SUM(replacement_cost) AS "Replacement cost"
FROM film
GROUP BY rating;

-- 5. How long is the longest movie in the database? The shortest?
SELECT MAX(length)
FROM film;

--ACTIVITY 4-------------------------------------------------------------

-- Select average length of films and order by the average length
SELECT film_id, AVG(length)  AS "avg length" FROM film
GROUP BY film_id
ORDER BY "avg length";

-- Round the results to use only two decimal places
SELECT film_id, ROUND(AVG(length), 2)  AS "avg length" FROM film
GROUP BY film_id
ORDER BY "avg length";

-- Order by descending values
SELECT film_id, ROUND(AVG(length), 2)  AS "avg length" FROM film
GROUP BY film_id
ORDER BY "avg length" DESC;

-- Limit results to 5
SELECT film_id, ROUND(AVG(length), 2)  AS "avg length" FROM film
GROUP BY film_id
ORDER BY "avg length" DESC
LIMIT 5;

--ACTIVITY 5------------------------------------------------

-- Select count of actors first names in descending order ACTOR
-- Order by descending values
SELECT first_name, COUNT(first_name) AS "actor count"
FROM actor
GROUP BY first_name
ORDER BY "actor count" DESC;

-- Select the average duration of movies by rating FILM
SELECT rating, ROUND(AVG(rental_duration),2) AS "avg duration"
FROM film
GROUP BY rating
ORDER BY "avg duration";

-- Select top ten replace costs for the length of the movie FILM
SELECT length, ROUND(AVG(replacement_cost)) AS "avg cost"
FROM film
GROUP BY length
ORDER BY "avg cost" DESC
LIMIT 10;

-- Select the count of countries CITY
SELECT country.country, COUNT(country.country) AS "country count"
FROM city
JOIN country ON city.country_id = country.country_id
GROUP BY country.country
ORDER BY "country count" DESC;

--ACTIVITY 6------------------------------------------------

-- First select customer_id, inventory_id, and rental_date from the rental date and order by customer_id.
SELECT customer_id, inventory_id, rental_date
FROM rental
ORDER BY customer_id, rental_id DESC;

-- Using the previous query we add the DISTINCT statement to get the different values
SELECT DISTINCT customer_id, inventory_id, rental_date
FROM rental
ORDER BY rental_date;

-- Use Join to find the inventory, film and store id
SELECT DISTINCT customer_id, rental_date
FROM rental
WHERE customer_id = 130
ORDER BY rental_date;

-- Use DISTINCT ON and pass the customer_id in the parentheses to get each unique customer's latest rental date. 
SELECT DISTINCT ON (customer_id) customer_id, rental_date
FROM rental
ORDER BY customer_id, rental_date DESC;


--ACTIVITY 7------------------------------------------------

-- 1. Retreive the latest rental for each customer's first and last name and emial address. 

SELECT DISTINCT ON (r.customer_id) c.first_name, c.last_name, c.email, r.rental_date 
FROM rental AS r
JOIN customer AS c 
ON (r.customer_id=c.customer_id)
ORDER BY r.customer_id, r.rental_date DESC;


-- 2. Retrieve the latest rental date for each title. 

SELECT DISTINCT ON (f.title ) f.title, r.rental_date
FROM rental AS r
JOIN inventory as i
ON (i.inventory_id = r.inventory_id)
JOIN film as f
ON (f.film_id = i.film_id)
ORDER BY f.title, r.rental_date DESC;

-- Bonus:
-- Query 2 only returned 958 movies, which means 42 movies are not being rented. 
-- We know that there are 1,000 movies in the `film` table. 
-- Retrieve the film titles of the 42 movies that are not in the `inventory` table. 

SELECT film_id, title
FROM film 
WHERE film_id NOT IN
  (SELECT film_id 
   FROM inventory);

