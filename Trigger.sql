INSERT INTO CUSTOMERS(C_ID, FIRST_NAME, LAST_NAME, EMAIL) VALUES(1, 'PRINCY','WILSON','PRINCY@G
MAIL.COM');

INSERT INTO ACCOUNTS(ACC_NO, C_ID, BALANCE) VALUES(1, 1, 5000);

INSERT INTO TRANSACTIONS(TRANSACTION_ID, ACC_NO, TRANSACTION_TYPE, AMOUNT) VALUES(1, 1, 'DEPOSIT', 2000);

INSERT INTO TRANSACTIONS(TRANSACTION_ID, ACC_NO, TRANSACTION_TYPE, AMOUNT) VALUES(2, 1, 'WITHDRAWAL', 4500);

CREATE OR REPLACE TRIGGER prevent_low_balance_withdrawal
BEFORE INSERT ON transactions
FOR EACH ROW
DECLARE
    current_balance NUMBER(10, 2);
BEGIN
    IF :NEW.transaction_type = 'withdrawal' THEN
        SELECT balance
        INTO current_balance
        FROM accounts
        WHERE acc_no = :NEW.acc_no;
        IF current_balance - :NEW.amount < 1000 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Cannot withdraw. Balance is below 1000.');
        ELSE
            UPDATE accounts
            SET balance = balance - :NEW.amount
            WHERE acc_no = :NEW.acc_no;
        END IF;
    ELSIF :NEW.transaction_type = 'deposit' THEN
        UPDATE accounts
        SET balance = balance + :NEW.amount
        WHERE acc_no = :NEW.acc_no;
    END IF;
END;
/

 
