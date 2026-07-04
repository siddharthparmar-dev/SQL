USE mydb;

ALTER table employees ADD COLUMN age INT CHECK (age > 18);
ALTER table employees DROP COLUMN id;
ALTER table employees RENAME COLUMN name TO Full_Name;