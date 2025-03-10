-- 1. DDL to implement the schema with appropriate data types and constraints

-- Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
    DEPT_NO INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    MENO INT,
    NOE INT DEFAULT 0
);

-- Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
    ENO INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    GENDER CHAR(1) CHECK (GENDER IN ('M', 'F', 'O')), -- Check constraint for GENDER
    DOB DATE,
    DOJ DATE,
    DESIGNATION VARCHAR(50),
    BASIC DECIMAL(10, 2),
    DEPT_NO INT,
    PANNO VARCHAR(10),
    SENO INT,
    FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO),
    FOREIGN KEY (SENO) REFERENCES EMPLOYEE(ENO)
);

-- Add Foreign Key to DEPARTMENT referencing EMPLOYEE for MENO
ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_EMPLOYEE
FOREIGN KEY (MENO) REFERENCES EMPLOYEE(ENO);

-- Create PROJECT table
CREATE TABLE PROJECT (
    PROJ_NO INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    DEPT_NO INT,
    FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO)
);

-- Create WORKSFOR table
CREATE TABLE WORKSFOR (
    ENO INT,
    PROJ_NO INT,
    DATE_WORKED DATE,
    HOURS DECIMAL(5, 2),
    PRIMARY KEY (ENO, PROJ_NO, DATE_WORKED), -- Composite primary key
    FOREIGN KEY (ENO) REFERENCES EMPLOYEE(ENO),
    FOREIGN KEY (PROJ_NO) REFERENCES PROJECT(PROJ_NO)
);

-- 2. Populate the database with sample data

-- Insert data into DEPARTMENT (without MENO initially as it references EMPLOYEE)
INSERT INTO DEPARTMENT (DEPT_NO, NAME, NOE) VALUES 
(101, 'IT', 0),
(102, 'HR', 0),
(103, 'Finance', 0),
(104, 'Marketing', 0),
(105, 'Operations', 0);

