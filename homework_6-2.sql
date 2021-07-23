/* Пусть задан некоторый пользователь. 
 * Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
 */

-- любой кто, больше всех общался с пользователем 1
select count(*) as msg_count
     , m.from_user_id 
from messages m
where m.to_user_id = 1
group by m.from_user_id
order by msg_count desc 
limit 1;

-- все кто больше всех общался с пользователем 1
select from_user_id
from messages
where to_user_id = 1 
group by from_user_id
having count(*) 
         in ( select max(msg.msg_count)
              from ( select count(*) as msg_count
                     from messages
                     where to_user_id = 1 
                     group by from_user_id ) msg )
      