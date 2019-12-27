drop table books;
create table books(book_id number,
             book_name varchar2(100) not null,
             author_name varchar2(100) not null,
             price number not null,
             publisher varchar2(100) not null,
             version number,
             book_category varchar2(50) not null,
             active number default 1,
             constraint book_id_pk primary key (book_id),
             constraint book_uq unique(book_name,author_name,version),
             constraint price_ck check (price>=0)
             );
insert into books(book_id,book_name,author_name,price,publisher,version,book_category)values(1,'c','Ritchie',400,'thomson',1,'Programming');
insert into books(book_id,book_name,author_name,price,publisher,version,book_category)values(2,'c','Ritchie',400,'thomson',2,'Programming');
insert into books(book_id,book_name,author_name,price,publisher,version,book_category)values(3,'c','Ritchie',400,'thomson',3,'Programming');
insert into books(book_id,book_name,author_name,price,publisher,version,book_category)values(4,'c++','Balagurusamy',800,'thomson',1,'Programming');

select * from books;

drop table orders;
create table orders(order_id number,
             username varchar2(100) not null,
             book_id number not null,
             ordered_date timestamp not null,
             delivered_date timestamp ,
             total_amount number not null,
             quantity number default 1 not null,
             status varchar2(50) default 'ordered',
             comments varchar2(500) default 'nothing',
             constraint order_id_pk primary key(order_id),
             constraint book_id_fk foreign key(book_id) references books(book_id),
             constraint total_amount_ck check (total_amount>=0),
             constraint quantity_ck check (quantity>=1)
             );
insert into orders(order_id,username,book_id,ordered_date,total_amount,quantity) values(1,'Mareeswari',1,systimestamp,1600,4);
insert into orders(order_id,username,book_id,ordered_date,total_amount,quantity) values(2,'Bhava',2,systimestamp,1600,4);
insert into orders(order_id,username,book_id,ordered_date,total_amount,quantity) values(3,'Maha',3,systimestamp,1600,4);
insert into orders(order_id,username,book_id,ordered_date,total_amount,quantity) values(4,'Pavithra',1,systimestamp,1600,4);

select * from orders;

update orders set status='delivered', delivered_date=systimestamp where order_id=3;
select sum(quantity) from orders where status='delivered';
