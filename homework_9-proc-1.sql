/* Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
 * С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
 * с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи". 
 * */

drop function if exists get_hello;

delimiter //
create function get_hello(tm time) 
returns varchar(13) deterministic
begin
  if (tm between time("00:00:00") and time("05:59:59")) then 
    return "Доброй ночи";
  elseif (tm between time("06:00:00") and time("11:59:59")) then
    return "Доброе утро";
  elseif (tm between time("12:00:00") and time("17:59:59")) then
    return "Добрый вечер";  
  elseif (tm between time("18:00:00") and time("23:59:59")) then  
    return "Добрый вечер";
  end if;
  -- return "Hello";
  signal sqlstate '45000' set message_text = 'Неверные входные данные';
end//
delimiter ;

-- успешные тесты
select get_hello(time("00:00"))
     , get_hello(time("05:00"))
     , get_hello(time("5:59:59"))
     , get_hello(time("6:00"))
     , get_hello(time("6:00:01"))
     , get_hello(time("19:30:10"))
     , get_hello(time("23:59:59"));

-- ошибочные тесты    
select get_hello(null);

select get_hello(time("24:00"));
