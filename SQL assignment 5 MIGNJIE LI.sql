/* Writing questions:
1. SQL objects are schemas, journals, catalogs, tables, aliases, views, indexes, constraints, triggers, 
masks, permissions, sequences, stored procedures, user-defined functions, user-defined types, global variables, and SQL packages
2. index
3. index
4.index
5. index
6. index
7. index
8. normalizations is a process to organize columns and tables to ensure that dependencies are properly enforced by database constrains. Procesures :
    1. ensure single ecll hold only one column
	2. should not contain partial dependency
	3. should be no transitive dependency
9. A technique in which we add redundant data to one or more tables.we can use that to avoid costly joins.
10.By achieving completness, accuracy, and consistency
11. Not Null, unique, primary key, foreign key, check, default, create index
12. primary key should not contain null but unique key can have one null
13. foreign key is a column use to referencing another table
14. Yes
15. foreign key must refer to primary key or unique key. so it's unique but may have null
16. index
17. A transaction is a logical unit of work that contains one or more SQL statements. There are dirty reads, nonrepeatable reads, and phantom read to indecate transaction level
*/

--1
select a.iname, sum(b.order_id) from customer a join order b on a.cust_id = b.cust_id where year(order_date) = 2002 group by a.iname

--2
select firstname + lastname as name from person where lastname like 'A%'
--3
select a.name, count(b.Person_id) from person a join person b on a.manager_id = b.person_id where a.manager_id is null group by a.manager_id
--4
update, delete, insert, DDL statements, system events, user events
--5
