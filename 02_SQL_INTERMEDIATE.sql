-- SQL Functions & Grouping
-- Covers Aggregate Functions, Grouping & SQL Features


-- =========================================================
-- SECTION 1 : AGGREGATE FUNCTIONS
-- =========================================================

-- Count total rows
SELECT COUNT(*)
FROM EMPLOYEE;

-- Calculate total salary
SELECT SUM(EMP_SALARY)
FROM EMPLOYEE;

-- Calculate average salary
SELECT AVG(EMP_SALARY)
FROM EMPLOYEE;

-- Find highest salary
SELECT MAX(EMP_SALARY)
FROM EMPLOYEE;

-- Find lowest salary
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

-- Average salary by department
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
-- SECTION 4 : SQL FEATURES
-- =========================================================

-- Column Alias
SELECT EMP_NAME AS NAME,
       EMP_SALARY AS SALARY
FROM EMPLOYEE;

-- Arithmetic Expressions
SELECT EMP_NAME,
       EMP_SALARY,
       EMP_SALARY * 12 AS ANNUAL_SALARY
FROM EMPLOYEE;

-- ROWNUM
SELECT *
FROM EMPLOYEE
WHERE ROWNUM <= 5;

-- SYSDATE
SELECT SYSDATE
FROM DUAL;


------------------------------------ 
--SECTION 5 : CHARACTER FUNCTIONS

SELECT * FROM EMPLOYEE;

-- FOR LOWER CASE OUTPUT
SELECT LOWER (EMP_NAME) FROM EMPLOYEE;

--FOR UPPER CASE OUTPUT
SELECT UPPER (EMP_NAME) FROM EMPLOYEE;
SELECT * FROM EMPLOYEE WHERE  UPPER (EMP_NAME) = 'ASHISH KHADKA';

-- FIRST LETTER CAPITAL
SELECT INITCAP(EMP_NAME) FROM EMPLOYEE;

-- CONCAT
SELECT CONCAT(EMP_NAME, EMP_SALARY) FROM EMPLOYEE;

    -- SUBSTR
--SUBSTR(string, start_position, length)

--String: 'I AM STUDENT'
--Start Position: 3
--Length: 2

SELECT SUBSTR ('I AM STUDENT', 3, 2) FROM DUAL;

-- TOTAL LENGTH OF STRING
SELECT LENGTH ('I AM ASHISH') FROM DUAL;
SELECT EMP_NAME FROM EMPLOYEE WHERE LENGTH (EMP_NAME) = 13;

    -- INSTR
-- USED TO FIND THE POSITION OF A SUBSTRING WITHIN A STRING.
SELECT INSTR('I AM STUDENT', 'ST') FROM DUAL;

    -- LPAD
-- LEFT PADDING : returns a string of a specified length by adding padding characters to the left
SELECT LPAD ('ASHISH', 20, '*') FROM DUAL;

    -- RPAD
-- RIGHT PADDING : returns a string of a specified length by padding characters on the right
SELECT RPAD ('ASHISH', 10, '*') FROM DUAL;

--TRIM
SELECT TRIM('  ASHISH  ') FROM DUAL;

-- REPLACE
SELECT REPLACE ('123ASHISH123', '123') FROM DUAL;


---------------------------------------------------------
--NUMERIC FUNCTIONS

    -- ABS()
-- ABSOLUTE VALUE
SELECT ABS (-26) FROM DUAL;

    --CEIL()
-- ROUND UP : RETURN THE SMALLEST INTEGER GREATER THAN OR EQUAL TO NUMBER 
SELECT CEIL (15.1) FROM DUAL;

    --FLOOR()
-- ROUND UP : RETURN LARGEST INTEGER LESS THAN OR EQUAL TO NUMBER
SELECT FLOOR (15.9) FROM DUAL;

    -- TRUNC()
-- REMOVE DECIMAL WITHOUT ROUNDING
SELECT TRUNC(10.8) FROM DUAL;

    -- MOD()
-- REMAINDER
SELECT MOD(20,3) FROM DUAL;

    -- POWER()
SELECT POWER (2,3) FROM DUAL;

    -- SQRT()
SELECT SQRT(81) FROM DUAL;


--------------------------------------------------
    -- CONVERSION FUNCTION
-- CONVERT DATATYPE FROM ONE DATATYPE TO ANOTHER

    -- TO_CHAR()
-- CONVERTS A NUMBER OR DATE INTO A CHARACTER (STRING)
SELECT TO_CHAR(12345) FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY') FROM DUAL;

    -- TO_NUMBER
-- CONVERTS A CHARACTER STRING INTO A NUMBER
SELECT TO_NUMBER ('2500') + 500 FROM DUAL;

    -- TO_DATE
-- CONVERTS A CHARACTER STRING INTO A DATE
SELECT TO_DATE('07-07-2026','DD-MM-YYYY')
FROM DUAL;

    -- CAST()
-- CONVERTS ONE DATA TYPE TO ANOTHER
SELECT CAST('150' AS NUMBER) FROM DUAL;
