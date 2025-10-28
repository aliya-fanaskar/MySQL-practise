USE company;          -- select the database
SHOW TABLES;          -- display the list of tables in that database


# Basics -----------------------------------------------------------------------------------------------------------------------
-- Display full table
SELECT * from worker;

-- Display specific columns
SELECT first_name, last_name, department from worker;


# LIMIT, OFFSET
-- Display first 5 Records of table
SELECT * FROM worker LIMIT 5;

-- Display first 5 Records of table from the second row
SELECT * FROM worker LIMIT 5 OFFSET 1;


# ALIASING ------------------------------------------------------------------------------------------------------------------------
SELECT first_name AS worker_name from worker;

SELECT
	worker_id AS col_1,
    first_name AS col_2,
    last_name AS col_3,
    salary AS col_4,
    joining_date AS col_5,
    department AS col_6,
    city AS col_7
FROM
	worker;


# WHERE clause ---------------------------------------------------------------------------------------------------------------
SELECT * FROM worker WHERE first_name = 'Amitabh'; 
SELECT * FROM worker WHERE department = 'HR';


# IN, NOT IN ---------------------------------------------------------------------------------------------------------------
SELECT * FROM worker WHERE first_name IN ('Amitabh', 'Monika', 'Satish', 'Sangita');
SELECT * FROM worker WHERE first_name NOT IN ('Amitabh', 'Monika', 'Satish', 'Sangita');


# LIKE, NOT LIKE ---------------------------------------------------------------------------------------------------------------
SELECT * FROM worker WHERE first_name LIKE 'Monika';
SELECT * FROM worker WHERE city NOT LIKE 'Mumbai';

# LIKE and WILDCARD ---------------------------------------------------------------------------------------------------------------
SELECT * FROM worker WHERE first_name LIKE '%e%';      -- whose name contains 'e' 
SELECT * FROM worker WHERE first_name LIKE 'S%';       -- whose name begin with 'S' 
SELECT * FROM worker WHERE first_name LIKE '%a';       -- whose name ends with 'a' 
SELECT * FROM worker WHERE first_name LIKE '_i%';      -- whose name's second letter is 'i' 
SELECT * FROM worker WHERE first_name LIKE '_i%l';     -- whose name's second letter is 'i' and ends with 'l'
SELECT * FROM worker WHERE first_name LIKE '_____l';   -- whose names have 6 letters and ends with 'l'


# UNIQUE values ---------------------------------------------------------------------------------------------------------------
-- Display Unique Department Values
SELECT DISTINCT department FROM worker;

-- Display Unique Departments and their lengths
SELECT 
	DISTINCT department AS dept, 
    LENGTH(department) AS chars 
FROM worker;

-- Counting Distinct departments
SELECT COUNT(department) AS depts FROM worker;          -- will simply count the no. of rows in the table causing count of repetitions as well
SELECT COUNT(DISTINCT(department)) AS unique_depts FROM worker;

-- Counting Distinct surnames
SELECT COUNT(DISTINCT last_name) AS unique_lastnames FROM worker;


# ORDER BY clause ---------------------------------------------------------------------------------------------------------------
-- order table records by worker name
SELECT * FROM worker ORDER BY first_name ASC;

-- Display only last 5 Records of a Table.
SELECT * FROM worker ORDER BY worker_id DESC LIMIT 5;

-- Display only last record of the table.
SELECT * FROM worker ORDER BY worker_id DESC LIMIT 1;

-- Display only second-last record of the table.
SELECT * FROM worker ORDER BY worker_id DESC LIMIT 1 OFFSET 1;


# LOGICAL OPERATORS for multiple conditions ------------------------------------------------------------------------------------------
SELECT * FROM worker WHERE city = 'Pune' AND department = 'HR';
SELECT * FROM worker WHERE city = 'Pune' OR department = 'Accounts';
SELECT * FROM worker WHERE NOT city = 'Pune' AND NOT department  = 'Admin';
SELECT * FROM worker  WHERE department = 'HR' AND salary >= 100000;


# TEXT -------------------------------------------------------------------------------------------------------------------------------
-- names in Upper case
SELECT 
	upper(first_name) AS F_Name, 
    upper(last_name) AS L_Name
FROM worker;

SELECT REVERSE(first_name) FROM worker;

-- first 3 characters of the First Name.
SELECT LEFT(first_name, 3) FROM worker;
SELECT SUBSTR(first_name, 1, 3) FROM worker;
SELECT SUBSTRING(first_name, 1, 3) AS nickname FROM worker;
 
-- Combine First name and Last name into Full Name
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM worker;
SELECT first_name || ' ' || last_name AS full_name FROM worker;  
-- the || method does not work because in some SQL dialects (like older versions of MySQL), 

-- Replace 'a' with 'A'
SELECT REPLACE(first_name, 'a', '@') FROM worker;

-- position of Alphabet 'a' in the First Name.
SELECT first_name, INSTR(first_name, 'a') FROM worker;
SELECT first_name, POSITION('a' IN first_name) FROM worker;

/* more: TRIM, LTRIM, RTRIM - used to remove unnecessary spaces*/


# MATHEMATICAL ---------------------------------------------------------------------------------------------------------------
-- SQL Aggregate Functions
SELECT SUM(salary) AS total_salary FROM worker;
SELECT MAX(salary) AS highest FROM worker;
SELECT MIN(salary) AS lowest FROM worker;
SELECT AVG(salary) AS avg_salary FROM worker;
SELECT ROUND(AVG(salary), 1) AS avg_salary FROM worker;

SELECT SUM(salary) AS HR_cost FROM worker WHERE department = 'HR';
SELECT MAX(salary) AS Mumbai_highest FROM worker WHERE city = 'Mumbai';

-- Write SQL Query to Show Only Odd Rows from a Table.
SELECT * FROM worker WHERE worker_id % 2 != 0;
SELECT * FROM worker WHERE worker_id % 2 <> 0;

-- Write SQL Query to Show Only Even Rows from a Table.
SELECT * FROM worker WHERE worker_id % 2 = 0;

-- Display workers info whose Salary is between 100000 & 500000
SELECT * FROM worker WHERE salary BETWEEN 100000 AND 500000;

-- Fetch worker full names whose Salaries is between 50000 to 100000
SELECT CONCAT(first_name, ' ', last_name) AS worker_name, salary
FROM worker
WHERE salary BETWEEN 80000 AND 100000
ORDER BY salary;

# DATE and TIME ---------------------------------------------------------------------------------------------------------------
-- Some Basic Date and Time functions.
SELECT curdate();
SELECT current_date();

SELECT curtime();
SELECT current_time();

SELECT current_timestamp();
SELECT NOW()AS Right_Now;

-- workers who joined in Feb 2021.
select * from worker;
SELECT * FROM worker WHERE YEAR(joining_date) = 2021 AND MONTH(joining_date) = 2;

-- workers who joined after before May 2021.
SELECT * FROM worker WHERE YEAR(joining_date) = 2021 AND MONTH(joining_date) < 5;

