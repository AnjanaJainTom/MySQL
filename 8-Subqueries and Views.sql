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

# 1. Find the number of persons in each country
SELECT Country_name, COUNT(Id) AS PERSONS_COUNT 
FROM Persons WHERE Country_name IN
(SELECT Country_name FROM Country) GROUP BY Country_name;

# 2. Find the number of persons in each country sorted from high to low
SELECT Country_name, COUNT(Id) AS PERSONS_COUNT 
FROM Persons WHERE Country_name IN
(SELECT Country_name FROM Country) 
GROUP BY Country_name ORDER BY COUNT(Id) DESC;

# 3. Find out an average rating for Persons in respective countries if the average is greater than 3.0
SELECT Country_name, AVG(Rating) AS AVERAGE_RATING 
FROM Persons WHERE Country_name IN
(SELECT Country_name FROM Country) 
GROUP BY Country_name HAVING AVG(Rating) > 3;

# 4. Find the countries with the same rating as the USA. (Use Subqueries)

INSERT INTO Persons
VALUES
(DEFAULT,'MATHEW','PETER',5000000,5.0,7,'JAPAN'),
(DEFAULT,'GOMOS','THOMAS',5000000,9.0,7,'JAPAN');

SELECT Country_name, AVG(Rating) AS AVERAGE_RATING 
FROM Persons WHERE Country_name IN
(SELECT Country_name FROM Country) 
GROUP BY Country_name HAVING AVG(Rating) =
(SELECT AVG(Rating) FROM Persons WHERE Country_name = 'USA');

# 5. Select all countries whose population is greater than the average population of all nations
SELECT Country_name, Population FROM Country 
WHERE Population >
(SELECT AVG(Population) FROM Country);

#####################################################

-- CREATING DATABASE
CREATE database Product;
USE Product;

-- CREATING TABLE
CREATE TABLE Customer (
Customer_Id INT auto_increment primary key,
First_name VARCHAR(50),
Last_name VARCHAR(50),
Email VARCHAR(150) UNIQUE,
Phone_no VARCHAR(15) UNIQUE,
Address VARCHAR(250),
City VARCHAR(50),
State VARCHAR(50),
Zip_code VARCHAR(20),
Country VARCHAR(50)
);

-- INSERTING VALUES
INSERT INTO Customer(First_name,Last_name,Email,Phone_no,State,Country)
VALUES
('MATHEW','JOHN','mjohn@sample.com','+19876543210','CALIFORNIA','USA'),
('MARY','KLIEN','mklien@sample.com','+17776543210','CALIFORNIA','USA'),
('NANCY','ROSH','nrosh@sample.com','+15576543210','CALIFORNIA','USA'),
('STEPHEN','TIM','stim@sample.com','+14476543210','CALIFORNIA','USA'),
('TOM','JOSEPH','tjoseph@sample.com','+919876543220','KERALA','INDIA'),
('KEVIN','JAMES','kjames@sample.com','+919876543230','KERALA','INDIA'),
('MERIN','THOMAS','mthomas@sample.com','+919876543240','KERALA','INDIA'),
('NEENA','PAUL','npaul@sample.com','+919876543250','KERALA','INDIA'),
('PETER','SIMON','psimon@sample.com','+919876543260','KERALA','INDIA'),
('HANOK','ERICK','herick@sample.com','+919876543270','KERALA','INDIA'),
('NITHYA','DAS','ndas@sample.com','+919876543280','KERALA','INDIA'),
('AMOS','MARK','amark@sample.com','+12276543210','TEXAS','USA'),
('MARK','TWAIN','mtwain@sample.com','+12276543220','TEXAS','USA'),
('KINDER','JOY','kjoy@sample.com','+12276543230','TEXAS','USA'),
('HANOK','WATERS','hwaters@sample.com','+12276543240','TEXAS','USA'),
('GLADI','LOUIS','glouis@sample.com','+12276543250','TEXAS','USA');

SELECT * FROM Customer;

# 1. Create a view named customer_info for the Customer table that displays Customer’s 
--   Full name and email address. Then perform the SELECT operation for the customer_info view.

CREATE VIEW customer_info AS
SELECT CONCAT(First_name,' ', Last_name) AS FULL_NAME, Email FROM Customer;

SELECT * FROM customer_info;

# 2. Create a view named US_Customers that displays customers located in the US. 
CREATE VIEW US_Customers AS
SELECT * FROM Customer WHERE Country = 'USA';

SELECT * FROM US_Customers;

# 3. Create another view named Customer_details with columns 
--   full name(Combine first_name and last_name), email, phone_no, and state.
CREATE VIEW Customer_details AS
SELECT CONCAT(First_name,' ', Last_name) AS FULL_NAME, Email, Phone_no, State
FROM Customer;

SELECT * FROM Customer_details;

# 4. Update phone numbers of customers who live in California for Customer_details view
UPDATE Customer_details SET Phone_no = REPLACE(Phone_no, '+1', '+3') WHERE STATE = 'CALIFORNIA';

# 5. Count the number of customers in each state and show only states with more than 5 customers
SELECT State, COUNT(*) AS NO_OF_CUSTOMERS FROM Customer GROUP BY State HAVING COUNT(*) >5;

# 6. Write a query that will return the number of customers in each state, 
--   based on the "state" column in the "customer_details" view
SELECT State, COUNT(*) AS NO_OF_CUSTOMERS FROM Customer_details GROUP BY State;

# 7. Write a query that returns all the columns from the "customer_details" view, 
--   sorted by the "state" column in ascending order
SELECT * FROM Customer_details ORDER BY State;




