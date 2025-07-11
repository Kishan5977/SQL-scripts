create database kishan;
use kishan; 

create table asd(
id int ,
student_name varchar(255)  ,
mobile_number int ,
email varchar(255),
address varchar(255) ,
marks float,
admission_date datetime
);

insert into asd values (1,"kishan",1212114, "vvsgvdg@sdgd.com",'surat',96.23,"2025-01-01");
insert into asd values (2, "raju",1515414, "vvsshhg@sdgd.com","ahmedabad",84.56,"2025-03-18");
insert into asd values (3, "naman",15155514, "vvsgdbfhddg@sdgd.com","Dahod",72.12,"2025-02-14");
insert into asd values (4, "sanjay",15155454, "vvsgvdsfgdg@sdgd.com","bardoli",45.36,"2025-03-12");
insert into asd values (5, "krunal",151555, "vvsgvdsvfhg@sdgd.com","Vadodara",67.52,"2025-02-25");

select * from asd;

drop table asd;
truncate table asd;
delete from ASD where id=5;

/*Data Types*/

#tinyint
#smallint
#mediumint
#int
#bigint
#float
#double
#char
#varchar
#boolean
#date
#datetime
#time
#timestamp
#year

/*DDL Operations*/

#create
#drop
#truncate

select * from asd;

rename table asd to asd2;
alter table asd2 rename to asd;

Alter table asd drop column address; # drop column

alter table asd change column email EMailID varchar(255); #Rename Column

ALTER TABLE asd ADD COLUMN address varchar(255); # Add a new column

ALTER TABLE asd MODIFY COLUMN marks int; # changed datatype

/*View*/

create view asd4 as 
select student_name, marks from asd;
select  STUDENT_NAME,MARKS,emailid from asd4;

select * from asd;
select student_name,marks from asd4;
select * from asd4;

/*Constraints*/

# primary key => no null values, no duplicate values
# not null => no null values => duplicate [possible
# Unique => no duplicate values => null value possible
# default => If null, system can take default value
# check => check condition before inserting data => if yes, insert data, else ignore data
#### Foreign key => To connect two tables

create table asd(
id int primary key,
student_name varchar(255) not null ,
mobile_number int unique,
email varchar(255),
address varchar(255) default "Surat",
marks float check(marks>35),
admission_date datetime
);

insert into asd(id,student_name,mobile_number,email,marks,admission_date) values (1,"kishan",1212114, "vvsgvdg@sdgd.com",96.23,"2025-01-01 12:25:35");
insert into asd values (2, "raju",1515414, "vvsshhg@sdgd.com","ahmedabad",84.56,"2025-03-18");
insert into asd values (3, "naman",15155514, "vvsgdbfhddg@sdgd.com","Dahod",72.12,"2025-02-14");
insert into asd values (4, "sanjay",15155454, "vvsgvdsfgdg@sdgd.com","bardoli",45.36,"2025-03-12");
insert into asd values (5, "krunal",151555, "vvsgvdsvfhg@sdgd.com","Vadodara",67.52,"2025-02-25");

select * from asd;
update asd set student_name="yashvi" where id=2;
delete from ASD where id=5;

drop table asd;

/*Single line functions and Aggregated Functions*/
select * from asd;
select count(*) from asd;
select min(marks) from asd;
select max(marks) from asd;
select avg(marks) from asd;
select sum(marks) from asd;
select upper(student_name) from asd;
select lower(student_name) from asd;
select distinct(marks) from asd;

select now();
select curdate();
select curtime();
select current_date();
select current_time();
select current_timestamp();

select year(admission_date) from asd;
select month(admission_date) from asd;
select day(admission_date) from asd;

select max(marks) from asd;
select student_name, address from asd where marks = (select max(marks) from asd);

/*Operators*/

select student_name, marks from asd where marks > 80;
select student_name, marks from asd where marks < 50;
select student_name, marks from asd where marks >= 40 and marks <= 90;
select student_name, marks from asd where marks between 40 and 90;
select student_name, marks from asd where marks < 35 or marks > 90;
select student_name, marks from asd where not marks=36;
select * from asd where email is not null;
select * from asd where email is null;
select * from asd where address in ('Surat','Ahmedabad');
select student_name from asd where student_name like 'ki%';

