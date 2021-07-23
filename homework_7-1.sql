/* Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине. */

select *
from users u
where exists ( select null
               from orders o
               where u.id = o.user_id );
