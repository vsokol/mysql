/* 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы. */
create table multiplication (
  value bigint
);

insert into multiplication
values (1), (2), (3), (4), (5);

select exp(sum(ln(value))) as product_of_numbers
from multiplication;
