-- =========================================================
-- Oracle PL/SQL Advanced
-- Covers Triggers, Procedures, Functions,
-- Exception Handling and Packages
--
-- File : 05_PL_SQL_Advanced.sql
-- =========================================================

SET SERVEROUTPUT ON;

-- =========================================================
-- SECTION 1 : DATABASE SETUP
-- =========================================================

-- Display Existing Tables
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

-- Create Log Table
CREATE TABLE EMPLOYEE_LOG(
    EMP_ID NUMBER PRIMARY KEY,
    NEW_SALARY NUMBER(10,2),
    MESSAGE VARCHAR2(100)
);

SELECT *
FROM EMPLOYEE_LOG;

COMMIT;


-- =========================================================
-- SECTION 2 : TRIGGERS
-- =========================================================

-- Trigger
-- Automatically stores updated salary information
-- after an employee salary is updated.

CREATE OR REPLACE TRIGGER TRG_EMPLOYEE_UPDATE
AFTER UPDATE OF EMP_SALARY
ON EMPLOYEE
FOR EACH ROW
BEGIN

    INSERT INTO EMPLOYEE_LOG
    (
        EMP_ID,
        NEW_SALARY,
        MESSAGE
    )
    VALUES
    (
        :OLD.EMP_ID,
        :NEW.EMP_SALARY,
        'Employee salary updated'
    );

END;
/

-- Test Trigger

UPDATE EMPLOYEE
SET EMP_SALARY = 10000
WHERE EMP_ID = 101;

SELECT *
FROM EMPLOYEE_LOG;


-- =========================================================
-- SECTION 3 : STORED PROCEDURES
-- =========================================================

------------------------------------------------------------
-- Procedure 1
-- Display Simple Message
------------------------------------------------------------

CREATE OR REPLACE PROCEDURE PR_WELCOME
AS
BEGIN

    DBMS_OUTPUT.PUT_LINE('WELCOME TO IT EXPERT');

END;
/

BEGIN

    PR_WELCOME;

END;
/

------------------------------------------------------------
-- Procedure 2
-- Insert Department
------------------------------------------------------------

CREATE OR REPLACE PROCEDURE PR_INSERT_DEPARTMENT
(
    P_DEPT_ID   IN NUMBER,
    P_DEPT_NAME IN VARCHAR2
)
IS
BEGIN

    INSERT INTO DEPARTMENT
    VALUES
    (
        P_DEPT_ID,
        P_DEPT_NAME
    );

END;
/

SELECT *
FROM DEPARTMENT;

BEGIN

    PR_INSERT_DEPARTMENT
    (
        70,
        'Reception'
    );

END;
/

SELECT *
FROM DEPARTMENT;


------------------------------------------------------------
-- Procedure 3
-- Update Employee Salary
-- OUT Parameter Example
------------------------------------------------------------

CREATE OR REPLACE PROCEDURE PR_UPDATE_EMPLOYEE
(
    P_EMP_ID     IN NUMBER,
    P_INCREMENT  IN NUMBER,
    P_NEW_SALARY OUT NUMBER
)
IS
BEGIN

    UPDATE EMPLOYEE
    SET EMP_SALARY = EMP_SALARY + P_INCREMENT
    WHERE EMP_ID = P_EMP_ID;

    SELECT EMP_SALARY
    INTO P_NEW_SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = P_EMP_ID;

    DBMS_OUTPUT.PUT_LINE
    (
        'Updated Salary : ' || P_NEW_SALARY
    );

END;
/

VARIABLE V_SALARY NUMBER;

EXEC PR_UPDATE_EMPLOYEE(112,10000,:V_SALARY);

PRINT V_SALARY;

SELECT *
FROM EMPLOYEE;

-- =========================================================
-- SECTION 4 : FUNCTIONS
-- =========================================================

------------------------------------------------------------
-- Function 1
-- Add Two Numbers
------------------------------------------------------------

CREATE OR REPLACE FUNCTION FN_ADD_NUMBER
(
    P_NUM1 IN NUMBER,
    P_NUM2 IN NUMBER
)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN

    V_RESULT := P_NUM1 + P_NUM2;

    RETURN V_RESULT;

