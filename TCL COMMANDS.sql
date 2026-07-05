-- TCL COMMANDS
START TRANSACTION;
UPDATE employees SET salary = salary + 1000 WHERE id = 1;
COMMIT;      -- save changes
ROLLBACK;    -- undo changes
SAVEPOINT sp1;
ROLLBACK TO sp1;