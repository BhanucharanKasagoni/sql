--JOINS

--1.Retrieve all orders along with the product details.

use bikestores01

select * from production.products
select * from sales.order_items
select * from sales.orders

select oi.*,p.* from sales.orders as o
join sales.order_items as oi on oi.order_id=o.order_id
join production.products as p on oi.product_id=p.product_id

--2.List all customers along with the orders they have placed.
select * from sales.orders
select * from sales.customers

select c.customer_id,o.order_id,c.first_name,c.last_name from sales.customers as c
join sales.orders as o on c.customer_id=o.customer_id

--3.Find all products that have never been ordered.

select * from production.products
select * from sales.order_items

SELECT p.* FROM production.products p
LEFT JOIN sales.order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

--4.Retrieve the details of all orders along with the store and staff details.
select * from sales.orders
select * from sales.stores
select * from sales.staffs

select o.order_id,s.*,ss.* from sales.orders as o
join sales.stores as s on o.store_id=s.store_id
join sales.staffs as ss on ss.store_id=s.store_id
--5.List all products along with their brand and category names.
select * from production.products
select * from production.brands
select * from production.categories

select p.*,b.brand_id,c.category_name from production.brands as b
join production.products as p on b.brand_id=p.brand_id
join production.categories as c on p.category_id=c.category_id
--6.Find all customers who have placed more than 5 orders.
select * from sales.orders
select * from sales.customers

SELECT c.*, COUNT(o.order_id) AS order_count
FROM sales.customers  c
JOIN sales.orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.phone, c.street, c.city, c.state, c.zip_code
HAVING COUNT(o.order_id) > 2;

--7.Retrieve the details of all orders placed by customers from California (CA).
select * from sales.orders
select * from sales.customers

select * from sales.orders as o 
join sales.customers as c on o.customer_id=c.customer_id where c.state='CA'

--8.List all products along with the total quantity sold for each product.
select * from production.products
select * from sales.order_items

select p.product_name,sum(((oi.list_price*oi.quantity)*(1-oi.discount)))as price
from production.products as p
join sales.order_items as oi on p.product_id=oi.product_id group by p.product_name
--9.Find all orders that include products from the 'Electric Bikes' category.
select * from production.products
select * from sales.order_items
select * from production.categories

select oi.*,p.product_name,c.category_name from sales.order_items as oi 
join production.products as p on oi.product_id=p.product_id
join production.categories as c on c.category_id=p.category_id where c.category_name='Electric Bikes'

--10.Retrieve the details of all orders along with the total discount applied.
select * from sales.orders
select * from sales.order_items

select o.order_id,sum(oi.discount) from sales.orders as o 
join sales.order_items as oi on o.order_id=oi.order_id
group by o.order_id

SELECT o.*, SUM(oi.discount * oi.quantity * oi.list_price / 100) AS total_discount
FROM sales.orders o
JOIN sales.order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.customer_id, o.order_status, o.order_date, o.required_date,
o.shipped_date, o.store_id, o.staff_id;
