/* 5.	(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
 * SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
 * */
select * 
from catalogs
where id in (5, 1, 2)
order by 
  case
    when id = 5 then 1
    when id = 1 then 2
    else 3    
  end;
