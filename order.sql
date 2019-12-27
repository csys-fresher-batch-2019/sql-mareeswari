create table books(book_id number ,
                   book_title varchar2(100) not null,
                   book_price number not null,
                   constraint book_id_pk primary key (book_id),
                   constraint book_price_ck check(book_price>=0)
                 );
insert into books(book_id,book_title,book_price)values(101,'c',100);
insert into books(book_id,book_title,book_price)values(102,'Java',200);
drop table books;
select * from books;
create table book_stock (stock_no number,book_id number ,quantity number,
                         constraint stock_no_pk primary key(stock_no),
                         constraint book_id_fk foreign key(book_id)references books(book_id)
                         );
insert into book_stock(stock_no,book_id,quantity)values(1,101,10);
insert into book_stock(stock_no,book_id,quantity)values(2,102,5);

create table orders(order_id number,
                    username varchar2(20) not null,
                    total_amount number ,
                    ordered_date timestamp not null,
                    delivered_date varchar2(20),
                    status varchar2(20) default 'ordered',
                    constraint order_id_pk primary key(order_id),
                    constraint total_amount_ck check(total_amount>=0)
                    );
insert into orders (order_id,username,total_amount,ordered_date)values(1,'Marees',1400,systimestamp); 
insert into orders (order_id,username,total_amount,ordered_date)values(2,'Maha',1400,systimestamp); 
drop table order_items;
create table order_items (item_no number,order_id number ,book_id number,
                          quantity1 number,status1 varchar2(20) default'ordered',
                         constraint item_no_pk primary key(item_no),
                         constraint book_id_fk1 foreign key(book_id)references books(book_id),
                         constraint order_id_fk2 foreign key(order_id)references orders(order_id)
                         );
insert into order_items(item_no,order_id,book_id,quantity1)values(1,1,101,3);
insert into order_items(item_no,order_id,book_id,quantity1)values(2,2,101,5);
insert into order_items(item_no,order_id,book_id,quantity1)values(3,2,102,3);

select book_title,((select quantity from book_stock where book_id=b.book_id)-
(select sum(quantity1) from order_items where book_id=b.book_id))as available_stock from books b;

update book_stock set quantity=15 where book_id=102;

select * from book_stock;
select * from order_items;
