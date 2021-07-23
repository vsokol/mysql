/*
 * Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения (JOIN пока не применять).
 */ 

-- Без join можно варианты запросов с заменой distinct на group by (хотя план выполнения будет одним и тем же) и in на exists. 

-- объединяем две группы, чтобы получить всех друзей
SELECT to_user_id FROM friend_requests WHERE from_user_id = 1 AND request_type = 1
UNION
SELECT from_user_id FROM friend_requests WHERE to_user_id = 1 AND request_type = 1;

-- еще один вариант без использования UNION
SELECT 
	DISTINCT IF(to_user_id = 1, from_user_id, to_user_id) AS friends
FROM friend_requests 
WHERE request_type = 1 AND (to_user_id = 1 OR from_user_id = 1);

-- вариант через group by 
select if(to_user_id = 1, from_user_id, to_user_id) as friends
from friend_requests
where request_type = 1
  and ( to_user_id = 1
     or from_user_id = 1
  )
group by if(to_user_id = 1, from_user_id, to_user_id);


/*
 * Задание 6. Выводим имя и фамилию друзей пользователя с id = 1
*/
SELECT CONCAT(first_name, ' ', last_name) AS name
FROM users
WHERE id IN (
	SELECT to_user_id FROM friend_requests WHERE from_user_id = 1 AND request_type = 1
		UNION
	SELECT from_user_id FROM friend_requests WHERE to_user_id = 1 AND request_type = 1);
	
-- вариант с exists
select concat(u.first_name, ' ', u.last_name) as name 
from users u
where 
  exists ( select null 
               from friend_requests fr1 
               where fr1.to_user_id = 1
                 and fr1.from_user_id = u.id 
                 and fr1.request_type = 1 
                 union all 
               select null 
               from friend_requests fr2 
               where fr2.from_user_id = 1
                 and fr2.to_user_id = u.id 
                 and fr2.request_type = 1 );
