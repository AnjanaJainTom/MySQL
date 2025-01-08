-- CREATING DATABASE
CREATE database DISTRIBUTION;
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

INSERT INTO Persons (FNAME,LNAME,RATING)
VALUES
('THOMAS','BROWN',8.0),
('MARK','TWAIN',2.5);

SELECT * FROM Persons;

-- 1. To print the first three characters of Country_name from the Country table
SELECT Country_name, SUBSTR(Country_name,1,3) AS FIRST_THREE FROM Country;

-- 2. To concatenate first name and last name from Persons table
SELECT concat(FNAME,' ',LNAME) AS FULL_NAME FROM Persons;

-- 3. To count the number of unique country names from Persons table
SELECT count(distinct(Country_name)) AS DISTINCT_COUNTRY_NAME FROM Persons;

-- 4. To print the maximum population from the Country table
SELECT max(Population) AS MAX_POPULATION FROM Country;

-- 5. To print the minimum population from Persons table
SELECT min(Population) AS MIN_POPULATION FROM Persons;

-- 6. Insert 2 new rows to the Persons table making the Lname NULL. 
--    Then write another query to count Lname from Persons table.
INSERT INTO Persons (FNAME,RATING)
VALUES
('NICK',8.0),
('ANTONY',2.5);

SELECT * FROM Persons;
SELECT COUNT(LNAME) AS NO_OF_LNAME FROM Persons;

-- 7. To find the number of rows in the Persons table
SELECT COUNT(*) AS NO_OF_ROWS FROM Persons;

-- 8. To show the population of the Country table for the first 3 rows. (Hint: Use LIMIT)
SELECT Population FROM Country LIMIT 3;

-- 9. To print 3 random rows of countries. (Hint: Use rand() function and LIMIT) 
SELECT * FROM Country ORDER BY RAND() LIMIT 3;

-- 10. List all persons ordered by their rating in descending order
SELECT * FROM PERSONS ORDER BY RATING DESC;

-- 11. Find the total population for each country in the Persons table
SELECT Country_name, sum(Population) FROM Persons GROUP BY Country_name;

-- 12. Find countries in the Persons table with a total population greater than 50,000 
SELECT Country_name, sum(Population) FROM Persons GROUP BY Country_name HAVING sum(Population) > 50000;

-- 13. List the total number of persons and average rating for each country, 
--     but only for countries with more than 2 persons, ordered by the average 
--     rating in ascending order.
INSERT INTO Persons
VALUES
(DEFAULT,'JILL','GOLD',5000000,8.0,1,'USA');

SELECT COUNT(*) AS TOTAL_PERSONS, avg(RATING) AS AVERAGE_RATING, Country_name FROM Persons 
GROUP BY Country_name HAVING COUNT(*) > 2 ORDER BY avg(RATING);