-------- Deliverable 1 ------------------

--  Using the ERD you created in this module as a reference and
--  your knowledge of SQL queries, create a Retirement Titles 
--  table that holds all the titles of employees who were born between 
--  January 1, 1952 and December 31, 1955. Because some employees may 
--  have multiple titles in the database—for example, due to promotions—
--  you’ll need to use the DISTINCT ON statement to create a table that 
--  contains the most recent title of each employee. Then, use the COUNT()
--  function to create a table that has the number of retirement-age 
--  employees by most recent job title. Finally, because we want to include 
--  only current employees in our analysis, be sure to exclude those 
--  employees who have already left the company.

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles

--  There are duplicate entries for some employees because they 
--  have switched titles over the years. Use the following 
--  instructions to remove these duplicates and keep only the most 
--  recent title of each employee.

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) 
					rt.emp_no, 
					rt.first_name, 
					rt.last_name, 
					rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles

-- Retrieve the number of employees by their most 
-- recent job title who are about to retire.
SELECT COUNT (ut.title) AS "count", ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;

SELECT * FROM retiring_titles

------ DELIVERABLE 2 -------

-- Create a mentorship-eligibility table that holds the current 
-- employees who were born between 1/1/1965 and 12/31/1965.

SELECT DISTINCT ON (e.emp_no)	
		e.emp_no, e.first_name, e.last_name, e.birth_date, 
		de.from_date, de.to_date,
		t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
INNER JOIN titles as t ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibilty










EDITING

-- #1-7

DROP TABLE retirement_titles;

SELECT 	e.emp_no, e.first_name, e.last_name, 
		t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- #8-15
DROP TABLE unique_titles;

SELECT DISTINCT ON (rt.emp_no) 
					rt.emp_no, 
					rt.first_name, 
					rt.last_name, 
					rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles;

----GOOG TIL HERE------------------------------------------

-- #16-21
-- 16.Write another query in the Employee_Database_challenge.sql file to 
--    retrieve the number of employees by their most recent job title who 
--    are about to retire.

DROP TABLE retiring_titles;

-- 17. First, retrieve the number of titles from the Unique Titles table.
SELECT COUNT (ut.first_name) AS "count", ut.title
--INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;

SELECT * FROM retiring_titles


SELECT COUNT(first_name)   
FROM employees as e   
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')  
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

------ DELIVERABLE 2 -------

-- Create a mentorship-eligibility table that holds the current 
-- employees who were born between 1/1/1965 and 12/31/1965.

SELECT DISTINCT ON (e.emp_no)	
		e.emp_no, e.first_name, e.last_name, e.birth_date, 
		de.from_date, de.to_date,
		t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
INNER JOIN titles as t ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibilty