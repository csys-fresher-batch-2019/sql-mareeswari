# Hot Star
 www.hotstar.com
 
## Features
 * Register with the app to get in
 * User can view all movies based on user preferred language
 * User can view all movies
 * User can view all tv shows
 * User can view all episodes of all tv_shows
 * User can view all episodes counts of particular show
 * User can view today episodes for particular show
 * User can view all episodes for all shows
 * User can view previous watching
 * User can view the movies by movie ratings
 

#### Feature1 : Register with the app to get in
```sql
  create table users(user_id number,
                   user_name varchar2(100) not null,
                   email varchar2(100) not null,
                   phone_no number not null,
                   pre_language varchar2(100) not null,
                   constraint user_id_pk primary key(user_id),
                   constraint email_ck check(email LIKE '%_@%_._%'),
                   constraint phone_no_ck check(phone_no not like '%[^0-9]%') ,
                   constraint pre_language_ck check(pre_language in('tamil','telugu','english')),
                   constraint user_uq unique (user_name,email)
                   );

  ```
  Query:
        insert into users(user_id,user_name,email,phone_no,pre_language)
            values(user_id_sq.nextval,'Maha','maha@gmail.com',9165948856,'telugu');
            
| user_id | user_name  | email                  | phone_no   | pre_language |
|---------|------------|------------------------|------------|--------------|
| 1       | Mareeswari | marees@gmail.com       | 9155787999 | tamil        |
| 2       | Mareeswari | mareesrengan@gmail.com | 9155897999 | tamil        |
| 3       | Maha       | maha@gmail.com         | 9165948856 | telugu       |

#### Feature2 : User can view all movies based on user preferred language

```sql
 create table movies(movie_id number,
                    movie_name varchar2(100) not null ,
                    movie_type varchar2(100) not null,
                    movie_language varchar2(100) not null,
                    movie_ratings number default 1,
                    movie_director varchar2(100) not null,
                    movie_released_date date not null,
                    date_launching_into_hotstar date default sysdate,
                    constraint movie_id_pk primary key (movie_id),
                    constraint movie_type_ck check(movie_type in('comedy','thriller','action','drama')),
                    constraint movie_id_ck check(movie_id between 0 and 100),
                    constraint movie_language_ck check(movie_language in('tamil','english','telugu')),
                    constraint movie_ratings_ck check(movie_ratings in(1,2,3,4,5)),
                    constraint movie_uq unique(movie_name,movie_type,movie_language,movie_director)
                    );

  ```
                      
                      
   Query:
   select movie_id,movie_name ,movie_director,movie_language from movies where movie_language=(select pre_language from users where       user_id=2);
                      
| movie_id | movie_name              | maovie_director | pre_language |
|----------|-------------------------|-----------------|--------------|
| 1        | vaanam                  | krish           | tamil        |
| 2        | chekka chivantha vaanam | mani rathnam    | tamil        |



#### Feature3 : User can view all movies
  Query:
  select * from movies

| movie_id | movie_name           | movie_type | movie_language | movie_ratings | movie_director | movie_released_date | launching_date |
|----------|-------------------------|------------|----------------|---------------|----------------|---------------------|-------------
| 1        | vaanam                  | drama      | tamil          | 1             | krish          | 29-04-11            | 02-01-20       
| 2        | chekka chivantha vaanam | action     | tamil          | 1             | mani rathnam   | 29-04-11            | 02-01-20       
| 3        | magili                  | drama      | telugu         | 1             | shiva          | 05-04-19            | 02-01-20       
#### Feature4 : User can view all tv shows

```sql
create table tv_shows(show_id number,
                      show_name varchar2(100) not null,
                      date_launching_into_hotstar date default sysdate,
                      show_language varchar2(100) not null,
                      show_type varchar2(100) not null,
                      show_ratings number default 1,
                      constraint show_id_pk primary key(show_id),
                     constraint show_id_ck check(show_id between 100 and 200),

                      constraint show_type_ck check (show_type in('reality','serial')),
                      constraint show_language_ck check (show_language in('tamil','telugu','english')),
                      constraint show_ratings_ck check(show_ratings in(1,2,3,4,5)),
                      constraint tv_shows_uq unique(show_name,show_type,show_language)
                      );

  ```
Query:
  select * from tv_shows;
  
| show_id | show_name      | launching_date | show_language | show_type | show_ratings |
|---------|----------------|----------------|---------------|-----------|--------------|
| 101     | get set go     | 02-01-20       | tamil         | reality   | 1            |
| 102     | coffee with dd | 02-01-20       | tamil         | reality   | 1            |

