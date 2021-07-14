-- image, audio, video, document
update media_types 
  set name = 'image'
where id = 1;  

update media_types 
  set name = 'audio'
where id = 2;

update media_types 
  set name = 'video'
where id = 3;

update media_types 
  set name = 'document'
where id = 4;

-- удаление заявок в друзья самому себе
delete from friend_requests 
where from_user_id = to_user_id;
