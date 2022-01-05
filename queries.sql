-- List all the names of the people born from 1952-1955.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- How many employees were born 1952-1955?
SELECT COUNT (first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- How many employees were born in 1952
SELECT COUNT (first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- How many employees were born in 1953?
SELECT COUNT (first_name)
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- How many employees were born in 1954?
SELECT COUNT (first_name)
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- How many employees were born in 1955?
SELECT COUNT (first_name)
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Narrow query: Add filter/conditional for specific hiring range 1985-1988.
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Get number of employees retiring born 1952-1955 & hired 1985-1988
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create table called "retirement_info" to export & save:
--   employees retiring born 1952-1955 & hired 1985-1988.
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info