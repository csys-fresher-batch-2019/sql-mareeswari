# Hot Star
 www.hotstar.com
 
## Features
 * view all the thriller movies

#### Feature1 : List all thriller movies

  create table movies(movie_id number,
                      movie_name varchar2(100) not null,
                      released_date date default sysdate,
                      movie_type varchar2(100) not null,
                      constraint  movie_id_pk primary key(movie_id)
                      );
                      
                      
   Query:
        select * from movies where movie_type='thriller';
                      
                      
