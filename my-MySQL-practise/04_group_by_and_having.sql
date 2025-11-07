/*
---------------------------------------------------------------------------------------------------------------------------
Filename       : 04_group_by_and_having.sql
Level          : Intermediate
Concepts covered :
  1. Text Functions - 
  2. Mathematical Functions - 
  3. Date and Time Fumctions
---------------------------------------------------------------------------------------------------------------------------
*/

USE company;          -- select the database

SELECT * FROM employee;

-- Display the no. of employees from Mumbai city
SELECT COUNT(*) AS Mumbai_based_emps FROM employee WHERE city = 'Mumbai';

-- Display No. of employees in the 'Admin' department.
SELECT count(*) AS admin_dept_count FROM employee WHERE department = 'Admin';

# GROUP BY clause
/*The GROUP BY clause in SQL is used to group rows that have the 
same values in one or more specified columns into summary rows. 
This is frequently used in conjunction with aggregate functions 
to perform calculations on these grouped data. */

-- Display the no. of employees from each city
SELECT
	city,
    count(*)
FROM employee
GROUP BY city;


-- Display the no. of employees in each department
SELECT
	department, 
    COUNT(*) 
FROM employee 
GROUP BY department;


-- count of employee last names
SELECT 
	last_name,
    COUNT(*) AS nos
FROM employee
GROUP BY last_name;


-- Good practise to alias columns and order the table rows according to counts for better readability
SELECT 
	department AS dept, 
    COUNT(*) AS No_of_employees
FROM employee
GROUP BY department
ORDER BY No_of_employees;

-- Count of employees in different departments from Mumbai city.
SELECT 
	department,
    COUNT(*) AS from_Mumbai
FROM employee
WHERE city = 'Mumbai'
GROUP BY department
ORDER BY from_Mumbai;

-- get each department's count of employees, total salaries and highest and lowest salary
SELECT 
	department AS dept, 
    COUNT(*) AS nos,
    SUM(salary) AS dept_cost,
    MAX(salary) AS highest_pay,
    MIN(salary) AS lowest_pay
FROM employee
GROUP BY department
ORDER BY nos;

-- From which city does the company have the highest number of employees?
SELECT 
	city,
    COUNT(*) AS nos
FROM employee
GROUP BY city
ORDER BY nos DESC
LIMIT 1;

-- From which city does the company have the lowest number of employees?
SELECT 
	city,
    COUNT(*) AS nos
FROM employee
GROUP BY city
ORDER BY nos
LIMIT 1;


-- Write a query to display the count of employees for every unique department and city pair. 
SELECT
	department,
    city,
    count(*) as nos
FROM employee
GROUP BY department, city
ORDER BY nos, department;

# GROUP_CONCAT
/* function in MySQL is used to combine multiple values from different rows into a single string.
It’s especially useful when summarizing grouped data or displaying related values in one line.
In short, it concatenates values from a column into a single string, typically used with GROUP BY 

SYNTAX :- GROUP_CONCAT([DISTINCT] expression [ORDER BY expression ASC|DESC] [SEPARATOR separator])
	DISTINCT → Removes duplicate values before concatenation
    ORDER BY → Sorts values within each group
    SEPARATOR → Defines the string separator (default is a comma ,)
*/
-- get the names of employees from each list
SELECT 
	city,
    GROUP_CONCAT(first_name ORDER BY first_name SEPARATOR ', ') 
FROM employee 
GROUP BY city;  -- group by discussed in another file


-- get the department-wise count of employees and their full names
SELECT 
	department,
    COUNT(*) AS frequency,
    GROUP_CONCAT(CONCAT(first_name, ' ', last_name) ORDER BY first_name SEPARATOR ', ') AS employee_names
FROM employee 
GROUP BY department
ORDER BY frequency;  -- group by discussed in another file


-- ------------------------------------------------------------------------------------------------------------
# HAVING
/* The HAVING clause in SQL is used to filter groups of rows 
based on a specified condition, typically involving aggregate functions. 
It is used in conjunction with the GROUP BY clause.
Unlike the WHERE clause, which filters individual rows before grouping, 
HAVING filters the results after the GROUP BY clause has aggregated the data into groups.*/

-- Get the count of employees in each department.
SELECT
	department,
    count(*)
FROM employee
GROUP BY department;

 -- Fetch the department(s) with only 2 employees.
SELECT 
	department,
    COUNT(*) AS frequency
FROM employee
GROUP BY department
HAVING frequency = 2;

-- Display the number of employees from each city and filter only those cities having 5 or more employees.
SELECT
	city, 
    COUNT(*) AS employees
FROM employee 
GROUP BY city
HAVING employees >= 5;

-- Display the number of employees from each city and filter only those cities having employees between the range of 3 to 6.
SELECT
	city, 
    COUNT(*) AS employees
FROM employee 
GROUP BY city
HAVING employees BETWEEN 3 AND 6;

-- Department-wise total salaries
SELECT
	department, 
    SUM(salary) AS dept_cost
FROM employee 
GROUP BY department
ORDER BY dept_cost;

-- Department with total salary more than 1,000,000
SELECT
	department, 
    SUM(salary) AS dept_cost
FROM employee 
GROUP BY department
HAVING dept_cost > 1000000
ORDER BY dept_cost;

-- Write a query to display the number of employees working in each department and city.
-- Show only those department–city combinations where the count of employees is greater than 1. 
SELECT
	department,
    city,
    count(*) AS nos
FROM employee
GROUP BY department, city
HAVING nos > 1
ORDER BY department;

-- Query to find repeated last names and show how many employees share each one
SELECT 
	last_name,
    COUNT(*) AS frequency
FROM employee
GROUP BY last_name
HAVING frequency > 1;



# Handling ties with Subqueries...
-- Which department has the highest no. of employees?
SELECT department, COUNT(*) AS nos
FROM employee
GROUP BY department
ORDER BY nos DESC
LIMIT 1;

-- but if you check the count...
SELECT department, COUNT(*) FROM employee GROUP BY department ORDER BY COUNT(*) DESC;
-- there are ties... 

-- to get the department(s) with the highest no. of employees (by handling ties):

-- STEP 1: get the department-wise count. You will get a column list of count values
-- basic syntax: SELECT COUNT(*) FROM table GROUP BY col;
SELECT COUNT(*) AS dept_nos
FROM employee
GROUP BY department;

-- STEP 2: get the highest count from the column list of counts using max()
-- basic syntax: SELECT MAX(col) FROM table;
 SELECT MAX(dept_nos) 
 FROM (
	SELECT COUNT(*) AS dept_nos 
    FROM employee 
    GROUP BY department
    ) AS dept_count_table;  -- the column acts as 1D table so don't forget to ALIAS the derived-table

-- STEP 3: filter groups of rows from the entire employee table HAVING the max value.
-- basic syntax: SELECT cols FROM table GROUP BY col HAVING condtion;
SELECT department, count(*) AS nos 
FROM employee 
GROUP BY department
HAVING nos = (
	SELECT MAX(dept_nos)
    FROM (
		SELECT COUNT(*) AS dept_nos 
        FROM employee 
        GROUP BY department) AS dept_count_table
);

-- ... the concept of subquery is discussed in detail in further files