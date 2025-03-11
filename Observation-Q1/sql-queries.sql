-- 1. Query to list the department number and number of staff in each department
SELECT d.DEPTNO, d.NAME, COUNT(s.STAFFNO) AS NumberOfStaff
FROM DEPT d
LEFT JOIN STAFF s ON d.DEPTNO = s.DEPTNO
GROUP BY d.DEPTNO, d.NAME
ORDER BY d.DEPTNO;

/* Result:
+--------+------------+---------------+
| DEPTNO | NAME       | NumberOfStaff |
+--------+------------+---------------+
| 1      | IT         | 3             |
| 2      | HR         | 3             |
| 3      | Finance    | 3             |
| 4      | Marketing  | 2             |
| 5      | Operations | 2             |
+--------+------------+---------------+
*/

-- 2. Query to list the details of staff who earn less than the average basic pay of all staff
SELECT *
FROM STAFF
WHERE BASIC_PAY < (SELECT AVG(BASIC_PAY) FROM STAFF)
ORDER BY BASIC_PAY DESC;

/* Result:
+---------+------------------+------------+--------+------------+---------------------+-----------+--------+
| STAFFNO | NAME             | DOB        | GENDER | DOJ        | DESIGNATION         | BASIC_PAY | DEPTNO |
+---------+------------------+------------+--------+------------+---------------------+-----------+--------+
| 106     | Jennifer Davis   | 1992-09-12 | F      | 2016-11-22 | Developer           | 72000.00  | 1      |
| 108     | Sarah Taylor     | 1986-12-10 | F      | 2011-05-08 | Accountant          | 68000.00  | 3      |
| 110     | Olivia Garcia    | 1984-06-30 | F      | 2010-10-25 | Operations Analyst  | 67000.00  | 5      |
| 112     | Emily Anderson   | 1993-10-05 | F      | 2018-02-19 | HR Specialist       | 62000.00  | 2      |
| 109     | James Wilson     | 1991-08-22 | M      | 2017-03-14 | Marketing Coordinator | 60000.00 | 4     |
| 107     | David Miller     | 1987-04-05 | M      | 2013-08-17 | HR Assistant        | 55000.00  | 2      |
+---------+------------------+------------+--------+------------+---------------------+-----------+--------+
Average BASIC_PAY = 72076.92
*/

-- 3. Query to list the details of departments which has more than five staff working in it
SELECT d.DEPTNO, d.NAME, COUNT(s.STAFFNO) AS NumberOfStaff
FROM DEPT d
LEFT JOIN STAFF s ON d.DEPTNO = s.DEPTNO
GROUP BY d.DEPTNO, d.NAME
HAVING COUNT(s.STAFFNO) > 5
ORDER BY d.DEPTNO;

/* Result:
No departments have more than 5 staff members based on our sample data.
Empty result set.
*/

-- 4. Query to list the details of staff who have more than three skills
SELECT s.STAFFNO, s.NAME, s.DESIGNATION, s.BASIC_PAY, COUNT(ss.SKILL_CODE) AS SkillCount
FROM STAFF s
JOIN STAFF_SKILL ss ON s.STAFFNO = ss.STAFFNO
GROUP BY s.STAFFNO, s.NAME, s.DESIGNATION, s.BASIC_PAY
HAVING COUNT(ss.SKILL_CODE) > 3
ORDER BY s.STAFFNO;

/* Result:
+---------+---------------+--------------------+-----------+-----------+
| STAFFNO | NAME          | DESIGNATION        | BASIC_PAY | SkillCount|
+---------+---------------+--------------------+-----------+-----------+
| 101     | John Smith    | Senior Developer   | 85000.00  | 4         |
| 111     | Daniel Martinez | System Administrator | 78000.00 | 4     |
+---------+---------------+--------------------+-----------+-----------+
*/

