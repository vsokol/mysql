/* (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
 * Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей. 
 * */

-- Создание базы, схемы и тестовых данных
create database if not exists lesson_9;

use lesson_9;

drop table if exists task_4; 
create table task_4 (
    id         serial       primary key
  , name       varchar(100)
  , created_at datetime     default current_timestamp
);

insert into task_4 (name, created_at) values
    ('01', str_to_date('2018-08-01', '%Y-%m-%d'))
  , ('04', str_to_date('2018-08-04', '%Y-%m-%d'))
  , ('16', str_to_date('2018-08-16', '%Y-%m-%d'))
  , ('06', str_to_date('2018-08-06', '%Y-%m-%d'))
  , ('30', str_to_date('2018-08-30', '%Y-%m-%d'))
  , ('10', str_to_date('2018-08-10', '%Y-%m-%d'))    
  , ('17', str_to_date('2018-08-17', '%Y-%m-%d'));
 

-- Решение
create or replace view v_task_4_5_most_recent_entries as
select id 
from task_4
order by created_at desc limit 5;

delete  
from task_4 t1
where not exists ( select null 
                   from v_task_4_5_most_recent_entries v
                   where t1.id = v.id );

-- можно без view
with v_task_4 as (
  select id 
  from task_4
  order by created_at desc limit 5
)
delete from task_4 t1
where not exists ( select null 
                   from v_task_4 v
                   where t1.id = v.id );
                  