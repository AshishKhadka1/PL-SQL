-- Covers Database Creation, Basic SQL, DML & Transactions

-- Create Employee Table
CREATE TABLE EMPLOYEE(
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(50),
    EMP_SALARY NUMBER(10,2),
    DEPT_ID NUMBER
);

-- Display table structure
DESC EMPLOYEE;


-- Create Department Table
CREATE TABLE DEPARTMENT(
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50)
);

-- Display table structure
DESC DEPARTMENT;


-- =========================================================
-- SECTION 2 : INSERT DATA
-- =========================================================

-- Insert Employee Records
INSERT INTO EMPLOYEE VALUES(101,'Ashish Khadka',50000,10);
INSERT INTO EMPLOYEE VALUES(102,'Sita Sharma',45000,20);

-- Insert Department Records
INSERT INTO DEPARTMENT VALUES(10,'HR');
INSERT INTO DEPARTMENT VALUES(20,'Finance');

-- Save changes permanently
COMMIT;


-- =========================================================
-- SECTION 3 : SELECT STATEMENTS
-- =========================================================

-- Display all columns
SELECT * FROM EMPLOYEE;

-- Display specific columns
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE;

-- Filter records
SELECT *
FROM EMPLOYEE
WHERE EMP_SALARY > 45000;

-- Sort records
SELECT *
FROM EMPLOYEE
ORDER BY EMP_NAME;

-- Remove duplicate values
SELECT DISTINCT DEPT_ID
FROM EMPLOYEE;


-- =========================================================
-- SECTION 4 : FILTERING
-- =========================================================

-- Pattern matching
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE 'A%';

-- Search within a range
SELECT *
FROM EMPLOYEE
WHERE EMP_SALARY BETWEEN 40000 AND 55000;

-- Match multiple values
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID IN (10,20);

-- Exclude multiple values
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID NOT IN (30,40);

-- All conditions must be true
SELECT *
FROM EMPLOYEE
WHERE EMP_SALARY > 45000
AND DEPT_ID = 10;

-- Any condition can be true
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = 10
OR DEPT_ID = 20;

-- Reverse a condition
SELECT *
FROM EMPLOYEE
WHERE NOT EMP_SALARY > 60000;

-- Find NULL values
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME IS NULL;

-- Find non-NULL values
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME IS NOT NULL;


-- =========================================================
-- SECTION 5 : DML (DATA MANIPULATION LANGUAGE)
-- =========================================================

-- Modify existing records
UPDATE EMPLOYEE
SET EMP_SALARY = 55000
WHERE EMP_ID = 101;

-- Remove records
DELETE FROM EMPLOYEE
WHERE EMP_ID = 102;


-- =========================================================
-- SECTION 6 : TRANSACTION CONTROL (TCL)
-- =========================================================

-- Create a rollback point
SAVEPOINT SP1;

-- Update a record
UPDATE EMPLOYEE
SET EMP_SALARY = 60000
WHERE EMP_ID = 101;

-- Undo changes after savepoint
ROLLBACK TO SP1;

-- Save changes permanently
COMMIT;
```
