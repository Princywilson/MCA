-- Populating the database with sample data

-- Insert data into DEPARTMENT
INSERT INTO DEPARTMENT (DNO, DNAME) VALUES
(1, 'Computer Science'),
(2, 'Information Technology'),
(3, 'Electronics and Communication'),
(4, 'Electrical and Electronics'),
(5, 'Mechanical Engineering');

-- Insert data into BRANCH
INSERT INTO BRANCH (BCODE, BNAME, DNO) VALUES
('CSE', 'Computer Science and Engineering', 1),
('IT', 'Information Technology', 2),
('ECE', 'Electronics and Communication Engineering', 3),
('EEE', 'Electrical and Electronics Engineering', 4),
('MECH', 'Mechanical Engineering', 5),
('DS', 'Data Science', 1),
('AI', 'Artificial Intelligence', 1),
('SE', 'Software Engineering', 2);

-- Insert data into STUDENT
INSERT INTO STUDENT (ROLLNO, NAME, DOB, GENDER, DOA, BCODE) VALUES
('S001', 'John Doe', '2000-05-15', 'M', '2020-08-01', 'CSE'),
('S002', 'Jane Smith', '2001-03-21', 'F', '2020-08-01', 'IT'),
('S003', 'Robert Brown', '2000-11-10', 'M', '2020-08-01', 'ECE'),
('S004', 'Emily Davis', '2001-07-18', 'F', '2020-08-01', 'EEE'),
('S005', 'Michael Wilson', '2000-09-22', 'M', '2020-08-01', 'MECH'),
('S006', 'Sarah Johnson', '2001-01-30', 'F', '2020-08-01', 'DS'),
('S007', 'David Lee', '2000-12-05', 'M', '2020-08-01', 'AI'),
('S008', 'Lisa Wang', '2001-04-14', 'F', '2020-08-01', 'SE'),
('S009', 'Alex Torres', '2000-08-19', 'M', '2020-08-01', 'CSE'),
('S010', 'Emma White', '2001-06-25', 'F', '2020-08-01', 'IT');

-- Insert data into COURSE
INSERT INTO COURSE (CCODE, CNAME, CREDITS, DNO) VALUES
('CS101', 'Introduction to Programming', 4, 1),
('CS102', 'Data Structures', 4, 1),
('CS103', 'Database Management Systems', 4, 1),
('CS104', 'Advanced Databases', 3, 1),
('CS105', 'Operating Systems', 4, 1),
('IT101', 'Web Development', 3, 2),
('IT102', 'Network Security', 3, 2),
('EC101', 'Digital Electronics', 4, 3),
('EE101', 'Electrical Circuits', 4, 4),
('ME101', 'Engineering Mechanics', 4, 5),
('CS106', 'Computer Networks', 3, 1),
('CS107', 'Artificial Intelligence', 4, 1),
('CS108', 'Machine Learning', 4, 1),
('IT103', 'Cloud Computing', 3, 2),
('CS109', 'Software Engineering', 3, 1);

-- Insert data into BRANCH_COURSE
INSERT INTO BRANCH_COURSE (BCODE, CCODE, SEMESTER) VALUES
('CSE', 'CS101', 1),
('CSE', 'CS102', 2),
('CSE', 'CS103', 3),
('CSE', 'CS104', 4),
('CSE', 'CS105', 3),
('CSE', 'CS106', 4),
('IT', 'CS101', 1),
('IT', 'CS102', 2),
('IT', 'IT101', 3),
('IT', 'IT102', 4),
('ECE', 'CS101', 1),
('ECE', 'EC101', 2),
('EEE', 'EE101', 1),
('MECH', 'ME101', 1),
('DS', 'CS101', 1),
('DS', 'CS102', 2),
('DS', 'CS103', 3),
('DS', 'CS108', 4),
('AI', 'CS101', 1),
('AI', 'CS102', 2),
('AI', 'CS107', 3),
('AI', 'CS108', 4),
('SE', 'CS101', 1),
('SE', 'CS102', 2),
('SE', 'CS103', 3),
('SE', 'CS109', 4);

