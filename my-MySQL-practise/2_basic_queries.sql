USE company;          -- select the database
SHOW TABLES;          -- display the list of tables in that database
DESC employee;        -- give details about a table

# Basics -----------------------------------------------------------------------------------------------------------------------
-- Display full table
SELECT * FROM employee;
SELECT * FROM bonus;

-- Count no. of rows in a table.
SELECT COUNT(*) FROM employee;

-- Display specific columns
SELECT first_name, last_name, department FROM employee;
SELECT department, last_name, first_name, city FROM employee;     -- can rearrange the columns however you want


# LIMIT, OFFSET
/* 'LIMIT' and 'OFFSET' clauses are used to control the number of rows 
returned by a SELECT query and to specify the starting point for retrieving those rows.
- The 'LIMIT' clause restricts the maximum number of rows returned by a query.
- The 'OFFSET' clause specifies the number of rows to skip from the beginning of the result set before starting to return rows.*/
-- Display first 5 Records of table
SELECT * FROM employee LIMIT 5;

-- Display first 5 Records of table from the second row
SELECT * FROM employee LIMIT 5 OFFSET 1;


# ALIASING ------------------------------------------------------------------------------------------------------------------------
SELECT first_name AS employee_name from employee;

SELECT
	emp_id AS col_1,
    first_name AS col_2,
    last_name AS col_3,
    salary AS col_4,
    joining_date AS col_5,
    department AS col_6,
    city AS col_7
FROM
	employee;


# WHERE clause ---------------------------------------------------------------------------------------------------------------
/* used to filter records based on specified conditions to only those that satisfy the given criteria.*/
SELECT * FROM employee WHERE first_name = 'Nikhil'; 
SELECT * FROM employee WHERE department = 'HR';


# IN, NOT IN ---------------------------------------------------------------------------------------------------------------
/* The SQL 'IN' and 'NOT IN' operators are used to filter results 
based on whether a value matches or does not match any value in a specified list or subquery.*/
SELECT * FROM employee WHERE first_name IN ('Amitabh', 'Rajesh', 'Satish', 'Raj', 'Gita');
SELECT * FROM employee WHERE first_name NOT IN ('Amitabh', 'Rajesh', 'Satish', 'Raj', 'Gita');


# LIKE, NOT LIKE ---------------------------------------------------------------------------------------------------------------
SELECT * FROM employee WHERE last_name LIKE 'Kumar';
SELECT * FROM employee WHERE city NOT LIKE 'Mumbai';

# LIKE and WILDCARD ---------------------------------------------------------------------------------------------------------------
/* SQL wildcards are special characters used with 
the LIKE operator in the WHERE clause to search for 
specific patterns within string data in a database.
- '%' (Percent Sign): Represents zero or more characters.
- '_' (Underscore): Represents a single character.*/
SELECT * FROM employee WHERE first_name LIKE '%e%';      -- whose name contains 'e' 
SELECT * FROM employee WHERE first_name LIKE '%a';       -- whose name ends with 'a' 
SELECT * FROM employee WHERE first_name LIKE '_i%';      -- whose name's second letter is 'i' 
SELECT * FROM employee WHERE first_name LIKE '_i%l';     -- whose name's second letter is 'i' and ends with 'l'
SELECT * FROM employee WHERE first_name LIKE '_____l';   -- whose names have 6 letters and ends with 'l' (6 underscores)
SELECT * FROM employee WHERE last_name LIKE 'S%';        -- whose last name begins with 'S' 
SELECT * FROM employee WHERE last_name LIKE '_____';     -- whose last name contains 5 characers (5 underscores) 


# DISTINCT ---------------------------------------------------------------------------------------------------------------
-- Display Unique Department Values
SELECT DISTINCT department FROM employee;

-- Display Unique First Names and their lengths
SELECT 
	DISTINCT first_name AS name_of_emp, 
    LENGTH(first_name) AS chars 
FROM employee;

-- Counting Distinct departments
SELECT COUNT(department) AS depts FROM employee;          -- will simply count the no. of rows in the table causing count of repetitions as well
SELECT COUNT(DISTINCT(department)) AS unique_depts FROM employee;

-- Counting Distinct last names
SELECT COUNT(DISTINCT last_name) AS unique_lastnames FROM employee;


# ORDER BY clause ---------------------------------------------------------------------------------------------------------------
/* used to sort the result set of a SELECT statement based on one or more columns 
in a specific order, either ascending (ASC) or descending (DESC). Default is ASC*/
-- order table records by employee first name
SELECT * FROM employee ORDER BY first_name;

