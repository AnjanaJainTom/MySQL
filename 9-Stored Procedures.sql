-- CREATING DATABASE
CREATE DATABASE IF NOT EXISTS HUMAN;
USE HUMAN;

-- CREATING A TABLE
CREATE TABLE WORKER (
Worker_Id INT primary key,
FirstName CHAR(25), 
LastName CHAR(25), 
Salary INT(15), 
JoiningDate DATETIME, 
Department CHAR(25));

SELECT * FROM WORKER;

# 1. Create a stored procedure that takes in IN parameters for all the columns in the Worker table 
--   and adds a new record to the table and then invokes the procedure call. 
DELIMITER //
CREATE PROCEDURE ADD_RECORD(IN Id INT, IN FNAME CHAR(25), IN LNAME CHAR(25), 
							IN Sal INT(15),IN Join_Date DATETIME, IN DEPT CHAR(25))
BEGIN
INSERT INTO WORKER
VALUES (Id, FNAME, LNAME, SAL, JOIN_DATE, DEPT);
END //
DELIMITER ;

SET @Worker_Id = 1;
CALL ADD_RECORD (@Worker_Id, 'ANGEL', 'JAMES', 30000, '2020-01-25', 'HR');

# 2. Write stored procedure takes in an IN parameter for WORKER_ID and an OUT parameter for SALARY. 
--   It should retrieve the salary of the worker with the given ID and returns it in the p_salary 
--   parameter. Then make the procedure call. 
DELIMITER //
CREATE PROCEDURE DISP_SAL(IN Id INT, OUT P_SALARY INT(15))
BEGIN
SELECT Salary INTO P_SALARY FROM WORKER WHERE Worker_Id = Id;
END //
DELIMITER ;

SET @SAL = 0;
CALL DISP_SAL(1, @SAL);
SELECT @SAL AS SALARY_OF_WORKER;

# 3. Create a stored procedure that takes in IN parameters for WORKER_ID and DEPARTMENT. 
--   It should update the department of the worker with the given ID. Then make a procedure call. 
DELIMITER //
CREATE PROCEDURE UPDATE_DEPT(IN Id INT, IN DEPT CHAR(25))
BEGIN
UPDATE WORKER SET Department = DEPT WHERE Worker_Id = Id;
END // 
DELIMITER ;

SET @W_Id = 1;
CALL UPDATE_DEPT(@W_Id, 'IT');
SELECT * FROM WORKER;

# 4. Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter 
--   for p_workerCount. It should retrieve the number of workers in the given department and 
--   returns it in the p_workerCount parameter. Make procedure call.

INSERT INTO WORKER
VALUES 
(2, 'MATHEW','JOHN', 20000, '2022-05-01', 'SECURITY'),
(3, 'MARY','NICK', 55000, '2005-01-01', 'IT'),
(4, 'PETER','CLUS', 15000, '2023-02-10', 'SECURITY'),
(5, 'NANCY','PHILIP', 50000, '2007-05-01', 'FINANCE'),
(6, 'KATE','ROKI', 25000, '2022-01-01', 'HR');

DELIMITER //
CREATE PROCEDURE CAL_WORKER_COUNT(IN DEPT CHAR(25), OUT P_WORKERCOUNT INT)
BEGIN
SELECT COUNT(*) INTO P_WORKERCOUNT FROM WORKER WHERE Department = DEPT;
END // 
DELIMITER ;

SET @WORKER_COUNT = 0;
CALL CAL_WORKER_COUNT('SECURITY',@WORKER_COUNT);
SELECT @WORKER_COUNT AS NUMBER_OF_WORKERS;

# 5. Write a stored procedure that takes in an IN parameter for DEPARTMENT and an OUT parameter 
--   for p_avgSalary. It should retrieve the average salary of all workers in the given department 
--   and returns it in the p_avgSalary parameter and call the procedure.
DELIMITER //
CREATE PROCEDURE CAL_AVGSAL(IN DEPT CHAR(25), OUT P_AVGSALARY DECIMAL(10,2))
BEGIN
SELECT AVG(Salary) INTO P_AVGSALARY FROM WORKER WHERE Department = DEPT;
END // 
DELIMITER ;

SET @AVG_SALARY = 0;
CALL CAL_AVGSAL('SECURITY',@AVG_SALARY);
SELECT @AVG_SALARY AS DEPARTMENT_AVERAGE_SALARY;