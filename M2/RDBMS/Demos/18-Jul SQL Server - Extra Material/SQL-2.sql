use Temp_Eval

--creating new database
create database db_Amol132419;

--deleting existing database
drop database db_Amol132419;

drop table Employee;
drop table Department;

create table Department
(
	DeptId int,
	DeptName varchar(20),
	Location varchar(20)
)

insert into Department values(101, 'Admin', 'Andheri');
insert into Department(DeptId, Location) values(102, 'Vashi');
insert into Department(DeptId, DeptName) values(103, 'HR');


alter table Department
alter column DeptId int NOT NULL

alter table Department
add constraint pk_Department primary key(DeptId)

create table Employee
(
	EmpId int primary key,
	EmpName varchar(20),
	DOJ date,
	Salary money,
	DeptId int
)

alter table Employee
alter column EmpName varchar(20) NOT NULL

alter table Employee
alter column DOJ date NOT NULL

alter table Employee
alter column Salary money NOT NULL

alter table Employee
alter column DeptId int NOT NULL

drop table Employee

create table Employee
(
	EmpId int primary key identity,
	EmpName varchar(20),
	DOJ date,
	Salary money,
	DeptId int
)

insert into Employee values('Ravindra', '2017-8-31', 46000,1) -- allowed
insert into Employee values('Jayesh', '12-12-2016', 34000,2) --allowed
insert into Employee values('Harshal', '31-8-2017', 43000,1) -- not allowed
insert into Employee values('Kavita', '8-31-2017', 40000,3) -- allowed

declare @d1 date = sysdatetime()
print @d1
declare @d2 datetime = sysdatetime()
print @d2
declare @d3 datetime2 = sysdatetime()
print @d3
declare @d4 datetimeoffset = sysdatetime()
print @d4


create type EmailOrName
from varchar(30) NOT NULL

drop table ToBeDeleted

create table ToBeDeleted
(
 col1 EmailOrName,
 col2 varchar(20) NOT NULL
)

alter table ToBeDeleted 
alter column col2 EmailOrName

alter table ToBeDeleted 
alter column col1 EmailOrName


create schema EmpDept

create table EmpDept.Employee
(
	EmpId int primary key identity,
	EmpName varchar(20),
	DOJ date,
	Salary money,
	DeptId int
)

CREATE SEQUENCE SQ1 AS INT
START WITH 101
INCREMENT BY 1
MINVALUE 101
MAXVALUE 200
CYCLE


alter table Employee
add EAddress varchar(30) 

alter table Employee
add constraint df_customer_Add DEFAULT 'UNKNOWN' for EAddress

insert into Employee(EmpName, DOJ, Salary, DeptId) values('Harish', '2017-8-31', 46000,1)


drop SEQUENCE SQ2
CREATE SEQUENCE SQ2 AS INT
START WITH 101
INCREMENT BY 1
MAXVALUE 105
CYCLE
GO

create table tbl1
(
	id1 int,
	id2 int
)

insert into tbl1 values(1, next value for sq2);
insert into tbl1 values(2, next value for sq2);
insert into tbl1 values(3, next value for sq2);
insert into tbl1 values(4, next value for sq2);
insert into tbl1 values(5, next value for sq2);
insert into tbl1 values(6, next value for sq2);
insert into tbl1 values(7, next value for sq2);

insert into MyTableName(Id,Name) values
(next value for sq2, 'ProdName1', 12012);

select * from tbl1

create table tbl2 
(
pub_id char(4),
pub_name varchar(40), 
constraint my_chk_constraint check (pub_id in ('1234', '4321', '1212'))
)

insert into tbl2 values('1234', 'Pname1')
insert into tbl2 values('4321', 'Pname2')
insert into tbl2 values('1212', 'Pname3')
insert into tbl2 values('123', 'Pname4')
insert into tbl2 values('2344', 'Pname5')

drop table ContactDetails
drop table CustomerMaster

