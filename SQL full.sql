-- ===========================
-- ORACLE SQL BASIC CHEAT SHEET
-- ===========================

-- Show current container
SHOW CON_NAME;
SELECT name FROM v$containers;
ALTER SESSION SET CONTAINER = freepdb1;
ALTER PLUGGABLE DATABASE freepdb1 OPEN;

--------------------------------------------------
-- CREATE TABLE
--------------------------------------------------
CREATE TABLE Asset(
    aId NUMBER PRIMARY KEY,                 -- Primary Key
    aName NVARCHAR2(50) UNIQUE NOT NULL,    -- Asset Name
    aPrice NUMBER(12,2) DEFAULT 0 NOT NULL, -- Price
    purchaseDate DATE                       -- Purchase Date
);

DESC Asset;    -- Display table structure

--------------------------------------------------
-- INSERT (CREATE)
--------------------------------------------------
INSERT INTO Asset VALUES(1,'Laptop',80000,SYSDATE);
INSERT INTO Asset VALUES(2,'Printer',25000,SYSDATE);

--------------------------------------------------
-- SELECT (READ)
--------------------------------------------------
SELECT * FROM Asset;
SELECT aId,aName FROM Asset;

--------------------------------------------------
-- WHERE
--------------------------------------------------
SELECT * FROM Asset WHERE aId=1;
SELECT * FROM Asset WHERE aPrice>50000;

--------------------------------------------------
-- UPDATE
--------------------------------------------------
UPDATE Asset
SET aPrice=85000
WHERE aId=1;

UPDATE Asset
SET aName='Gaming Laptop',
    aPrice=90000
WHERE aId=1;

--------------------------------------------------
-- DELETE
--------------------------------------------------
DELETE FROM Asset
WHERE aId=2;

--------------------------------------------------
-- SORTING
--------------------------------------------------
SELECT * FROM Asset ORDER BY aPrice ASC;
SELECT * FROM Asset ORDER BY aPrice DESC;

--------------------------------------------------
-- DISTINCT
--------------------------------------------------
SELECT DISTINCT aPrice FROM Asset;

--------------------------------------------------
-- LIKE
--------------------------------------------------
SELECT * FROM Asset WHERE aName LIKE 'L%';    -- Starts with L
SELECT * FROM Asset WHERE aName LIKE '%r';    -- Ends with r
SELECT * FROM Asset WHERE aName LIKE '%top%'; -- Contains top
SELECT * FROM Asset WHERE aName LIKE '_a%';   -- Second letter a

--------------------------------------------------
-- BETWEEN
--------------------------------------------------
SELECT * FROM Asset
WHERE aPrice BETWEEN 20000 AND 90000;

--------------------------------------------------
-- IN / NOT IN
--------------------------------------------------
SELECT * FROM Asset WHERE aId IN (1,2,3);
SELECT * FROM Asset WHERE aId NOT IN (2,3);

--------------------------------------------------
-- NULL
--------------------------------------------------
SELECT * FROM Asset WHERE purchaseDate IS NULL;
SELECT * FROM Asset WHERE purchaseDate IS NOT NULL;

--------------------------------------------------
-- AGGREGATE FUNCTIONS
--------------------------------------------------
SELECT COUNT(*) FROM Asset;
SELECT SUM(aPrice) FROM Asset;
SELECT AVG(aPrice) FROM Asset;
SELECT MAX(aPrice) FROM Asset;
SELECT MIN(aPrice) FROM Asset;

--------------------------------------------------
-- GROUP BY / HAVING
--------------------------------------------------
SELECT aPrice,COUNT(*)
FROM Asset
GROUP BY aPrice;

SELECT aPrice,COUNT(*)
FROM Asset
GROUP BY aPrice
HAVING COUNT(*)>1;

--------------------------------------------------
-- LOGICAL OPERATORS
--------------------------------------------------
SELECT * FROM Asset
WHERE aPrice>20000 AND aPrice<80000;

SELECT * FROM Asset
WHERE aPrice<20000 OR aPrice>80000;

SELECT * FROM Asset
WHERE NOT aPrice>50000;

--------------------------------------------------
-- LIMIT ROWS (Oracle)
--------------------------------------------------
SELECT *
FROM Asset
WHERE ROWNUM<=5;

--------------------------------------------------
-- ARITHMETIC
--------------------------------------------------
SELECT
    aId,
    aName,
    aPrice,
    aPrice*0.13 AS VAT
FROM Asset;

--------------------------------------------------
-- ALTER TABLE
--------------------------------------------------
ALTER TABLE Asset ADD assetType VARCHAR2(50);
ALTER TABLE Asset MODIFY assetType VARCHAR2(100);
ALTER TABLE Asset DROP COLUMN assetType;

--------------------------------------------------
-- RENAME
--------------------------------------------------
RENAME Asset TO Assets;

--------------------------------------------------
-- VIEW
--------------------------------------------------
CREATE VIEW AssetView AS
SELECT aId,aName,aPrice
FROM Asset;

SELECT * FROM AssetView;

DROP VIEW AssetView;

--------------------------------------------------
-- SEQUENCE
--------------------------------------------------
CREATE SEQUENCE asset_seq
START WITH 1
INCREMENT BY 1;

INSERT INTO Asset
VALUES(asset_seq.NEXTVAL,'Camera',35000,SYSDATE);

--------------------------------------------------
-- TRANSACTIONS
--------------------------------------------------
COMMIT;

ROLLBACK;

SAVEPOINT sp1;

ROLLBACK TO sp1;

--------------------------------------------------
-- DATE
--------------------------------------------------
SELECT SYSDATE FROM dual;

--------------------------------------------------
-- DROP / TRUNCATE
--------------------------------------------------
TRUNCATE TABLE Asset;   -- Remove all rows
DROP TABLE Asset;       -- Delete table permanently