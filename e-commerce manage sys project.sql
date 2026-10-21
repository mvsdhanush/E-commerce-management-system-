create database ecommerce;
use ecommerce;
create table customers(customers_id int,customers_name varchar(100) not null,email varchar(100),
phone_number varchar(100),address varchar(100),constraint pk primary key(customers_id)
,constraint uk unique key(email));

create table categories(category_id int ,category_name varchar(20) not null
,constraint pk primary key(category_id ));

create table product(product_id int,product_name varchar(100)not null,category_id int
,price Decimal(10,2),stock_quantity int,constraint pk primary key (product_id)
,constraint fk_categories foreign key (category_id) references categories(category_id));

create table orders(order_id int,customers_id int,order_date Date,total_amount Decimal(10,2)
,order_status varchar(30),constraint pf primary key(order_id)
,constraint fk foreign key (customers_id) references customers(customers_id));

create table order_details(order_detailsid int,order_id int,product_id int,quantity int,price Decimal(10,2),
constraint pk primary key(order_detailsid),constraint fk_order foreign key(order_id) references orders (order_id),
constraint fk_product foreign key(product_id) references product (product_id));

create table payment(payment_id int,order_id int,payment_method varchar(100),payment_status varchar(100)
,payment_date Date,constraint pk primary key (payment_id)
,constraint fk_order1 foreign key (order_id) references orders(order_id));



insert into customers values(01,'siva','mvsdhan***@gmail.com','995274****','tirunelveli'),
							(02,'dheepsy','dheep****@gmail.com','93748*****','nagarcoli'),
                            (03,'joe','joefli****@gmail.com','63682*****','tirunelveli'),
                            (04,'brad pitt','brad*****@gmail.com','99388*****','america'),
                            (05,'madison beer','madis*****@gmail.com','99673*****','america');
						
                        
insert into categories values(01,'Electronics'),
							 (02,'Clothing'),
                             (03,'Books'),
                             (04,'Home Appliances'),
                             (05,'Accessories');
							 
                             
insert into product values(01,'laptop',01,98000.00,10),
						  (02,'smartphone',01,82000.00,20),
                          (03,'T-shirt',02,2000.10,15),
                          (04,'python books',03,500.20,20),
                          (05,'washing machine',04,20000.00,10),
                          (06,'watch',05,10000.00,10);

                             
insert into orders values(1,1,'2026-07-15',98000.00,'Delivered'),
                         (2,2,'2026-05-19',82000.00,'Delivered'),
                         (3,3,'2026-08-18',2000.10,'pending'),
                         (4,4,'2026-01-29',10000.00,'Shipped'),
                         (5,5,'2026-03-25',500.20,'Delivered');
                         
	
insert into order_details values(01,01,01,1,98000.00),
                                (02,02,1,02,82000.00),
                                (03,03,1,03,2000.10),
                                (04,04,1,06,10000.00),
                                (05,05,1,04,500.00);
                                
                                
insert into payment values(01,01,'Gpay','paid','2026-07-10'),
                          (02,02,'Paytm','paid','2026-05-15'),
                          (03,03,'PhonePay','pend','2026-08-19'),
                          (04,04,'NetBanking','paid','2026-08-21'),
                          (05,05,'SuperMoney','paid','2026-03-20');

select * from customers;
select * from product where price > 10000;
select * from product order by price Desc Limit 1;

select p.product_name,c.category_name,p.price from product p join categories c on p.category_id = c.category_id;

select c.customers_name,o.order_id,o.order_date,o.total_amount,o.order_status from customers c join orders o on c.customers_id = o.customers_id;

select sum(total_amount) as total_sales from orders;

select avg(total_amount) as average_order_value from orders;

select c.customers_name,sum(o.total_amount) AS total_spent from customers c join orders o on 
c.customers_id = o.customers_id group by c.customers_id, c.customers_name having sum(o.total_amount) > 30000;

select * from products where stock_quantity = 0;

select p.product_name,sum(od.quantity) as total_quantity from product p join order_details od 
on p.product_id = od.product_id group by p.product_id, p.product_name order by total_quantity DESC LIMIT 1;