#### Feature5 : User can view all episodes of all tv_shows
```sql
create table show_episodes(show_epi_id number,
                           show_id number not null,
                           episode_no number not null,
                           episode_date date default sysdate,
                           constraint show_epi_id_pk primary key (show_epi_id),
                           constraint show_id_fk foreign key (show_id) references tv_shows(show_id),
                           constraint episodes_uq unique(show_id,episode_date)
                        );

  ```
  Query:
   select * from show_episodes;

| epi_id | show_id | episode_no | launching_date |
|--------|---------|------------|----------------|
| 1      | 101     | 1          | 02-01-20       |
| 2      | 102     | 1          | 02-01-20       |
| 3      | 101     | 3          | 02-01-20       |
   
#### Feature6 : User can view all episodes counts of particular show

 Query:
  select t.show_name,(select  count(episode_no) from show_episodes where t.show_id=show_id) as epi_count from tv_shows t where t.show_name=lower('Get set go');

| show_name  | episode_count |
|------------|---------------|
| get set go | 2             |

#### Feature7 : User can view today episodes for particular show

Query:
   select t.show_name,s.episode_no,s.episode_date from tv_shows t,show_episodes s where t.show_id=s.show_id and
t.show_name=lower('coffee with dd') and trunc(s.episode_date)=trunc(sysdate);

| show_name      	| episode_no 	| episode_date 	|
|----------------	|------------	|--------------	|
| coffee with dd 	| 1          	| 03-01-20     	|

#### Feature8 : User can view all episodes for all show

Query:
  select t.show_name,s.episode_no,s.episode_date from tv_shows t,show_episodes s where t.show_id=s.show_id ;

| show_name      	| episode_no 	| episode_date 	|
|----------------	|------------	|--------------	|
| get set go     	| 1          	| 02-01-20     	|
| coffee with dd 	| 1          	| 02-01-20     	|
| get set go     	| 3          	| 02-01-20     	|
| coffee with dd 	| 1          	| 03-01-20     	|


#### Feature9 : User can view previous watching
```sql
create table users_watching_details_movies(watching_id number,
                                    last_watching_id number not null,
                                    last_viewing_date date default sysdate,
                                    user_id number not null unique,
                                    constraint watching_id_pk primary key(watching_id),
                                    constraint user_id_fk foreign key(user_id) references users(user_id) ,
                                    constraint last_watching_id_fk foreign key(last_watching_id ) references movies(movie_id)
                                    );
insert into users_watching_details_movies(watching_id,last_watching_id,user_id)values (watching_id_sq.nextval,1,2);
insert into users_watching_details_movies(watching_id,last_watching_id,user_id)values (watching_id_sq.nextval,1,1);

update users_watching_details_movies set last_viewing_date=sysdate, last_watching_id=2 where user_id=2;


  ```
  Query:
   select movie_name,movie_director from movies where movie_id=(select last_watching_id from users_watching_details_movies where user_id=(select user_id from users where email='mareesrengan@gmail.com'));

| movie_name              	| movie_director 	|
|-------------------------	|----------------	|
| chekka chivantha vaanam 	| mani rathnam   	|

#### Feature10 : User can view the movies by movie ratings
```sql
create table movie_ratings (ratings_id number,
                            movie_id number ,
                            user_id number,
                            ratings number not null,
                            rating_date date default sysdate ,
                            constraint ratings_id_pk primary key (ratings_id),
                            constraint user_id_fk2 foreign key(user_id) references users(user_id),
                            constraint movie_id foreign key (movie_id) references movies(movie_id)
                            );
insert into movie_ratings (ratings_id,user_id,movie_id,ratings) values(movie_ratings_id.nextval,1,1,2);
insert into movie_ratings (ratings_id,user_id,movie_id,ratings) values(movie_ratings_id.nextval,2,1,3);
insert into movie_ratings (ratings_id,user_id,movie_id,ratings) values(movie_ratings_id.nextval,3,1,4);

update movies set movie_ratings =find_min_ratings(1) where movie_id=1;

CREATE OR REPLACE FUNCTION FIND_MIN_RATINGS 
(
  M_ID IN NUMBER 
) RETURN NUMBER AS max_rating number;
BEGIN
  select max(ratings) into max_rating from movie_ratings where movie_id=M_ID;

  RETURN max_rating;
END FIND_MIN_RATINGS;

  ```
  Query:
  select movie_id,movie_name,movie_director,movie_language,movie_ratings from movies order by movie_ratings DESC;
  
| movie_id 	| movie_name              	| movie_director 	| movie_language 	| movie_ratings 	|
|----------	|-------------------------	|----------------	|----------------	|---------------	|
| 1        	| vaanam                  	| krish          	| tamil          	| 4             	|
| 3        	| magili                  	| shiva          	| telugu         	| 1             	|
| 2        	| chekka chivantha vaanam 	| mani rathnam   	| tamil          	| 1             	|
