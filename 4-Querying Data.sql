-- CREATING DATABASE
CREATE DATABASE DISTRIBUTION;
USE DISTRIBUTION;

-- CREATING TABLES
CREATE TABLE Country (
Id INT PRIMARY KEY auto_increment,
Country_name VARCHAR(30),
Population INT,
Area DECIMAL(10,2)
);

CREATE TABLE Persons (
Id INT PRIMARY KEY auto_increment,
Fname VARCHAR(50),
Lname VARCHAR(50),
Population INT,
Rating DECIMAL(3,1),
Country_Id INT,
Country_name VARCHAR(30),
foreign key (Country_Id) references Country(Id)
);

-- INSERTING ROWS INTO TABLES
INSERT INTO Country
VALUES
(DEFAULT,'USA',5000000,'170000.45'),
(DEFAULT,'CANADA',1000000,'500000.85'),
(DEFAULT,'UK',700000,'50000.05'),
(DEFAULT,'INDIA',1200000,'90000.45'),
(DEFAULT,'AUSTRALIA',900000,'100000.55'),
(DEFAULT,'CHINA',400000,'80000.00'),
(DEFAULT,'JAPAN',200000,'60000.25'),
(DEFAULT,'FINLAND',100000,'30000.50'),
(DEFAULT,'SWEDEN',200000,'400000.55'),
(DEFAULT,'CHILE',200000,'90000.15');

SELECT * FROM Country;

INSERT INTO Persons
VALUES
(DEFAULT,'JOHN','SMITH',5000000,5.0,1,'USA'),
(DEFAULT,'MARY','KLEIN',700000,10.0,3,'UK'),
(DEFAULT,'JOSEPH','WATERS',700000,7.0,3,'UK'),
(DEFAULT,'PETER','SIMON',1200000,5.5,4,'INDIA'),
(DEFAULT,'JENNIFER','GLADS',200000,4.0,9,'SWEDEN'),
(DEFAULT,'JIMMY','KURIAN',1200000,6.5,4,'INDIA'),
(DEFAULT,'KITTY','TOM',100000,4.5,8,'FINLAND'),
(DEFAULT,'LOUIS','ANDREWS',200000,10.0,10,'CHILE'),
(DEFAULT,'JAMES','KIROP',200000,8.5,10,'CHILE'),
(DEFAULT,'VENUS','MATHEW',5000000,9.0,1,'USA');

SELECT * FROM Persons;

-- 1. List the distinct country names from the Persons table 
SELECT distinct(Country_name) AS DISTINCT_COUNTRY FROM Persons;

-- 2. Select first names and last names from the Persons table with aliases
SELECT FNAME AS FIRST_NAME, 
	   LNAME AS LAST_NAME,	 
       CONCAT(FNAME,' ',LNAME) AS FULL_NAME 
       FROM Persons;
       
-- 3. Find all persons with a rating greater than 4.0
SELECT * FROM Persons WHERE Rating > 4.0;

-- 4. Find countries with a population greater than 10 lakhs
SELECT * FROM Country WHERE Population > 1000000;

-- 5. Find persons who are from 'USA' or have a rating greater than 4.5
SELECT ID, FNAME, LNAME, Rating, Country_name 
	FROM Persons WHERE Rating > 4.5 OR Country_name = 'USA';
    
INSERT INTO Persons (FNAME,LNAME,RATING)
VALUES
('THOMAS','BROWN',8.0),
('MARK','TWAIN',2.5);

SELECT * FROM Persons;

-- 6. Find all persons where the country name is NULL
SELECT ID, FNAME, LNAME FROM PERSONS WHERE Country_name IS NULL;

-- 7. Find all persons from the countries 'USA', 'Canada', and 'UK'
SELECT ID, FNAME, LNAME, Country_name FROM PERSONS 
	WHERE Country_name IN ('USA','CANADA','UK');
    
-- 8. Find all persons not from the countries 'India' and 'Australia'
SELECT ID, FNAME, LNAME, Country_name FROM PERSONS 
	WHERE Country_name NOT IN ('INDIA','AUSTRALIA');
    
-- 9. Find all countries with a population between 5 lakhs and 20 lakhs
SELECT ID, Country_name, Population FROM Country 
	WHERE Population BETWEEN 500000 AND 2000000;
    
-- 10. Find all countries whose names do not start with 'C'
SELECT ID, Country_name FROM Country WHERE Country_name NOT LIKE 'C%';