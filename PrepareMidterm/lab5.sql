-- 1. Create a new table named  ''usa_customers'' with copying only the structure of four columns:
-- customernumber, customername, city, country of the ''customers'' table. Do not copy any data from the ''customers'' table. Please verify by querying data from the table.
-- Write a statement(s) here
drop table usa_customers;

create table usa_customers
select customernumber, customername, city, country
from customers
where 1=2;

select * from usa_customers;

-- 2. Insert data by copying the existing data of all customers who live in the USA from the ''customers'' table into the “usa_customers” table. Please verify by querying data from the table. How many rows are inserted into the "usa_customers" table.
-- Write a statement(s) here and also capture the screen of querying data from the table.
insert into usa_customers
select customernumber, customername, city, country
from customers
where country = 'USA';

select * from usa_customers;

-- 3. Based on the ''usa_customers'' table, modify the city of the customername "Mini Wheels Co." 
-- to the same city of the customer number 344 of the "customers" table. Please verify your data modification.
-- Write a statement(s) here and also capture the screen of querying data from the table.
update usa_customers
set city = (select city
            from customers
            where customerNumber = 344)
where customername like 'Mini Wheels Co.';
 
select * from usa_customers;

-- 4. Based on the ''usa_customers'' table, modify the city of all customers who have a sales representative (employee) last named "Patterson" to "Bangmod". Please verify your data modification. 
-- Hint: you may use the customers and employees tables to find out “who have a sales representative (employee) last named "Patterson". 
-- Write a statement(s) here and also capture the screen of querying data from the table.
update usa_customers
set city = 'Bangmod'
where customernumber in (select customerNumber
                         from customers c join employees e on c.salesRepEmployeeNumber = e.employeeNumber
                         where e.lastName like 'Patterson');
                         
select * from usa_customers;

-- 5. Modify an existing view named "mini_customer_view" to display the customer number, customer name, city and country of all customers whose names start with the word “Mini” from the ''usa_customers'' table.  Name four columns of this view to "cno", ''cname'', "city" and ''country'', respectively. Please verify by querying data from this view. 
-- Write a statement here(s) and also capture the screen of querying data from the table/view.
create or replace view mini_customer_view (cno, cname, city, country)
as
select *
from usa_customers
where customername like 'Mini%';

select * from mini_customer_view;

-- 6. Create a view named "miniltd_customer_view" to display the customer number, customer name, city and country of all customers whose names end with the word “Ltd.” from the “mini_customer_view” view. Please ensure that the rows that are being changed through this view are conformable to the definition of the "miniltd_customer_view" view. Name four columns of this view to “custno", "custname”, “custcity” and "custcountry", respectively.  Please verify by querying data from this view.
-- Write a statement(s) here and also capture the screen of querying data from the table/view.
create or replace view miniltd_customer_view (custno, custname, custcity, custcountry)
as
select *
from mini_customer_view
where cname like '%Ltd.'
with local check option;

select * from miniltd_customer_view;

-- 7. Insert new data {customer number "9000", customer name ''SUNISA Ltd.'', city ''Texas'' and country ''USA''} through the “miniltd_customer_view” view. Please verify by querying data from both this view and the base table. Can the data be inserted through this view? If not, please explain.
-- Write a statement(s) here 
insert into miniltd_customer_view values (9000, 'SUNISA Ltd.', 'Texas', 'USA');

select * from usa_customers;
select * from miniltd_customer_view;

-- 8. Insert new data {customer number "9001", customer name ''Mini SUNISA'', city = ''Texas'' and country ''USA''} through the “miniltd_customer_view” view. Please verify by querying data from both this view and the base table. Can the data be inserted through this view? If not, please explain.
-- Write a statement(s) here 
insert into miniltd_customer_view values (9001, 'Mini SUNISA', 'Texas', 'USA');

-- 9. Modify an existing view named the "miniltd_customer_view" created in Question 6 to ensure that the rows that are being changed through this view are conformable to the definition of the "miniltd_customer_view" view and also the definition of the underlying views recursively.
-- Write a statement(s) here and also capture the screen of querying data from the table/view.
create or replace view miniltd_customer_view (custno, custname, custcity, custcountry)
as
select *
from mini_customer_view
where cname like '%Ltd.'
with cascaded check option;

-- 10. Try to insert the same data of Question 7-8 again.
-- What happened to the row of the customer name ''SUNISA Ltd.''? Please verify by querying data from both this view and the base table. Can the data be inserted through this view? If not, please explain.
-- Write a statement(s) here 
insert into miniltd_customer_view values (9000, 'SUNISA Ltd.', 'Texas', 'USA');

-- What happened to the row of the customer name ''Mini SUNISA'' ?  Please verify by querying data from both this view and the base table. Can the data be inserted through this view? If not, please explain.
-- Write a statement(s) here 
insert into miniltd_customer_view values (9001, 'Mini SUNISA', 'Texas', 'USA');

-- 11. Please insert one row through the “miniltd_customer_view” view. You should create the data by yourself that can be inserted through this view. Please verify by querying data from both the views and the base table.  
-- Write a statement(s) here and also capture the screen of querying data from the table/view.
insert into miniltd_customer_view values (9999, 'Mini SUNISA Ltd.', 'Texas', 'USA');

-- 12. Remove two existing views that were created in Lab04. You can select two views by yourself.
-- Write a statement(s) here
