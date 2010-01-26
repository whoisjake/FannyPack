-- create database fannypack_development;
-- create database fannypack_test;
-- create database fannypack_production;
use mysql;
grant all on fannypack_development.* to 'fannypack'@'localhost';
grant all on fannypack_test.* to 'fannypack'@'localhost';
grant all on fannypack_production.* to 'fannypack'@'localhost' identified by 'productionPass';

use fannypack_development;

drop table if exists group_user;
drop table if exists groups_messages;
drop table if exists groups_events;
drop table if exists messages;
drop table if exists events;
drop table if exists invitations;
drop table if exists usersettings;
drop table if exists users;
drop table if exists groups;



Create table users (
id int not null auto_increment,
username varchar(100) not null,
hashed_password varchar(100) not null,
first_name varchar(100),
last_name varchar(100),
photo blob,
photo_type varchar(10),
email varchar(250),
address1 varchar(250),
address2 varchar(250),
city varchar(250),
state varchar(250),
zip_code varchar(10),
last_activity datetime,
PRIMARY KEY (id)
);


create table usersettings (
id int not null auto_increment,
user_id int not null,
blogurl varchar(100),
birth_date datetime,
flickr_email varchar(250),
amazon_url varchar(250),
theme_name varchar(100),
PRIMARY KEY (id),
FOREIGN KEY (user_id) REFERENCES users (id) on delete cascade
);

create table groups
(
id int not null auto_increment,
user_id int not null,
group_name varchar(100),
PRIMARY KEY (id),
FOREIGN KEY fk_owner (user_id) REFERENCES users (id) on delete cascade
);

create table groups_users (
membergroup_id int not null,
member_id int not null,
PRIMARY KEY (membergroup_id,member_id),
FOREIGN KEY (member_id) REFERENCES users (id) on delete cascade,
FOREIGN KEY (membergroup_id) REFERENCES groups (id) on delete cascade
);

create table invitations (
id int not null auto_increment,
user_id int not null,
group_id int not null,
PRIMARY KEY (id),
FOREIGN KEY (user_id) REFERENCES users (id) on delete cascade,
FOREIGN KEY (group_id) REFERENCES groups (id) on delete cascade
);


create table messages
(
id int not null auto_increment,
user_id int not null,
subject varchar(100),
message text,
posted datetime,
PRIMARY KEY (id),
FOREIGN KEY (user_id) REFERENCES users (id) on delete cascade
);

create table groups_messages
(
message_id int not null,
group_id int not null,
PRIMARY KEY (message_id,group_id),
FOREIGN KEY (message_id) REFERENCES messages (id) on delete cascade,
FOREIGN KEY (group_id) REFERENCES groups (id) on delete cascade
);

create table events
(
id int not null auto_increment,
user_id int not null,
name varchar(100),
location varchar(100),
date datetime,
PRIMARY KEY (id),
FOREIGN KEY (user_id) REFERENCES users (id) on delete cascade
);

create table groups_events
(
event_id int not null,
group_id int not null,
PRIMARY KEY (event_id,group_id),
FOREIGN KEY (event_id) REFERENCES events (id) on delete cascade,
FOREIGN KEY (group_id) REFERENCES groups (id) on delete cascade
);
