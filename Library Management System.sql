-- CREATING DATABASE
CREATE DATABASE IF NOT EXISTS Library;
USE Library;

-- CREATING A TABLES
# TABLE 1
CREATE TABLE Branch (
Branch_no INT auto_increment PRIMARY KEY,
Manager_Id INT,
Branch_address VARCHAR(200), 
Contact_no VARCHAR(15) UNIQUE );

# TABLE 2
CREATE TABLE Employee (
Emp_Id INT auto_increment PRIMARY KEY,
Emp_name VARCHAR(50), 
Position VARCHAR(30), 
Salary INT, 
Branch_no INT,
FOREIGN KEY (Branch_no) REFERENCES Branch (Branch_no) );

# TABLE 3
CREATE TABLE Books (
ISBN VARCHAR(13) PRIMARY KEY, 
Book_title VARCHAR(50), 
Category VARCHAR(50), 
Rental_Price INT, 
Status VARCHAR(3) CHECK(Status IN ('YES','NO')), 
Author VARCHAR(50), 
Publisher VARCHAR(50) );

# TABLE 4
CREATE TABLE Customer (
Customer_Id INT auto_increment PRIMARY KEY,
Customer_name VARCHAR(50), 
Customer_address VARCHAR(200), 
Reg_date DATE DEFAULT(CURRENT_DATE) );

# TABLE 5
CREATE TABLE IssueStatus (
Issue_Id INT auto_increment PRIMARY KEY, 
Issued_cust INT, 
FOREIGN KEY (Issued_cust) REFERENCES CUSTOMER(Customer_Id),
Issued_book_name VARCHAR(50), 
Issue_date DATE DEFAULT(CURRENT_DATE), 
Isbn_book VARCHAR(13),
FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN) );

# TABLE 6
CREATE TABLE ReturnStatus (
Return_Id INT auto_increment PRIMARY KEY, 
Return_cust VARCHAR(50), 
Return_book_name VARCHAR(50), 
Return_date DATE DEFAULT(CURRENT_DATE), 
Isbn_book2 VARCHAR(13),
FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN) );

INSERT INTO BRANCH (Manager_Id, Branch_address, Contact_no)
VALUES
('111', 'REGENT PLAZA, KOTTAYAM', '+91-9445554263'),
('112', 'MANGROOVES LANE, ERNAKULAM', '+91-9895554263'),
('113', 'CHITHRA NAGAR, KOLLAM', '+91-9985554263'),
('114', 'ADAMS TOWER, THRISSUR', '+91-9095554263'),
('115', 'MAIN CITY CENTER, TRIVANDRUM', '+91-9905554263');

SELECT * FROM Branch;

INSERT INTO Employee (Emp_name, Position, Salary, Branch_no)
VALUES
('MATHEW PHILIP', 'Librarian', 35000, 1),
('NITHA DILEEP', 'Library Assistant', 15000, 3),
('GAYATHRI S', 'Librarian', 20000, 2),
('JAMES K', 'Library Assistant', 16000, 2),
('NITHIN PETER', 'MANAGER', 55000, 1),
('PRASAD J', 'Librarian', 40000, 1),
('NIMMY LUKE', 'Library Assistant', 15000, 1),
('ROHAN P', 'Library Technician', 10000, 1),
('AKSHAY S', 'Library Technician', 10000, 1),
('HARI M', 'MANAGER', 55000, 2),
('CHACKO P', 'Librarian', 30000, 2),
('NITHYA DAS', 'Library Assistant', 20000, 2),
('NEVIL K', 'Library Technician', 15000, 2);

SELECT * FROM Employee;

INSERT INTO BOOKS 
VALUES
('0011','Making India Awesome', 'Non Fiction', 30, 'YES', 'Chetan Bhagat', 'DC BOOKS'),
('0012','Naked Triangle', 'Autobiographical Novel', 20, 'NO', 'Balwant Gargi', 'Macmillan'),
('0013','Half Girlfriend', 'Romance', 35, 'YES', 'Chetan Bhagat', 'DC BOOKS'),
('0014','By God’s Decree', 'Biography', 50, 'YES', 'Kapil Dev', 'Macmillan'),
('0015','The Dark Room', 'Domestic Novels', 25, 'YES', 'R.K. Narayan', 'Macmillan'),
('0016','The Hidden Act', 'Domestic Novels', 25, 'YES', 'R.K. Narayan', 'Macmillan'),
('0017','A History of the Modern World', 'History', 50, 'YES', 'Robert Roswell Palmer', 'DC BOOKS'),
('0018','China: A History', 'History', 30, 'YES', 'John Keay', 'DC BOOKS');

SELECT * FROM Books;

