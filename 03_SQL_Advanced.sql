/*
============================================================
                ORACLE SQL ADVANCED
============================================================
Topics Covered
--------------
1. Constraints
2. Referential Integrity
3. Views
4. Sequences

Prerequisite
------------
Run 01_SQL_Basics.sql before executing this file.
============================================================
*/


-- =========================================================
-- SECTION 1 : CONSTRAINTS
-- =========================================================

-- NOT NULL Constraint
-- Prevents NULL values in a column.

CREATE TABLE EMPLOYEE1
(
    EMP_ID      NUMBER PRIMARY KEY,
    EMP_NAME    VARCHAR2(50) NOT NULL,
    EMP_SALARY  NUMBER(10,2)
);

INSERT INTO EMPLOYEE1
VALUES (1,'Ayush Khadka',50000);

SELECT *
FROM EMPLOYEE1;



-- UNIQUE Constraint
-- Prevents duplicate values.

CREATE TABLE STUDENT1
(
    STUDENT_ID NUMBER PRIMARY KEY,
    EMAIL      VARCHAR2(100) UNIQUE,
    NAME       VARCHAR2(50)
);

INSERT INTO STUDENT1
VALUES (101,'ashish@gmail.com','Ashish');

INSERT INTO STUDENT1
VALUES (102,'sita@gmail.com','Sita');

SELECT *
FROM STUDENT1;



-- PRIMARY KEY
-- Uniquely identifies each row.
-- Does not allow NULL or duplicate values.



-- FOREIGN KEY
-- Creates a relationship between parent and child tables.



-- =========================================================
-- SECTION 2 : REFERENTIAL INTEGRITY
-- =========================================================

-- Parent Table

CREATE TABLE DEPARTMENT
(
    DEPT_ID   NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50)
);

INSERT INTO DEPARTMENT VALUES (10,'Human Resources');
INSERT INTO DEPARTMENT VALUES (20,'Finance');
INSERT INTO DEPARTMENT VALUES (30,'Information Technology');
INSERT INTO DEPARTMENT VALUES (40,'Marketing');
INSERT INTO DEPARTMENT VALUES (50,'Administration');
INSERT INTO DEPARTMENT VALUES (60,'Technology');
INSERT INTO DEPARTMENT VALUES (70,'Sales');



-- Child Table

CREATE TABLE EMPLOYEE
(
    EMP_ID      NUMBER PRIMARY KEY,
    EMP_NAME    VARCHAR2(50) NOT NULL,
    EMP_SALARY  NUMBER(10,2),
    DEPT_ID     NUMBER,

    CONSTRAINT FK_EMPLOYEE_DEPARTMENT
    FOREIGN KEY (DEPT_ID)
    REFERENCES DEPARTMENT(DEPT_ID)
);



INSERT INTO EMPLOYEE VALUES (101,'Ashish Khadka',50000,10);
INSERT INTO EMPLOYEE VALUES (102,'Sita Sharma',45000,20);
INSERT INTO EMPLOYEE VALUES (103,'Ram Thapa',60000,10);
INSERT INTO EMPLOYEE VALUES (104,'Hari KC',55000,30);
INSERT INTO EMPLOYEE VALUES (105,'Gita Rai',48000,20);
INSERT INTO EMPLOYEE VALUES (106,'Bikash Gurung',70000,30);
INSERT INTO EMPLOYEE VALUES (107,'Nisha Adhikari',52000,10);
INSERT INTO EMPLOYEE VALUES (108,'Prakash Bhandari',65000,40);
INSERT INTO EMPLOYEE VALUES (109,'Anita Joshi',47000,20);
INSERT INTO EMPLOYEE VALUES (110,'Rohan Shrestha',58000,40);
INSERT INTO EMPLOYEE VALUES (112,'Manisha Shrestha',58000,70);

COMMIT;



SELECT *
FROM EMPLOYEE;

SELECT *
FROM DEPARTMENT;



-- =========================================================
-- SECTION 3 : VIEWS
-- =========================================================

-- Create View

CREATE VIEW EMP_VIEW AS
SELECT EMP_ID,
       EMP_NAME,
       EMP_SALARY
FROM EMPLOYEE;



-- Display View

SELECT *
FROM EMP_VIEW;



-- Remove View

DROP VIEW EMP_VIEW;



-- =========================================================
-- SECTION 4 : SEQUENCES
-- =========================================================

-- Create Sequence

