-- SQL QUERIES

-- 1. List the details of employees who earn less than the average basic pay of all employees
SELECT * FROM EMPLOYEE 
WHERE BASIC < (SELECT AVG(BASIC) FROM EMPLOYEE);

-- Output:
/*
ENO    NAME           GENDER DOB        DOJ        DESIGNATION          BASIC     DEPT_NO PANNO    SENO
------ -------------- ------ ---------- ---------- -------------------- --------- ------- -------- ------
E006   Sarah Wilson   F      1990-06-18 2015-04-22 HR Assistant         55000.00  D001    PAN006   E001
E008   Amanda Miller  F      1991-11-12 2016-08-10 Financial Analyst    65000.00  D003    PAN008   E003
E009   Thomas Wright  M      1986-03-28 2013-10-05 Marketing Specialist 62000.00  D004    PAN009   E004
E010   Linda Garcia   F      1989-07-14 2015-12-18 Research Analyst     70000.00  D005    PAN010   E005
*/

-- 2. List the details of departments which has more than six employees working in it
SELECT * FROM DEPARTMENT 
WHERE NOE > 6;

-- Output:
/*
No rows selected
*/

-- 3. Create a view to track department statistics
CREATE VIEW DEPARTMENT_STATS AS
SELECT 
    D.DEPT_NO,
    D.NAME,
    D.NOE,
    SUM(E.BASIC) AS TOTAL_BASIC_PAY
FROM 
    DEPARTMENT D
JOIN 
    EMPLOYEE E ON D.DEPT_NO = E.DEPT_NO
GROUP BY 
D.DEPT_NO, D.NAME, D.NOE;

-- Query:
SELECT * FROM DEPARTMENT_STATS;

-- Output:
/*
DEPT_NO NAME            NOE   TOTAL_BASIC_PAY
------- --------------- ----- ---------------
D001    Human Resources 2     140000.00
D002    Engineering     2     155000.00
D003    Finance         2     155000.00
D004    Marketing       2     140000.00
D005    Research        2     158000.00
*/

-- 4. Trigger for incrementing NOE when a new employee is inserted
-- SQLite Syntax
CREATE TRIGGER INCREMENT_NOE_ON_EMPLOYEE_INSERT
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    UPDATE DEPARTMENT
    SET NOE = NOE + 1
    WHERE DEPT_NO = NEW.DEPT_NO;
END;


-- Testing triggers

-- Testing INSERT trigger
INSERT INTO EMPLOYEE (ENO, NAME, GENDER, DOB, DOJ, DESIGNATION, BASIC, DEPT_NO, PANNO, SENO)
VALUES ('E011', 'Kevin Williams', 'M', '1990-02-25', '2017-05-10', 'HR Specialist', 60000.00, 'D001', 'PAN011', 'E001');


-- Check NOE increase
SELECT DEPT_NO, NOE FROM DEPARTMENT WHERE DEPT_NO = 'D001';

/*
Output
DEPT_NO	NOE
D001	3
*/

-- 5. Trigger for decrementing NOE when an employee is deleted
-- SQLite Syntax
CREATE TRIGGER DECREMENT_NOE_ON_EMPLOYEE_DELETE
AFTER DELETE ON EMPLOYEE
FOR EACH ROW
BEGIN
    UPDATE DEPARTMENT
    SET NOE = NOE - 1
    WHERE DEPT_NO = OLD.DEPT_NO;
END;


--Testing DELETE trigger
DELETE FROM EMPLOYEE WHERE ENO = 'E011';

-- Check NOE decrease
SELECT DEPT_NO, NOE FROM DEPARTMENT WHERE DEPT_NO = 'D001';

/*
Output
DEPT_NO	NOE
D001	2
*/

-- 6. Trigger for updating NOE when an employee is transferred to another department
-- SQLite Syntax
CREATE TRIGGER UPDATE_NOE_ON_EMPLOYEE_TRANSFER
AFTER UPDATE OF DEPT_NO ON EMPLOYEE
FOR EACH ROW
WHEN NEW.DEPT_NO != OLD.DEPT_NO
BEGIN
    -- Decrement NOE in the old department
    UPDATE DEPARTMENT
    SET NOE = NOE - 1
    WHERE DEPT_NO = OLD.DEPT_NO;
    
    -- Increment NOE in the new department
    UPDATE DEPARTMENT
    SET NOE = NOE + 1
    WHERE DEPT_NO = NEW.DEPT_NO;
END;

-- Testing UPDATE trigger (transfer)
-- First insert the employee again
INSERT INTO EMPLOYEE (ENO, NAME, GENDER, DOB, DOJ, DESIGNATION, BASIC, DEPT_NO, PANNO, SENO)
VALUES ('E011', 'Kevin Williams', 'M', '1990-02-25', '2017-05-10', 'HR Specialist', 60000.00, 'D001', 'PAN011', 'E001');

-- Now transfer the employee
UPDATE EMPLOYEE SET DEPT_NO = 'D002' WHERE ENO = 'E011';

-- Check both departments
SELECT DEPT_NO, NOE FROM DEPARTMENT WHERE DEPT_NO IN ('D001', 'D002');

/*
Output
DEPT_NO	NOE
D001	2
D002	3
*/

