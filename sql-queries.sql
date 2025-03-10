-- 1. DATABASE SCHEMA CREATION (DDL)

-- Create CUSTOMER table
CREATE TABLE CUSTOMER (
    CID INT PRIMARY KEY,
    CNAME VARCHAR(50) NOT NULL
);

-- Create BRANCH table
CREATE TABLE BRANCH (
    BCODE VARCHAR(10) PRIMARY KEY,
    BNAME VARCHAR(50) NOT NULL
);

-- Create ACCOUNT table
CREATE TABLE ACCOUNT (
    ANO VARCHAR(15) PRIMARY KEY,
    ATYPE CHAR(1) NOT NULL,
    BALANCE DECIMAL(12,2) NOT NULL,
    CID INT NOT NULL,
    BCODE VARCHAR(10) NOT NULL,
    CONSTRAINT CHK_ATYPE CHECK (ATYPE IN ('S', 'C')),
    CONSTRAINT FK_ACCOUNT_CUSTOMER FOREIGN KEY (CID) REFERENCES CUSTOMER(CID),
    CONSTRAINT FK_ACCOUNT_BRANCH FOREIGN KEY (BCODE) REFERENCES BRANCH(BCODE)
);

-- Create TRANSACTION table
CREATE TABLE TRANSACTION (
    TID INT PRIMARY KEY,
    ANO VARCHAR(15) NOT NULL,
    TTYPE CHAR(1) NOT NULL,
    TDATE DATE NOT NULL,
    TAMOUNT DECIMAL(12,2) NOT NULL,
    CONSTRAINT CHK_TTYPE CHECK (TTYPE IN ('D', 'W')),
    CONSTRAINT FK_TRANSACTION_ACCOUNT FOREIGN KEY (ANO) REFERENCES ACCOUNT(ANO)
);

-- 2. INSERT SAMPLE DATA

-- Insert data into CUSTOMER table
INSERT INTO CUSTOMER (CID, CNAME) VALUES 
(1, 'John Smith'),
(2, 'Mary Johnson'),
(3, 'Robert Brown'),
(4, 'Patricia Davis'),
(5, 'Michael Wilson');

-- Insert data into BRANCH table
INSERT INTO BRANCH (BCODE, BNAME) VALUES 
('B001', 'Main Street Branch'),
('B002', 'Downtown Branch'),
('B003', 'North Hills Branch'),
('B004', 'University Branch');

-- Insert data into ACCOUNT table
INSERT INTO ACCOUNT (ANO, ATYPE, BALANCE, CID, BCODE) VALUES 
('A001', 'S', 12000.00, 1, 'B001'),
('A002', 'C', 25000.00, 1, 'B001'),
('A003', 'S', 15000.00, 2, 'B002'),
('A004', 'C', 30000.00, 2, 'B003'),
('A005', 'S', 9000.00, 3, 'B002'),
('A006', 'C', 18000.00, 3, 'B002'),
('A007', 'S', 22000.00, 4, 'B003'),
('A008', 'S', 8000.00, 5, 'B004');

-- Insert data into TRANSACTION table
INSERT INTO TRANSACTION (TID, ANO, TTYPE, TDATE, TAMOUNT) VALUES 
(1, 'A001', 'D', '2023-01-15', 5000.00),
(2, 'A002', 'W', '2023-01-15', 3000.00),
(3, 'A003', 'D', '2023-01-16', 2000.00),
(4, 'A001', 'W', '2023-01-17', 1000.00),
(5, 'A004', 'D', '2023-01-17', 10000.00),
(6, 'A005', 'W', '2023-01-17', 1500.00),
(7, 'A001', 'D', '2023-01-18', 3000.00),
(8, 'A006', 'W', '2023-01-18', 2000.00),
(9, 'A007', 'D', '2023-01-18', 4000.00),
(10, 'A001', 'D', '2023-01-18', 2000.00),
(11, 'A001', 'W', '2023-01-18', 1000.00),
(12, 'A008', 'D', '2023-01-19', 3000.00);

-- 3. SQL QUERIES

-- Query 1: List customers who have both a savings account and a current account
SELECT DISTINCT c.CID, c.CNAME 
FROM CUSTOMER c
WHERE EXISTS (
    SELECT 1 FROM ACCOUNT a1 
    WHERE a1.CID = c.CID AND a1.ATYPE = 'S'
) 
AND EXISTS (
    SELECT 1 FROM ACCOUNT a2 
    WHERE a2.CID = c.CID AND a2.ATYPE = 'C'
);