CREATE SEQUENCE EMP_SEQ
START WITH 111
INCREMENT BY 1;



-- Generate Next Sequence Value

SELECT EMP_SEQ.NEXTVAL
FROM DUAL;



-- Display Current Sequence Value

SELECT EMP_SEQ.CURRVAL
FROM DUAL;



-- Insert Using Sequence

INSERT INTO EMPLOYEE
VALUES
(
    EMP_SEQ.NEXTVAL,
    'New Employee',
    50000,
    50
);



SELECT *
FROM EMPLOYEE;



-- Create Another Sequence Example

CREATE TABLE STUDENTS
(
    STD_ID   NUMBER PRIMARY KEY,
    STD_NAME VARCHAR2(30)
);

CREATE SEQUENCE STD_SEQ
START WITH 1
INCREMENT BY 1;

INSERT INTO STUDENTS
VALUES(STD_SEQ.NEXTVAL,'Ashish');

INSERT INTO STUDENTS
VALUES(STD_SEQ.NEXTVAL,'Anis');


SELECT *
FROM STUDENTS;

/*
============================================================
            ORACLE SQL ADVANCED
============================================================
Topics Covered
--------------
5. Set Operators
6. Joins
7. Subqueries
8. Oracle Pseudocolumns
============================================================
*/


-- =========================================================
-- SECTION 5 : SET OPERATORS
-- =========================================================

-- UNION
-- Combines the results of two queries and removes duplicates.

SELECT DEPT_ID
FROM EMPLOYEE

UNION

SELECT DEPT_ID
FROM DEPARTMENT;



-- UNION ALL
-- Combines the results of two queries and keeps duplicates.

SELECT DEPT_ID
FROM EMPLOYEE

UNION ALL

SELECT DEPT_ID
FROM DEPARTMENT;



-- INTERSECT
-- Returns only common rows from both queries.

SELECT DEPT_ID
FROM EMPLOYEE

INTERSECT

SELECT DEPT_ID
FROM DEPARTMENT;



-- MINUS
-- Returns rows from the first query that are not found in the second query.

SELECT DEPT_ID
FROM EMPLOYEE

MINUS

SELECT DEPT_ID
FROM DEPARTMENT;



-- =========================================================
-- SECTION 6 : JOINS
-- =========================================================

-- INNER JOIN
-- Returns matching rows from both tables.

SELECT E.EMP_ID,
       E.EMP_NAME,
       D.DEPT_NAME
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;



-- LEFT OUTER JOIN
-- Returns all rows from EMPLOYEE.

SELECT E.EMP_ID,
       E.EMP_NAME,
       D.DEPT_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;



-- RIGHT OUTER JOIN
-- Returns all rows from DEPARTMENT.

SELECT E.EMP_ID,
       E.EMP_NAME,
       D.DEPT_NAME
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;



-- FULL OUTER JOIN
-- Returns all matching and non-matching rows.

SELECT E.EMP_ID,
       E.EMP_NAME,
       D.DEPT_NAME
FROM EMPLOYEE E
FULL JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;



-- CROSS JOIN
-- Returns every possible combination of rows.

SELECT E.EMP_NAME,
       D.DEPT_NAME
FROM EMPLOYEE E
CROSS JOIN DEPARTMENT D;



-- NATURAL JOIN
-- Joins tables using columns with the same name.

SELECT *
FROM EMPLOYEE
NATURAL JOIN DEPARTMENT;



-- SELF JOIN
-- Joins a table with itself.

SELECT E1.EMP_NAME,
       E2.EMP_NAME,
       E1.DEPT_ID
FROM EMPLOYEE E1
JOIN EMPLOYEE E2
ON E1.DEPT_ID = E2.DEPT_ID
WHERE E1.EMP_ID <> E2.EMP_ID;



-- =========================================================
-- SECTION 7 : SUBQUERIES
-- =========================================================

-- Single-row Subquery
-- Display employee with the highest salary.

SELECT *
FROM EMPLOYEE
WHERE EMP_SALARY =
(
    SELECT MAX(EMP_SALARY)
    FROM EMPLOYEE
);



-- Multiple-row Subquery
-- Display employees earning more than 50000.

SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_SALARY IN
(
    SELECT EMP_SALARY
    FROM EMPLOYEE
    WHERE EMP_SALARY > 50000
);



-- Correlated Subquery
-- Display employees earning above their department average.

SELECT EMP_NAME,
       EMP_SALARY,
       DEPT_ID
