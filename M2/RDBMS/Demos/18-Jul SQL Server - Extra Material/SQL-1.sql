
-- Using Default Constraint

drop table ToBeDeleted1
create table ToBeDeleted1
(
 col1 int,
 col2 varchar(20) NOT NULL DEFAULT 'UNKNOWN'
)

insert into ToBeDeleted1(col1) values (1);
insert into ToBeDeleted1(col1) values (2);
insert into ToBeDeleted1(col1) values (3);

select * from ToBeDeleted1

DELETE ToBeDeleted1 
TRUNCATE TABLE  ToBeDeleted1 



--------------------------------------------------------------------------------
-- Using Check Constraint 

create table tbl2 
(
pub_id char(4) check ( pub_id in('1234', '4321', '1212') ),
pub_name varchar(40)
)

insert into tbl2 values('1234', 'Pname1')
insert into tbl2 values('4321', 'Pname2')
insert into tbl2 values('1212', 'Pname3')
insert into tbl2 values('123', 'Pname4')
insert into tbl2 values('2344', 'Pname5')

select * from tbl2

----------------------------------------------------------------------------------

-- * Create table Department_132419 with following fields.
	-- DeptId (int) PK, DeptName (string), Location (string)
-- * Insert 3 Sample records in the above table using insert query.

drop type Location


create type Location
from varchar(30) NOT NULL

create default DF_Location as 'UNKNOWN'

EXEC SP_BinDefault DF_Location, Location

drop table Department
create table Department
(
	DeptId int Primary Key,
	DeptName varchar(20) NOT NULL,
	Location Location
)

insert into Department values(101, 'Admin', 'Andheri');
insert into Department(DeptId, DeptName, Location) values(102, 'Operation', 'Vashi');
insert into Department(DeptId, DeptName) values(103, 'HR');

select * from Department


-- * Create table Employee_132419 with following fields.
	-- EmpId (int) PK,	EmpName (string), DOJ (date), Salary (currency), DeptId (int) FK
-- * Insert 6 Sample records in the above table using insert query.
drop table Employee
create table Employee
(
	EmpId int primary key Identity (1001, 1),
	EmpName varchar(20),
	DOJ date,
	Salary money,
	DeptId int FOREIGN KEY REFERENCES Department(DeptId)
)

insert into Employee values('Ravindra', '2017-8-31', 46000,101) -- allowed
insert into Employee values('Jayesh', '12-12-2016', 34000,102) --allowed
insert into Employee(EmpName,DOJ,Salary,DeptId) values('Harshal', '8-31-2017', 43000,103) -- not allowed
insert into Employee values('Kavita', '8-31-2017', 40000,104) -- not allowed

select * from Employee

alter table Employee
add EAddress varchar(30) 

alter table Employee
add constraint df_customer_Add DEFAULT 'UNKNOWN' for EAddress

-- * Using group by query
-- * Use select query to retirve records from more than one related tables.
-- * Display records from details table based on value from master table.
-- * Retrive records based on year/month from the date field
-- * Retrive the records containing highest (number) value.
-- * Retrive the records containing in specific range

---------------------------------------------------------------------------------

select * from Employee

declare @id int
set @id = 1001
select @id
print @id

declare @n varchar(20) 
set @n = 'Shivendra'

declare @d date
set @d = '2-23-1980'

-- Updating records
update Employee set EmpName = @n, DOJ = @d where EmpId = @id
update Employee set EmpName = 'Anjali', DOJ = '1-21-1992' where EmpId = 1002

--DeletingRecords
delete from Employee where EmpId = 1002

------------------------------------------------------------------------------------------------------------
-- Merge Statement in SQL Server

drop table StudentSource
Create table StudentSource
(
 ID int primary key,
 Name nvarchar(20)
)

Insert into StudentSource values (1, 'Mike')
Insert into StudentSource values (2, 'Sara')
GO

drop table StudentTarget
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
-- Selecting data from more than 1 related tables

use Training_17Jan2018_Bangalore

select * from Student_master order by Stud_Name desc
select * from Student_master order by Stud_Name desc

select * from Department_master 

select Stud_Code, Stud_Name, Dept_Name 
from Student_master as S, Department_master as D
where S.Dept_Code = D.Dept_code
---------------------------------------------------------------------------------------
-- ORDER BY (display Student Name, DOB for student born in 1980 by desc order of their DOB)
select Stud_Name, Dept_Code, Stud_DOB
from Student_master 
where DatePart(year,Stud_dob) = '1980'
order by Stud_DOB desc



---------------------------------------------------------------------------------------
-- Using GROUP by (Display Department wise Student Count )

select Dept_Code, SUM(Stud_Code) from Student_master
group by Dept_Code 

---------------------------------------------------------------------------------------
-- Using DISTINCT

select distinct dept_code from Department_master

---------------------------------------------------------------------------------------

