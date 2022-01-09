--Deliverable 1 
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

-- Retrieve the number of employees by their most 
-- recent job title who are about to retire.
SELECT COUNT (ut.title) AS "count", ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;


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

