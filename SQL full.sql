--------------------------------------------------
-- CREATE TABLE
--------------------------------------------------
CREATE TABLE EMPLOYEE(
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(50) NOT NULL,
    EMP_SALARY NUMBER(10,2),
    DEPT_ID NUMBER
);

DESC EMPLOYEE;

--------------------------------------------------
-- INSERT DATA
--------------------------------------------------
INSERT INTO EMPLOYEE VALUES(101,'Ashish Khadka',50000,10);
INSERT INTO EMPLOYEE VALUES(102,'Sita Sharma',45000,20);
INSERT INTO EMPLOYEE VALUES(103,'Ram Thapa',60000,10);
INSERT INTO EMPLOYEE VALUES(104,'Hari KC',55000,30);
INSERT INTO EMPLOYEE VALUES(105,'Gita Rai',48000,20);
INSERT INTO EMPLOYEE VALUES(106,'Bikash Gurung',70000,30);
INSERT INTO EMPLOYEE VALUES(107,'Nisha Adhikari',52000,10);
INSERT INTO EMPLOYEE VALUES(108,'Prakash Bhandari',65000,40);
INSERT INTO EMPLOYEE VALUES(109,'Anita Joshi',47000,20);
INSERT INTO EMPLOYEE VALUES(110,'Rohan Shrestha',58000,40);

COMMIT;

--------------------------------------------------
-- SELECT
--------------------------------------------------
SELECT * FROM EMPLOYEE;

SELECT EMP_ID,EMP_NAME
FROM EMPLOYEE;

--------------------------------------------------
-- WHERE
--------------------------------------------------
SELECT *
FROM EMPLOYEE
WHERE EMP_ID=101;

SELECT *
FROM EMPLOYEE
WHERE EMP_SALARY>50000;

SELECT *
FROM EMPLOYEE
WHERE DEPT_ID=20;

--------------------------------------------------
-- ORDER BY
--------------------------------------------------
SELECT *
FROM EMPLOYEE
ORDER BY EMP_SALARY ASC;

SELECT *
FROM EMPLOYEE
ORDER BY EMP_SALARY DESC;

SELECT *
FROM EMPLOYEE
ORDER BY EMP_NAME;

--------------------------------------------------
-- DISTINCT
--------------------------------------------------
SELECT DISTINCT DEPT_ID
FROM EMPLOYEE;

--------------------------------------------------
-- LIKE
--------------------------------------------------
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE 'A%';

SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%a';

SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%Sh%';

SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_i%';

--------------------------------------------------
-- BETWEEN
--------------------------------------------------
SELECT *
FROM EMPLOYEE
WHERE EMP_SALARY BETWEEN 50000 AND 65000;

--------------------------------------------------
-- IN
--------------------------------------------------
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID IN (10,20);

SELECT *
FROM EMPLOYEE
WHERE EMP_ID IN (101,103,105);

--------------------------------------------------
-- NOT IN
--------------------------------------------------
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID NOT IN (30,40);

--------------------------------------------------
-- AND
--------------------------------------------------
SELECT *
FROM EMPLOYEE
WHERE EMP_SALARY>50000
AND DEPT_ID=10;

--------------------------------------------------
-- OR
--------------------------------------------------
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID=20
OR DEPT_ID=40;

--------------------------------------------------
-- NOT
--------------------------------------------------
SELECT *
FROM EMPLOYEE
WHERE NOT EMP_SALARY>60000;

--------------------------------------------------
-- UPDATE
--------------------------------------------------
UPDATE EMPLOYEE
SET EMP_SALARY=55000
WHERE EMP_ID=101;

UPDATE EMPLOYEE
SET EMP_NAME='Ashish K.',
    EMP_SALARY=60000
WHERE EMP_ID=101;

--------------------------------------------------
-- DELETE
--------------------------------------------------
DELETE FROM EMPLOYEE
WHERE EMP_ID=110;

ROLLBACK;

--------------------------------------------------
-- AGGREGATE FUNCTIONS
--------------------------------------------------
SELECT COUNT(*) FROM EMPLOYEE;

SELECT SUM(EMP_SALARY) FROM EMPLOYEE;

SELECT AVG(EMP_SALARY) FROM EMPLOYEE;

SELECT MAX(EMP_SALARY) FROM EMPLOYEE;

SELECT MIN(EMP_SALARY) FROM EMPLOYEE;

--------------------------------------------------
-- GROUP BY
--------------------------------------------------
SELECT DEPT_ID,
COUNT(*) TOTAL_EMPLOYEE
FROM EMPLOYEE
GROUP BY DEPT_ID;

SELECT DEPT_ID,
AVG(EMP_SALARY) AVG_SALARY
FROM EMPLOYEE
GROUP BY DEPT_ID;

--------------------------------------------------
-- HAVING
--------------------------------------------------
SELECT DEPT_ID,
COUNT(*) TOTAL
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING COUNT(*)>2;

--------------------------------------------------
-- ALIAS
--------------------------------------------------
SELECT EMP_NAME AS NAME,
EMP_SALARY AS SALARY
FROM EMPLOYEE;

--------------------------------------------------
-- ARITHMETIC
--------------------------------------------------
SELECT
EMP_NAME,
EMP_SALARY,
EMP_SALARY*12 AS ANNUAL_SALARY
FROM EMPLOYEE;

SELECT
EMP_NAME,
EMP_SALARY,
EMP_SALARY*0.10 BONUS
FROM EMPLOYEE;

--------------------------------------------------
-- ROWNUM
--------------------------------------------------
SELECT *
FROM EMPLOYEE
WHERE ROWNUM<=5;

--------------------------------------------------
-- NULL
--------------------------------------------------
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME IS NULL;

SELECT *
FROM EMPLOYEE
WHERE EMP_NAME IS NOT NULL;

--------------------------------------------------
-- ALTER TABLE
--------------------------------------------------
ALTER TABLE EMPLOYEE
ADD EMAIL VARCHAR2(50);

ALTER TABLE EMPLOYEE
MODIFY EMAIL VARCHAR2(100);

ALTER TABLE EMPLOYEE
DROP COLUMN EMAIL;

--------------------------------------------------
-- RENAME TABLE
--------------------------------------------------
RENAME EMPLOYEE TO EMP;

RENAME EMP TO EMPLOYEE;

--------------------------------------------------
-- VIEW
--------------------------------------------------
CREATE VIEW EMP_VIEW AS
SELECT EMP_ID,
EMP_NAME,
EMP_SALARY
FROM EMPLOYEE;

SELECT *
FROM EMP_VIEW;

DROP VIEW EMP_VIEW;

--------------------------------------------------
-- SEQUENCE
--------------------------------------------------
CREATE SEQUENCE EMP_SEQ
START WITH 111
INCREMENT BY 1;

INSERT INTO EMPLOYEE
VALUES(EMP_SEQ.NEXTVAL,'New Employee',45000,50);

--------------------------------------------------
-- TRANSACTION
--------------------------------------------------
SAVEPOINT SP1;

UPDATE EMPLOYEE
SET EMP_SALARY=70000
WHERE EMP_ID=102;

ROLLBACK TO SP1;

COMMIT;

--------------------------------------------------
-- DATE
--------------------------------------------------
SELECT SYSDATE
FROM DUAL;

--------------------------------------------------
-- TRUNCATE
--------------------------------------------------
TRUNCATE TABLE EMPLOYEE;

--------------------------------------------------
-- DROP TABLE
--------------------------------------------------
DROP TABLE EMPLOYEE;