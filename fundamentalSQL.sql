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