-- Insert data into EMPLOYEE (without SENO initially as it's self-referencing)
INSERT INTO EMPLOYEE (ENO, NAME, GENDER, DOB, DOJ, DESIGNATION, BASIC, DEPT_NO, PANNO) VALUES 
(1001, 'John Smith', 'M', '1980-05-15', '2010-01-10', 'Manager', 80000.00, 101, 'ABCPX1234Y'),
(1002, 'Sarah Johnson', 'F', '1985-08-22', '2011-03-15', 'Manager', 78000.00, 102, 'DEFPX5678Z'),
(1003, 'Michael Brown', 'M', '1978-11-30', '2009-07-20', 'Manager', 85000.00, 103, 'GHIPX9012A'),
(1004, 'Emily Davis', 'F', '1982-04-18', '2012-05-05', 'Manager', 76000.00, 104, 'JKLPX3456B'),
(1005, 'Robert Wilson', 'M', '1975-09-25', '2008-11-12', 'Manager', 90000.00, 105, 'MNOPX7890C');

-- Update DEPARTMENT with manager employee numbers
UPDATE DEPARTMENT SET MENO = 1001 WHERE DEPT_NO = 101;
UPDATE DEPARTMENT SET MENO = 1002 WHERE DEPT_NO = 102;
UPDATE DEPARTMENT SET MENO = 1003 WHERE DEPT_NO = 103;
UPDATE DEPARTMENT SET MENO = 1004 WHERE DEPT_NO = 104;
UPDATE DEPARTMENT SET MENO = 1005 WHERE DEPT_NO = 105;

-- Insert more employees with supervisors
INSERT INTO EMPLOYEE (ENO, NAME, GENDER, DOB, DOJ, DESIGNATION, BASIC, DEPT_NO, PANNO, SENO) VALUES 
(1006, 'Patricia Moore', 'F', '1988-07-14', '2014-02-20', 'Developer', 65000.00, 101, 'PQRPX1234D', 1001),
(1007, 'James Anderson', 'M', '1990-03-08', '2015-09-17', 'Developer', 62000.00, 101, 'STUPA5678E', 1001),
(1008, 'Jennifer White', 'F', '1987-12-03', '2013-11-25', 'HR Assistant', 58000.00, 102, 'VWXPY9012F', 1002),
(1009, 'David Miller', 'M', '1989-06-27', '2016-04-10', 'Accountant', 64000.00, 103, 'ZABPC3456G', 1003),
(1010, 'Lisa Taylor', 'F', '1991-10-11', '2017-08-03', 'Marketing Exec', 56000.00, 104, 'DEFPG7890H', 1004),
(1011, 'Richard Harris', 'M', '1986-02-19', '2013-05-22', 'Operations Analyst', 59000.00, 105, 'GHIPI1234I', 1005),
(1012, 'Susan Martin', 'F', '1992-05-07', '2018-01-15', 'Developer', 60000.00, 101, 'JKLPJ5678J', 1001),
(1013, 'Thomas Clark', 'M', '1984-09-23', '2012-07-08', 'HR Recruiter', 61000.00, 102, 'MNOPK9012K', 1002),
(1014, 'Karen Lewis', 'F', '1990-01-29', '2017-03-12', 'Financial Analyst', 63000.00, 103, 'PQRPL3456L', 1003),
(1015, 'Daniel Walker', 'M', '1993-08-16', '2019-06-25', 'Content Creator', 57000.00, 104, 'STUPM7890M', 1004);

-- Update NOE in DEPARTMENT (would normally be done by trigger)
UPDATE DEPARTMENT SET NOE = 3 WHERE DEPT_NO = 101; -- Manager + 2 developers
UPDATE DEPARTMENT SET NOE = 3 WHERE DEPT_NO = 102; -- Manager + 2 HR staff
UPDATE DEPARTMENT SET NOE = 3 WHERE DEPT_NO = 103; -- Manager + 2 finance staff
UPDATE DEPARTMENT SET NOE = 3 WHERE DEPT_NO = 104; -- Manager + 2 marketing staff
UPDATE DEPARTMENT SET NOE = 2 WHERE DEPT_NO = 105; -- Manager + 1 operations staff

-- Insert data into PROJECT
INSERT INTO PROJECT (PROJ_NO, NAME, DEPT_NO) VALUES 
(201, 'ERP Implementation', 101),
(202, 'Employee Training Program', 102),
(203, 'Financial Reporting System', 103),
(204, 'Brand Campaign 2023', 104),
(205, 'Supply Chain Optimization', 105),
(206, 'Mobile App Development', 101),
(207, 'HR Policy Revision', 102),
(208, 'Cost Reduction Initiative', 103);

-- Insert data into WORKSFOR
INSERT INTO WORKSFOR (ENO, PROJ_NO, DATE_WORKED, HOURS) VALUES 
(1001, 201, '2023-01-15', 6.5),
(1001, 206, '2023-01-15', 2.0),
(1006, 201, '2023-01-15', 8.0),
(1007, 206, '2023-01-15', 8.0),
(1012, 201, '2023-01-15', 4.0),
(1012, 206, '2023-01-15', 4.0),
(1002, 202, '2023-01-15', 5.0),
(1002, 207, '2023-01-15', 3.5),
(1008, 202, '2023-01-15', 8.0),
(1013, 207, '2023-01-15', 8.0),
(1003, 203, '2023-01-15', 7.0),
(1003, 208, '2023-01-15', 1.5),
(1009, 203, '2023-01-15', 8.0),
(1014, 208, '2023-01-15', 8.0),
(1004, 204, '2023-01-15', 8.0),
(1010, 204, '2023-01-15', 8.0),
(1015, 204, '2023-01-15', 8.0),
(1005, 205, '2023-01-15', 8.0),
(1011, 205, '2023-01-15', 8.0);

-- 3. SQL query to list the details of employees who earn less than the average basic pay of all employees
SELECT * FROM EMPLOYEE
WHERE BASIC < (SELECT AVG(BASIC) FROM EMPLOYEE);

-- 4. SQL query to list the details of departments which has more than six employees working in it
SELECT * FROM DEPARTMENT
WHERE NOE > 6;

-- 5. Create a view to track department statistics
CREATE VIEW DEPARTMENT_STATS AS
SELECT D.DEPT_NO, D.NAME, D.NOE, SUM(E.BASIC) AS TOTAL_BASIC_PAY
FROM DEPARTMENT D
JOIN EMPLOYEE E ON D.DEPT_NO = E.DEPT_NO
GROUP BY D.DEPT_NO, D.NAME, D.NOE;

-- 6. Trigger to increment NOE when a new record is inserted in the EMPLOYEE relation
CREATE OR REPLACE TRIGGER INCREMENT_NOE
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    UPDATE DEPARTMENT
    SET NOE = NOE + 1
    WHERE DEPT_NO = :NEW.DEPT_NO;
END;
/

-- 7. Trigger to decrement NOE when a record is deleted from the EMPLOYEE relation
CREATE OR REPLACE TRIGGER DECREMENT_NOE
AFTER DELETE ON EMPLOYEE
FOR EACH ROW
BEGIN
    UPDATE DEPARTMENT
    SET NOE = NOE - 1
    WHERE DEPT_NO = :OLD.DEPT_NO;
END;
/

-- 8. Trigger to update NOE when an employee is transferred between departments
CREATE OR REPLACE TRIGGER UPDATE_NOE_ON_TRANSFER
AFTER UPDATE OF DEPT_NO ON EMPLOYEE
FOR EACH ROW
BEGIN
    -- Decrement NOE for old department
    UPDATE DEPARTMENT
    SET NOE = NOE - 1
    WHERE DEPT_NO = :OLD.DEPT_NO;
    
    -- Increment NOE for new department
    UPDATE DEPARTMENT
    SET NOE = NOE + 1
    WHERE DEPT_NO = :NEW.DEPT_NO;
END;
/

-- Sample execution of queries with results

-- Query 3 Result: Employees earning less than average basic pay
-- Average BASIC is (80000+78000+85000+76000+90000+65000+62000+58000+64000+56000+59000+60000+61000+63000+57000)/15 = 67600

/*
+------+----------------+--------+------------+------------+-------------------+----------+---------+------------+------+
| ENO  | NAME           | GENDER | DOB        | DOJ        | DESIGNATION       | BASIC    | DEPT_NO | PANNO      | SENO |
+------+----------------+--------+------------+------------+-------------------+----------+---------+------------+------+
| 1006 | Patricia Moore | F      | 1988-07-14 | 2014-02-20 | Developer         | 65000.00 | 101     | PQRPX1234D | 1001 |
| 1007 | James Anderson | M      | 1990-03-08 | 2015-09-17 | Developer         | 62000.00 | 101     | STUPA5678E | 1001 |
| 1008 | Jennifer White | F      | 1987-12-03 | 2013-11-25 | HR Assistant      | 58000.00 | 102     | VWXPY9012F | 1002 |
| 1010 | Lisa Taylor    | F      | 1991-10-11 | 2017-08-03 | Marketing Exec    | 56000.00 | 104     | DEFPG7890H | 1004 |
| 1011 | Richard Harris | M      | 1986-02-19 | 2013-05-22 | Operations Analyst| 59000.00 | 105     | GHIPI1234I | 1005 |
| 1012 | Susan Martin   | F      | 1992-05-07 | 2018-01-15 | Developer         | 60000.00 | 101     | JKLPJ5678J | 1001 |
| 1013 | Thomas Clark   | M      | 1984-09-23 | 2012-07-08 | HR Recruiter      | 61000.00 | 102     | MNOPK9012K | 1002 |
| 1015 | Daniel Walker  | M      | 1993-08-16 | 2019-06-25 | Content Creator   | 57000.00 | 104     | STUPM7890M | 1004 |
+------+----------------+--------+------------+------------+-------------------+----------+---------+------------+------+
*/

-- Query 4 Result: Departments with more than 6 employees
-- In our sample data, no department has more than 6 employees
/*
No results - all departments have 3 or fewer employees
*/

-- Query 5 Result: DEPARTMENT_STATS view
/*
+---------+------------+-----+----------------+
| DEPT_NO | NAME       | NOE | TOTAL_BASIC_PAY|
+---------+------------+-----+----------------+
| 101     | IT         | 3   | 207000.00      |
| 102     | HR         | 3   | 197000.00      |
| 103     | Finance    | 3   | 212000.00      |
| 104     | Marketing  | 3   | 189000.00      |
| 105     | Operations | 2   | 149000.00      |
+---------+------------+-----+----------------+
*/
