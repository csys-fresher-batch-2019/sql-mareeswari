# Hot Star
 www.hotstar.com
 
## Features
 * Register with the app to get in
 * User can view all movies based on user preferred language
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