END FN_ADD_NUMBER;
/

DECLARE
    V_RESULT NUMBER;
BEGIN

    V_RESULT := FN_ADD_NUMBER(15,200);

    DBMS_OUTPUT.PUT_LINE
    (
        'Addition = ' || V_RESULT
    );

END;
/

------------------------------------------------------------
-- Function 2
-- Update Salary and Return New Salary
------------------------------------------------------------

CREATE OR REPLACE FUNCTION FN_UPDATE_SALARY
(
    P_EMP_ID     IN NUMBER,
    P_INCREMENT  IN NUMBER
)
RETURN NUMBER
IS
    V_NEW_SALARY NUMBER;
BEGIN

    UPDATE EMPLOYEE
    SET EMP_SALARY = EMP_SALARY + P_INCREMENT
    WHERE EMP_ID = P_EMP_ID;

    SELECT EMP_SALARY
    INTO V_NEW_SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = P_EMP_ID;

    DBMS_OUTPUT.PUT_LINE
    (
        'Updated Salary : ' || V_NEW_SALARY
    );

    RETURN V_NEW_SALARY;

END FN_UPDATE_SALARY;
/

DECLARE

    V_SALARY NUMBER;

BEGIN

    V_SALARY := FN_UPDATE_SALARY
    (
        103,
        10000
    );

    DBMS_OUTPUT.PUT_LINE
    (
        'Returned Salary : ' || V_SALARY
    );

END;
/

SELECT *
FROM EMPLOYEE;


-- =========================================================
-- SECTION 5 : EXCEPTION HANDLING
-- =========================================================

------------------------------------------------------------
-- Predefined Exception
------------------------------------------------------------

DECLARE

    V_EMP_ID EMPLOYEE.EMP_ID%TYPE := &EMP_ID;
    V_EMP_NAME EMPLOYEE.EMP_NAME%TYPE;

BEGIN

    SELECT EMP_NAME
    INTO V_EMP_NAME
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;

    DBMS_OUTPUT.PUT_LINE
    (
        'Employee Name : ' || V_EMP_NAME
    );

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE
        (
            'No employee found.'
        );

    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE
        (
            'More than one record returned.'
        );

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE
        (
            'Unexpected error.'
        );

END;
/

------------------------------------------------------------
-- Raising Exception
------------------------------------------------------------

DECLARE

    V_NUMBER NUMBER := &NUMBER;

    EX_INVALID EXCEPTION;

BEGIN

    IF V_NUMBER >= 10 THEN

        RAISE EX_INVALID;

    ELSE

        DBMS_OUTPUT.PUT_LINE
        (
            'Number is less than 10.'
        );

    END IF;

EXCEPTION

    WHEN EX_INVALID THEN

        DBMS_OUTPUT.PUT_LINE
        (
            'Number must be less than 10.'
        );

END;
/

------------------------------------------------------------
-- User-defined Exception
------------------------------------------------------------

DECLARE

    V_EMP_ID EMPLOYEE.EMP_ID%TYPE := &EMP_ID;
    V_EMP_NAME EMPLOYEE.EMP_NAME%TYPE;

    EX_INVALID_ID EXCEPTION;

BEGIN

    IF V_EMP_ID < 100 THEN

        RAISE EX_INVALID_ID;

    END IF;

    SELECT EMP_NAME
    INTO V_EMP_NAME
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;

    DBMS_OUTPUT.PUT_LINE
    (
        'Employee Name : ' || V_EMP_NAME
    );

EXCEPTION

    WHEN EX_INVALID_ID THEN

        DBMS_OUTPUT.PUT_LINE
        (
            'Employee ID must be greater than or equal to 100.'
        );

    WHEN NO_DATA_FOUND THEN

        DBMS_OUTPUT.PUT_LINE
        (
            'Employee not found.'
        );

    WHEN OTHERS THEN

        DBMS_OUTPUT.PUT_LINE
        (
            'Unexpected error.'
        );

