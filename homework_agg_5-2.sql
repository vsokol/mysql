/*2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения. 
 * */
select u.day_of_week
     , count(u.day_of_week) as count_birthday_in_day_of_week
from ( select date_format(concat(date_format(birthday_at, '%d.%m.'), date_format(current_date() , '%Y')), '%w') as day_of_week 
       from users ) u
group by u.day_of_week
order by u.day_of_week;