INSERT INTO CUSTOMER (Customer_name, Customer_address)
VALUES
('DANY P', 'GAZAL HOUSE, TRIVANDRUM'),
('KEERAN H', 'MANJERI VILLA, KOTTAYAM'),
('NAITHAN JOSE', '21B-SAGAR AVENUE PARK, ERNAKULAM'),
('NITHY KORAH', '1B-AVENUE VILLAS, TRIVANDRUM'),
('THOMAS M', 'MARGERATE VIEW HILLS, WYNAD');

INSERT INTO CUSTOMER (Customer_name, REG_DATE)
VALUES
('PAULY NINAN', '2000-01-01'),
('NICK LUKE', '2003-10-01'),
('MARK JIM', '2010-05-25');

SELECT * FROM Customer;

INSERT INTO IssueStatus (Issued_cust, Issued_book_name, Isbn_book)
VALUES
(4, 'Making India Awesome', '0011'),
(1, 'Half Girlfriend', '0013'),
(5, 'The Dark Room', '0015'),
(3, 'By God’s Decree', '0014'),
(2, 'Making India Awesome', '0011');

INSERT INTO IssueStatus (Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(6, 'Half Girlfriend', '2024-06-01', '0013'),
(7, 'By God’s Decree', '2023-06-25','0014');

SELECT * FROM IssueStatus;

INSERT INTO ReturnStatus (Return_cust, Return_book_name, Isbn_book2)
VALUES
(6,'Half Girlfriend','0013'),
(7, 'By God’s Decree', '0014');

SELECT * FROM ReturnStatus;

# 1.  Retrieve the book title, category, and rental price of all available books
SELECT Book_title, Category, Rental_Price FROM BOOKS WHERE STATUS = 'YES';

# 2. List the employee names and their respective salaries in descending order of salary
SELECT Emp_name, Salary FROM EMPLOYEE ORDER BY Salary DESC;

# 3. Retrieve the book titles and the corresponding customers who have issued those books
SELECT I.Issued_book_name AS BOOK_TITLES, C.Customer_name AS CUSTOMERS FROM IssueStatus I 
LEFT JOIN Customer C ON I.Issued_cust = C.Customer_Id;

# 4. Display the total count of books in each category
SELECT COUNT(*) AS TOTAL_COUNT_OF_BOOKS, Category FROM BOOKS GROUP BY Category;

# 5. Retrieve the employee names and their positions for the employees whose salaries 
--   are above Rs.50,000
SELECT Emp_name, Position FROM EMPLOYEE WHERE SALARY > 50000;

# 6. List the customer names who registered before 2022-01-01 and have not issued any books yet
SELECT Customer_name, REG_DATE FROM CUSTOMER WHERE Customer_Id NOT IN
(SELECT Issued_cust FROM IssueStatus) HAVING REG_DATE < '2022-01-01';

# 7. Display the branch numbers and the total count of employees in each branch
SELECT B.Branch_no, COUNT(E.Emp_name) AS Total_Count_of_Employees 
FROM Branch B LEFT JOIN Employee E 
ON B.Branch_no = E.Branch_no
GROUP BY B.Branch_no;

# 8. Display the names of customers who have issued books in the month of June 2023
SELECT C.Customer_name, I.Issue_date 
FROM IssueStatus I LEFT JOIN CUSTOMER C 
ON I.Issued_cust = C.Customer_Id HAVING 
SUBSTR(I.Issue_date,1,7) = '2023-06';

# 9. Retrieve book_title from book table containing history
SELECT Book_title FROM BOOKS WHERE Book_title LIKE '%HISTORY%';

# 10. Retrieve the branch numbers along with the count of employees for branches 
--    having more than 5 employees
SELECT Branch_no, COUNT(*) AS Count_of_Employees 
FROM Employee GROUP BY Branch_no HAVING COUNT(*) > 5;

# 11. Retrieve the names of employees who manage branches and their 
--    respective branch addresses
SELECT E.EMP_NAME, B.BRANCH_NO, B.BRANCH_ADDRESS 
FROM EMPLOYEE E LEFT JOIN BRANCH B 
ON E.BRANCH_NO = B.BRANCH_NO 
WHERE E.POSITION = 'MANAGER';

# 12. Display the names of customers who have issued books with a rental 
--    price higher than Rs.25
SELECT I.Issued_cust, I.ISBN_BOOK, C. CUSTOMER_NAME 
FROM IssueStatus I LEFT JOIN CUSTOMER C 
ON I.Issued_cust = C.CUSTOMER_ID 
WHERE I.ISBN_BOOK IN 
(SELECT ISBN FROM BOOKS WHERE RENTAL_PRICE > 25);


