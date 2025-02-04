-- CREATING DATABASE
CREATE DATABASE IF NOT EXISTS SCHOOL;
USE SCHOOL;

# 1. Create a table named teachers with fields id, name, subject, experience and 
--   salary and insert 8 rows

-- CREATING A TABLE
CREATE TABLE teachers (
id INT auto_increment primary key, 
name VARCHAR(50), 
subject VARCHAR(25), 
experience INT,
salary int );

INSERT INTO teachers 
VALUES
(DEFAULT, 'ASHA BIJU', 'MATHEMATICS', 5, 15000),
(DEFAULT, 'NEENA MATHEW', 'BIOLOGY', 3, 10000),
(DEFAULT, 'KAVYA S', 'PHYSICS', 12, 25000),
(DEFAULT, 'THOMAS PHILIP', 'IT', 8, 18000),
(DEFAULT, 'MANU NINAN', 'CHEMISTRY', 10, 20000),
(DEFAULT, 'JAMES MATHEW', 'ART', 2, 10000),
(DEFAULT, 'RUKHIYA ROOHA', 'GEOGRAPHY', 1, 10000),
(DEFAULT, 'KARUNA PRASAD', 'HISTORY', 15, 25000);

SELECT * FROM teachers;

# 2. Create a before insert trigger named before_insert_teacher that will raise an 
--   error “salary cannot be negative” if the salary inserted to the table is less than zero
DELIMITER //
CREATE TRIGGER before_insert_teacher
BEFORE INSERT ON teachers 
FOR EACH ROW
BEGIN
IF NEW.salary < 0 THEN
SIGNAL SQLSTATE '45000'
SET message_text = 'Salary cannot be negative';
END IF;
END //
DELIMITER ;

INSERT INTO teachers 
VALUES
(DEFAULT, 'NICOL HIMA', 'ART', 5, -200);

# 3. Create an after insert trigger named after_insert_teacher that inserts a row with teacher_id,
--   action, timestamp to a table called teacher_log when a new entry gets inserted to the teacher table.
--   teacher_id -> column of teacher table, action -> the trigger action, timestamp -> time at which the 
--   new row has got inserted

CREATE TABLE teacher_log (
teacher_id INT auto_increment primary key,
action VARCHAR(50),
timestamp timestamp DEFAULT CURRENT_TIMESTAMP );

DELIMITER //
CREATE TRIGGER after_insert_teacher
AFTER INSERT ON teachers
FOR EACH ROW
BEGIN
INSERT INTO teacher_log (teacher_id, action)
VALUES
(NEW.id, 'INSERT');
END //
DELIMITER ;

INSERT INTO teachers 
VALUES
(DEFAULT, 'MINI ANDREWS', 'IT', 5, 15000);

SELECT * FROM teacher_log;

# 4. Create a before delete trigger that will raise an error when you try to delete a row 
--   that has experience greater than 10 years.
DELIMITER //
CREATE TRIGGER BEFORE_DELETE_TEACHER
BEFORE DELETE ON teachers
FOR EACH ROW
BEGIN
IF OLD.experience > 10 THEN
SIGNAL SQLSTATE '45000'
SET message_text = 'CANNOT DELETE TEACHERS WITH EXPERIANCE MORE THAN 10 YEARS';
END IF;
END //
DELIMITER ;

DELETE FROM teachers WHERE ID = 3;

# 5. Create an after delete trigger that will insert a row to teacher_log table when 
--   that row is deleted from teacher table
DELIMITER //
CREATE TRIGGER AFTER_DELETE_TEACHER
AFTER DELETE ON teachers
FOR EACH ROW
BEGIN
INSERT INTO teacher_log (teacher_id, action)
VALUES
(OLD.id, 'DELETE');
END //
DELIMITER ;

DELETE FROM teachers WHERE ID = 1;