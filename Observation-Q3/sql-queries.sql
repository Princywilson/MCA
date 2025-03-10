-- 1. List the details of departments that offer more than three branches
SELECT d.*
FROM DEPARTMENT d
JOIN BRANCH b ON d.DNO = b.DNO
GROUP BY d.DNO, d.DNAME
HAVING COUNT(b.BCODE) > 3;

-- Sample output:
-- DNO | DNAME
-- 1   | Computer Science

-- 2. List the details of courses that do not have prerequisite courses
SELECT c.*
FROM COURSE c
WHERE c.CCODE NOT IN (SELECT CCODE FROM PREREQUISITE_COURSE);

-- Sample output:
-- CCODE | CNAME                  | CREDITS | DNO
-- EC101 | Digital Electronics    | 4       | 3
-- EE101 | Electrical Circuits    | 4       | 4
-- ME101 | Engineering Mechanics  | 4       | 5
-- CS109 | Software Engineering   | 3       | 1

-- 3. List the details of courses that are common for more than three branches
SELECT c.*
FROM COURSE c
JOIN BRANCH_COURSE bc ON c.CCODE = bc.CCODE
GROUP BY c.CCODE, c.CNAME, c.CREDITS, c.DNO
HAVING COUNT(DISTINCT bc.BCODE) > 3;

-- Sample output:
-- CCODE | CNAME                   | CREDITS | DNO
-- CS101 | Introduction to Programming | 4   | 1
-- CS102 | Data Structures         | 4       | 1
-- CS103 | Database Management Systems | 4   | 1

-- 4. List the details of students who have got a 'U' grade in more than two courses during a single enrollment
SELECT s.*, e.SESS
FROM STUDENT s
JOIN ENROLLS e ON s.ROLLNO = e.ROLLNO
WHERE e.GRADE = 'U'
GROUP BY s.ROLLNO, s.NAME, s.DOB, s.GENDER, s.DOA, s.BCODE, e.SESS
HAVING COUNT(e.CCODE) > 2;

-- Sample output:
-- ROLLNO | NAME     | DOB        | GENDER | DOA        | BCODE
-- (No results with our current dataset)

-- 5. Create a view that will keep track of the course code, name and number of prerequisite courses
CREATE VIEW COURSE_PREREQS AS
SELECT c.CCODE, c.CNAME, COUNT(pc.PCCODE) AS NUM_PREREQS
FROM COURSE c
LEFT JOIN PREREQUISITE_COURSE pc ON c.CCODE = pc.CCODE
GROUP BY c.CCODE, c.CNAME;

-- To view the results of the view:
SELECT * FROM COURSE_PREREQS;

-- Sample output:
-- CCODE | CNAME                   | NUM_PREREQS
-- CS101 | Introduction to Programming | 0
-- CS102 | Data Structures         | 1
-- CS103 | Database Management Systems | 1
-- CS104 | Advanced Databases      | 1
-- ...

-- 6. Database trigger that will not permit a student to enroll for a course if they have not completed the prerequisite courses
DELIMITER //
CREATE TRIGGER check_prerequisites 
BEFORE INSERT ON ENROLLS
FOR EACH ROW
BEGIN
    DECLARE prereq_count INT;
    DECLARE completed_count INT;
    
    -- Count the number of prerequisites for the course
    SELECT COUNT(*) INTO prereq_count
    FROM PREREQUISITE_COURSE
    WHERE CCODE = NEW.CCODE;
    
    -- Count the number of completed prerequisites
    SELECT COUNT(*) INTO completed_count
    FROM PREREQUISITE_COURSE pc
    JOIN ENROLLS e ON pc.PCCODE = e.CCODE
    WHERE pc.CCODE = NEW.CCODE
    AND e.ROLLNO = NEW.ROLLNO
    AND e.GRADE IN ('S', 'A', 'B', 'C', 'D', 'E');
    
    -- If there are prerequisites and not all have been completed
    IF (prereq_count > 0 AND completed_count < prereq_count) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student has not completed all prerequisite courses';
    END IF;
END //
DELIMITER ;
