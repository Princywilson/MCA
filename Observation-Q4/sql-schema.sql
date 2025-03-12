-- Create Tables with Constraints

-- Department Table
CREATE TABLE DEPARTMENT (
    DEPT_NO VARCHAR(10) PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    MENO VARCHAR(10), -- FK to be added later due to circular dependency
    NOE INT DEFAULT 0
);

-- Employee Table
CREATE TABLE EMPLOYEE (
    ENO VARCHAR(10) PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    GENDER CHAR(1) CHECK (GENDER IN ('M', 'F', 'O')), -- Check constraint for GENDER
    DOB DATE NOT NULL,
    DOJ DATE NOT NULL,
    DESIGNATION VARCHAR(50) NOT NULL,
    BASIC DECIMAL(10, 2) NOT NULL,
    DEPT_NO VARCHAR(10) NOT NULL,
    PANNO VARCHAR(10) UNIQUE,
    SENO VARCHAR(10),
    FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO),
    FOREIGN KEY (SENO) REFERENCES EMPLOYEE(ENO)
);

-- Add the foreign key for MENO in DEPARTMENT after EMPLOYEE is created (resolving circular dependency)
ALTER TABLE DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_EMPLOYEE
FOREIGN KEY (MENO) REFERENCES EMPLOYEE(ENO);

-- Project Table
CREATE TABLE PROJECT (
    PROJ_NO VARCHAR(10) PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    DEPT_NO VARCHAR(10) NOT NULL,
    FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO)
);

-- WorksFor Table
CREATE TABLE WORKSFOR (
    ENO VARCHAR(10),
    PROJ_NO VARCHAR(10),
    DATE_WORKED DATE,
    HOURS DECIMAL(5, 2) CHECK (HOURS > 0 AND HOURS <= 24),
    PRIMARY KEY (ENO, PROJ_NO, DATE_WORKED),
    FOREIGN KEY (ENO) REFERENCES EMPLOYEE(ENO),
    FOREIGN KEY (PROJ_NO) REFERENCES PROJECT(PROJ_NO)
);

-- Populate the Database

-- Insert Departments (initially without MENO due to circular dependency)
INSERT INTO DEPARTMENT (DEPT_NO, NAME, NOE) VALUES
('D001', 'Human Resources', 0),
('D002', 'Engineering', 0),
('D003', 'Finance', 0),
('D004', 'Marketing', 0),
('D005', 'Research', 0);

-- Insert Employees
INSERT INTO EMPLOYEE (ENO, NAME, GENDER, DOB, DOJ, DESIGNATION, BASIC, DEPT_NO, PANNO, SENO) VALUES
('E001', 'John Smith', 'M', '1980-05-15', '2010-01-10', 'HR Manager', 85000.00, 'D001', 'PAN001', NULL),
('E002', 'Jane Doe', 'F', '1985-08-20', '2012-03-15', 'Senior Engineer', 80000.00, 'D002', 'PAN002', NULL),
('E003', 'Robert Johnson', 'M', '1975-12-03', '2008-07-20', 'Finance Manager', 90000.00, 'D003', 'PAN003', NULL),
('E004', 'Emily Brown', 'F', '1988-04-25', '2014-09-05', 'Marketing Manager', 78000.00, 'D004', 'PAN004', NULL),
('E005', 'Michael Chen', 'M', '1982-10-08', '2011-11-12', 'Research Manager', 88000.00, 'D005', 'PAN005', NULL);

-- Update SENO for the first set of employees
UPDATE EMPLOYEE SET SENO = 'E001' WHERE ENO IN ('E001');
UPDATE EMPLOYEE SET SENO = 'E002' WHERE ENO IN ('E002');
UPDATE EMPLOYEE SET SENO = 'E003' WHERE ENO IN ('E003');
UPDATE EMPLOYEE SET SENO = 'E004' WHERE ENO IN ('E004');
UPDATE EMPLOYEE SET SENO = 'E005' WHERE ENO IN ('E005');