Select address,count(*) from asd group by address;
Select address,count(*) from asd group by address having count(address)>=1 ;

Select * from asd limit 1 offset 1;

/*Foreign Key and Joins*/
create table Department
(
department_id int primary key,
department_name varchar(255) not null
);

insert into Department values (1,'Sales');
insert into Department values (2,'HR');
insert into Department values (3,'Admin');
insert into Department values (4,'Finance');

create table Employee
(
employee_no int primary key,
employee_name varchar(255) not null,
dept_id int,
gender varchar(6) default 'male',
age int check (age>18),
address varchar(255),
joining_date date,
Foreign key (dept_id) references Department(department_id)
);

insert into Employee values (1,'Romal',1,'Female',30,'Surat','2025-1-31');
insert into Employee values (2,'Ketan',1,'Male',31,'brd','2025-2-26');
insert into Employee values (3,'hemal',2,'Male',20,'Bharuch','2025-3-14');
insert into Employee values (4,'shyam',3,'Male',19,'Valsad','2025-4-1');
insert into Employee values (5,'Ram',3,'Male',20,'vapi','2025-1-7');
insert into Employee (employee_no,employee_name,gender,age,address,joining_date) values (6,'Shyam','Male',22,'vadodara','2025-1-27');

select * from Department;
select * from Employee;

/*JOINS*/

select e.employee_no,e.employee_name,d.department_id,d.department_name from employee e left join department d on d.department_id = e.dept_id;
select e.employee_no,e.employee_name,d.department_id,d.department_name from employee e right join department d on d.department_id = e.dept_id;
select e.employee_no,e.employee_name,d.department_id,d.department_name from employee e inner join department d on d.department_id = e.dept_id;
select e.employee_no,e.employee_name,d.department_id,d.department_name from employee e join department d on d.department_id = e.dept_id;

select e.employee_no,e.employee_name,d.department_id,d.department_name from department d left join Employee e on e.dept_id = d.department_id;
select e.employee_no,e.employee_name,d.department_id,d.department_name from Department d right join Employee e on e.dept_id = d.department_id;

SELECT * FROM Employee e LEFT JOIN Department d ON d.department_id = e.dept_id
UNION
SELECT * FROM Employee e RIGHT JOIN Department d ON d.department_id = e.dept_id;

/*7-step query execution*/
SELECT 
    d.department_name, 
    COUNT(e.employee_no) AS employee_count
FROM Employee e
LEFT JOIN Department d 
ON e.dept_id = d.department_id
WHERE e.age > 18 
GROUP BY d.department_name 
HAVING COUNT(e.employee_no) > 1 
ORDER BY employee_count DESC 
LIMIT 5
offset 1; 

/*Stored Procedure*/

create table Employee1
(
Emp_ID int primary key,
Emp_name varchar(100),
Emp_desig varchar(100),
Emp_salary int
);

insert into Employee1 values 
(01, 'Anupama', 'clerk', 20000),
(02, 'Sagar', 'Manager', 35000),
(03, 'Yash', 'Manager', 70000),
(04, 'Nagma', 'Director', 85000),
(05, 'Jalpa', 'Developer', 5000),
(06, 'Alpa', 'Developer', 45000),
(07, 'Naman', 'Manager', 65000),
(08, 'Chintan', 'clerk', 25000),
(09, 'Chintan', 'Developer', 40000),
(10, 'Komal', 'Developer', 55000);

Select * from Employee1;

delimiter $$
create procedure Salary()
begin
	select emp_id, emp_salary from employee1;
end $$
delimiter ;

# Execution of stored Procedure
call Salary();

# Stored Procedure with parameters
Delimiter //
create procedure salary1 (in salary int )
begin
select emp_id, emp_salary from employee1 where emp_salary < salary;
End //
Delimiter ;

call Salary1(30000);

# Stored Procedure with IN-OUT parameters
DELIMITER //
CREATE PROCEDURE GetSalary(IN empId INT, OUT salary DECIMAL(10,2))
BEGIN
	SELECT emp_salary INTO salary FROM employee1 WHERE emp_id = empId;
