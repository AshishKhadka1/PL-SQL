/*
============================================================
                SQL FUNCTIONS & GROUPING
============================================================
Topics Covered
--------------
1. Aggregate Functions
2. GROUP BY Clause
3. HAVING Clause
4. Character Functions
5. Numeric Functions
6. Conversion Functions
7. Date Functions
8. SQL Features
============================================================
*/


-- =========================================================
-- SECTION 1 : AGGREGATE FUNCTIONS
-- =========================================================

-- COUNT() : Counts the total number of rows
SELECT COUNT(*)
FROM EMPLOYEE;

-- SUM() : Returns the total salary
SELECT SUM(EMP_SALARY)
FROM EMPLOYEE;

-- AVG() : Returns the average salary
SELECT AVG(EMP_SALARY)
FROM EMPLOYEE;

-- MAX() : Returns the highest salary
SELECT MAX(EMP_SALARY)
FROM EMPLOYEE;

-- MIN() : Returns the lowest salary
SELECT MIN(EMP_SALARY)
FROM EMPLOYEE;



-- =========================================================
-- SECTION 2 : GROUP BY
-- =========================================================

-- Count employees in each department
SELECT DEPT_ID,
       COUNT(*) AS TOTAL_EMPLOYEES
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- Display average salary by department
SELECT DEPT_ID,
       AVG(EMP_SALARY) AS AVG_SALARY
FROM EMPLOYEE
GROUP BY DEPT_ID;



-- =========================================================
-- SECTION 3 : HAVING
-- =========================================================

-- Display departments having more than two employees
SELECT DEPT_ID,
       COUNT(*) AS TOTAL_EMPLOYEES
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING COUNT(*) > 2;



-- =========================================================
-- SECTION 4 : CHARACTER FUNCTIONS
-- =========================================================

SELECT *
FROM EMPLOYEE;

-- LOWER() : Converts text to lowercase
SELECT LOWER(EMP_NAME)
FROM EMPLOYEE;

-- UPPER() : Converts text to uppercase
SELECT UPPER(EMP_NAME)
FROM EMPLOYEE;

-- Case-insensitive search
SELECT *
FROM EMPLOYEE
WHERE UPPER(EMP_NAME) = 'ASHISH KHADKA';

-- INITCAP() : Converts first letter of each word to uppercase
SELECT INITCAP(EMP_NAME)
FROM EMPLOYEE;

-- CONCAT() : Joins two strings
SELECT CONCAT(EMP_NAME, EMP_SALARY)
FROM EMPLOYEE;

-- SUBSTR() : Extracts part of a string
-- SUBSTR(string, start_position, length)

SELECT SUBSTR('I AM STUDENT', 3, 2)
FROM DUAL;

-- LENGTH() : Returns total number of characters
SELECT LENGTH('I AM ASHISH')
FROM DUAL;

SELECT EMP_NAME
FROM EMPLOYEE
WHERE LENGTH(EMP_NAME) = 13;

-- INSTR() : Returns the position of a substring
SELECT INSTR('I AM STUDENT', 'ST')
FROM DUAL;

-- LPAD() : Pads characters on the left
SELECT LPAD('ASHISH', 20, '*')
FROM DUAL;

-- RPAD() : Pads characters on the right
SELECT RPAD('ASHISH', 10, '*')
FROM DUAL;

-- TRIM() : Removes leading and trailing spaces
SELECT TRIM('  ASHISH  ')
FROM DUAL;

-- REPLACE() : Replaces a string with another string
SELECT REPLACE('123ASHISH123', '123')
FROM DUAL;



-- =========================================================
-- SECTION 5 : NUMERIC FUNCTIONS
-- =========================================================

-- ABS() : Returns the absolute value
SELECT ABS(-26)
FROM DUAL;

-- CEIL() : Rounds up to the nearest integer
SELECT CEIL(15.1)
FROM DUAL;

-- FLOOR() : Rounds down to the nearest integer
SELECT FLOOR(15.9)
FROM DUAL;

-- TRUNC() : Removes the decimal part without rounding
SELECT TRUNC(10.8)
FROM DUAL;

-- MOD() : Returns the remainder
SELECT MOD(20,3)
FROM DUAL;

-- POWER() : Raises a number to a power
SELECT POWER(2,3)
FROM DUAL;

-- SQRT() : Returns the square root
SELECT SQRT(81)
FROM DUAL;



-- =========================================================
-- SECTION 6 : CONVERSION FUNCTIONS
-- =========================================================

-- TO_CHAR() : Converts number to character
SELECT TO_CHAR(12345)
FROM DUAL;

-- TO_CHAR() : Converts date to character
SELECT TO_CHAR(SYSDATE,'DD-MON-YYYY')
FROM DUAL;

-- TO_NUMBER() : Converts character to number
SELECT TO_NUMBER('2500') + 500
FROM DUAL;

-- TO_DATE() : Converts character to date
SELECT TO_DATE('07-07-2026','DD-MM-YYYY')
FROM DUAL;

-- CAST() : Converts one data type to another
SELECT CAST('150' AS NUMBER)
FROM DUAL;



-- =========================================================
-- SECTION 7 : DATE FUNCTIONS
-- =========================================================

-- Display current system date
SELECT SYSDATE
FROM DUAL;



-- =========================================================
-- SECTION 8 : SQL FEATURES
-- =========================================================

-- Column Alias
SELECT EMP_NAME AS NAME,
       EMP_SALARY AS SALARY
FROM EMPLOYEE;

-- Arithmetic Expression
SELECT EMP_NAME,
       EMP_SALARY,
       EMP_SALARY * 12 AS ANNUAL_SALARY
FROM EMPLOYEE;

-- Display first five rows
SELECT *
FROM EMPLOYEE
WHERE ROWNUM <= 5;