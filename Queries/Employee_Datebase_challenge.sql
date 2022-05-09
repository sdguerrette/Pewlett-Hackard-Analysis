--Employee Database Challenge

--create table of retirement age employees and include their title
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--count number of employees set to retire by title
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

--create a table showing mentorship eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no,
				e.first_name,
				e.last_name,
				e.birth_date,
				de.from_date,
				de.to_date,
				t.title
INTO mentorship_eligibility
FROM employees as e
JOIN dept_emp as de
ON e.emp_no = de.emp_no
JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

--create table showing mentorship elible employees by title
SELECT COUNT(emp_no), title
--INTO mentorship_titles
FROM mentorship_eligibility
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

-- table showing only the high level titles of retiring employees
select * from retiring_titles
WHERE title IN ('Senior Engineer', 'Senior Staff', 'Technique Leader', 'Manager')

--create a table of retirement eligible employees by department
SELECT Distinct ON(u.emp_no) u.emp_no,
		u.first_name,
		u.last_name,
		u.title,
		d.dept_name
INTO retirement_departments
FROM unique_titles as u 
LEFT JOIN dept_emp as de
ON de.emp_no = u.emp_no
JOIN departments as d
on d.dept_no = de.dept_no
ORDER BY u.emp_no

--show total retirement counts by department
SELECT COUNT(emp_no), dept_name
INTO retiring_departments
FROM retirement_departments
GROUP BY dept_name
ORDER BY COUNT(emp_no) DESC

--create table that shows birth_date for retiring employees

SELECT rd.emp_no,
		rd.first_name,
		rd.last_name,
		rd.title,
		rd.dept_name,
		EXTRACT(YEAR FROM e.birth_date) as birth_year
INTO retirement_year
FROM retirement_departments as rd
LEFT JOIN employees as e
ON rd.emp_no = e.emp_no
ORDER BY e.birth_date 

--create table grouping by birth year
SELECT birth_year, COUNT(emp_no) as Employees 
FROM retirement_year
GROUP BY birth_year
ORDER BY birth_year

