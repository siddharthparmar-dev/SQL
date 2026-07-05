-- DML COMMANDS

INSERT INTO employees (name,salary,dept_id) VALUES("Rahul",22000,1);
INSERT INTO employees (name, salary, dept_id) VALUES 
  ('Aman', 60000, 2), ('Priya', 55000, 3);
  
  UPDATE employees SET salary = 55000 WHERE id = 1;
  
  DELETE FROM employees WHERE id = 3;