END //
DELIMITER ;

Call GetSalary(2, @emp_salary);
select @emp_salary;

# Drop a Procedure
drop procedure if exists SALARY1;

/*Functions*/

DELIMITER //
CREATE Function GetSalary(EmpId int)
returns decimal(10,2)
DETERMINISTIC
BEGIN
	DECLARE salary DECIMAL(10,2);
    SELECT emp_salary INTO salary FROM employee1 WHERE emp_id = EmpId;
    RETURN salary;
END //
DELIMITER ;

# Call a Function 
SELECT GetSalary(1);

Select * from Employee1;

# Drop a Function
DROP FUNCTION IF EXISTS GetSalary;

select Emp_name, GetSalary(emp_id) from employee1 where emp_id=2; # CAN CALL STORED PROCEDURE IN A SELECT QUERY
select Emp_name, salary() from employee1 where emp_id=2; # CAN'T CALL STORED PROCEDURE IN A SELECT QUERY

/*Triggers*/

# Triggers can be created for Insert, Update and Delete only
# Creation of trigger that updates "total" and "percentage" before inserting any record
# So it first calculate total and percentage when we try to insert record, then it inserts record with correct result.

create table Exam
(
Rollno int primary key,
Firstname varchar(100),
Bio int,
Physics int,
chem int,
maths int,

total int,
percentage float
);


select * from Exam;
drop table exam;

Insert into exam values (11, 'Kaushik', 95, 100, 90, 99, 0, 0);

create trigger abc 
before insert on Exam 
for each row # Every time new record is inserted
set
new.total = new.bio + new.physics + new.chem + new.maths,
new.percentage = (new.total/400)*100;

Insert into exam values (15, 'Kaushik', 95, 100, 90, 99, 0, 0);

Insert into exam values 
(13, 'Hitesh', 94, 40, 80, 79, 0, 0),
(21, 'Chirag', 56, 16, 89, 25, 0, 0),
(16, 'Vikas', 45, 80, 36, 49, 78, 45);

Insert into exam values(20, 'Vikas', 45, 80, 36, 49, 0, 0);

DROP TRIGGER IF EXISTS ABC;

Insert into exam values (56, 'Kaushik', 95, 100, 90, 99, 0, 0);

# AFTER TRIGGERS:

CREATE TABLE Orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    total_amount DECIMAL(10, 2)
);

CREATE TABLE Order_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    log_message VARCHAR(255),
    log_time DATETIME
);

DELIMITER //

CREATE TRIGGER after_order_insert
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_Log (order_id, log_message, log_time)
    VALUES (NEW.id, CONCAT('Order placed by ', NEW.customer_name), NOW());
END;
//

DELIMITER ;
DROP TRIGGER IF EXISTS after_order_insert;
DROP TABLE Orders;
DROP TABLE ORDER_LOG;

select * from Orders;
select * from Order_Log;
INSERT INTO Orders (customer_name, total_amount)
VALUES ('Alice', 150.00) , ('KISHAN', 154.00),('vishal',130.45);

# BEFORE AND AFTER UPDATE TRIGGERS:

CREATE TABLE users (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  age INT
);

INSERT INTO users VALUES (1, 'KISHAN', 25);
INSERT INTO users VALUES (2, 'YASHVI', 30);

DELIMITER $$

CREATE TRIGGER before_update_users
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
  IF NEW.age < 0 THEN
    SET NEW.age = 0;  -- Fix negative age BEFORE it is saved
  END IF;
END$$

DELIMITER ;
UPDATE users SET age = 26 WHERE id = 2;

DROP TRIGGER IF exists before_update_users;

DROP TABLE USERS;
SELECT * FROM users;

# AFTER UPDATE

CREATE TABLE user_logs (
  log_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  old_age INT,
  new_age INT,
  log_time DATETIME
);

DELIMITER $$

CREATE TRIGGER after_update_users
AFTER UPDATE ON users
FOR EACH ROW
BEGIN
  INSERT INTO user_logs(user_id, old_age, new_age, log_time)
  VALUES (OLD.id, OLD.age, NEW.age, NOW());
END$$

DELIMITER ;
UPDATE users SET age = 35 WHERE id = 2;

