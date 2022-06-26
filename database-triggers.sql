-- 1. Displays all customers data and modification log
SELECT * FROM customers
ORDER BY customer_id;

SELECT * FROM customers_log;

-- 2. Implement a trigger to log modification info on each customers info update
CREATE TRIGGER log_customers
BEFORE UPDATE ON customers
FOR EACH ROW
EXECUTE PROCEDURE log_customers_change();

-- 3. Modify customers first name with customer id and check for verification
UPDATE customers
SET first_name = 'Prince'
WHERE customer_id = 1;

SELECT * FROM customers
ORDER BY customer_id;

SELECT * FROM customers_log;

-- 4. Modify customers state with customer id and check for verification
UPDATE customers
SET state_name = 'Washington'
WHERE customer_id = 1;

SELECT * FROM customers
ORDER BY customer_id;

SELECT * FROM customers_log;

-- 5. Implement a trigger to log modification info on multiple data insertion
CREATE TRIGGER customer_insert
AFTER INSERT ON customers
FOR EACH STATEMENT
EXECUTE PROCEDURE log_customers_change();

-- 6. Add new customer info and check for verification
INSERT INTO customers(first_name, last_name, email_address, home_phone, city, state_name, years_old)
VALUES 
('Jeffrey','Cook','Jeffrey.Cook@example.com','202-555-0398','Jersey city','New Jersey',66),
('Tim','Young','Tim.Young@example.com','202-666-2020','Juneau','Alaska', 59),
('Alice','Burner','Alice.Burner@example.com','202-575-2022','Jackson','Mississippi', 70);

SELECT * FROM customers
ORDER BY customer_id;

SELECT * FROM customers_log;

-- 7.  Implement trigger to check if new age is less than 13 and modify with minimum age(13)
CREATE TRIGGER customer_min_age
AFTER UPDATE ON customers
FOR EACH ROW
WHEN (NEW.years_old < 13)
EXECUTE PROCEDURE override_with_min_age();

-- 8. Modify customers age with customers id and check for verification
UPDATE customers
SET years_old = 13
WHERE customer_id = 1;

UPDATE customers
SET years_old = 20
WHERE customer_id = 2;

SELECT * FROM customers
ORDER BY customer_id;

SELECT * FROM customers_log;

-- 9. Modify customers name and age with customers id and check for verification
UPDATE customers
SET first_name = 'John',
    years_old = 12
WHERE customer_id = 1;

SELECT * FROM customers
ORDER BY customer_id;

SELECT * FROM customers_log;

-- 10. Delete trigger customer_min_age on customers table
SELECT * FROM information_schema.triggers;

DROP TRIGGER customer_min_age ON customers;

SELECT * FROM information_schema.triggers;