-- Using LIKE operator ( use % or _ ) 


---------------------------------------------------------------------------------------
-- Using functions - REPLACE
declare @s1 varchar(20)
set @s1 = 'Keyboard'
print @s1

select Replace(@s1, 'key', 'white')

select dept_Code, Count(Stud_Name) 
from Student_master
group by Dept_Code 
having count(*) < 5

------------------------------------------------------------------------------

-- Using Joins

drop table Department
drop table Employee

create table Department
(
	DeptId int Primary Key,
	DeptName varchar(20)
)
insert into Department values (100, 'HR'), (300, 'Admin'), (400, 'Operation')

create table Employee (
	EmpId int Primary Key,
	EmpName varchar(20),
	DeptId int,
	Salary money)
insert into Employee values (1001, 'Lalit', 100, 44200.00), (1002,'Kavita',	100, 44200.00),
(1003,'Manoj',	200, 37000.00), (1004,'Jayeshri', 200, 24500.00), (1005, 'Manish', 300, 44200.00);
insert into Employee(Empid, EmpName, Salary) values (1006,'Harshal', 44200.00), 
(1007, 'Kiran', 44200.00);

select * from Department
select * from Employee

-- Inner Join
select Empid, Empname, DeptName
from Employee
inner join Department -- [inner] keyword is optional
on Employee.DeptId = Department.DeptId

--same query in easy way
select EmpId, EmpName, DeptName
from Employee, Department
where Employee.DeptId = Department.DeptId

-- Left Outer
select Empid, Empname, Department.DeptName
from Employee
left outer join Department
on Employee.DeptId = Department.DeptId

-- Right Outer join
select Empid, Empname, Department.DeptName
from Employee
right outer join Department
on Employee.DeptId = Department.DeptId

-- Full Outer Join
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

Declare @dName varchar(20)
set @dName = 'Admin'

select EmpId, EmpName, Salary 
from Employee 
where DeptId = (select DeptId 
				from Department 
				where DeptName = @dName)

declare @eId int
set @eId = 101

select EmpId, EmpName, DeptId
from Employee
where DeptId = 
(select DeptId from Employee where Empid = @eId)


-- Sub-Query Example-2
--Use NORTHWND
-- Get products(info) from suppliers in City Paris
select ProductId, ProductName, UnitPrice
from PRODUCTS where SupplierID in 
(select SupplierID
from Suppliers
where CITY='Paris'
)

--use AdventureWorks2012
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
 @Answer varchar(30) OUTPUT 
 as
   Declare @sum int
   Set @sum = @FirstNumber + @SecondNumber
   Set @Answer = 'The answer is ' + convert(varchar,@sum)
Return @sum

SP_Help Employee

-------------------------------------------------------------------------
-- Defining & Using SPs
 
create table Product
(
	ProdId int Primary Key Identity,
	ProdName varchar(20),
	Price money,
	[Description] varchar(200) 
)

select * from Product

declare @pName varchar(20) = 'Laptop'
declare @pPrice money = 56000
declare @pDesc varchar(200) = 'THis is description for laptop'
insert into Product values(@pName,@pPrice,@pDesc)

declare @pName varchar(20) = 'Laptop'
declare @pPrice money = 56000
declare @pDesc varchar(200) = 'THis is description for laptop'
insert into Product values(@pName,@pPrice,@pDesc)

declare @pId int = 1
set @pName = 'Desktop';
update Product set ProdName = @pName, Price = @pPrice, [Description] = @pDesc 
where ProdId = @pId

delete from Product where ProdId = @pId

--SP to Select All Products
create proc USP_GetAllProducts
as
select * from Product

--SP to Select Product based on Id
create proc USP_GetProductById
@pId int
as
select * from Product where ProdId = @pId

create proc USP_UpdateProduct
@pId int,
@pName varchar(20),
@pPrice money,
@pDesc varchar(200)
as
update Product set ProdName = @pName, Price = @pPrice, [Description] = @pDesc where ProdId = @pId

create proc USP_InsertProduct
@pName varchar(20),
@pPrice money,
@pDesc varchar(200)
as
insert into Product values(@pName,@pPrice,@pDesc)

create proc USP_DeleteProduct
@pId int
as
delete from Product where ProdId = @pId

exec USP_GetAllProducts

exec USP_GetProductById 1
exec USP_GetProductById @pId=1

exec USP_InsertProduct @pName = 'mouse', @pPrice = 350, @pDesc = 'This is description for Mouse'
exec USP_InsertProduct @pPrice = 350, @pName = 'mouse', @pDesc = 'This is description for Mouse'




exec SP_HelpText USP_GetProductById

create proc USP_GetAddition
@n1 int, 
@n2 int,
@r int out
as
set @r = @n1 + @n2

declare @r int 
declare @n1 int = 20
declare @n2 int = 10
exec USP_GetAddition 20, 30, @r out
print @r

