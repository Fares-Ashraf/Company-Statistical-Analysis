create table client (

client_id int not null,
client_name varchar(20) not null ,
st_name  varchar(10),
st_number int,
city varchar(10),
#creditCard varchar(20),
client_email varchar(30) not null,
account_password varchar(16) not null,
client_class varchar(10)

constraint clnt_pk primary key (client_id),
constraint unique_email unique (client_email),
constraint unique_credit unique (#creditCard)
);

create table client_telephone (
customer_id int not null,
client_telephone varchar(11) not null

constraint tele_pk primary key (customer_id,client_telephone),
constraint tele_fkey foreign key (customer_id) 
references client (client_id)
);

create table orders (
order_number int not null,
order_details varchar(30),
order_date date,
ship_date date not null,
total_price int,
order_stats varchar(20),
client_num int not null,
constraint order_pk primary key (order_number),
constraint order_fk foreign key (client_num)
references client (client_id)
);

/* client records*/
insert into client
values (001,'shady ashraf','makramEbid','10','cairo','0096548134','shady123@yahoo.com','6556165','S');

insert into client
values (002,'fares ashraf','madinaty','66','cairo','0097426389','fareselsalamony@hotmail.com','15612658','A');

insert into client
values (003,'amira asaad','smoha','22','alexandria','0093276451','amrmr25@outlook.com','8155816dfs','C');

insert into client
values (004,'nour hatem','gamaa st','7','mansoura','0098430765','lighting@msn.com','nourgm157','B');

insert into client
values (005,'wesam wesam','korniesh','14','damietta','0091547639','weeeeso@yahoo.com','wesaaam854','A');

/*client_telephone records*/
insert into client_telephone
values (001,'01119151495');

insert into client_telephone
values (001,'01204389721');

insert into client_telephone
values (002,'01013637521');

insert into client_telephone
values (002,'01009264304');

insert into client_telephone
values (003,'01026587324');

insert into client_telephone
values (004,'01206597354');

insert into client_telephone
values (005,'01598610434');

/* orders records*/
insert into orders
values (1,'cloths','12/8/2018','12/10/2018','1200','packed and queued','001');

insert into orders
values (2,'gym equipment','7/25/2018','7/28/2018','700','shipped','002');

insert into orders
values (3,'makeup','8/12/2018','8/17/2018','1500','shipped','003');

insert into orders
values (4,'air conditioner','11/25/2018','12/1/2018','600','packed and queued','004');

insert into orders
values (5,'carpets','10/10/2018','10/13/2018','1350','shipped','005');

insert into orders
values (6,'carpets','11/29/2018','12/1/2018','500','packed and queued','002');

insert into orders
values (7,'carpets','10/10/2018','10/13/2018','3000','shipped','002');

/* query shows the orders done in November
   ---------------------------------------- */
select order_number , ship_date, order_stats
from orders
where order_date between '11/1/2018' and '11/30/2018';

/* query shows the telephone numbers of the 'vip' clients
   ------------------------------------------------------- */
select client_id,client_name,client_class,client_telephone
from client_telephone , client
where client_class in ('A','S')
and customer_id = client_id
order by client_name;

/* query shows the client that did the highest number of order 
   ------------------------------------------------------------ */
select top (1) client_id , client_name, count(client_num) as 'number of orders done by client'
from orders , client
where client_id=client_num
group by client_id, client_name,client_num
order by 'number of orders done by client' desc;

/*query shows the telephone numbers of the clients with shipped orders
  --------------------------------------------------------------------- */
select distinct client_name, client_telephone as 'contacting number'
from client_telephone, client
where customer_id=client_id
and customer_id in (select client_num 
						from client , orders
						where client_num = client_id
						and order_stats = 'shipped');