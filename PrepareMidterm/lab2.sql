-- 2.1 List the product name and quantity in stock of all products that classified in the “Classic Cars” product line (กลุ่มของสินค้า/ผลิตภัณฑ์) and their buy prices are more than 80.
select *
from products p join productlines pl on p.productLine = pl.productLine
where lower(pl.productLine) = 'Classic Cars' and buyPrice > 80;

-- 2.2 List the customer name, city and country of all customers who live in the country named: Japan, Germany or Canada. Sort the results in descending order by country and ascending order by customer name.
select customerName, city, country
from customers
where country in ('Japan', 'Germany', 'Canada')
order by 3 desc, 1 asc;

-- 2.3 List the order number and the total amount of sales for all orders. Name the total amount of sales column to “total_amount”.
select orderNumber, sum(quantityOrdered * priceEach) as total_amount
from orderdetails
group by 1;

-- 2.4 List the order number and the total amount of sales of all orders that their total amount of sales is more than 55000. Name the total amount of sales column to “total_amount”.
select orderNumber, sum(quantityOrdered * priceEach) as total_amount
from orderdetails
group by 1
having sum(quantityOrdered * priceEach) > 55000;

-- 2.5 List the customer name and the number of sales orders of all customers whose name start with the letter ‘D’. Name the number of sales orders column to “num_orders”.
select customerName, count(orderNumber) as num_orders
from customers c join orders o on c.customerNumber = o.customerNumber
where customerName like 'D%'
group by 1;

-- 2.6 List the customer name, the sales rep employee last name, and the check number of all customers who made the payment in year 2005. Name the sales rep employee last name column to “salesempname”.
select customerName, e.lastName as salesempname, p.checkNumber
from customers c join employees e on c.salesRepEmployeeNumber = e.employeeNumber
join payments p on c.customerNumber = p.customerNumber
where extract(year from p.paymentDate) = 2005;

-- 2.7 List the manager last name (the employee who were reported to) and the number of employees of all managers. Name the manager last name and the number of employees columns to “mgrname” and “num_emp”, respectively.
select e2.lastName as mgrname, count(e1.employeeNumber) as num_emp
from employees e1 join employees e2 on e1.reportsTo = e2.employeeNumber
group by 1;