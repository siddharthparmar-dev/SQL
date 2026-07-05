-- DQL COMMANDS

SELECT * FROM employees;
SELECT Full_Name,salary FROM employees;
SELECT DISTINCT dept_id FROM employees;

SELECT * FROM employees WHERE salary > 55000;
SELECT * FROM employees WHERE dept_id = 1 AND salary > 40000;

SELECT * FROM employees order by salary DESC;

SELECT * FROM employees LIMIT 5;

SELECT * FROM employees LIMIT 5 OFFSET 7;