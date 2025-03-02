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
        END IF;
    END IF;
END;
/
