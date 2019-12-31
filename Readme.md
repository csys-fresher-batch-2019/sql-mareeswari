# Hot Star
 www.hotstar.com
 
## Features
 * view all the thriller movies

#### Feature1 : List all  movies

```sql
  create table movies(
  movie_id number,
  movie_name varchar2(100) not null,
  movie_lang varchar2(100) not null,
  movie_ratings number default 0,
  movie_released_date date not null,
  launching_date_to_hotstar date default sysdate,
  movie_type varchar2(100) not null,
  constraint  movie_id_pk primary key(movie_id),
  constraint movie_type_ck check(movie_type in('comedy','action','thriller','Drama','Gangster')),
  constraint movie_lang_ck check(movie_lang in('Tamil','English','Malayalam','Telugu')),
  constraint movie_ratings_ck check(movie_ratings in(5,4,3,2,1))
  );
  ```
                      
                      
   Query:
        select * from movies ;
                      
| movie_id | movie_name              | movie_lang | movie_ratings | movie_released_date | launching_date_to_hotstar | movie_type |
|----------|-------------------------|------------|---------------|---------------------|---------------------------|------------|
| 1        | vaanam                  | Tamil      | 5             | 20-08-2010          | 20-12-2010                | Drama      |
| 2        | Chekka Chivantha Vaanam | Tamil      | 5             | 20-08-2018          | 20-12-2018                | Gangster   |
                  
