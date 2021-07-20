/*Writing questions
1. View is virtual table that does not require any storage. We can use view to aquire desired data without modifying the database. View can limit user from accessing the rest of base table, join multiple tables into single one.
2. Yes, one can update, insert, delete rows in view satement, but can't change text and image, and will only change one table when there are many joins.
3. Stored procedure is a block of statements in sql. We can store it and use it many times by calling the procedure. It reduce the query redundancy.
4. Stored procedure is like normal query statement producing vritual table. Stored procedure do querying based on input parameters and its contents.
5. Function must have return value but stored procedure may not have one.
6. Yes, stored procedure can return multiple sets
7. NO, because it will mix declarative and impreative programming and SQL will get confused
8. A trigger is a special type of stored procedure that automatically runs when an event occurs in the database server. There are DDL trigger, DML trigger, and Logon trigger
9. One may use trigger to: automatically update the 'sum' column when 'elements' column is changed to ensure data integrity. Or: record and update logfile when someone modifies or queues data
10.Trigger runs automatically but stored procedure runs upon calls.
*/
--1
use Northwind
go
--1
Begin try
	insert into dbo.Region (RegionID,RegionDescription) values (5,'Middle Earth')
	insert into dbo.Territories (TerritoryID,TerritoryDescription,RegionID) values(99999,'Gondor',5)
	insert into dbo.Employees ( FirstName,LastName,Region) values('Aragorn','King','Gondor')
	insert into dbo.EmployeeTerritories(EmployeeID,TerritoryID) values(10,99999)

end try
begin catch
end catch
--2
update dbo.Territories set TerritoryDescription = 'Arnor' where TerritoryID = 99999

--3
begin try
delete from dbo.EmployeeTerritories where EmployeeID = 10
delete from dbo.Territories where RegionID = 5
delete from dbo.Employees where EmployeeID = 10
delete from dbo.Region where RegionID = 5
end try
begin catch
end catch
go
--4
create view [view_product_order_Li] as select a.ProductName, sum(b.Quantity) as TotalQuantity from dbo.Products a join dbo.[Order Details] b on a.ProductID = b.ProductID group by a.ProductName
go
--5
create procedure [sp_product_order_quantity_Li] 
@id int,
@quantity int output
as
begin
select @quantity = sum(b.Quantity)from dbo.Products a join dbo.[Order Details] b on a.ProductID = b.ProductID where a.ProductID = @id group by a.ProductID 
end
--6
go
create procedure sp_product_order_city_Li @name nvarchar(40), @data nvarchar(200) output as
begin
select top 5 @data = a.ShipCity + cast(sum(b.quantity) as nvarchar(5)) from (dbo.Products c join dbo.[Order Details] b on c.ProductID = b.ProductID ) join dbo.Orders a on a.OrderID = b.OrderID where c.ProductName = @name group by a.ShipCity order by sum(b.quantity) desc
end
go

create procedure sp_move_employees_Li as
begin

declare @count int
select @count=count(c.EmployeeID) from dbo.EmployeeTerritories c join dbo.Territories b on b.TerritoryID = c.TerritoryID where b.TerritoryDescription ='Troy'
if @count>0
	begin
		insert into dbo.Territories (TerritoryID,TerritoryDescription,RegionID) values (99999,'Stevens Point',3 )
		update dbo.EmployeeTerritories set TerritoryID = 99999 where EmployeeID in (select c.EmployeeID from dbo.EmployeeTerritories c join dbo.Territories b on b.TerritoryID = c.TerritoryID where b.TerritoryDescription ='Troy')

		
	end
end
go

create trigger trig_mov_back
on dbo.EmployeeTerritories
after update as
begin
declare @count int
select @count = count(TerritoryID) from dbo.EmployeeTerritories where TerritoryID=99999
if @count>100
begin
	update dbo.EmployeeTerritories set TerritoryID = 48084 where EmployeeID in (select c.EmployeeID from dbo.EmployeeTerritories c join dbo.Territories b on b.TerritoryID = c.TerritoryID where c.TerritoryID = 99999)
end


end

drop trigger trig_mov_back

--9
create table people_Li(id int primary key, Name nvarchar(15),City int)
insert into people_Li (id,Name, City) values (1,'Aaron Roders',2),(2,'Russell Wilson',1),(3,'Jody Nelson',2)

create table city_Li(id int primary key, City nvarchar(15))
insert into city_Li (id,City) values (1,'Seattle'), (2,'Green Bay')

update city_Li set City = 'Madison' where id = 1
go
create view Packers_Mingjie_Li as
select b.Name from dbo.people_Li b join dbo.city_Li a on a.id = b.City where a.id = 2
go
Select * from Packers_Mingjie_Li
Drop view Packers_Mingjie_Li
Drop table dbo.city_Li
Drop table dbo.people_Li

go
--10
create procedure sp_birthday_employees_Li 
as
begin
Create table brithday_employees_Li (Name nvarchar(15))
Select * into brithday_employees_Li from (select FirstName + ' ' + LastName from dbo.Employees where month( BirthDate ) = 2 )

end

exec sp_birthday_employees_Li
drop table brithday_employees_Li
go
create procedure sp_Li_1 @cities nvarchar(1000) output
as
begin
select @cities = 
stuff((select ';'+b.ContactName from dbo.Customers b join (dbo.[Order Details] a join dbo.Orders c on a.OrderID = c.OrderID) on b.CustomerID = c.CustomerID group by b.ContactName having count(c.OrderID)<3 for XML path('')),1,1,'' ) from dbo.Customers

end

--12 by using minus statement

-- 13
-- select [First Name] + ' ' + [Last Name] + ifnull([Middle Name]+'.','') from table
--14
-- select top 1 Marks from table where Sex = 'F' order by Marks
--16
-- Select * from table order by Sex,Marks desc

