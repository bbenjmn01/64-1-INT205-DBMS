use classicmodels;
-- 2.1 List the product name and quantity in stock of all products that classified in the “Classic Cars” product line (กลุ่มของสินค้า/ผลิตภัณฑ์)  and their buy prices are more than 80.
select productName, quantityInStock
from products p join productlines pl on p.productLine = pl.productLine
where  pl.productLine = "Classic Cars" and p.buyPrice > 80;

-- 2.2 List the customer name, city and country of all customers who live in the country named: Japan, Germany or Canada. Sort the results in descending order by country and ascending order by customer name.
select customerName, city, country
from customers
where country in ('Japan', 'Germany', 'Canada')
order by country desc, customerName asc;

-- 2.3 List the order number and the total amount of sales for all orders. Name the total amount of sales column to “total_amount”.
select orderNumber, sum(quantityOrdered * priceEach) as total_amount
from orderdetails
group by orderNumber;

-- 2.4 List the order number and the total amount of sales of all orders that their total amount of sales is more than 55000. Name the total amount of sales column to “total_amount”.
select orderNumber, sum(quantityOrdered * priceEach) as total_amount
from orderdetails
group by orderNumber
having sum(quantityOrdered * priceEach) > 55000;

-- 2.5 List the customer name and the number of sales orders of all customers whose name start with the letter ‘D’. Name the number of sales orders column to “num_orders”.
select customerName, o.orderNumber as "num_oders"
from customers c join orders o ON c.customerNumber = o.customerNumber
where c.customerName like 'D%';

-- 2.6 List the customer name, the sales rep employee last name, and the check number of all customers who made the payment in year 2005. Name the sales rep employee last name column to “salesempname”.
select customerName, e.lastName as salesempnsme, p.checkNumber 
from customers c join employees e on c.salesRepEmployeeNumber = e.employeeNumber
join payments p on c.customerNumber = p.customerNumber
where extract(year from paymentDate) = 2005;

-- 2.7 List the manager last name (the employee who were reported to) and the number of employees of all managers. Name the manager last name and the number of employees columns to “mgrname” and “num_emp”, respectively.
select e2.lastname as mgrname, count(e1.reportsTo) as num_emp
from employees e1 join employees e2 on e1.reportsTo = e2.employeeNumber
group by e1.reportsTo;

-- 2.8 Create your own question and the answered SQL statement should have SELECT, FROM, WHERE, GROUP BY and HAVING clauses.
-- หาประเทศที่มีจำนวนลูกค้ามากกว่า 7 คนขึ้นไป  โดยเรียงลำดับจำนวนลูกค้าจากหน้อยไปมาก
select country as "Office City", count(customerNumber) as "The number of customers"
from customers
group by country
having count(customerNumber) >= 7
order by 2 asc;

-- 2.9 Create your own question and the answered SQL statement should have SELECT, FROM 3 tables, WHERE and ORDER BY clauses.
-- หา
select pl.productLine, sum(od.quantityOrdered * od.priceEach) as "Total amount"
from products p join productlines pl on p.productLine = pl.productLine
join orderdetails od on p.productcode = od.productcode
join orders o on o.ordernumber = od.ordernumber
where extract(month from o.orderdate) = 1 and extract(year from o.orderdate) = 2004
group by pl.productline
order by 2 desc;
