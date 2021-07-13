use AdventureWorks2019 
go
select ProductID, Name,Color,ListPrice from Production.Product

select ProductID, Name, Color,ListPrice from Production.Product where ListPrice = 0

select ProductID, Name, Color, ListPrice from Production.Product where Color is NULL

select ProductID, Name, Color, ListPrice from Production.Product where Color is not NULL

select ProductID, Name, Color, ListPrice from Production.Product where Color is not NULL and ListPrice > 0

select Name, Color from Production.Product where Color is not NULL

select 'NAME: '+Name+' -- COLOR: '+Color as 'Name And Color' from Production.Product Where Color is not NULL

select ProductID,Name from Production.Product where ProductID between 400 and 500

Select ProductID,Name, Color from Production.Product where Color = 'Black' or Color = 'Blue'

Select * from Production.Product Where Name like 'S%'

select Name, ListPrice from Production.Product order by Name

Select Name, Listprice from Production.Product where Name like 'S%' or Name like 'A%' order by Name

Select Name from Production.Product where Name like 'SPO%' and Name not like 'SPOK%' order by Name

Select Distinct ProductSubCategoryID, Color from Production.Product where ProductSubCategoryID is not null and Color is not null

SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, ListPrice 
FROM Production.Product
WHERE (Color IN ('Red','Black') 
      
      and ProductSubCategoryID != 1)
	  OR ListPrice BETWEEN 1000 AND 2000 
ORDER BY ProductID
 
 select ProductSubCategoryID,Name,Color,ListPrice from Production.Product where ProductSubcategoryID <=14 and Color is not Null order by ProductSubcategoryID desc 