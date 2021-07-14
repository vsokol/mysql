/* 2. Таблица users была неудачно спроектирована. 
 * Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
 * Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения. 
 * */  
alter table users rename column created_at to created_at_old;

alter table users rename column updated_at to updated_at_old;

alter table users add column created_at datetime not null default CURRENT_TIMESTAMP;

alter table users add column updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP;
	
update users
set created_at = str_to_date(created_at_old, '%d.%m.%Y %H:%i')
  , updated_at = str_to_date(updated_at_old, '%d.%m.%Y %H:%i')


alter table users drop column created_at_old ;

alter table users drop column updated_at_old;