-- Insert data into PREREQUISITE_COURSE
INSERT INTO PREREQUISITE_COURSE (CCODE, PCCODE) VALUES
('CS102', 'CS101'),
('CS103', 'CS102'),
('CS104', 'CS103'),
('CS105', 'CS101'),
('CS106', 'CS101'),
('CS107', 'CS102'),
('CS108', 'CS107'),
('IT101', 'CS101'),
('IT102', 'IT101'),
('IT103', 'IT101');

-- Insert data into ENROLLS
INSERT INTO ENROLLS (ROLLNO, CCODE, SESS, GRADE) VALUES
('S001', 'CS101', 'APRIL2021', 'A'),
('S001', 'CS102', 'NOVEMBER2021', 'B'),
('S001', 'CS103', 'APRIL2022', 'C'),
('S001', 'CS104', 'NOVEMBER2022', 'U'),
('S001', 'CS104', 'APRIL2023', 'B'),
('S001', 'CS105', 'APRIL2022', 'U'),
('S001', 'CS105', 'NOVEMBER2022', 'U'),
('S001', 'CS105', 'APRIL2023', 'D'),

('S002', 'CS101', 'APRIL2021', 'S'),
('S002', 'CS102', 'NOVEMBER2021', 'A'),
('S002', 'IT101', 'APRIL2022', 'B'),
('S002', 'IT102', 'NOVEMBER2022', 'C'),

('S003', 'CS101', 'APRIL2021', 'B'),
('S003', 'EC101', 'NOVEMBER2021', 'C'),
('S003', 'CS101', 'NOVEMBER2021', 'U'),
('S003', 'CS101', 'APRIL2022', 'A'),

('S004', 'EE101', 'APRIL2021', 'A'),

('S005', 'ME101', 'APRIL2021', 'B'),

('S006', 'CS101', 'APRIL2021', 'A'),
('S006', 'CS102', 'NOVEMBER2021', 'B'),
('S006', 'CS103', 'APRIL2022', 'U'),
('S006', 'CS103', 'NOVEMBER2022', 'B'),
('S006', 'CS108', 'NOVEMBER2022', 'U'),
('S006', 'CS108', 'APRIL2023', 'U'),
('S006', 'CS108', 'NOVEMBER2023', 'C'),

('S007', 'CS101', 'APRIL2021', 'A'),
('S007', 'CS102', 'NOVEMBER2021', 'B'),
('S007', 'CS107', 'APRIL2022', 'C'),
('S007', 'CS108', 'NOVEMBER2022', 'D'),

('S008', 'CS101', 'APRIL2021', 'S'),
('S008', 'CS102', 'NOVEMBER2021', 'A'),
('S008', 'CS103', 'APRIL2022', 'U'),
('S008', 'CS103', 'NOVEMBER2022', 'B'),
('S008', 'CS109', 'NOVEMBER2022', 'A'),

('S009', 'CS101', 'APRIL2021', 'B'),
('S009', 'CS102', 'NOVEMBER2021', 'C'),
('S009', 'CS103', 'APRIL2022', 'U'),
('S009', 'CS103', 'NOVEMBER2022', 'U'),
('S009', 'CS103', 'APRIL2023', 'D'),
('S009', 'CS105', 'APRIL2022', 'U'),
('S009', 'CS105', 'NOVEMBER2022', 'C'),

('S010', 'CS101', 'APRIL2021', 'A'),
('S010', 'CS102', 'NOVEMBER2021', 'U'),
('S010', 'CS102', 'APRIL2022', 'U'),
('S010', 'CS102', 'NOVEMBER2022', 'B'),
('S010', 'IT101', 'NOVEMBER2022', 'C');