END;
/

-- =========================================================
-- SECTION 6 : PACKAGES
-- =========================================================

------------------------------------------------------------
-- Package Specification
------------------------------------------------------------
-- A package specification declares procedures and functions
-- that can be accessed by other PL/SQL programs.

CREATE OR REPLACE PACKAGE PKG_DEPARTMENT
AS

    -- Insert Department
    PROCEDURE PR_INSERT_DEPARTMENT
    (
        P_DEPT_ID   IN NUMBER,
        P_DEPT_NAME IN VARCHAR2
    );

    -- Delete Department
    PROCEDURE PR_DELETE_DEPARTMENT
    (
        P_DEPT_ID IN NUMBER
    );

    -- Add Two Numbers
    FUNCTION FN_ADD_NUMBER
    (
        P_NUM1 IN NUMBER,
        P_NUM2 IN NUMBER
    )
    RETURN NUMBER;

END PKG_DEPARTMENT;
/

------------------------------------------------------------
-- Package Body
------------------------------------------------------------
-- Package body contains the implementation of all procedures
-- and functions declared in the specification.

CREATE OR REPLACE PACKAGE BODY PKG_DEPARTMENT
AS

    --------------------------------------------------------
    -- Insert Department
    --------------------------------------------------------

    PROCEDURE PR_INSERT_DEPARTMENT
    (
        P_DEPT_ID   IN NUMBER,
        P_DEPT_NAME IN VARCHAR2
    )
    IS
    BEGIN

        INSERT INTO DEPARTMENT
        VALUES
        (
            P_DEPT_ID,
            P_DEPT_NAME
        );

    END PR_INSERT_DEPARTMENT;

    --------------------------------------------------------
    -- Delete Department
    --------------------------------------------------------

    PROCEDURE PR_DELETE_DEPARTMENT
    (
        P_DEPT_ID IN NUMBER
    )
    IS
    BEGIN

        DELETE FROM DEPARTMENT
        WHERE DEPT_ID = P_DEPT_ID;

    END PR_DELETE_DEPARTMENT;

    --------------------------------------------------------
    -- Add Two Numbers
    --------------------------------------------------------

    FUNCTION FN_ADD_NUMBER
    (
        P_NUM1 IN NUMBER,
        P_NUM2 IN NUMBER
    )
    RETURN NUMBER
    IS
        V_RESULT NUMBER;
    BEGIN

        V_RESULT := P_NUM1 + P_NUM2;

        RETURN V_RESULT;

    END FN_ADD_NUMBER;

END PKG_DEPARTMENT;
/

-- =========================================================
-- SECTION 7 : USING PACKAGE PROCEDURES
-- =========================================================

------------------------------------------------------------
-- Insert Department Using Package
------------------------------------------------------------

BEGIN

    PKG_DEPARTMENT.PR_INSERT_DEPARTMENT
    (
        80,
        'Management'
    );

    DBMS_OUTPUT.PUT_LINE
    (
        'Department inserted successfully.'
    );

END;
/

SELECT *
FROM DEPARTMENT;

------------------------------------------------------------
-- Delete Department Using Package
------------------------------------------------------------

BEGIN

    PKG_DEPARTMENT.PR_DELETE_DEPARTMENT
    (
        70
    );

    DBMS_OUTPUT.PUT_LINE
    (
        'Department deleted successfully.'
    );

END;
/

SELECT *
FROM DEPARTMENT;

------------------------------------------------------------
-- Call Package Function
------------------------------------------------------------

DECLARE

    V_RESULT NUMBER;

BEGIN

    V_RESULT :=
    PKG_DEPARTMENT.FN_ADD_NUMBER
    (
        15,
        20
    );

    DBMS_OUTPUT.PUT_LINE
    (
        'Addition = ' || V_RESULT
    );

END;
/

-- =========================================================
-- SECTION 8 : VERIFY DATA
-- =========================================================

SELECT *
FROM EMPLOYEE;

SELECT *
FROM DEPARTMENT;

SELECT *
FROM EMPLOYEE_LOG;

COMMIT;