DROP TRIGGER IF exists after_update_users;

SELECT * FROM user_logs;
DROP TABLE user_logs


# CASE Statements

/*  Syntax
CASE
	WHEN condition1 THEN result1
	WHEN condition2 THEN result2
	...
	ELSE default_result
END

Each `WHEN` clause contains a separate condition.
MySQL evaluates conditions sequentially and returns the first matched result.
*/

SELECT Firstname, maths,
CASE 
    WHEN maths=100 THEN 'A+'
    WHEN maths>=90 THEN 'A'
    WHEN maths>=80 THEN 'B'
    WHEN maths>=70 THEN 'C'
    ELSE 'Fail'
END AS grade
FROM Exam;

select * from Exam;

SELECT Emp_name, Emp_salary,
CASE
    WHEN Emp_salary > 70000 THEN 'High'
    WHEN Emp_salary BETWEEN 40000 AND 70000 THEN 'Medium'
    ELSE 'Low'
END AS salary_category
FROM Employee1;

# Using CASE in UPDATE Statement
UPDATE Employee1
SET Emp_salary =
CASE
    WHEN Emp_desig = 'Director' THEN Emp_salary * 1.25
    WHEN Emp_desig = 'Manager' THEN Emp_salary * 1.15
    WHEN Emp_desig = 'Developer' THEN Emp_salary * 1.10
    ELSE Emp_salary * 1.05
END;

select * from Employee1;

# Using CASE in ORDER BY
SELECT Emp_name, Emp_desig, Emp_salary FROM Employee1
ORDER BY 
CASE Emp_desig
    WHEN 'Director' THEN 1
    WHEN 'Manager' THEN 2
    WHEN 'Principal' THEN 3
    WHEN 'Teacher' THEN 4
    WHEN 'Developer' THEN 5
    ELSE 6
END;

# Using CASE in GROUP BY (Conditional Aggregation functions like `SUM`, `COUNT`, `AVG`, etc.)
SELECT 
SUM(CASE WHEN Emp_desig = 'Manager' THEN Emp_salary ELSE 0 END) AS Manager_Salary, 
SUM(CASE WHEN Emp_desig = 'Developer' THEN Emp_salary ELSE 0 END) AS Developer_Salary 
FROM Employee1;

# Using CASE in HAVING Clause
SELECT Emp_desig, SUM(Emp_salary) AS total_salary FROM Employee1
GROUP BY Emp_desig
HAVING 
CASE 
    WHEN SUM(Emp_salary) > 50000 THEN TRUE
    ELSE FALSE
END;

/*SubQueries*/

/*
A subquery is a query nested inside another query. 
It is enclosed within parentheses and is used to fetch data that is then used by the main (outer) query.

SELECT column1, column2, ... , FROM table_name
WHERE column_name OPERATOR (SELECT column_name FROM table_name WHERE condition);

Types of Subqueries:
1. Single-Row Subqueries → Return one value → for scalar operations
2. Multi-Row Subqueries → Return multiple values → If using IN, EXISTS, ALL, ANY or FROM caluses
3. Multi-Column Subqueries → Return multiple columns
4. Correlated Subqueries → Reference the outer query 
*/
select * from Employee1;

/*A scalar subquery returns a single value that can be used like a variable.*/
SELECT Emp_name, Emp_salary FROM Employee1
WHERE Emp_salary = (SELECT MAX(Emp_salary) FROM Employee1 WHERE Emp_desig = 'Developer');

/*Comparison operators in subqueries.*/
SELECT Emp_name, Emp_salary FROM Employee1 
WHERE Emp_salary > (SELECT AVG(Emp_salary) FROM Employee1);

/* IN checks if a value exists in a list returned by the subquery.*/
SELECT Emp_name, Emp_salary FROM Employee1 
WHERE Emp_salary IN (SELECT Emp_salary FROM Employee1 WHERE Emp_desig = 'Developer');

/* ANY compares a value with any value in the subquery. */
SELECT Emp_name, Emp_salary FROM Employee1
WHERE Emp_salary > ANY (SELECT Emp_salary FROM Employee1 WHERE Emp_desig = 'manager');
/*The query selects employees earning more than the lowest MANAGER salary.*/

