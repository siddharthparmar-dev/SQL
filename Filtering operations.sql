-- FILTERING OPERATIONS

SELECT * FROM employees WHERE salary BETWEEN 30000 AND 60000;
SELECT * FROM employees WHERE dept_id IN (1, 2, 3);
SELECT * FROM employees WHERE Full_Name LIKE 'A%';
SELECT * FROM employees WHERE Full_Name LIKE '%an%'; 


