-- Добавить необходимую таблицу/таблицы для того, чтобы можно было использовать лайки для медиафайлов, постов и пользователей.
use vk;

drop table if exists likes;
drop table if exists like_types;

create table if not exists like_types (
	id   int unsigned not null auto_increment primary key comment 'Уникальный идентификатор'
  ,	name varchar(20)  not null comment 'Название типа лайка'
) comment = 'Типы лайков';

alter table like_types auto_increment = 100;

insert into like_types values 
    (1, 'Медиафайлы')
  , (2, 'Посты')
  , (3, 'Пользователи');

 create table if not exists likes (
     id           serial   primary key       comment 'Уникальный идентификатор'   
   , like_type_id int      unsigned not null comment 'Тип лайка'
   , object_id    bigint   unsigned not null comment 'Ссылка на медиафайл, пост или пользователя'
   , created_at   datetime          not null default NOW() comment 'Дата создания лайка'
) comment 'Лайки';
 
alter table likes add constraint likes_like_type_id_object_id_uk unique key (like_type_id, object_id);

/*
 * Вариант реализации зависит от решаемой задачи, способов использования и нагрузки
 * 
 * Один из вариантов, при большой нагрузке стоит создать одельную таблицу лайков 
 * и 3 таблицы связи (для медиафайлов, постов и пользователей) 
 * 
 * */