CREATE TABLE CustomerMaster (
  Id INT NOT NULL PRIMARY KEY IDENTITY,
  firstname varchar(50) NOT NULL,
  lastname varchar(50) NOT NULL
)

CREATE TABLE ContactDetails (
  id INT,
  customer_id INT FOREIGN KEY REFERENCES CustomerMaster(id) on delete cascade on update cascade, 
  info varchar(50) NOT NULL,
  type varchar(50) NOT NULL  
)


delete from CustomerMaster where Id = 1


-- Alias / User Defined Type
create type Region 
from varchar(15) NOT NULL

-- Create Default
create default DF_Value as 'NA'

exec SP_bindefault 'DF_Value','Region';


create table Customer1(
Id int,
FName varchar(50),
LName varchar(50),
CountryCode char(2),
Age tinyint
)

insert into Customer1 values(1, 'Raja', 'M', 'IN', 20),
(2, 'James', 'Smith', 'CA', 60),
(3, 'Robert', 'Ladson', 'US', 54),
(4, 'Alias', 'John', 'US', 87)

create table Customer2(
Id int,
FName varchar(50),
LName varchar(50),
CountryCode char(2),
Age tinyint
)
insert into Customer2 values(4, 'Raja', 'M', 'US', 33),
(5, 'Dita', 'M', 'US', 15),
(6, 'Adita', 'M', 'US', 29)

select age from Customer1 --20,60,54,87
select age from Customer2 --33,15,29

select * from Customer1 where LName = 'Ladson'
select * from Customer1 where Age > All(select age from Customer2)
select * from Customer1 where Age > All [33,15,29]
-- 20 > All(33,15,29) --FALSE
-- 60 > All(33,15,29) --TRUE
-- 54 > All(33,15,29) --TRUE
-- 87 > All(33,15,29) --TRUE

select * from Customer1
where Age < Any(select age from Customer2)
-- 20 < Any(33,15,29) --TRUE
-- 60 < Any(33,15,29) --FALSE
-- 54 < Any(33,15,29) --FALSE
-- 87 < Any(33,15,29) --FALSE

use NORTHWND

SELECT UnitPrice FROM Products

SELECT UnitPrice FROM Products WHERE UnitPrice > 500

select * from Products
where UnitPrice > ALL (SELECT UnitPrice FROM Products WHERE UnitPrice > 500);

PRINT STR(123.456, 7, 2)
PRINT STR(123.456)


declare @d1 datetime = GetDate();
declare @d2 datetime = DATEADD(month,-1,@d1);
select @d2
select DATEDIFF(day,@d1, @d2);



select * from Employee
exec SP_Help Employee

select DeptId from Employee group by DeptId having count(*) > 2

use NORTHWND
select CategoryID, AVG(UnitPrice) as AvgPrice from Products
group by CategoryID order by AvgPrice desc


select * from Customer1 --20,60,54,87
select * from Customer2 --33,15,29

create table tblFirst
(
	Id int,
	Name varchar(20)
)
insert into tblFirst values(1, 'abhi'),
(2, 'adam');

create table tblSecond
(
	Id int,
	Name varchar(20)
)
insert into tblSecond values(2, 'adam'),
(3, 'Chester');

select * from tblFirst
select * from tblSecond

select * from tblFirst
union
select * from tblSecond

select * from tblFirst
union all
select * from tblSecond

select * from tblFirst
intersect
select * from tblSecond

select * from tblFirst
except
select * from tblSecond


-- Indexes 

drop table tblPerson



create table tblPerson
(
	Id int ,
	Name varchar(20),
	[Address] varchar(250)
)

insert into tblPerson values
(5, 'Abhi', 'Mumbai-400012'),
(3, 'Adam', 'Mumbai-400021');

select * from tblPerson

create clustered index INX_PersonId
on tblPerson(Id)

select * from tblPerson

insert into tblPerson values
(1, 'Jay', 'Mumbai-400028'),
(2, 'Chester', 'Mumbai-400003'),
(4, 'Manish', 'Mumbai-400032');

select * from tblPerson

drop index tblPerson.INX_PersonId;