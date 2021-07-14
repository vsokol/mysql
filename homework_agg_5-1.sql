/*1. Подсчитайте средний возраст пользователей в таблице users. */
select round(avg(TIMESTAMPDIFF(MONTH, birthday_at, current_date()) / 12), 1) as avg_age
from users;