FROM EMPLOYEE E
WHERE EMP_SALARY >
(
    SELECT AVG(EMP_SALARY)
    FROM EMPLOYEE
    WHERE DEPT_ID = E.DEPT_ID
);



-- =========================================================
-- SECTION 8 : ORACLE PSEUDOCOLUMNS
-- =========================================================

-- ROWNUM
-- Displays the first five rows.

SELECT *
FROM EMPLOYEE
WHERE ROWNUM <= 5;



-- ROWID
-- Displays the physical address of each row.

SELECT ROWID,
       EMP_ID,
       EMP_NAME
FROM EMPLOYEE;



-- LEVEL
-- Displays hierarchy levels.

SELECT LEVEL
FROM DUAL
CONNECT BY LEVEL <= 5;



-- NEXTVAL
-- Generates the next sequence value.

SELECT EMP_SEQ.NEXTVAL
FROM DUAL;



-- CURRVAL
-- Displays the current sequence value.

SELECT EMP_SEQ.CURRVAL
FROM DUAL;

/*
============================================================
            ORACLE SQL ADVANCED
============================================================
Topics Covered
--------------
9. Data Dictionary
10. SQL Reports
11. INPUT Variable
12. DEFINE Variable
============================================================
*/


-- =========================================================
-- SECTION 9 : DATA DICTIONARY
-- =========================================================

-- Data Dictionary stores information about database objects.


-- Display all tables owned by current user
SELECT *
FROM USER_TABLES;


-- Display table names
SELECT *
FROM TAB;


-- Display column information
SELECT COLUMN_NAME,
       DATA_TYPE,
       DATA_LENGTH
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEE';


-- Display all user-created sequences
SELECT *
FROM USER_SEQUENCES;


-- Display constraints on EMPLOYEE table
SELECT CONSTRAINT_NAME,
       CONSTRAINT_TYPE,
       STATUS
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEE';


-- Display indexes created by current user
SELECT INDEX_NAME,
       TABLE_NAME
FROM USER_INDEXES;


-- Display current logged-in user
SELECT USERNAME
FROM USER_USERS;


-- Display objects owned by current user
SELECT OBJECT_NAME,
       OBJECT_TYPE
FROM USER_OBJECTS
ORDER BY OBJECT_TYPE;


-- Check available tablespaces
SELECT TABLESPACE_NAME
FROM USER_TABLESPACES;


-- =========================================================
-- SECTION 10 : SQL REPORTS
-- =========================================================

-- Reports are executed using F5 (Run Script).

-- Save report into a text file
SPOOL /home/ashishkhadka/Documents/OracleReports/Employee_Report.txt


-- Report Settings
SET PAGESIZE 30
SET LINESIZE 120

TTITLE LEFT 'EMPLOYEE REPORT'
BTITLE LEFT 'END OF REPORT'


-- Column Formatting
COLUMN EMP_NAME FORMAT A20
COLUMN DEPT_NAME FORMAT A25
COLUMN EMP_SALARY FORMAT 999999.99


-- Generate Report
SELECT E.EMP_ID      AS "EMP ID",
       E.EMP_NAME    AS "EMPLOYEE NAME",
       E.EMP_SALARY  AS "SALARY",
       D.DEPT_NAME   AS "DEPARTMENT"
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;


-- Disable report settings
TTITLE OFF
BTITLE OFF
CLEAR COLUMNS

SPOOL OFF;


-- =========================================================
-- SECTION 11 : INPUT VARIABLE
-- =========================================================

-- Accept user input at runtime.

ACCEPT EMPNAME CHAR PROMPT 'Enter Employee Name : '

SELECT *
FROM EMPLOYEE
WHERE EMP_NAME = '&EMPNAME';


-- Input Employee ID

ACCEPT EMPID NUMBER PROMPT 'Enter Employee ID : '

SELECT *
FROM EMPLOYEE
WHERE EMP_ID = &EMPID;



-- =========================================================
-- SECTION 12 : DEFINE VARIABLE
-- =========================================================

-- Define a variable.

DEFINE EMPNO = 101

SELECT *
FROM EMPLOYEE
WHERE EMP_ID = &EMPNO;


-- Change variable value

DEFINE EMPNO = 105

SELECT *
FROM EMPLOYEE
WHERE EMP_ID = &EMPNO;


-- Display all defined variables
DEFINE


-- Remove variable
UNDEFINE EMPNO


-- Verify variable removed
DEFINE