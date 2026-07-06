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