-- Query 2: List branches and the number of accounts in each branch
SELECT b.BCODE, b.BNAME, COUNT(a.ANO) AS ACCOUNT_COUNT
FROM BRANCH b
LEFT JOIN ACCOUNT a ON b.BCODE = a.BCODE
GROUP BY b.BCODE, b.BNAME
ORDER BY ACCOUNT_COUNT DESC;

-- Query 3: List branches where the number of accounts is less than the average
SELECT b.BCODE, b.BNAME, COUNT(a.ANO) AS ACCOUNT_COUNT
FROM BRANCH b
LEFT JOIN ACCOUNT a ON b.BCODE = a.BCODE
GROUP BY b.BCODE, b.BNAME
HAVING COUNT(a.ANO) < (
    SELECT AVG(ACCOUNT_PER_BRANCH) 
    FROM (
        SELECT COUNT(ANO) AS ACCOUNT_PER_BRANCH
        FROM ACCOUNT
        GROUP BY BCODE
    ) AS AVG_ACCOUNTS
)
ORDER BY ACCOUNT_COUNT;

-- Query 4: List customers who have performed three transactions on a day
SELECT c.CID, c.CNAME, t.TDATE, COUNT(t.TID) AS TRANSACTION_COUNT
FROM CUSTOMER c
JOIN ACCOUNT a ON c.CID = a.CID
JOIN TRANSACTION t ON a.ANO = t.ANO
GROUP BY c.CID, c.CNAME, t.TDATE
HAVING COUNT(t.TID) >= 3
ORDER BY t.TDATE;

-- 4. CREATE VIEW FOR BRANCH ACCOUNT SUMMARY
CREATE VIEW BRANCH_ACCOUNT_SUMMARY AS
SELECT b.BCODE, b.BNAME, COUNT(a.ANO) AS ACCOUNT_COUNT, 
       SUM(a.BALANCE) AS TOTAL_BALANCE
FROM BRANCH b
LEFT JOIN ACCOUNT a ON b.BCODE = a.BCODE
GROUP BY b.BCODE, b.BNAME;

-- View the created view
SELECT * FROM BRANCH_ACCOUNT_SUMMARY;

-- 5. TRIGGERS

-- Trigger to limit transactions to 3 per day per customer
DELIMITER //
CREATE TRIGGER limit_daily_transactions
BEFORE INSERT ON TRANSACTION
FOR EACH ROW
BEGIN
    DECLARE trans_count INT;
    DECLARE customer_id INT;
    
    -- Get the customer ID for the account
    SELECT CID INTO customer_id
    FROM ACCOUNT
    WHERE ANO = NEW.ANO;
    
    -- Count transactions by this customer today
    SELECT COUNT(*) INTO trans_count
    FROM TRANSACTION t
    JOIN ACCOUNT a ON t.ANO = a.ANO
    WHERE a.CID = customer_id
    AND t.TDATE = NEW.TDATE;
    
    -- If already at 3 transactions, prevent the insert
    IF trans_count >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Customer has already performed 3 transactions today';
    END IF;
END //
DELIMITER ;

-- Trigger to update account balance on transaction
DELIMITER //
CREATE TRIGGER update_account_balance
AFTER INSERT ON TRANSACTION
FOR EACH ROW
BEGIN
    DECLARE acc_type CHAR(1);
    DECLARE curr_balance DECIMAL(12,2);
    DECLARE min_balance DECIMAL(12,2);
    
    -- Get current account details
    SELECT ATYPE, BALANCE INTO acc_type, curr_balance
    FROM ACCOUNT
    WHERE ANO = NEW.ANO;
    
    -- Set minimum balance based on account type
    IF acc_type = 'S' THEN
        SET min_balance = 2000.00;
    ELSE
        SET min_balance = 5000.00;
    END IF;
    
    -- For deposit, simply add amount
    IF NEW.TTYPE = 'D' THEN
        UPDATE ACCOUNT
        SET BALANCE = BALANCE + NEW.TAMOUNT
        WHERE ANO = NEW.ANO;
    
    -- For withdrawal, check if minimum balance will be maintained
    ELSEIF NEW.TTYPE = 'W' THEN
        IF (curr_balance - NEW.TAMOUNT) >= min_balance THEN
            UPDATE ACCOUNT
            SET BALANCE = BALANCE - NEW.TAMOUNT
            WHERE ANO = NEW.ANO;
        ELSE
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Withdrawal would violate minimum balance requirement';
        END IF;
    END IF;
END //
DELIMITER ;
