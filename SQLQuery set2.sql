use bikestores01

--1.Retrieve all orders along with the customer and store details.
select * from sales.orders;
select * from sales.customers;
select * from sales.stores;

select o.*,c.*,s.* from sales.customers as c
left join sales.orders as o on c.customer_id=o.customer_id
join sales.stores as s on s.store_id=o.store_id


--2.List all products along with their brand, category, and the total quantity sold.

select * from production.categories
select * from production.products
select * from production.brands
select * from sales.order_items

select p.*,c.category_name,b.brand_name,(oi.list_price*oi.quantity*oi.discount/100)as total_quantity
from production.categories as c
right join production.products as p on c.category_id=p.category_id
join production.brands as b on p.brand_id=b.brand_id
join sales.order_items as oi on oi.product_id=p.product_id


--3.Find all customers who have placed orders for products from more than one category.

select * from sales.customers
select * from production.categories
select * from production.products
select * from sales.orders
select * from sales.order_items

---4.Retrieve the details of all orders along with the product, brand, and category details.

select * from production.categories
select * from production.products
select * from sales.orders
select * from sales.order_items
select * from production.brands

select s.*,p.product_name,c.category_name,b.brand_name from sales.orders as s 
join sales.order_items as oi on s.order_id=oi.order_id
join production.products as p on oi.product_id=p.product_id
join production.categories as c on p.category_id=c.category_id
join production.brands as b on b.brand_id=p.brand_id


--5.List all customers along with the total value of orders they have placed.
select * from sales.customers
select * from sales.orders
select * from sales.order_items

select c.customer_id,c.first_name,sum((oi.quantity*oi.list_price)*(1-oi.discount))as total_value
from sales.customers as c
left join sales.orders as o on c.customer_id=o.customer_id
join sales.order_items as oi on o.order_id=oi.order_id group by c.customer_id,c.first_name


--6.Find all stores that have sold products from the 'Electric Bikes' category.

select * from sales.stores
select * from production.categories
select * from production.products
select * from sales.order_items
select * from sales.orders

select s.store_name,p.product_name from sales.stores as s
left join sales.orders as o on s.store_id=s.store_id
join sales.order_items as oi on oi.order_id=o.order_id
join production.products as p on oi.product_id=p.product_id
join production.categories as c on c.category_id=p.category_id 
where c.category_name='Electric Bikes';




--7.Retrieve the details of all orders along with the customer and product details, sorted by order date.

select * from production.products
select * from sales.order_items
select * from sales.orders
select * from sales.customers

select o.*,c.first_name,p.product_name from sales.orders as o
left join sales.order_items as oi on o.order_id=oi.order_id
join production.products as p on p.product_id=oi.product_id
join sales.customers as c on c.customer_id=o.customer_id order by o.order_date



--8.List all products that have been ordered by customers from California (CA).

select * from production.products
select * from sales.orders
select * from sales.order_items
select * from sales.customers

select p.product_name,c.state from production.products as p 
left join sales.order_items as oi on p.product_id=oi.product_id
join sales.orders as o on o.order_id=oi.order_id
join sales.customers as c on c.customer_id=o.customer_id where c.state='CA'


--9.Find all orders that include products from brands that have more than 10 products.
select * from sales.orders
select * from sales.order_items
select * from production.products
select * from production.brands

select o.order_id,p.product_name,a.brand_id from sales.orders as o
left join sales.order_items as oi on o.order_id=oi.order_id
join production.products as p on p.product_id=oi.product_id
join (select brand_id from production.products group by brand_id having count(product_id)>10) 
as a on p.brand_id=a.brand_id



select count(p.product_name) as pname,b.brand_id from production.products as p 
join production.brands as b on b.brand_id=p.brand_id
group by b.brand_id




--10.Retrieve the details of all orders along with the total quantity and total price for each order.
select * from sales.orders
select * from sales.order_items

select o.order_id,sum(oi.quantity) as totalquantity,sum((oi.list_price*oi.quantity)*(1-oi.discount))as totalvalue
from sales.orders as o
left join sales.order_items as oi on o.order_id=oi.order_id
group by o.order_id

