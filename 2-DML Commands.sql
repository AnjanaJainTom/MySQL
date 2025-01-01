-- CREATING DATABASE
CREATE DATABASE ORGANIZATION;
USE ORGANIZATION;

-- CREATING TABLE
CREATE TABLE Managers (
Manager_Id int primary key auto_increment,
First_name varchar(30),
Last_Name varchar(30),
DOB date,
Age int check(AGE >=18 AND AGE <= 65),
Last_update date,
Gender char(1) CHECK (Gender IN ('M','F','O')),
Department varchar(30),
Salary decimal(10,2) NOT NULL
);

DESC Managers;

-- Insert 10 rows
INSERT INTO Managers
VALUES
(DEFAULT,'MICHEAL', 'TOM','1990-01-24',34,'2024-01-01','M','HR',50000),
(DEFAULT,'AALIYA', 'HIND','1992-01-30',32,'2022-11-01','F','IT',35000),
(DEFAULT,'ALLEN', 'BROWN','1995-10-24',29,'2024-10-01','M','IT',40000),
(DEFAULT,'TIM', 'GROOK','1992-11-10',32,'2024-05-01','M','HEALTH CARE',50000),
(DEFAULT,'MELINDA', 'ROBUST','1992-02-02',32,'2023-06-01','F','IT',35000),
(DEFAULT,'PENINCA', 'MIKE','1990-09-24',34,'2020-11-01','F','HR',70000),
(DEFAULT,'JAMES', 'SMITH','1989-01-04',35,'2021-04-01','M','SECURITY',20000),
(DEFAULT,'RAKE', 'NOON','1980-01-11',44,'2020-11-01','M','HEALTH CARE',55000),
(DEFAULT,'ADAM', 'NIKE','1960-05-03',64,'2024-01-01','M','HEALTH CARE',80000),
(DEFAULT,'ETHEN', 'SNOWS','1995-01-29',29,'2023-10-01','M','SECURITY',15000);

SELECT * FROM Managers;

-- Retrieve the name and date of birth of the manager with Manager_Id 1
SELECT First_name, Last_Name, DOB FROM Managers WHERE Manager_Id = 1;

-- To display the annual income of all managers
SELECT First_name, Last_Name, Salary*12 AS ANNUAL_INCOME FROM Managers;
SELECT concat(First_name,' ',Last_Name) AS FULL_NAME, Salary*12 AS ANNUAL_INCOME FROM Managers;

-- To display records of all managers except ‘Aaliya’
SELECT * FROM Managers WHERE First_name <> 'Aaliya';

-- To display details of managers whose department is IT and earns more than 25000 per month
SELECT * FROM Managers WHERE Department = 'IT' AND Salary > 25000;

-- To display details of managers whose salary is between 10000 and 35000
SELECT * FROM Managers WHERE Salary BETWEEN 10000 AND 35000;