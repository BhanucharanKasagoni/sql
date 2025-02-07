use bikestores;
select * from brands;
select * from categories;
select * from customers;
select * from order_items;
select * from orders;
select * from products;
select * from staffs;
select * from stocks;
select * from stores;
select * from students;

select * from brands;
select * from categories;
select * from products;

select a.product_id,a.product_name,b.category_name,c.brand_name from products as a 
left join categories as b on a.product_id=b.category_id
left join brands as c on a.product_id=c.brand_id;

select c.product_id,c.product_name,a.category_name,b.brand_name from categories as a 
right join brands as b on a.category_id=b.brand_id
right join products as c on a.category_id=c.product_id;

select * from customers;
select * from orders;
select * from order_items;

select sum(c.quantity*c.list_price)as price,a.customer_id,a.first_name,a.last_name,b.order_id,c.order_id from customers as a 
inner join orders as b on a.customer_id=b.customer_id
inner join order_items as c on b.order_id=c.order_id
group by a.customer_id,a.first_name,a.last_name,b.order_id,c.order_id;


select top 3 * from(
       select a.brand_id,a.brand_name, sum(c.quantity*c.last_price)as ordervalue from brands as a
	   left join products as b on a.brand_id=b.brand_id
	   inner join order_items as c on b.product_id=c.product_id
	   group by a.brand_id,a.brand_name,