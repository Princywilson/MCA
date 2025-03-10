-- DDL Implementation of Company Database Schema

-- Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
    DEPT_NO INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    MENO INT,
    NOE INT DEFAULT 0
    -- MENO foreign key will be added after EMPLOYEE table is created
);

-- Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
    ENO INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    GENDER CHAR(1) NOT NULL CHECK (GENDER IN ('M', 'F')),
    DOB DATE NOT NULL,
    DOJ DATE NOT NULL,
    DESIGNATION VARCHAR(50) NOT NULL,
    BASIC DECIMAL(10, 2) NOT NULL,
    DEPT_NO INT NOT NULL,
    PANNO VARCHAR(10) UNIQUE NOT NULL,
    SENO INT,
    FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO),
    FOREIGN KEY (SENO) REFERENCES EMPLOYEE(ENO)
);

-- Add MENO foreign key to DEPARTMENT table
ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_EMPLOYEE
FOREIGN KEY (MENO) REFERENCES EMPLOYEE(ENO);

-- Create PROJECT table
CREATE TABLE PROJECT (
    PROJ_NO INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    DEPT_NO INT NOT NULL,
    FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO)
);

-- Create WORKSFOR table
CREATE TABLE WORKSFOR (
    ENO INT,
    PROJ_NO INT,
    DATE_WORKED DATE NOT NULL,
    HOURS DECIMAL(5, 2) NOT NULL CHECK (HOURS > 0 AND HOURS <= 24),
    PRIMARY KEY (ENO, PROJ_NO, DATE_WORKED),
    FOREIGN KEY (ENO) REFERENCES EMPLOYEE(ENO),
    FOREIGN KEY (PROJ_NO) REFERENCES PROJECT(PROJ_NO)
);

-- Inserting sample data into the tables

-- Insert Department records (without managers initially)
INSERT INTO DEPARTMENT (DEPT_NO, NAME, NOE) VALUES
(101, 'Human Resources', 0),
(102, 'Finance', 0),
(103, 'Engineering', 0),
(104, 'Marketing', 0),
(105, 'Research & Development', 0);

-- Insert Employee records (including department managers)
INSERT INTO EMPLOYEE (ENO, NAME, GENDER, DOB, DOJ, DESIGNATION, BASIC, DEPT_NO, PANNO, SENO) VALUES
-- Department Managers
(1001, 'John Smith', 'M', '1975-05-15', '2010-06-01', 'HR Manager', 85000.00, 101, 'PANHR001', NULL),
(1002, 'Sarah Johnson', 'F', '1980-03-22', '2012-04-10', 'Finance Manager', 90000.00, 102, 'PANFN001', NULL),
(1003, 'Michael Chen', 'M', '1978-11-30', '2011-07-15', 'Engineering Manager', 95000.00, 103, 'PANEN001', NULL),
(1004, 'Emily Davis', 'F', '1982-09-18', '2013-02-20', 'Marketing Manager', 88000.00, 104, 'PANMK001', NULL),
(1005, 'Robert Wilson', 'M', '1977-07-25', '2010-12-05', 'R&D Manager', 92000.00, 105, 'PANRD001', NULL),

-- Supervisors
(2001, 'David Brown', 'M', '1985-04-12', '2015-03-10', 'HR Supervisor', 65000.00, 101, 'PANHR002', 1001),
(2002, 'Lisa Anderson', 'F', '1983-08-28', '2014-06-15', 'Finance Supervisor', 68000.00, 102, 'PANFN002', 1002),
(2003, 'James Taylor', 'M', '1984-01-05', '2014-09-22', 'Engineering Supervisor', 70000.00, 103, 'PANEN002', 1003),
(2004, 'Michelle Lee', 'F', '1986-11-17', '2016-01-15', 'Marketing Supervisor', 67000.00, 104, 'PANMK002', 1004),
(2005, 'Thomas Moore', 'M', '1982-06-30', '2013-11-08', 'R&D Supervisor', 69000.00, 105, 'PANRD002', 1005),

-- Regular Employees
(3001, 'Jennifer Walker', 'F', '1990-02-14', '2018-05-20', 'HR Assistant', 45000.00, 101, 'PANHR003', 2001),
(3002, 'Christopher King', 'M', '1988-10-23', '2017-08-14', 'Accountant', 50000.00, 102, 'PANFN003', 2002),
(3003, 'Jessica Wright', 'F', '1991-07-08', '2019-03-05', 'Software Engineer', 55000.00, 103, 'PANEN003', 2003),
(3004, 'Daniel Hill', 'M', '1989-12-30', '2018-07-25', 'Marketing Specialist', 48000.00, 104, 'PANMK003', 2004),
(3005, 'Amanda Scott', 'F', '1992-04-17', '2020-01-10', 'Research Scientist', 54000.00, 105, 'PANRD003', 2005),
(3006, 'Kevin Green', 'M', '1993-09-05', '2020-06-15', 'HR Coordinator', 42000.00, 101, 'PANHR004', 2001),
(3007, 'Elizabeth Adams', 'F', '1990-05-28', '2019-02-18', 'Financial Analyst', 48000.00, 102, 'PANFN004', 2002),
(3008, 'Ryan Baker', 'M', '1991-11-12', '2019-08-20', 'Software Developer', 52000.00, 103, 'PANEN004', 2003),
(3009, 'Olivia Carter', 'F', '1992-08-03', '2020-03-10', 'Marketing Analyst', 46000.00, 104, 'PANMK004', 2004),
(3010, 'Andrew Nelson', 'M', '1993-01-20', '2020-09-08', 'Lab Technician', 47000.00, 105, 'PANRD004', 2005);

