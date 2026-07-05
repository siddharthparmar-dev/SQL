-- DCL COMMANDS

GRANT SELECT, INSERT ON mydb.employees TO 'user1'@'localhost';
REVOKE INSERT ON mydb.employees FROM 'user1'@'localhost';