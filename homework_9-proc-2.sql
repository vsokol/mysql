/* В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 * Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 * Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 * При попытке присвоить полям NULL-значение необходимо отменить операцию. 
 * */

use shop;

drop trigger if exists trg_products_bi_er;
drop trigger if exists trg_products_bu_er;

delimiter //

create trigger trg_products_bi_er
  before insert on products
  for each row 
begin
  if (new.name is null and new.description is null) then 
    signal sqlstate '45000' set message_text = 'Name and description fields cannot be NULL at the same time. Operation canceled.';
  end if;
end//

create trigger trg_products_bu_er
  before update on products
  for each row 
begin
  if (new.name is null and new.description is null) then 
    signal sqlstate '45000' set message_text = 'Name and description fields cannot be NULL at the same time. Operation canceled.';
  end if;
end//

delimiter ;


-- Тестирование
delete from products where id >= 10000;
insert into products (id, name, description, price, catalog_id)
values (10000, 'Name-1', 'Description-1', 100.00, 1)
     , (10001, 'Name-2', null,            200.00, 1)
     , (10002,  null,    'Description-3', 300.00, 1);
    
insert into products (id, name, description, price, catalog_id) values (10003, null, null, 400.00, 1);

update products 
  set name = 'Name-1-1'
    , description = 'Description-1-1'
where id = 10000;

update products 
  set name = 'Name-1-2'
    , description = null 
where id = 10001;

update products 
  set name = null 
    , description = 'Description-1-3'
where id = 10002;

update products 
  set name = null 
    , description = null 
where id = 10002;
