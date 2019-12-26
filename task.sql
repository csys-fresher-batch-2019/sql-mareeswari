create table task_details(task_name varchar2(20) not null,
task_by varchar2(20) not null,
task_dline_date date not null,
task_completed_date date,
task_status char(1) default 'success',
constraint task_status_ck check(task_completed_date <task_dline_date)
);

insert into task_details values('install oracle','surya',to_date('26-12-2019','DD-MM-YYYY'),to_date('25-12-2019','DD-MM-YYYY'));

select * from task_details;
