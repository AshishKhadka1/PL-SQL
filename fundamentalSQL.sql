--Write SQL statements to:

--Create a Student table
--Insert at least 3 records
--Display all records
--Display only name and marks
--Show students with marks greater than 75
    
CREATE TABLE STUDENT (
    ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(50),
    AGE NUMBER,
    MARKS NUMBER
);
INSERT INTO STUDENT VALUES (1, 'RAM', 20, 49);
INSERT INTO STUDENT VALUES (2, 'SITA', 19, 90);
INSERT INTO STUDENT VALUES (3, 'HARI', 21, 70);

SELECT * FROM STUDENT;
SELECT NAME , MARKS FROM STUDENT;
SELECT * FROM STUDENT 
    WHERE MARKS > 75 ;

-------------------------------------------------------------------------
    
--Update marks of a student
--Delete a student record
--Display students sorted by marks (descending)
--Show students with marks between 70 and 90
--Show students whose name starts with 'S'

UPDATE STUDENT SET MARKS = 85 WHERE ID = 1;

DELETE FROM STUDENT WHERE ID = 3;

SELECT * FROM STUDENT ORDER BY MARKS DESC;

SELECT * FROM STUDENT WHERE MARKS BETWEEN 70 AND 90;

SELECT * FROM STUDENT WHERE NAME LIKE 'S%';

-------------------------------------------------------------------------

--Find average, maximum, and minimum marks
--Count total students
--Group students by age and count them
--Display students with marks greater than average
--Show names and marks sorted by marks
        
SELECT AVG(MARKS), MAX(MARKS), MIN(MARKS) FROM STUDENT;

SELECT COUNT(*) FROM STUDENT;

SELECT AGE, COUNT(*) FROM STUDENT GROUP BY AGE;

SELECT * FROM STUDENT WHERE MARKS > (SELECT AVG(MARKS) FROM STUDENT);

SELECT NAME, MARKS FROM STUDENT ORDER BY MARKS DESC;

-------------------------------------------------------------------------

--Create Department and Employee tables
--Insert sample data
--Display employee name with department name (JOIN)
--Show employees whose salary is greater than average salary (Subquery)
        
CREATE TABLE DEPARTMENT (
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50)
);

CREATE TABLE EMPLOYEE (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(50),
    SALARY NUMBER,
    DEPT_ID NUMBER, 
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID)
);

INSERT INTO Department VALUES (1, 'HR');
INSERT INTO Department VALUES (2, 'IT');  


INSERT INTO Employee VALUES (101, 'Ram', 30000, 1);
INSERT INTO Employee VALUES (102, 'Sita', 40000, 2);
INSERT INTO Employee VALUES (103, 'Hari', 25000, 1);

-- JOIN
SELECT E.EMP_NAME, D.DEPT_NAME 
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;

-- SUBQUERY
SELECT emp_name, salary
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);

-----------------------------------------------------------------------
--Create a sequence
--Create Product table
--Insert records using sequence
--Display all records

CREATE SEQUENCE PROD_SEQ
START WITH 1
INCREMENT BY 1;


CREATE TABLE Product (
  p_id NUMBER PRIMARY KEY,
  p_name VARCHAR2(50),
  price NUMBER
);

INSERT INTO Product VALUES (prod_seq.NEXTVAL, 'Pen', 10);
INSERT INTO Product VALUES (prod_seq.NEXTVAL, 'Book', 50);
INSERT INTO Product VALUES (prod_seq.NEXTVAL, 'Bag', 500);

SELECT * FROM Product;

------------------------------------------------------------------------

--Create a table
--Insert data
--Drop the table
--Show recycle bin contents
--Restore the table
--Permanently delete the table
        
CREATE TABLE TestTable (
  id NUMBER,
  name VARCHAR2(50)
);

INSERT INTO TestTable VALUES (1, 'Ram');

DROP TABLE TestTable;

-- View recycle bin
SHOW RECYCLEBIN;

-- Restore table
FLASHBACK TABLE TestTable TO BEFORE DROP;

-- Permanently delete
PURGE TABLE TestTable;


-------------------------------------------------------------------------
--Create all tables with appropriate primary and foreign keys.
--Insert at least 5 records into each table.
--Display employee name, department name, project name, and salary.
--Display employees whose salary is greater than the average salary of their department.
--Display the department having the highest average salary.
--Display employees who are not assigned to any project.

-- Department Table
CREATE TABLE Department(
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(50)
);

-- Employee Table
CREATE TABLE Employee(
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    salary NUMBER,
    dept_id NUMBER,
    CONSTRAINT fk_dept
    FOREIGN KEY(dept_id)
    REFERENCES Department(dept_id)
);

-- Project Table
CREATE TABLE Project(
    project_id NUMBER PRIMARY KEY,
    project_name VARCHAR2(50),
    emp_id NUMBER,
    CONSTRAINT fk_emp
    FOREIGN KEY(emp_id)
    REFERENCES Employee(emp_id)
);

INSERT INTO Department VALUES(1,'HR');
INSERT INTO Department VALUES(2,'IT');
INSERT INTO Department VALUES(3,'Finance');

INSERT INTO Employee VALUES(101,'Ram',35000,1);
INSERT INTO Employee VALUES(102,'Sita',60000,2);
INSERT INTO Employee VALUES(103,'Hari',45000,2);
INSERT INTO Employee VALUES(104,'Gita',55000,3);
INSERT INTO Employee VALUES(105,'Milan',30000,1);

INSERT INTO Project VALUES(1,'Payroll',101);
INSERT INTO Project VALUES(2,'Website',102);
INSERT INTO Project VALUES(3,'Mobile App',103);
INSERT INTO Project VALUES(4,'Accounting',104);

-- Employee + Department + Project
SELECT e.emp_name,
       d.dept_name,
       p.project_name,
       e.salary
FROM Employee e
JOIN Department d
ON e.dept_id=d.dept_id
LEFT JOIN Project p
ON e.emp_id=p.emp_id;

-- Salary greater than department average
SELECT emp_name,salary
FROM Employee e
WHERE salary>
(
SELECT AVG(salary)
FROM Employee
WHERE dept_id=e.dept_id
);

-- Department with highest average salary
SELECT dept_name
FROM Department
WHERE dept_id=
(
SELECT dept_id
FROM Employee
GROUP BY dept_id
ORDER BY AVG(salary) DESC
FETCH FIRST 1 ROW ONLY
);

-- Employees without project
SELECT emp_name
FROM Employee
WHERE emp_id NOT IN
(
SELECT emp_id
FROM Project
);