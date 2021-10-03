-- 1. Create a view named "mini_customer_view" to display the customer name of all customers whose names start with the word “Mini”. Please verify by querying data from this view.
-- Write a statement here, the screen of querying data from this view is optional
create or replace view mini_customer_view
as
select customerName
from customers
where customerName like 'Mini%';

select * from mini_customer_view;

-- 2. Create a view named "prod_stock_view" to display the product name and quantity in stock of 
-- the product that has the minimum quantities in stock. Please verify by querying data from this view. 
create or replace view prod_stock_view
as
select productName, quantityInStock
from products
where quantityInStock = (select min(quantityInStock)
                         from products);
                         
select * from prod_stock_view;

-- 3. Create a view named "totalamount_orders_view" to display the order number, order date and the total amount of sales of all orders and sort the results in descending order by the total amount of sales. Name three columns of the view to orderno, orderdate and total_amount, respectively. Please verify by querying data from this view.       			
create or replace view totalamount_orders_view (orderno, orderdate, total_amount)
as
select o.orderNumber, o.orderDate, sum(od.quantityOrdered * od.priceEach)
from orders o join orderdetails od on o.orderNumber = od.orderNumber
group by 1, 2
order by 3;

select * from totalamount_orders_view;

-- 4. Create a view named "customer_samecity_view" to display the customer name and city of all customers who live in the same city of their sales rep employee’s office city. Name two view columns to cust_name and cust_city, respectively. Please verify by querying data from this view.
create or replace view customer_samecity_view (cust_name, cust_city)
as
select customerName, city
from customers c join employees e on c.salesRepEmployeeNumber = e.employeeNumber
where exists (select *
              from offices
              where officeCode = e.officeCode and city = c.city);
              
select * from customer_samecity_view;

-- 5. Create a view named "maxcredit_city_view" to display the city and the maximum credit limit of all customers in each city. Please verify by querying data from this view.             
create or replace view maxcredit_city_view (city, maxCreditLimit)
as
select city, max(creditLimit)
from customers
group by city;

select * from maxcredit_city_view;

-- 6. Create a view named "maxcredit_london_view" to display the city and the maximum credit limit of all customers who live in London city. You should create this view from the "maxcredit_city_view" view in Question 5. Please verify by querying data from this view.       
create or replace view maxcredit_london_view
as
select *
from maxcredit_city_view
where city = 'London';

select * from maxcredit_london_view;

-- 7. Create a table named "offices_copy" with copying the structure and data from the "offices" table using the following commands:
drop table offices_copy;
create table offices_copy
as select * from offices;   

select * from offices_copy;

-- Create a view named "usa_office_view" to display office code, city and state of the country "USA" 
-- from the "offices_copy" table. Please verify by querying data from this view.
create or replace view usa_office_view
as 
select officeCode, city, state
from offices_copy
where country = 'USA';

select * from usa_office_view;

-- 8. Try to insert a new row through the "usa_office_view"  view created in Question 7. What happens about the data insertion into the "offices_copy" table? Please explain.
-- Hint: You can create data for a new row by yourself.
insert into usa_office_view values ('8','Columbus','OH');

select * from usa_office_view;

-- 9.  To resolve the problem found in Question 8, Please modify the "usa_office_view" view  to ensure that you can insert a new row through this view (an updatable view). Please show the data insertion of the "offices_copy" table.
-- Hint: You can create data for a new row by yourself.
create or replace view usa_office_view
as 
select officeCode, city, phone, addressLine1, country, postalCode, territory
from offices_copy;

insert into usa_office_view values('8', 'Columbus', '+1 999 999 9999', '999 somewhere street', 'USA', '43291', 'NA');

select * from usa_office_view;

-- 10. Please delete both the structure and data of the "offices_copy" table. What happens to an existing view that references the "offices_copy" table? Please explain.
drop table offices_copy;