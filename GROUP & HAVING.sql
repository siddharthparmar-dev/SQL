-- GROUP AND HAVING

SELECT dept_id, COUNT(*) AS total_emp
FROM employees
GROUP BY dept_id;

SELECT dept_id, AVG(salary) AS avg_sal
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > 50000;   -- HAVING filters after grouping (WHERE filters before)