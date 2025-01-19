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

# 1. Perform inner join, Left join, and Right join on the tables

-- MATCHING VALUES FROM BOTH TABLES
-- INNER JOIN
SELECT C.Country_name, C.Area, CONCAT(P.Fname,' ',P.Lname) AS FULL_NAME, P.Rating
FROM Country C INNER JOIN Persons P 
ON C.Id = P.Country_Id;

-- LEFT JOIN
SELECT C.Country_name, C.Area, CONCAT(P.Fname,' ',P.Lname) AS FULL_NAME, P.Rating
FROM Country C LEFT JOIN Persons P 
ON C.Id = P.Country_Id;

-- RIGHT JOIN
SELECT C.Country_name, C.Area, CONCAT(P.Fname,' ',P.Lname) AS FULL_NAME, P.Rating
FROM Country C RIGHT JOIN Persons P 
ON C.Id = P.Country_Id;

# 2. List all distinct country names from both the Country and Persons tables
SELECT C.Country_name FROM Country C LEFT JOIN Persons P 
ON C.Country_name = P.Country_name
UNION
SELECT C.Country_name FROM Country C RIGHT JOIN Persons P 
ON C.Country_name = P.Country_name;

# 3. List all country names from both the Country and Persons tables, including duplicates
SELECT C.Country_name FROM Country C LEFT JOIN Persons P 
ON C.Country_name = P.Country_name
UNION ALL
SELECT C.Country_name FROM Country C RIGHT JOIN Persons P 
ON C.Country_name = P.Country_name;

# 4. Round the ratings of all persons to the nearest integer in the Persons table
SELECT CONCAT(FNAME,' ',LNAME) AS FULL_NAME, round(Rating) AS ROUNDED_RATING FROM Persons;

