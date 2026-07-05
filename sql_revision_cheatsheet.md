# SQL Complete Revision Sheet

## 1. Database & Table Basics (DDL)

```sql
-- Create / drop database
CREATE DATABASE mydb;
DROP DATABASE mydb;
USE mydb;

-- Create table
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2),
    dept_id INT,
    joined_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(id)
);

-- Alter table
ALTER TABLE employees ADD COLUMN email VARCHAR(100);
ALTER TABLE employees DROP COLUMN email;
ALTER TABLE employees MODIFY COLUMN name VARCHAR(100);
ALTER TABLE employees RENAME COLUMN name TO full_name;
ALTER TABLE employees RENAME TO staff;

-- Drop / truncate table
DROP TABLE employees;      -- removes structure + data
TRUNCATE TABLE employees;  -- removes data, keeps structure
```

## 2. Constraints

```sql
NOT NULL
UNIQUE
PRIMARY KEY
FOREIGN KEY
CHECK (salary > 0)
DEFAULT 0
```

## 3. Data Manipulation (DML)

```sql
INSERT INTO employees (name, salary, dept_id) VALUES ('Rahul', 50000, 1);
INSERT INTO employees (name, salary, dept_id) VALUES 
  ('Aman', 60000, 2), ('Priya', 55000, 1);

UPDATE employees SET salary = 65000 WHERE id = 1;

DELETE FROM employees WHERE id = 1;
```

## 4. Basic Querying (DQL)

```sql
SELECT * FROM employees;
SELECT name, salary FROM employees;
SELECT DISTINCT dept_id FROM employees;

SELECT * FROM employees WHERE salary > 50000;
SELECT * FROM employees WHERE dept_id = 1 AND salary > 40000;
SELECT * FROM employees WHERE dept_id = 1 OR dept_id = 2;
SELECT * FROM employees WHERE NOT dept_id = 1;

SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY dept_id ASC, salary DESC;

SELECT * FROM employees LIMIT 5;
SELECT * FROM employees LIMIT 5 OFFSET 10;
```

## 5. Filtering Operators

```sql
WHERE salary BETWEEN 30000 AND 60000;
WHERE dept_id IN (1, 2, 3);
WHERE name LIKE 'A%';        -- starts with A
WHERE name LIKE '%an%';      -- contains 'an'
WHERE name LIKE '_a%';       -- 2nd letter is 'a'
WHERE email IS NULL;
WHERE email IS NOT NULL;
```

## 6. Aggregate Functions

```sql
SELECT COUNT(*) FROM employees;
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MIN(salary), MAX(salary) FROM employees;
```

## 7. GROUP BY & HAVING

```sql
SELECT dept_id, COUNT(*) AS total_emp
FROM employees
GROUP BY dept_id;

SELECT dept_id, AVG(salary) AS avg_sal
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > 50000;   -- HAVING filters after grouping (WHERE filters before)
```

## 8. Joins

```sql
-- INNER JOIN: only matching rows
SELECT e.name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id;

-- LEFT JOIN: all from left + matched from right
SELECT e.name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id;

-- RIGHT JOIN: all from right + matched from left
SELECT e.name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.id;

-- FULL OUTER JOIN (not in MySQL directly, use UNION)
SELECT e.name, d.dept_name FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id
UNION
SELECT e.name, d.dept_name FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.id;

-- SELF JOIN
SELECT a.name AS emp, b.name AS manager
FROM employees a
JOIN employees b ON a.manager_id = b.id;

-- CROSS JOIN: cartesian product
SELECT * FROM employees CROSS JOIN departments;
```

## 9. Subqueries

```sql
-- Single value subquery
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- IN subquery
SELECT * FROM employees
WHERE dept_id IN (SELECT id FROM departments WHERE location = 'Delhi');

-- Correlated subquery
SELECT name FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees WHERE dept_id = e.dept_id);

-- EXISTS
SELECT name FROM departments d
WHERE EXISTS (SELECT 1 FROM employees e WHERE e.dept_id = d.id);
```

## 10. Set Operations

```sql
SELECT name FROM employees
UNION
SELECT name FROM managers;      -- removes duplicates

SELECT name FROM employees
UNION ALL
SELECT name FROM managers;      -- keeps duplicates

SELECT name FROM employees
INTERSECT
SELECT name FROM managers;

SELECT name FROM employees
EXCEPT
SELECT name FROM managers;
```

## 11. String Functions

```sql
CONCAT(first_name, ' ', last_name)
UPPER(name), LOWER(name)
LENGTH(name)
SUBSTRING(name, 1, 3)
TRIM(name)
REPLACE(name, 'a', 'b')
```

## 12. Date Functions

```sql
NOW()
CURDATE()
DATEDIFF(date1, date2)
DATE_ADD(date, INTERVAL 1 DAY)
DATE_FORMAT(date, '%Y-%m-%d')
YEAR(date), MONTH(date), DAY(date)
```

## 13. Numeric Functions

```sql
ROUND(salary, 2)
FLOOR(salary)
CEIL(salary)
ABS(-5)
MOD(10, 3)
```

## 14. CASE Statement (conditional logic)

```sql
SELECT name,
  CASE
    WHEN salary >= 60000 THEN 'High'
    WHEN salary >= 40000 THEN 'Medium'
    ELSE 'Low'
  END AS salary_band
FROM employees;
```

## 15. Views

```sql
CREATE VIEW high_earners AS
SELECT name, salary FROM employees WHERE salary > 60000;

SELECT * FROM high_earners;
DROP VIEW high_earners;
```

## 16. Indexes

```sql
CREATE INDEX idx_salary ON employees(salary);
DROP INDEX idx_salary ON employees;
```

## 17. Transactions (TCL)

```sql
START TRANSACTION;
UPDATE employees SET salary = salary + 1000 WHERE id = 1;
COMMIT;      -- save changes
ROLLBACK;    -- undo changes
SAVEPOINT sp1;
ROLLBACK TO sp1;
```

## 18. Window Functions (important, often skipped)

```sql
SELECT name, salary,
  RANK() OVER (ORDER BY salary DESC) AS rnk,
  DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rnk,
  ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS row_num,
  SUM(salary) OVER (PARTITION BY dept_id) AS dept_total
FROM employees;
```

## 19. Common Table Expressions (CTE)

```sql
WITH dept_avg AS (
  SELECT dept_id, AVG(salary) AS avg_sal
  FROM employees
  GROUP BY dept_id
)
SELECT e.name, e.salary, d.avg_sal
FROM employees e
JOIN dept_avg d ON e.dept_id = d.dept_id;
```

## 20. User & Permissions (DCL)

```sql
GRANT SELECT, INSERT ON mydb.employees TO 'user1'@'localhost';
REVOKE INSERT ON mydb.employees FROM 'user1'@'localhost';
```

## 21. Query Execution Order (very important for interviews)

```
FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
```

---

### Quick tips to remember
- `WHERE` filters rows before grouping; `HAVING` filters after grouping.
- `JOIN` combines tables; `UNION` combines result sets (same column count/types).
- Use `EXPLAIN SELECT ...` to check query performance.
- Always index columns used often in `WHERE`, `JOIN`, `ORDER BY`.