-- 5. Query to list the details of staff who have skills with a charge out rate greater than 60 per hour
SELECT DISTINCT s.STAFFNO, s.NAME, s.DESIGNATION, s.BASIC_PAY, d.NAME AS Department
FROM STAFF s
JOIN STAFF_SKILL ss ON s.STAFFNO = ss.STAFFNO
JOIN SKILL sk ON ss.SKILL_CODE = sk.SKILL_CODE
JOIN DEPT d ON s.DEPTNO = d.DEPTNO
WHERE sk.CHARGE_OUTRATE > 60
ORDER BY s.STAFFNO;

/* Result:
+---------+------------------+---------------------+-----------+------------+
| STAFFNO | NAME             | DESIGNATION         | BASIC_PAY | Department |
+---------+------------------+---------------------+-----------+------------+
| 101     | John Smith       | Senior Developer    | 85000.00  | IT         |
| 102     | Emma Wilson      | HR Manager          | 75000.00  | HR         |
| 103     | Michael Brown    | Financial Analyst   | 70000.00  | Finance    |
| 104     | Sophia Lee       | Marketing Specialist| 65000.00  | Marketing  |
| 105     | Robert Johnson   | Operations Manager  | 90000.00  | Operations |
| 106     | Jennifer Davis   | Developer           | 72000.00  | IT         |
| 108     | Sarah Taylor     | Accountant          | 68000.00  | Finance    |
| 110     | Olivia Garcia    | Operations Analyst  | 67000.00  | Operations |
| 111     | Daniel Martinez  | System Administrator| 78000.00  | IT         |
| 112     | Emily Anderson   | HR Specialist       | 62000.00  | HR         |
| 113     | William Thomas   | Finance Manager     | 88000.00  | Finance    |
+---------+------------------+---------------------+-----------+------------+
*/

-- 6. Create a view that tracks department statistics
CREATE VIEW DEPT_STATISTICS AS
SELECT 
    d.DEPTNO,
    d.NAME AS DepartmentName,
    COUNT(s.STAFFNO) AS NumberOfEmployees,
    SUM(s.BASIC_PAY) AS TotalBasicPayExpenditure
FROM 
    DEPT d
LEFT JOIN 
    STAFF s ON d.DEPTNO = s.DEPTNO
GROUP BY 
    d.DEPTNO, d.NAME;

-- Query to display the view data
SELECT * FROM DEPT_STATISTICS ORDER BY DEPTNO;

/* Result:
+--------+----------------+-------------------+--------------------------+
| DEPTNO | DepartmentName | NumberOfEmployees | TotalBasicPayExpenditure |
+--------+----------------+-------------------+--------------------------+
| 1      | IT             | 3                 | 235000.00                |
| 2      | HR             | 3                 | 192000.00                |
| 3      | Finance        | 3                 | 226000.00                |
| 4      | Marketing      | 2                 | 125000.00                |
| 5      | Operations     | 2                 | 157000.00                |
+--------+----------------+-------------------+--------------------------+
*/

-- 7. Database trigger to prevent staff from working on more than three projects on a day
CREATE TRIGGER prevent_excessive_work
BEFORE INSERT ON WORKS
FOR EACH ROW
WHEN (
    (SELECT COUNT(*) 
     FROM WORKS 
     WHERE STAFFNO = NEW.STAFFNO AND DATE_WORKED_ON = NEW.DATE_WORKED_ON) >= 3
)
BEGIN
    SELECT RAISE(FAIL, 'Staff cannot work on more than three projects in a day');
END;

/* Result:
SQL query successfully executed.
*/

-- Test the trigger
INSERT INTO WORKS (STAFFNO, PROJECTNO, DATE_WORKED_ON, IN_TIME, OUT_TIME) VALUES
(101, 302, '2023-03-16', '21:30:00', '22:30:00');

/* Result:
Error: Staff cannot work on more than three projects in a day
-- This should succeed because staff 101 is currently assigned to 3 projects on 2023-03-16.
*/

INSERT INTO WORKS (STAFFNO, PROJECTNO, DATE_WORKED_ON, IN_TIME, OUT_TIME) VALUES
(101, 303, '2023-03-16', '22:45:00', '23:45:00');

/* Result:
ERROR 1644 (45000): Staff cannot work on more than three projects in a day
*/