-- Display only last 5 Records of a Table.
SELECT * FROM employee ORDER BY emp_id DESC LIMIT 5;

-- Display last record of the table.
SELECT * FROM employee ORDER BY emp_id DESC LIMIT 1;

-- Display second-last record of the table.
SELECT * FROM employee ORDER BY emp_id DESC LIMIT 1 OFFSET 1;


# LOGICAL OPERATORS for multiple conditions (AND, OR, NOT)------------------------------------------------------------------------------------------
SELECT * FROM employee WHERE city = 'Bangalore' AND department = 'Account';   -- employees from Bangalore city working in Accounts dept
SELECT * FROM employee WHERE city = 'Mumbai' OR department = 'IT';            -- employees either from Mumbai city or in IT dept or both
SELECT * FROM employee WHERE NOT city = 'Pune' AND NOT department  = 'Admin'; -- employees neither from Pune city nor in Admin dept
SELECT * FROM employee WHERE department = 'IT' AND salary >= 200000;          -- employees of IT dept with salary more than or equal to 2 Lakhs
SELECT * FROM employee WHERE city = 'Mumbai' AND department IN ('HR', 'IT');  -- employees from Mumbai city but only of HR and IT dept 


# TEXT -------------------------------------------------------------------------------------------------------------------------------
-- names in Upper case
SELECT 
	upper(first_name) AS F_Name, 
    upper(last_name) AS L_Name
FROM employee;

SELECT REVERSE(first_name) FROM employee;

-- first 3 characters of the First Name.
SELECT LEFT(first_name, 3) FROM employee;
SELECT SUBSTR(first_name, 1, 3) FROM employee;
SELECT SUBSTRING(first_name, 1, 3) AS nickname FROM employee;
 
-- Combine First name and Last name into Full Name
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employee;
SELECT first_name || ' ' || last_name AS full_name FROM employee;  
/* the || method does not work because in MySQL, the operator || does NOT mean string concatenation.
It is treated as the logical OR operator, just like in programming languages.*/

-- Replace 'a' with '@'
SELECT REPLACE(first_name, 'a', '@') FROM employee;

-- position of Alphabet 'a' in the First Name.
SELECT first_name, INSTR(first_name, 'a') FROM employee;     -- give position of first occurence in case of repetition
SELECT first_name, POSITION('a' IN first_name) FROM employee;

/* more: TRIM, LTRIM, RTRIM - used to remove unnecessary spaces*/


# MATHEMATICAL ---------------------------------------------------------------------------------------------------------------
-- SQL Aggregate Functions
SELECT SUM(salary) AS total_salary FROM employee;
SELECT MAX(salary) AS highest FROM employee;
SELECT MIN(salary) AS lowest FROM employee;
SELECT AVG(salary) AS avg_salary FROM employee;
SELECT ROUND(AVG(salary), 1) AS avg_salary FROM employee;

SELECT department, SUM(salary) AS HR_cost FROM employee WHERE department = 'HR';
SELECT city, MAX(salary) AS Mumbai_highest FROM employee WHERE city = 'Mumbai';

-- Write SQL Query to Show Only Odd Rows from a Table.
SELECT * FROM employee WHERE emp_id % 2 != 0;
SELECT * FROM employee WHERE emp_id % 2 <> 0;

-- Write SQL Query to Show Only Even Rows from a Table.
SELECT * FROM employee WHERE emp_id % 2 = 0;

-- Display employees info whose Salary is between 200000 & 400000
SELECT * FROM employee WHERE salary BETWEEN 200000 AND 400000;

-- Fetch employee full names whose Salaries is between 50000 to 100000
SELECT CONCAT(first_name, ' ', last_name) AS employee_name, salary
FROM employee
WHERE salary BETWEEN 50000 AND 100000
ORDER BY salary;

# DATE and TIME ---------------------------------------------------------------------------------------------------------------
-- Some Basic Date and Time functions.
SELECT curdate();
SELECT current_date();

SELECT curtime();
SELECT current_time();

SELECT current_timestamp();
SELECT NOW()AS Right_Now;

select * from employee;

-- employees who joined in Jan 2025.
SELECT * FROM employee WHERE YEAR(joining_date) = 2025 AND MONTH(joining_date) = 1;

-- employees who joined before 2024.
SELECT * FROM employee WHERE YEAR(joining_date) < 2024 ORDER BY joining_date;
