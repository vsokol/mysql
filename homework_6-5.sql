/* Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети. */

-- Для правильной реализации необходимо определить понятие "активность".
-- Предположим, что "активность" - это кол-во постов, сообщений и лайков, причем вес у них одинаков
-- первые любые 10
select activity.user_id 
    , sum(activity.cnt) as activity_count
from ( select from_user_id as user_id 
            , count(*) as cnt
       from messages
       group by from_user_id
       union all
       select user_id 
            , count(*) as cnt
       from posts
       group by user_id
       union all
       select user_id 
            , count(*) as cnt
       from posts_likes
       group by user_id ) activity
group by activity.user_id
order by activity_count
limit 10;