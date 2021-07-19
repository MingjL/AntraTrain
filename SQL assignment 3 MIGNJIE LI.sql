/*Writing Questions:
1. I would use join because it performs faster than a subquery
2. CTE is a temporary result set that user can reference with statements. Usage: With _name_ as (cte_query)
3. Table variable is a kind of loacl variable to store data temporarily. The scope of table variable is the batch it's defined in.
4. Turncate always remove all rows from a table but remains table structure. Delete can conditionally remove table contents. Turncate will have better performance because delete will excute multiple times.
5. Identy column is a column in a database table that is made up of values generated by the database. Turncate resets the sequence for identity column types but delete does not.
6. Delete from deletes row one by one, turncate removes the whole table at once.
*/

use Northwind
go
--1
select a.City from dbo.Customers a inner join dbo.Employees b on a.City = b.City group by a.City
--2a
select c.City from dbo.Customers c where c.City not in (select a.City from dbo.Customers a inner join dbo.Employees b on a.City = b.City group by a.City) group by c.city
--3b
select a.City from dbo.Customers a left join dbo.Employees b on a.City = b.City where b.City is NULL group by a.City
--4
select c.City, sum(d.Quantity) from dbo.Customers c join (select a.Quantity, b.CustomerID from dbo.[Order Details] a join dbo.Orders b on a.OrderID = b.OrderID) d on c.CustomerID = d.CustomerID group by c.City
--5a
select City from dbo.Customers union select City from dbo.Customers 