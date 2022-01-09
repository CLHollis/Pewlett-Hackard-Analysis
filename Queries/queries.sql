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

-- delete table to make new one to add a column with a join
DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining departments and dept_manager tables
-- USING VARIABLES / ALIASES
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Create retirement_by_dept table for
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO retirement_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM retirement_by_dept

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no, first_name, last_name, gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM emp_info

SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
     AND (de.to_date = '9999-01-01');
	 
SELECT * FROM current_emp

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce ON (dm.emp_no = ce.emp_no);

SELECT 	ce.emp_no, ce.first_name, ce.last_name, d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d ON (de.dept_no = d.dept_no);

SELECT * FROM retirement_info

SELECT 	ce.emp_no, ce.first_name, ce.last_name
INTO sales_info
FROM current_emp as ce
INNER JOIN dept_emp AS de ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d ON (de.dept_no = d.dept_no)
WHERE d.dept_name='Sales';

-- Include retirees from Sales & Development depts 
--   to create new Mentors Department
SELECT 	ce.emp_no, ce.first_name, ce.last_name, d.dept_name
INTO mentor_info
FROM current_emp as ce
INNER JOIN dept_emp AS de ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d ON (de.dept_no = d.dept_no)
WHERE d.dept_name='Sales' OR d.dept_name='Development';

SELECT * FROM mentor_info