-- Insert more employees with supervisors
INSERT INTO EMPLOYEE (ENO, NAME, GENDER, DOB, DOJ, DESIGNATION, BASIC, DEPT_NO, PANNO, SENO) VALUES
('E006', 'Sarah Wilson', 'F', '1990-06-18', '2015-04-22', 'HR Assistant', 55000.00, 'D001', 'PAN006', 'E001'),
('E007', 'David Lee', 'M', '1987-09-30', '2014-02-15', 'Software Engineer', 75000.00, 'D002', 'PAN007', 'E002'),
('E008', 'Amanda Miller', 'F', '1991-11-12', '2016-08-10', 'Financial Analyst', 65000.00, 'D003', 'PAN008', 'E003'),
('E009', 'Thomas Wright', 'M', '1986-03-28', '2013-10-05', 'Marketing Specialist', 62000.00, 'D004', 'PAN009', 'E004'),
('E010', 'Linda Garcia', 'F', '1989-07-14', '2015-12-18', 'Research Analyst', 70000.00, 'D005', 'PAN010', 'E005');

-- Update Department Managers
UPDATE DEPARTMENT SET MENO = 'E001' WHERE DEPT_NO = 'D001';
UPDATE DEPARTMENT SET MENO = 'E002' WHERE DEPT_NO = 'D002';
UPDATE DEPARTMENT SET MENO = 'E003' WHERE DEPT_NO = 'D003';
UPDATE DEPARTMENT SET MENO = 'E004' WHERE DEPT_NO = 'D004';
UPDATE DEPARTMENT SET MENO = 'E005' WHERE DEPT_NO = 'D005';

-- Manually update NOE in departments (later this will be handled by triggers)
UPDATE DEPARTMENT SET NOE = 2 WHERE DEPT_NO = 'D001';
UPDATE DEPARTMENT SET NOE = 2 WHERE DEPT_NO = 'D002';
UPDATE DEPARTMENT SET NOE = 2 WHERE DEPT_NO = 'D003';
UPDATE DEPARTMENT SET NOE = 2 WHERE DEPT_NO = 'D004';
UPDATE DEPARTMENT SET NOE = 2 WHERE DEPT_NO = 'D005';

-- Insert Projects
INSERT INTO PROJECT (PROJ_NO, NAME, DEPT_NO) VALUES
('P001', 'Employee Management System', 'D001'),
('P002', 'Web Application Development', 'D002'),
('P003', 'Financial Reporting System', 'D003'),
('P004', 'Digital Marketing Campaign', 'D004'),
('P005', 'New Product Research', 'D005'),
('P006', 'Mobile App Development', 'D002'),
('P007', 'Annual Budget Planning', 'D003'),
('P008', 'Social Media Strategy', 'D004');

-- Insert WorksFor data
INSERT INTO WORKSFOR (ENO, PROJ_NO, DATE_WORKED, HOURS) VALUES
('E001', 'P001', '2023-01-10', 8.0),
('E006', 'P001', '2023-01-10', 7.5),
('E002', 'P002', '2023-01-10', 8.0),
('E007', 'P002', '2023-01-10', 8.0),
('E002', 'P006', '2023-01-10', 4.0),
('E007', 'P006', '2023-01-10', 4.0),
('E003', 'P003', '2023-01-10', 8.0),
('E008', 'P003', '2023-01-10', 7.0),
('E003', 'P007', '2023-01-10', 2.0),
('E008', 'P007', '2023-01-10', 3.0),
('E004', 'P004', '2023-01-10', 6.0),
('E009', 'P004', '2023-01-10', 8.0),
('E004', 'P008', '2023-01-10', 4.0),
('E009', 'P008', '2023-01-10', 2.0),
('E005', 'P005', '2023-01-10', 8.0),
('E010', 'P005', '2023-01-10', 7.5);
