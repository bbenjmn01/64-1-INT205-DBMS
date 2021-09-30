-- 3.1 List the customer name of all customers who live in the same country of customer named “Mini Classics”. Sort the results in ascending order by customer name.
select customerName
from customers
where country = (select country 
                 from customers 
                 where customerName = "Mini Classics")
order by customerName;

-- 3.2 List the customer name of all customers who live in the same country of customer named “Mini Classics” and their customer names start with “Mini”.
select customerName
from customers
where country = (select country 
                 from customers 
                 where customerName = "Mini Classics") and customerName like "Mini%";

-- 3.3 List the product name and quantity in stock of the product that has the maximum quantities in stock.
select productName, quantityInStock
from products
where quantityInStock = (select max(quantityInStock) 
                         from products);

-- 3.4 List the order number and the total amount of sales of all orders that their total amount of sales is more than the total amount of sales order number 10103. Name the total amount of sales column to “total_amount”.
select orderNumber, sum(quantityOrdered * priceEach) as total_amount
from orderdetails
group by orderNumber
having sum(quantityOrdered * priceEach) > (select sum(quantityOrdered * priceEach) 
                                           from orderdetails 
                                           where orderNumber = 10103);

-- 3.5 List the customer name and the employee last name of all customers that their sales rep employee worked in the office located in London city. 
select customerName, lastName
from customers c
join employees e on c.salesRepEmployeeNumber = e.employeeNumber
where exists (select * 
              from offices 
              where officeCode = e.officeCode and city = "London");

-- 3.6 List all cities that are both an office location and a customer location. Remove the duplicate answer.       
select distinct city
from offices o
where exists (select city 
              from customers 
              where city = o.city);
                
-- 3.7 List all cities where customers who do not live in the same city of their sales rep employee’s office city.   Remove the duplicate answer. 
select distinct c.city, o.city
from customers c join employees e on e.employeeNumber = c.salesRepEmployeeNumber join offices o on e.officeCode = o.officeCode 
where exists (select city 
                  from employees e 
                  join offices o on e.officeCode = o.officeCode 
                  where employeeNumber = c.salesRepEmployeeNumber);
                  
-- 3.8 List the customer name of all customers who have a credit limit greater than all average credit limits of customers in each city.
select customerName
from customers
where creditLimit >all (select avg(creditLimit) 
                        from customers 
                        group by city);

-- 3.9 List the customer name of all customers who have a credit limit greater than their average credit limits of customers in their cities.             
select customerName
from customers c
where creditLimit > (select avg(creditLimit) 
                     from customers 
                     where city = c.city);

-- 3.10 List the products that were never ordered by any customers.
select *
from products p
where not exists (select orderNumber 
                  from orderdetails
                  where productCode = p.productCode);
