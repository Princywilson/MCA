-- Creating the schema for the controller of examinations application

-- DEPARTMENT table
CREATE TABLE DEPARTMENT (
    DNO INT PRIMARY KEY,
    DNAME VARCHAR(50) NOT NULL
);

-- BRANCH table
CREATE TABLE BRANCH (
    BCODE VARCHAR(10) PRIMARY KEY,
    BNAME VARCHAR(50) NOT NULL,
    DNO INT NOT NULL,
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNO)
);

-- STUDENT table
CREATE TABLE STUDENT (
    ROLLNO VARCHAR(10) PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    GENDER CHAR(1) NOT NULL,
    DOA DATE NOT NULL,
    BCODE VARCHAR(10) NOT NULL,
    FOREIGN KEY (BCODE) REFERENCES BRANCH(BCODE),
    CONSTRAINT CHK_GENDER CHECK (GENDER IN ('M', 'F', 'O'))
);

-- COURSE table
CREATE TABLE COURSE (
    CCODE VARCHAR(10) PRIMARY KEY,
    CNAME VARCHAR(50) NOT NULL,
    CREDITS INT NOT NULL,
    DNO INT NOT NULL,
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNO),
    CONSTRAINT CHK_CREDITS CHECK (CREDITS > 0)
);

-- BRANCH_COURSE table
CREATE TABLE BRANCH_COURSE (
    BCODE VARCHAR(10) NOT NULL,
    CCODE VARCHAR(10) NOT NULL,
    SEMESTER INT NOT NULL,
    PRIMARY KEY (BCODE, CCODE),
    FOREIGN KEY (BCODE) REFERENCES BRANCH(BCODE),
    FOREIGN KEY (CCODE) REFERENCES COURSE(CCODE),
    CONSTRAINT CHK_SEMESTER CHECK (SEMESTER BETWEEN 1 AND 8)
);

-- PREREQUISITE_COURSE table
CREATE TABLE PREREQUISITE_COURSE (
    CCODE VARCHAR(10) NOT NULL,
    PCCODE VARCHAR(10) NOT NULL,
    PRIMARY KEY (CCODE, PCCODE),
    FOREIGN KEY (CCODE) REFERENCES COURSE(CCODE),
    FOREIGN KEY (PCCODE) REFERENCES COURSE(CCODE),
    CONSTRAINT CHK_DIFF_COURSES CHECK (CCODE <> PCCODE)
);

-- ENROLLS table
CREATE TABLE ENROLLS (
    ROLLNO VARCHAR(10) NOT NULL,
    CCODE VARCHAR(10) NOT NULL,
    SESS VARCHAR(20) NOT NULL,
    GRADE CHAR(1) NOT NULL,
    PRIMARY KEY (ROLLNO, CCODE, SESS),
    FOREIGN KEY (ROLLNO) REFERENCES STUDENT(ROLLNO),
    FOREIGN KEY (CCODE) REFERENCES COURSE(CCODE),
    CONSTRAINT CHK_GRADE CHECK (GRADE IN ('S', 'A', 'B', 'C', 'D', 'E', 'U'))
);

-- Populating the database with minimal sample data

-- Insert data into DEPARTMENT
INSERT INTO DEPARTMENT (DNO, DNAME) VALUES
(1, 'Computer Science'),
(2, 'Information Technology'),
(3, 'Electronics and Communication');

-- Insert data into BRANCH
INSERT INTO BRANCH (BCODE, BNAME, DNO) VALUES
('CSE', 'Computer Science and Engineering', 1),
('IT', 'Information Technology', 2),
('ECE', 'Electronics and Communication Engineering', 3),
('DS', 'Data Science', 1),
('AI', 'Artificial Intelligence', 1),
('SE', 'Software Engineering', 1);

-- Insert data into STUDENT
INSERT INTO STUDENT (ROLLNO, NAME, DOB, GENDER, DOA, BCODE) VALUES
('S001', 'John Doe', '2000-05-15', 'M', '2020-08-01', 'CSE'),
('S002', 'Jane Smith', '2001-03-21', 'F', '2020-08-01', 'IT'),
('S003', 'Robert Brown', '2000-11-10', 'M', '2020-08-01', 'ECE'),
('S004', 'Sarah Johnson', '2001-01-30', 'F', '2020-08-01', 'DS');

-- Insert data into COURSE
INSERT INTO COURSE (CCODE, CNAME, CREDITS, DNO) VALUES
('CS101', 'Introduction to Programming', 4, 1),
('CS102', 'Data Structures', 4, 1),
('CS103', 'Database Management Systems', 4, 1),
('CS104', 'Advanced Databases', 3, 1),
('IT101', 'Web Development', 3, 2),
('EC101', 'Digital Electronics', 4, 3);

-- Insert data into BRANCH_COURSE
INSERT INTO BRANCH_COURSE (BCODE, CCODE, SEMESTER) VALUES
('CSE', 'CS101', 1),
('CSE', 'CS102', 2),
('CSE', 'CS103', 3),
('CSE', 'CS104', 4),
('IT', 'CS101', 1),
('IT', 'CS102', 2),
('IT', 'IT101', 3),
('ECE', 'CS101', 1),
('ECE', 'EC101', 2),
('DS', 'CS101', 1),
('DS', 'CS102', 2),
('DS', 'CS103', 3),
('AI', 'CS101', 1),
('AI', 'CS102', 2),
('SE', 'CS101', 1),
('SE', 'CS102', 2);

-- Insert data into PREREQUISITE_COURSE
INSERT INTO PREREQUISITE_COURSE (CCODE, PCCODE) VALUES
('CS102', 'CS101'),
('CS103', 'CS102'),
('CS104', 'CS103'),
('IT101', 'CS101');

-- Insert data into ENROLLS
INSERT INTO ENROLLS (ROLLNO, CCODE, SESS, GRADE) VALUES
-- S001 is a student with multiple U grades in a semester
('S001', 'CS101', 'APRIL2021', 'A'),
('S001', 'CS102', 'NOVEMBER2021', 'B'),
('S001', 'CS103', 'APRIL2022', 'U'),
('S001', 'CS104', 'APRIL2022', 'U'),
('S001', 'CS104', 'NOVEMBER2022', 'U'),

-- S002 is a student with completed prerequisites
('S002', 'CS101', 'APRIL2021', 'A'),
('S002', 'CS102', 'NOVEMBER2021', 'B'),
('S002', 'CS103', 'APRIL2022', 'C'),

-- S003 is a student with non-CS courses
('S003', 'CS101', 'APRIL2021', 'B'),
('S003', 'EC101', 'NOVEMBER2021', 'A'),

-- S004 has repeated a course after getting U
('S004', 'CS101', 'APRIL2021', 'A'),
('S004', 'CS102', 'NOVEMBER2021', 'U'),
('S004', 'CS102', 'APRIL2022', 'B');
