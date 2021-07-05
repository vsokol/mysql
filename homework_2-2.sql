create database if not exists example;

use example;

drop table if exists users; 
create table users (
    id   serial       primary key
  , name varchar(100)
);

