/*
============================================================
                 ORACLE SQL BASICS
============================================================
Topics Covered
--------------
1. DDL (Data Definition Language)
2. Table Creation
3. Data Insertion
4. Data Retrieval
5. Filtering Data
6. DML (Data Manipulation Language)
7. TCL (Transaction Control Language)
============================================================
*/


-- =========================================================
-- SECTION 1 : DDL (DATA DEFINITION LANGUAGE)
-- =========================================================

-- Create Employee Table
CREATE TABLE EMPLOYEE(
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(50) NOT NULL,
    EMP_SALARY NUMBER(10,2),
    DEPT_ID NUMBER
);

-- Display Employee Table Structure
DESC EMPLOYEE;


-- Create Department Table
CREATE TABLE DEPARTMENT(
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50)
);

-- Display Department Table Structure
DESC DEPARTMENT;



-- =========================================================
-- SECTION 2 : DML - INSERT DATA
-- =========================================================

-- Insert Employee Records
INSERT INTO EMPLOYEE VALUES (101,'Ashish Khadka',50000,10);
INSERT INTO EMPLOYEE VALUES (102,'Sita Sharma',45000,20);

-- Insert Department Records
INSERT INTO DEPARTMENT VALUES (10,'Human Resources');
INSERT INTO DEPARTMENT VALUES (20,'Finance');

-- Save Changes
COMMIT;



-- =========================================================
-- SECTION 3 : DQL (DATA QUERY LANGUAGE)
-- =========================================================

-- Display all records
SELECT *
FROM EMPLOYEE;

-- Display selected columns
SELECT EMP_ID,
       EMP_NAME
FROM EMPLOYEE;

-- Display employees with salary greater than 45000
SELECT *
FROM EMPLOYEE
WHERE EMP_SALARY > 45000;

-- Sort employees by name
SELECT *
FROM EMPLOYEE
ORDER BY EMP_NAME;

-- Display unique department IDs
SELECT DISTINCT DEPT_ID
FROM EMPLOYEE;



-- =========================================================
-- SECTION 4 : FILTERING DATA
-- =========================================================

-- Pattern Matching
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE 'A%';

-- Range Search
SELECT *
FROM EMPLOYEE
WHERE EMP_SALARY BETWEEN 40000 AND 55000;

-- Match Multiple Values
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID IN (10,20);

-- Exclude Multiple Values
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID NOT IN (30,40);

-- AND Operator
SELECT *
FROM EMPLOYEE
WHERE EMP_SALARY > 45000
AND DEPT_ID = 10;

-- OR Operator
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = 10
OR DEPT_ID = 20;

-- NOT Operator
SELECT *
FROM EMPLOYEE
WHERE NOT EMP_SALARY > 60000;

-- NULL Values
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME IS NULL;

-- NOT NULL Values
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME IS NOT NULL;



-- =========================================================
-- SECTION 5 : DML (UPDATE & DELETE)
-- =========================================================

-- Update Employee Salary
UPDATE EMPLOYEE
SET EMP_SALARY = 55000
WHERE EMP_ID = 101;

-- Delete Employee Record
DELETE FROM EMPLOYEE
WHERE EMP_ID = 102;



-- =========================================================
-- SECTION 6 : TCL (TRANSACTION CONTROL LANGUAGE)
-- =========================================================

-- Create Savepoint
SAVEPOINT SP1;

-- Update Employee Salary
UPDATE EMPLOYEE
SET EMP_SALARY = 60000
WHERE EMP_ID = 101;

-- Rollback to Savepoint
ROLLBACK TO SP1;

-- Save Changes Permanently
COMMIT;