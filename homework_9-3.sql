/* (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', 
 * '2018-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
 * если дата присутствует в исходном таблице и 0, если она отсутствует. 
 * */

-- Создание базы, схемы и тестовых данных
create database if not exists lesson_9;

use lesson_9;

drop table if exists task_3; 
create table task_3 (
    id         serial       primary key
  , name       varchar(100)
  , created_at datetime     default current_timestamp
);

insert into task_3 (name, created_at) values
    ('01', str_to_date('2018-08-01', '%Y-%m-%d'))
  , ('04', str_to_date('2018-08-04', '%Y-%m-%d'))
  , ('16', str_to_date('2018-08-16', '%Y-%m-%d'))
  , ('17', str_to_date('2018-08-17', '%Y-%m-%d'));
 

-- Решение
-- не нашел стандарных способов для генерации записей :-(
-- сделаем с использование декартова произведения
-- Вариант 1 
with rows_gen as (
  select (@row_number := @row_number + 1) as row_num
  from ( select 0 as d union select 1 )  set_1 
     , ( select 0 as d union select 2 )  set_2
     , ( select 0 as d union select 4 )  set_3
     , ( select 0 as d union select 8 )  set_4
     , ( select 0 as d union select 16 ) set_5
     , ( select @row_number := 0 ) as rw
)
select date_gen.dt
     , if(t.created_at is not null, 1, 0) as flag
from ( select row_num, str_to_date(concat('2018-08-', row_num), '%Y-%m-%d') as dt
       from rows_gen
       where row_num <= TimeStampDiff(DAY, str_to_date('2018-08-01', '%Y-%m-%d'), str_to_date('2018-09-01', '%Y-%m-%d')) ) as date_gen
     left join task_3 t 
       on date_gen.dt = t.created_at 
order by date_gen.dt;
 
-- Вариант 2
with rows_gen as (
  select set_1.d + set_2.d + set_3.d + set_4.d + set_5.d as row_num
  from ( select 0 as d union select 1 )  set_1 
     , ( select 0 as d union select 2 )  set_2
     , ( select 0 as d union select 4 )  set_3
     , ( select 0 as d union select 8 )  set_4
     , ( select 0 as d union select 16 ) set_5
)
select date_gen.dt
     , if(t.created_at is not null, 1, 0) as flag
from ( select row_num, date_add('2018-08-01', interval row_num DAY) as dt
       from rows_gen
       where row_num < TimeStampDiff(DAY, str_to_date('2018-08-01', '%Y-%m-%d'), str_to_date('2018-09-01', '%Y-%m-%d')) ) as date_gen
     left join task_3 t 
       on date_gen.dt = t.created_at       
order by date_gen.dt;       
