-- =========================================================
-- Oracle Database Objects & Administration
-- Covers Views, Sequences, DDL, Joins, Tablespaces & Users
-- =========================================================


-- =========================================================
-- SECTION 1 : VIEWS
-- =========================================================

-- Create a View
CREATE VIEW EMP_VIEW AS
SELECT EMP_ID, EMP_NAME, EMP_SALARY
FROM EMPLOYEE;

-- Display data from View
SELECT *
FROM EMP_VIEW;

-- Drop View
DROP VIEW EMP_VIEW;


-- =========================================================
-- SECTION 2 : SEQUENCE
-- =========================================================

-- Create Sequence
CREATE SEQUENCE EMP_SEQ
START WITH 111
INCREMENT BY 1;

-- Generate Next Value
SELECT EMP_SEQ.NEXTVAL
FROM DUAL;

-- Display Current Value
SELECT EMP_SEQ.CURRVAL
FROM DUAL;


-- =========================================================
-- SECTION 3 : TABLE MODIFICATION
-- =========================================================

-- Add Column
ALTER TABLE EMPLOYEE
ADD EMAIL VARCHAR2(50);

-- Modify Column
ALTER TABLE EMPLOYEE
MODIFY EMAIL VARCHAR2(100);

-- Drop Column
ALTER TABLE EMPLOYEE
DROP COLUMN EMAIL;

-- Rename Table
RENAME EMPLOYEE TO EMP;

-- Rename Back
RENAME EMP TO EMPLOYEE;

-- Rename Column
ALTER TABLE EMPLOYEE
RENAME COLUMN EMP_NAME TO EMPLOYEE_NAME;


-- =========================================================
-- SECTION 4 : TABLE MANAGEMENT
-- =========================================================

-- Remove all rows
TRUNCATE TABLE EMPLOYEE;

-- Drop Table
DROP TABLE EMPLOYEE;


-- =========================================================
-- SECTION 5 : SET OPERATORS
-- =========================================================

-- UNION
SELECT DEPT_ID
FROM EMPLOYEE
UNION
SELECT DEPT_ID
FROM DEPARTMENT;

-- UNION ALL
SELECT DEPT_ID
FROM EMPLOYEE
UNION ALL
SELECT DEPT_ID
FROM DEPARTMENT;


-- =========================================================
-- SECTION 6 : JOINS
-- =========================================================

-- INNER JOIN
SELECT E.EMP_NAME, D.DEPT_NAME
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;

-- LEFT JOIN
SELECT E.EMP_NAME, D.DEPT_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;

-- RIGHT JOIN
SELECT E.EMP_NAME, D.DEPT_NAME
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;

-- FULL JOIN
SELECT E.EMP_NAME, D.DEPT_NAME
FROM EMPLOYEE E
FULL JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;

-- CROSS JOIN
SELECT E.EMP_NAME, D.DEPT_NAME
FROM EMPLOYEE E
CROSS JOIN DEPARTMENT D;

-- NATURAL JOIN
SELECT *
FROM EMPLOYEE
NATURAL JOIN DEPARTMENT;

-- SELF JOIN
SELECT E1.EMP_NAME, E2.EMP_NAME
FROM EMPLOYEE E1
JOIN EMPLOYEE E2
ON E1.EMP_ID = E2.EMP_ID;


-- =========================================================
-- SECTION 7 : REFERENTIAL INTEGRITY
-- =========================================================

-- Parent Table
CREATE TABLE DEPARTMENT(
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50)
);

-- Child Table
CREATE TABLE EMPLOYEE(
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(50),
    DEPT_ID NUMBER,
    CONSTRAINT FK_DEPT
    FOREIGN KEY (DEPT_ID)
    REFERENCES DEPARTMENT(DEPT_ID)
);


-- =========================================================
-- SECTION 8 : PSEUDOCOLUMNS
-- =========================================================

-- Display first five rows
SELECT *
FROM EMPLOYEE
WHERE ROWNUM <= 5;


-- =========================================================
-- SECTION 9 : DUAL
-- =========================================================

-- Display current date
SELECT SYSDATE
FROM DUAL;


-- =========================================================
-- SECTION 10 : TABLESPACES
-- =========================================================

-- Display User Tablespaces
SELECT TABLESPACE_NAME
FROM USER_TABLESPACES;

-- Display Datafiles
SELECT TABLESPACE_NAME, FILE_NAME
FROM DBA_DATA_FILES;

-- Create Tablespace
CREATE TABLESPACE TEST
DATAFILE '/opt/oracle/oradata/XE/TEST.dbf'
SIZE 50M;

-- Add Datafile
ALTER TABLESPACE TEST
ADD DATAFILE '/opt/oracle/oradata/XE/TEST1.dbf'
SIZE 40M;

-- Drop Tablespace
DROP TABLESPACE TEST
INCLUDING CONTENTS AND DATAFILES;


-- =========================================================
-- SECTION 11 : USERS & ROLES
-- =========================================================

-- Display Current Container
SHOW CON_NAME;

-- Display PDBs
SHOW PDBS;

-- Switch Container
ALTER SESSION SET CONTAINER = XEPDB1;

-- Create User
CREATE USER ASHISH
IDENTIFIED BY ASHISH;

-- Create Role
CREATE ROLE DEMO;

-- Grant Privileges
GRANT CREATE SESSION,
      CREATE TABLE
TO DEMO;

-- Assign Role to User
GRANT DEMO TO ASHISH;

-- Verify User
SELECT USERNAME
FROM DBA_USERS
WHERE USERNAME = 'ASHISH';

-- Verify Role Privileges
SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE = 'DEMO';

