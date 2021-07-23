/* Определить кто больше поставил лайков (всего) - мужчины или женщины? */

select if(lk.gender = 'f', 'Женщины', 'Мужчины')
from ( select p.gender
            , count(*) as cnt
       from posts_likes pl
          , profiles p
       where pl.like_type = true
         and pl.user_id = p.user_id
         and p.gender != 'x'
       group by p.gender ) lk
where lk.cnt = ( select max(max_likes.cnt) as mx
                 from ( select count(*) as cnt
                        from posts_likes pl
                           , profiles p
                        where pl.like_type = true
                          and pl.user_id = p.user_id
                          and p.gender != 'x'
                        group by p.gender ) max_likes )