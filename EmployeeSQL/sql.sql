
CREATE TABLE departments (
  dept_no VARCHAR(10) PRIMARY KEY,
  dept_name VARCHAR(50) NOT NULL
);
SELECT * FROM departments;

CREATE TABLE titles (
  title_id VARCHAR(10) PRIMARY KEY,
  title VARCHAR(50) NOT NULL
);
SELECT * FROM titles;

CREATE TABLE employees (
  emp_no int PRIMARY KEY,
  emp_title_id VARCHAR(10) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(5) NOT NULL,
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);
SELECT * FROM employees;

CREATE TABLE dept_emp (
	fk_emp_no int NOT NULL,
	FOREIGN KEY (fk_emp_no) REFERENCES employees(emp_no),
	fk_dept_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (fk_dept_no) REFERENCES departments(dept_no)
);	
SELECT * FROM dept_emp;

CREATE TABLE dept_manager (
	fk_dept_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (fk_dept_no) REFERENCES departments(dept_no),
	fk_emp_no int NOT NULL,
	FOREIGN KEY (fk_emp_no) REFERENCES employees(emp_no)
);
SELECT * FROM dept_manager;

CREATE TABLE salaries(
fk_emp_no int NOT NULL,
	FOREIGN KEY (fk_emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL
);
SELECT * FROM salaries;

--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
	FROM employees e
	INNER JOIN salaries s
	ON (e.emp_no = s.fk_emp_no)
;
--List first name, last name, and hire date for employees who were hired in 1986
SELECT last_name, first_name, hire_date
FROM employees
where hire_date BETWEEN '1986-01-01' and '1986-12-31'
;
--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name 
FROM employees e
JOIN dept_manager l ON e.emp_no = l.fk_emp_no
JOIN departments d ON l.fk_dept_no = d.dept_no
ORDER BY e.last_name

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT d.dept_name, e.emp_no, e.last_name, e.first_name 
FROM employees e
JOIN dept_emp s ON e.emp_no = s.fk_emp_no
JOIN departments d ON s.fk_dept_no = d.dept_no
ORDER BY e.last_name

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
;

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT d.dept_name, e.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_emp s ON e.emp_no = s.fk_emp_no
JOIN departments d ON d.dept_no = s.fk_dept_no
WHERE d.dept_name = 'Sales'
ORDER BY e.last_name
;

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT d.dept_name, e.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_emp s ON e.emp_no = s.fk_emp_no
JOIN departments d ON d.dept_no = s.fk_dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY e.last_name
;

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT COUNT(emp_no), last_name
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

--1. Import the SQL database into Pandas. (Yes, you could read the CSVs directly in Pandas, but you are, after all, trying to prove your technical mettle.) This step may require some research. Feel free to use the code below to get started. Be sure to make any necessary modifications for your username, password, host, port, and database name:

--* Consult [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/latest/core/engines.html#postgresql) for more information.

--* If using a password, do not upload your password to your GitHub repository. See [https://www.youtube.com/watch?v=2uaTPmNvH0I](https://www.youtube.com/watch?v=2uaTPmNvH0I) and [https://help.github.com/en/github/using-git/ignoring-files](https://help.github.com/en/github/using-git/ignoring-files) for more information.

--2. Create a histogram to visualize the most common salary ranges for employees.

--3. Create a bar chart of average salary by title.

