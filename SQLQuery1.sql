create database sample;
use sample;

create table products(
   pid char(5) primary key,
   pname varchar(10)
   );

insert into products(pid,pname)
values('p001','nike'),
('p002','addidas'),
('p003','puma');

select * from products;

create table product_price(
   pid char(5),
   price decimal(5,2) not null
   );

insert into product_price(pid,price)
values('p001',200),
('p002',500),
('p003',350),
('p004',800);

select * from product_price;

select a.pid,a.pname,b.price from products as a inner join product_price as b on a.pid=b.pid; 

insert into products(pid,pname)
values('p004','us polo'),
('p005','paragon'),
('p006','bata');

select a.pid,a.pname,b.price from products as a left join product_price as b on a.pid=b.pid;

select a.pid,a.pname,b.price from products as a right join product_price as b on a.pid=b.pid;


create table productq(
   pid char(5),
   pq  varchar(19)not null
   );
insert into productq(pid,pq)
values('p004','us polo111'),
('p005','paragon111'),
('p006','bata111');

select * from productq;

select a.pid,a.pname,b.price,c.pq from products as a left join product_price as b on a.pid=b.pid
left join productq as c on a.pid=c.pid;
