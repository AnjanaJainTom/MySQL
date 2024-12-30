-- CREATING DATABASE SCHOOL
create database SCHOOL;

use SCHOOL;

-- CREATING TABLE STUDENT
create table STUDENT (
ROLL_NO int auto_increment primary key,
SNAME varchar(50) not null,
MARKS int,
GRADE CHAR(1) check(GRADE IN ('A','B','C'))
);

desc STUDENT;

-- SELECTING DATA FROM TABLE STUDENT
select * from STUDENT;

-- Adding a column named Contact to the STUDENT table
alter table STUDENT add CONTACT varchar(15);

-- Removing the Grade column from the Student table
alter table STUDENT drop GRADE;

-- Rename the table to CLASSTEN
rename table STUDENT to CLASSTEN;

-- Delete all rows from the table
truncate table CLASSTEN;

desc CLASSTEN;

-- Remove the table from the database
drop table CLASSTEN;