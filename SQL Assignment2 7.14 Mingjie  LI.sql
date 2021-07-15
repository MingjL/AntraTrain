/*
Writing answers:
1. Result set is a set of rows from database that follows the order of query command.
2. Union all selects all values and does not elminate duplicate rows, union will only give unique rows.
3. Other set operations are intersect,minus.
4. Union combines tables in rows while join combines them in columns
5. Inner join only returns the matching rows between both tables, Full join returns all rows from the tables including non-matching rows.
6. Left join only returns all the rows from the left table, and null is filled when no maching rows is found, but not the right table. Outer join gives rows in both tables, filling null with no maching rows 
7. Cross join gives combination of each row between two tables (cartesian product).
8. Where is used to specify the contition for filtering before grouping, while having is used to specify condition for filtering values.
9. Yes it's possilbe to use 'group by x,y' to get result for same value on both x and y
*/

use AdventureWorks2019;
go
--1
select count(ProductID) from Production.Product
--2
select count(ProductID) from Production.Product where Production.Product.ProductSubcategoryID is not NULL

--3
select ProductSubCategoryID, count(ProductSubCategoryID) as 'CountedProducts' from Production.Product group by ProductSubcategoryID
--4
select count(ProductID) from Production.Product where  Production.Product.ProductSubcategoryID is NULL

--5
Select ProductID, sum(Quantity) as 'sum Quantity', avg(Quantity) as 'avg Quantity', count(Quantity) as 'count Quantity' from Production.ProductInventory group by ProductID
--6
select ProductID, sum(Quantity) as 'TheSum' from Production.ProductInventory where LocationID = 40  group by ProductID having sum(Quantity)<100

--7
Select Shelf,ProductID ,sum(Quantity) as 'TheSum' from Production.ProductInventory where LocationID = 40  group by Shelf, ProductID having sum(Quantity)<100

--8
Select ProductID, avg(Quantity) as 'TheAvg' from Production.ProductInventory where Production.ProductInventory.LocationID =10 group by ProductID

--9
Select ProductID,Shelf ,avg(Quantity) as 'TheAvg' from Production.ProductInventory group by Shelf, ProductID
--10
Select ProductID,Shelf ,avg(Quantity) as 'TheAvg' from Production.ProductInventory where Shelf != 'N/A' group by Shelf, ProductID 
--11
Select Color,Class, count(*) as 'TheCount',avg(ListPrice) as'AvgPrice' from Production.Product where Color is not null and Class is not null group by Color,Class
--12
Select p.Name as 'Country' , n.Name as 'Province' from Person.CountryRegion p join Person.StateProvince n on p.CountryRegionCode = n.CountryRegionCode

Select p.Name as 'Country' , n.Name as 'Province' from Person.CountryRegion p join Person.StateProvince n on p.CountryRegionCode = n.CountryRegionCode where p.Name in ('Germany','Canada')


go
use Northwind;

select q.ProductID , p.Orderdate from dbo.Orders p join dbo.[Order Details] q on p.OrderID = q.OrderID where year(p.OrderDate) >= 1996

select top 5 ShipPostalCode,  count(*) as 'Count' from dbo.Orders p group by p.ShipPostalCode order by count(*) desc 

select top 5 ShipPostalCode,  count(*) as 'Count' from dbo.Orders p where year(p.OrderDate)>2001 group by p.ShipPostalCode order by count(*) desc

select City,count(*) as 'Num of Customers' from dbo.[Customers] group by City

select City,count(*) as 'Num of Customers' from dbo.[Customers]  group by City having count(*)>10

select p.ContactName, q.orderDate from dbo.Customers p join dbo.Orders q on p.CustomerID=q.CustomerID where CAST(q.OrderDate as DATE) > CAST('1998-1-1' as DATE)

select p.ContactName, q.orderDate from dbo.Customers p join dbo.Orders q on p.CustomerID=q.CustomerID order by q.OrderDate desc

select p.ContactName, sum(s.Quantity) as 'count of products bought' from dbo.Customers p join (dbo.Orders q join dbo.[Order Details] s on q.OrderID=s.OrderID) on p.CustomerID=q.CustomerID group by p.ContactName

select p.CustomerID, sum(q.Quantity) as 'count of products bought' from dbo.Orders p join dbo.[Order Details] q  on p.OrderID=q.OrderID group by p.CustomerID having sum(q.quantity)>100
 
select a.CompanyName as 'Supplier Company Name' ,b.CompanyName as 'Shipping Company Name' from dbo.Suppliers a cross join dbo.Shippers b

select CAST(a.OrderDate as DATE) as 'Date' , b.ProductName from dbo.Orders a join dbo.[Order Details] c on a.OrderID = c.OrderID join dbo.Products b on b.ProductID = c.ProductID order by a.OrderDate

select a.EmployeeID, b.EmployeeID from dbo.Employees a, dbo.Employees b where a.Title = b.Title and a.EmployeeID != b.EmployeeID

select * from dbo.Employees

select a.EmployeeID from dbo.Employees a, dbo.Employees b where a.EmployeeID = b.ReportsTo group by a.EmployeeID having count(*)>2

select * from (Select City as 'City Name',ContactName as 'Contact Name', 'Customer'as Type from dbo.Customers) a union (select City as 'City Name',ContactName as 'Contact Name', 'Supplier' as Tpye from dbo.Suppliers) 
--28
--select * into T3 from F1.T1 inner join F2.T2 
/*result:
	T3
	2	  
	3	 
*/
--29
--select * into T4 from F1.T1 left join F2.T2
/*result:
	T4
	1
	2
	3
*/