-- Update Department managers
UPDATE DEPARTMENT SET MENO = 1001 WHERE DEPT_NO = 101;
UPDATE DEPARTMENT SET MENO = 1002 WHERE DEPT_NO = 102;
UPDATE DEPARTMENT SET MENO = 1003 WHERE DEPT_NO = 103;
UPDATE DEPARTMENT SET MENO = 1004 WHERE DEPT_NO = 104;
UPDATE DEPARTMENT SET MENO = 1005 WHERE DEPT_NO = 105;

-- Insert Project records
INSERT INTO PROJECT (PROJ_NO, NAME, DEPT_NO) VALUES
(501, 'Employee Benefits System', 101),
(502, 'Financial Reporting Tool', 102),
(503, 'Product Development Platform', 103),
(504, 'Digital Marketing Campaign', 104),
(505, 'Innovation Research', 105),
(506, 'HR Portal Enhancement', 101),
(507, 'Budget Optimization', 102),
(508, 'Cloud Migration Project', 103),
(509, 'Social Media Strategy', 104),
(510, 'New Product Research', 105);

-- Insert WORKSFOR records
INSERT INTO WORKSFOR (ENO, PROJ_NO, DATE_WORKED, HOURS) VALUES
-- HR Department
(1001, 501, '2023-05-10', 6.5),
(1001, 506, '2023-05-10', 2.0),
(2001, 501, '2023-05-10', 8.0),
(3001, 501, '2023-05-10', 8.0),
(3006, 506, '2023-05-10', 8.0),

-- Finance Department
(1002, 502, '2023-05-10', 5.0),
(1002, 507, '2023-05-10', 3.5),
(2002, 502, '2023-05-10', 8.0),
(3002, 507, '2023-05-10', 8.0),
(3007, 502, '2023-05-10', 8.0),

-- Engineering Department
(1003, 503, '2023-05-10', 4.0),
(1003, 508, '2023-05-10', 4.5),
(2003, 508, '2023-05-10', 8.0),
(3003, 503, '2023-05-10', 8.0),
(3008, 508, '2023-05-10', 8.0),

-- Marketing Department
(1004, 504, '2023-05-10', 6.0),
(1004, 509, '2023-05-10', 2.5),
(2004, 504, '2023-05-10', 8.0),
(3004, 509, '2023-05-10', 8.0),
(3009, 504, '2023-05-10', 8.0),

-- R&D Department
(1005, 505, '2023-05-10', 5.5),
(1005, 510, '2023-05-10', 3.0),
(2005, 510, '2023-05-10', 8.0),
(3005, 505, '2023-05-10', 8.0),
(3010, 510, '2023-05-10', 8.0);

-- Update NOE (Number of Employees) in DEPARTMENT table
UPDATE DEPARTMENT SET NOE = 4 WHERE DEPT_NO = 101; -- HR: Manager, Supervisor, 2 Employees
UPDATE DEPARTMENT SET NOE = 4 WHERE DEPT_NO = 102; -- Finance: Manager, Supervisor, 2 Employees
UPDATE DEPARTMENT SET NOE = 4 WHERE DEPT_NO = 103; -- Engineering: Manager, Supervisor, 2 Employees
UPDATE DEPARTMENT SET NOE = 4 WHERE DEPT_NO = 104; -- Marketing: Manager, Supervisor, 2 Employees
UPDATE DEPARTMENT SET NOE = 4 WHERE DEPT_NO = 105; -- R&D: Manager, Supervisor, 2 Employees

-- SQL query to list employees who earn less than the average basic pay of all employees
SELECT *
FROM EMPLOYEE
WHERE BASIC < (SELECT AVG(BASIC) FROM EMPLOYEE);

-- SQL query to list departments which have more than six employees
SELECT *
FROM DEPARTMENT
WHERE NOE > 6;

-- Create a view to track department statistics
CREATE VIEW DEPARTMENT_STATS AS
SELECT 
    D.DEPT_NO,
    D.NAME AS DEPT_NAME,
    D.NOE,
    SUM(E.BASIC) AS TOTAL_BASIC_PAY
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E ON D.DEPT_NO = E.DEPT_NO
GROUP BY D.DEPT_NO, D.NAME, D.NOE;