/*ALL compares a value with all values returned by the subquery.*/
SELECT Emp_name, Emp_salary FROM Employee1
WHERE Emp_salary > ALL (SELECT Emp_salary FROM Employee1 WHERE Emp_desig = 'manager');
/*The query selects employees earning more than the highest MANAGER salary.*/

/* SOME works like ANY */
SELECT Emp_name, Emp_salary FROM Employee1
WHERE Emp_salary > SOME (SELECT Emp_salary FROM Employee1 WHERE Emp_desig = 'manager');

/*A row subquery returns multiple columns*/
SELECT Emp_name, Emp_salary FROM Employee1 
WHERE (Emp_name, Emp_salary) = (SELECT Emp_name, Emp_salary FROM Employee1 WHERE Emp_desig = 'developer' limit 1);
/*The inner query returns a row (Emp_name, Emp_salary). The outer query selects employees matching that row.*/

/*EXISTS checks if a subquery returns any rows.*/
SELECT Emp_name, Emp_salary FROM Employee1 E1
WHERE EXISTS (
    SELECT 1 FROM Employee1 E2
    WHERE E1.Emp_name = E2.Emp_name AND E1.Emp_ID <> E2.Emp_ID
);
/*The inner query checks if the same name exists in another row. The outer query selects those employees.*/

/* Find employees without a duplicate name */
SELECT Emp_name, Emp_salary FROM Employee1 E1
WHERE NOT EXISTS (
    SELECT 1 FROM Employee1 E2
    WHERE E1.Emp_name = E2.Emp_name AND E1.Emp_ID <> E2.Emp_ID
);

/* A correlated subquery depends on the outer query and is executed once for each row.*/
SELECT Emp_name, Emp_desig, Emp_salary FROM Employee1 E1
WHERE Emp_salary > (SELECT AVG(Emp_salary) FROM Employee1 E2 WHERE E1.Emp_desig = E2.Emp_desig);
/* The query selects employees earning above their designation's average salary.*/

/* A subquery in the FROM clause is called a derived table. */
SELECT E.Emp_name, E.Emp_desig, E.Emp_salary FROM Employee1 E
JOIN (SELECT Emp_desig, AVG(Emp_salary) AS avg_salary FROM Employee1 GROUP BY Emp_desig) AS AvgTable
ON E.Emp_desig = AvgTable.Emp_desig
WHERE E.Emp_salary > AvgTable.avg_salary;
/* The subquery (AvgTable) calculates the average salary per designation. The main query selects employees earning above that average.*/


-- Practice Questions:

-- 1. Convert the TotalCharges column to numeric format for accurate calculations.
-- 2. Retrieve the total number of customers and those who have churned.
-- 3. Calculate the average tenure of customers who churned vs. those who didn't.
-- 4. Find the top 5 most common payment methods used by customers.
-- 5. Create a stored procedure to fetch customers based on a tenure range.
-- 6. Find the percentage of customers using Fiber Optic Internet.
-- 7. Create a trigger to prevent inserting customers with negative MonthlyCharges.
-- 8. Identify customers with above-average MonthlyCharges.
-- 9. Create a view to show customers with online security and tech support.
-- 10. Count the number of customers grouped by contract type, filtering those with over 100 customers.
-- 11. Retrieve the top 10 customers with the highest total charges.
-- 12. Find customers with tenure above 50 months and are still active.
-- 13. Calculate the total revenue generated per payment method.
-- 14. Create an index on tenure to optimize performance.
-- 15. Retrieve the count of customers who have both streaming TV and streaming movies services.
-- 16. Use a CASE statement to categorize customers based on tenure:
--     - 'New' (0-12 months), 'Intermediate' (13-48 months), 'Loyal' (49+ months).
-- 17. Use a CASE statement to classify customers based on MonthlyCharges:
--     - 'Low' (below $30), 'Medium' ($30-$70), 'High' (above $70).
-- 18. Create a function to calculate the total revenue for a given contract type.
-- 19. Insert a new customer record into the churn_data table.
-- 20. Update the MonthlyCharges for a specific customer.
-- 21. Delete a customer record from the churn_data table.