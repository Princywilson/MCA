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

/* 
Result:
CID	CNAME
1	John Smith
2	Mary Johnson
3	Robert Brown
*/

-- Query 2: List branches and the number of accounts in each branch
SELECT b.BCODE, b.BNAME, COUNT(a.ANO) AS ACCOUNT_COUNT
FROM BRANCH b
LEFT JOIN ACCOUNT a ON b.BCODE = a.BCODE
GROUP BY b.BCODE, b.BNAME
ORDER BY ACCOUNT_COUNT DESC;

/*
Result:
BCODE	BNAME	            ACCOUNT_COUNT
B002	Downtown Branch	    3
B001	Main Street Branch	2
B003	North Hills Branch	2
B004	University Branch	1
*/

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

/*
Result:
BCODE	BNAME	            ACCOUNT_COUNT
B004	University Branch	1
*/

-- Query 4: List customers who have performed three transactions on a day
SELECT c.CID, c.CNAME, t.TDATE, COUNT(t.TID) AS TRANSACTION_COUNT
FROM CUSTOMER c
JOIN ACCOUNT a ON c.CID = a.CID
JOIN TRANSACTIONS t ON a.ANO = t.ANO
GROUP BY c.CID, c.CNAME, t.TDATE
HAVING COUNT(t.TID) >= 3
ORDER BY t.TDATE;

/*
Result:
SQL query successfully executed. However, the result set is empty.
*/

-- 4. CREATE VIEW FOR BRANCH ACCOUNT SUMMARY
CREATE VIEW BRANCH_ACCOUNT_SUMMARY AS
SELECT b.BCODE, b.BNAME, COUNT(a.ANO) AS ACCOUNT_COUNT, 
       SUM(a.BALANCE) AS TOTAL_BALANCE
FROM BRANCH b
LEFT JOIN ACCOUNT a ON b.BCODE = a.BCODE
GROUP BY b.BCODE, b.BNAME;

-- View the created view
SELECT * FROM BRANCH_ACCOUNT_SUMMARY;

/*
Result:
BCODE	BNAME	            ACCOUNT_COUNT	TOTAL_BALANCE
B001	Main Street Branch	2	            37000
B002	Downtown Branch	    3	            42000
B003	North Hills Branch	2	            52000
B004	University Branch	1	            8000
*/

-- 5. TRIGGERS

-- Trigger to limit transactions to 3 per day per customer
CREATE TRIGGER limit_daily_transactions
BEFORE INSERT ON TRANSACTIONS
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN (
            SELECT COUNT(*)
            FROM TRANSACTIONS t
            JOIN ACCOUNT a ON t.ANO = a.ANO
            WHERE a.CID = (SELECT CID FROM ACCOUNT WHERE ANO = NEW.ANO)
            AND t.TDATE = NEW.TDATE
        ) >= 3
        THEN RAISE(ABORT, 'Customer has already performed 3 transactions today')
    END;
END;

-- Trigger to update account balance on transaction
CREATE TRIGGER update_account_balance
AFTER INSERT ON TRANSACTIONS
FOR EACH ROW
BEGIN
    -- For deposit
    UPDATE ACCOUNT
    SET BALANCE = BALANCE + NEW.TAMOUNT
    WHERE ANO = NEW.ANO AND NEW.TTYPE = 'D';
    
    -- For withdrawal - check minimum balance
    SELECT CASE
        WHEN NEW.TTYPE = 'W' AND (
            SELECT BALANCE - NEW.TAMOUNT < CASE WHEN ATYPE = 'S' THEN 2000.00 ELSE 5000.00 END
            FROM ACCOUNT
            WHERE ANO = NEW.ANO
        )
        THEN RAISE(ABORT, 'Withdrawal would violate minimum balance requirement')
    END;
    
    -- If we get here and it's a withdrawal, update the balance
    UPDATE ACCOUNT
    SET BALANCE = BALANCE - NEW.TAMOUNT
    WHERE ANO = NEW.ANO AND NEW.TTYPE = 'W';
END;

/*
Result:
SQL query successfully executed. However, the result set is empty.
*/

-- Testing

-- Test 1: Trigger limit_daily_transactions
-- Insert 3 transactions for the same customer on the same date (should succeed)
INSERT INTO TRANSACTIONS (TID, ANO, TTYPE, TDATE, TAMOUNT) 
VALUES (4, 'A003', 'D', '2025-03-11', 1000.00);

INSERT INTO TRANSACTIONS (TID, ANO, TTYPE, TDATE, TAMOUNT) 
VALUES (5, 'A003', 'W', '2025-03-11', 500.00);

INSERT INTO TRANSACTIONS (TID, ANO, TTYPE, TDATE, TAMOUNT) 
VALUES (6, 'A004', 'D', '2025-03-11', 200.00);  -- Different account but same customer

-- Try to insert a 4th transaction (should fail)
INSERT INTO TRANSACTIONS (TID, ANO, TTYPE, TDATE, TAMOUNT) 
VALUES (7, 'A003', 'D', '2025-03-11', 300.00);

/*
Result:
Error: Customer has already performed 3 transactions today
*/
    
-- Test 2: Trigger update_account_balance
-- Check current balance
SELECT ANO, BALANCE FROM ACCOUNT WHERE ANO = 'A003';

-- Make a deposit (should succeed and increase balance)
INSERT INTO TRANSACTIONS (TID, ANO, TTYPE, TDATE, TAMOUNT) 
VALUES (14, 'A003', 'D', '2025-03-12', 1000.00);

/*
Result:  
ANO	    BALANCE
A003	15500
*/

-- Check that balance was updated
SELECT ANO, BALANCE FROM ACCOUNT WHERE ANO = 'A003';

 /*
Result:   
ANO	    BALANCE
A003	16500
*/

-- Try to make a withdrawal that would violate minimum balance (should fail)
-- For savings account: minimum balance is 2000
INSERT INTO TRANSACTIONS (TID, ANO, TTYPE, TDATE, TAMOUNT) 
VALUES (15, 'A003', 'W', '2025-03-12', 15000.00);

/*
Result:  
Error: Withdrawal would violate minimum balance requirement
*/
    
-- Check that balance remains unchanged after failed withdrawal
SELECT ANO, BALANCE FROM ACCOUNT WHERE ANO = 'A003';

/*
Result:  
ANO	    BALANCE
A003	165000
*/
