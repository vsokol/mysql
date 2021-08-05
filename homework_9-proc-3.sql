/* (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
 *  Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
 * Вызов функции FIBONACCI(10) должен возвращать число 55. 
 * */

drop function if exists Fibonacci;

delimiter //
create function Fibonacci(num bigint) 
returns bigint deterministic
begin
  declare nm_prev_prev, nm_prev, i, fb bigint;
  if num < 0 then
    signal sqlstate '45000' set message_text = 'Неверные входные данные';
  elseif num = 0 then
    return 0;
  elseif num = 1 or num = 2 then
    return 1; 
  end if;
 
  set nm_prev_prev = 1;
  set nm_prev = 1;
  set fb = 0;
  set i = 3;
  while i <= num do
    set fb = nm_prev_prev + nm_prev;
    set nm_prev_prev = nm_prev;
    set nm_prev = fb;
    set i = i + 1;
  end while;
  return fb;  
end//
delimiter ;

-- Тестирование
select Fibonacci(-1);

select Fibonacci(0), Fibonacci(1), Fibonacci(2), Fibonacci(3), Fibonacci(4), Fibonacci(5);

select Fibonacci(6), Fibonacci(7), Fibonacci(8), Fibonacci(9), Fibonacci(10);