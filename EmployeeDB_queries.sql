DROP TABLE retirement_info

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

--Joining departments and dept_managers tabels
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments AS d
JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no;

--join retirement_info and dept_emp tables to get retirement eligible
--employess who still work for the company
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no



--join retirement_info table to dept_emp table
SELECT ri.emp_no, 
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01')

--employee count by department number
SELECT de.dept_no, COUNT(ce.emp_no)
INTO dept_retirement_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- create employee_info table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e 
INNER JOIN salaries as s
	ON e.emp_no = s.emp_no
INNER JOIN dept_emp as de
	on de.emp_no = e.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');

-- create management table
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager as dm
	INNER JOIN departments as d
		on dm.dept_no = d.dept_no
	INNER JOIN current_emp as ce
		on dm.emp_no = ce.emp_no;
-- list of department retirees
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
	INNER JOIN dept_emp as de
		ON ce.emp_no = de.emp_no
	INNER JOIN departments as d
		ON d.dept_no = de.dept_no;

--create sales list
SELECT *
INTO sales_dev_info
FROM dept_info
WHERE dept_name IN ('Sales', 'Development')
ORDER BY dept_name