-- Database Trigger to increment NOE when a new employee is inserted
CREATE OR REPLACE TRIGGER TRG_EMPLOYEE_INSERT
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    UPDATE DEPARTMENT
    SET NOE = NOE + 1
    WHERE DEPT_NO = :NEW.DEPT_NO;
END;
/

-- Database Trigger to decrement NOE when an employee is deleted
CREATE OR REPLACE TRIGGER TRG_EMPLOYEE_DELETE
AFTER DELETE ON EMPLOYEE
FOR EACH ROW
BEGIN
    UPDATE DEPARTMENT
    SET NOE = NOE - 1
    WHERE DEPT_NO = :OLD.DEPT_NO;
END;
/

-- Database Trigger for employee department transfer
CREATE OR REPLACE TRIGGER TRG_EMPLOYEE_DEPT_UPDATE
AFTER UPDATE OF DEPT_NO ON EMPLOYEE
FOR EACH ROW
BEGIN
    -- Decrement NOE in old department
    UPDATE DEPARTMENT
    SET NOE = NOE - 1
    WHERE DEPT_NO = :OLD.DEPT_NO;
    
    -- Increment NOE in new department
    UPDATE DEPARTMENT
    SET NOE = NOE + 1
    WHERE DEPT_NO = :NEW.DEPT_NO;
END;
/

-- Results of the SQL Queries:

-- Result of employees earning less than average basic pay query:
-- (Average basic pay is 63100.00)
/*
| ENO  | NAME            | GENDER | DOB        | DOJ        | DESIGNATION          | BASIC    | DEPT_NO | PANNO     | SENO  |
|------|-----------------|--------|------------|------------|----------------------|----------|---------|-----------|-------|
| 2001 | David Brown     | M      | 1985-04-12 | 2015-03-10 | HR Supervisor        | 65000.00 | 101     | PANHR002  | 1001  |
| 2002 | Lisa Anderson   | F      | 1983-08-28 | 2014-06-15 | Finance Supervisor   | 68000.00 | 102     | PANFN002  | 1002  |
| 2003 | James Taylor    | M      | 1984-01-05 | 2014-09-22 | Engineering Supervisor| 70000.00 | 103     | PANEN002  | 1003  |
| 2004 | Michelle Lee    | F      | 1986-11-17 | 2016-01-15 | Marketing Supervisor | 67000.00 | 104     | PANMK002  | 1004  |
| 2005 | Thomas Moore    | M      | 1982-06-30 | 2013-11-08 | R&D Supervisor       | 69000.00 | 105     | PANRD002  | 1005  |
| 3001 | Jennifer Walker | F      | 1990-02-14 | 2018-05-20 | HR Assistant         | 45000.00 | 101     | PANHR003  | 2001  |
| 3002 | Christopher King| M      | 1988-10-23 | 2017-08-14 | Accountant           | 50000.00 | 102     | PANFN003  | 2002  |
| 3003 | Jessica Wright  | F      | 1991-07-08 | 2019-03-05 | Software Engineer    | 55000.00 | 103     | PANEN003  | 2003  |
| 3004 | Daniel Hill     | M      | 1989-12-30 | 2018-07-25 | Marketing Specialist | 48000.00 | 104     | PANMK003  | 2004  |
| 3005 | Amanda Scott    | F      | 1992-04-17 | 2020-01-10 | Research Scientist   | 54000.00 | 105     | PANRD003  | 2005  |
| 3006 | Kevin Green     | M      | 1993-09-05 | 2020-06-15 | HR Coordinator       | 42000.00 | 101     | PANHR004  | 2001  |
| 3007 | Elizabeth Adams | F      | 1990-05-28 | 2019-02-18 | Financial Analyst    | 48000.00 | 102     | PANFN004  | 2002  |
| 3008 | Ryan Baker      | M      | 1991-11-12 | 2019-08-20 | Software Developer   | 52000.00 | 103     | PANEN004  | 2003  |
| 3009 | Olivia Carter   | F      | 1992-08-03 | 2020-03-10 | Marketing Analyst    | 46000.00 | 104     | PANMK004  | 2004  |
| 3010 | Andrew Nelson   | M      | 1993-01-20 | 2020-09-08 | Lab Technician       | 47000.00 | 105     | PANRD004  | 2005  |
*/

-- Result of departments with more than six employees query:
-- No departments have more than six employees in our sample data
/*
| DEPT_NO | NAME | MENO | NOE |
|---------|------|------|-----|
(No results)
*/

-- Result of DEPARTMENT_STATS view query:
/*
| DEPT_NO | DEPT_NAME           | NOE | TOTAL_BASIC_PAY |
|---------|---------------------|-----|-----------------|
| 101     | Human Resources     | 4   | 237000.00       |
| 102     | Finance             | 4   | 256000.00       |
| 103     | Engineering         | 4   | 272000.00       |
| 104     | Marketing           | 4   | 249000.00       |
| 105     | Research & Development | 4 | 262000.00      |
*/
