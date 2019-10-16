-- Using XML 

use AdventureWorks2012

drop table Resumes

CREATE TABLE dbo.Resumes
(
  	CandidateID 	INT 	IDENTITY PRIMARY KEY,
   	CandidateResume	XML
);
 
INSERT INTO Resumes (CandidateResume) SELECT Resume FROM HumanResources.JobCandidate;

select * FROM dbo.Resumes where CandidateID=1;

DECLARE @resume XML;
SELECT @resume = CandidateResume FROM dbo.Resumes WHERE CandidateID = 1;
SELECT @resume AS Resume; 

select CandidateResume as Resume FROM dbo.Resumes where CandidateID=1;

---------------------------------------------------------------------------------
use db_Amol132419
-- Using Joins
select * from Department
select * from Employee
delete from Employee

SP_Help Employee

alter table Employee
drop constraint FK__Employee__DeptId__117F9D94

alter table Employee
alter column EmpId int not null

alter table Employee 
Add constraint PK_Employee_Id Primary Key (EmpId)

insert into Employee values
(1001, 'Lalit', 100, 44200.00),
(1002,'Kavita',	100, 44200.00),
(1003,'Manoj',	200, 37000.00),
(1004,'Jayeshri', 200, 24500.00),
(1005, 'Manish', 300, 44200.00);

insert into Employee(Empid, EmpName, Salary) values
(1006,'Harshal', 44200.00),
(1007, 'Kiran', 44200.00);

select * from Employee

-- inner join example

select Empid, Empname, DeptName
from Employee
inner join Department  -- [inner] keyword is optional here
on Employee.DeptId = Department.DeptId

--same query in easy way
select EmpId, EmpName, Department.DeptName
from Employee, Department
where Employee.DeptId = Department.DeptId

-- left outer join
select Empid, Empname, Department.DeptName
from Employee
left outer join Department
on Employee.DeptId = Department.DeptId

-- right outer join

select Empid, Empname, Department.DeptName
from Employee
right outer join Department
on Employee.DeptId = Department.DeptId

-- full outer join

select Empid, Empname, Department.DeptName
from Employee
full outer join Department
on Employee.DeptId = Department.DeptId

--cross join

select Empid, Empname, Department.DeptName
from Employee
cross join Department
 
--same query in easy way
select Empid, Empname, Department.DeptName 
from Employee, Department

---------------------------------------------------------------------------------

-- Sub-Queries

-- Sub-Query Example-1

use Training_Db

select * from Employee

declare @eId int = 1003

select EmpId, EmpName, DeptId
from Employee
where DeptId = 
(select DeptId from Employee where Empid = @eId)


-- Sub-Query Example-2

Use NORTHWND

-- Get products(info) from suppliers in City Paris
select ProductId, ProductName, UnitPrice
from PRODUCTS where SupplierID in 
(select SupplierID
from Suppliers
where CITY='Paris'
)
use AdventureWorks2012
-- Another example-3 of Sub-Query (Multi-Row)
select ProductId, ProductName, SupplierId, UnitPrice
from Products
where UnitPrice > All (select UnitPrice from Products where SupplierID = 11 ) /*{ 14, 31.23, 43.90 } */
order by UnitPrice desc 
---------------------------------------------------------------------------------

-- Merge Statement in SQL Server

Create table StudentSource
(
 ID int primary key,
 Name nvarchar(20)
)

Insert into StudentSource values (1, 'Mike')
Insert into StudentSource values (2, 'Sara')
GO

Create table StudentTarget
(
 ID int primary key,
 Name nvarchar(20)
)
GO

Insert into StudentTarget values (1, 'Mike M')
Insert into StudentTarget values (3, 'John')
GO

select * from StudentSource
select * from StudentTarget

MERGE INTO StudentTarget AS T
USING StudentSource AS S
ON T.ID = S.ID
WHEN MATCHED THEN
 UPDATE SET T.NAME = S.NAME
WHEN NOT MATCHED BY TARGET THEN
 INSERT (ID, NAME) VALUES(S.ID, S.NAME);  

---------------------------------------------------------------------------------

 select EmpId, EmpName, DeptName from Employee, Department
 where (Employee.EmpId = 1003 and Department.DeptId = Employee.DeptId)

---------------------------------------------------------------------------------

create view IV_EmpDept
as 
select Empid, Empname, Department.DeptName
from Employee
inner join Department  -- [inner] keyword is optional here
on Employee.DeptId = Department.DeptId

select * from IV_EmpDept

---------------------------------------------------------------------------------

-- Find Employee.EmpName and Department.DepartmentName based on Employee.EmpId 

declare @eId int = 1003
select (select EmpName from Employee where EmpId = @eId) as EmpName, DeptName from Department where DeptId =  (select DeptId from Employee where EmpId = @eId)

---------------------------------------------------------------------------------

-- Using Store-Procedures

CREATE PROC USP_Addnum
 @FirstNumber int = 5,
   @SecondNumber int,
 @Answer varchar(30) OUTPUT as

   Declare @sum int
   Set @sum = @FirstNumber + @SecondNumber
   Set @Answer = 'The answer is ' + convert(varchar,@sum)
   Return @sum