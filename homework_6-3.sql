 /* Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей. */

select sum(lk.cnt) as likes_count
from ( select TIMESTAMPDIFF(YEAR, p.birthday, current_date()) as age
            , count(*) as cnt
       from posts_likes pl
          , profiles p
       where pl.like_type = true
         and pl.user_id = p.user_id
       group by age
       order by age
       limit 10 ) lk;