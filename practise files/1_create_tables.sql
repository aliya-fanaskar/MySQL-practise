SHOW DATABASES;               -- display the list of existing databases
CREATE DATABASE company;      -- create a database
USE company;                  -- select the database

SHOW TABLES;            -- display the list of tables in that database

CREATE TABLE worker(
	worker_id INT PRIMARY KEY NOT NULL,
    first_name CHAR(25),
    last_name CHAR(25),
    salary INT,
    joining_date DATETIME,
    department CHAR(25),
    city CHAR(25)
);

INSERT INTO worker (worker_id, first_name, last_name, salary, joining_date, department, city) VALUES
    (1, 'Monika', 'Arora', 100000, '2021-02-20 09:00:00', 'HR', 'Mumbai'),
    (2, 'Niharika', 'Verma', 80000, '2021-06-11 09:00:00', 'Admin', 'Lucknow'),
    (3, 'Vishal', 'Singhal', 300000, '2021-02-20 09:00:00', 'HR', 'Pune'),
    (4, 'Amitabh', 'Singh', 500000, '2021-02-20 09:00:00', 'Admin', 'Lucknow'),
    (5, 'Vivek', 'Bhati', 90000, '2021-06-11 09:00:00', 'Admin', 'Mumbai'),
    (6, 'Vipul', 'Diwan', 200000, '2021-06-11 09:00:00', 'Account', 'Mumbai'),
    (7, 'Satish', 'Kumar', 75000, '2021-01-20 09:00:00', 'Account', 'Pune'),
    (8, 'Geetika', 'Chauhan', 90000, '2021-04-11 09:00:00', 'Admin', 'Pune'),
    (9, 'Nikhil', 'Kumar', 120000, '2021-06-11 09:00:00', 'Admin', 'Mumbai'),
    (10, 'Sangita', 'Singh', 95000, '2021-01-20 09:00:00', 'HR', 'Lucknow');


CREATE TABLE bonus(
	worker_ref_id INT,
    bonus_amount INT,
    bonus_date DATETIME,
    FOREIGN KEY (worker_ref_id) REFERENCES worker(worker_id) ON DELETE CASCADE
);

INSERT INTO bonus (worker_ref_id, bonus_amount, bonus_date) VALUES
    (1, 5000, '2023-02-20'),
    (2, 3000, '2023-06-11'),
    (7, 4000, '2023-02-20'),
    (8, 4500, '2023-02-20'),
    (10, 3500, '2023-06-11'),
    (7, 4500, '2023-02-20'),
    (2, 3500, '2023-06-11');

CREATE TABLE title(
	worker_ref_id INT,
    worker_title CHAR(25),
    affect_from DATETIME,
    FOREIGN KEY (worker_ref_id) REFERENCES worker(worker_id) ON DELETE CASCADE
);

INSERT INTO title (worker_ref_id, worker_title, affect_from) VALUES
    (1, 'Manager', '2023-02-20 00:00:00'),
    (2, 'Executive', '2023-06-11 00:00:00'),
    (8, 'Executive', '2023-06-11 00:00:00'),
    (5, 'Manager', '2023-06-11 00:00:00'),
    (4, 'Asst. Manager', '2023-06-11 00:00:00'),
    (7, 'Executive', '2023-06-11 00:00:00'),
    (6, 'Manager', '2023-06-11 00:00:00'),
    (3, 'Lead', '2023-06-11 00:00:00');

-- view tables
SHOW TABLES;

SELECT * FROM worker;

SELECT * FROM bonus;
SELECT * FROM bonus ORDER BY worker_ref_id, bonus_amount;

SELECT * FROM title;
SELECT * FROM title ORDER BY worker_ref_id;

DESC worker;            -- details of a certain table
DESC title;
