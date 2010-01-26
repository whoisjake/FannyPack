create database fannypack_development;
create database fannypack_test;
create database fannypack_production;

use mysql;
grant all on fannypack_development.* to 'fannypack'@'localhost';
grant all on fannypack_test.* to 'fannypack'@'localhost';
grant all on fannypack_production.* to 'fannypack'@'localhost';

use fannypack_production;

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
group_id int not null,
user_id int not null,
PRIMARY KEY (group_id,user_id),
FOREIGN KEY (user_id) REFERENCES users (id) on delete cascade,
FOREIGN KEY (group_id) REFERENCES groups (id) on delete cascade
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


INSERT INTO users
(id,username,hashed_password, first_name,last_name,email,city,state,zip_code)
VALUES
(10,'demo','a94a8fe5ccb19ba61c4c0873d391e987982fbbd3','John','Demouser','john@demoland.com','Chanhassen','MN','55410');

INSERT INTO groups (id,user_id,group_name) VALUES (10,10,'office');
INSERT INTO messages (id,user_id,subject,message,posted) VALUES (10,10,'Welcome to Fanny Pack','I hope you are enjoying your stay','2005-6-1 1:00');
INSERT INTO groups_messages(message_id,group_id) VALUES (10,10);

INSERT INTO users
(id,username,hashed_password, first_name,last_name,email,city,state,zip_code,last_activity)
VALUES
(11,'dbrent','a94a8fe5ccb19ba61c4c0873d391e987982fbbd3','David','Brent','dbrent@wernhamhogg.com','Chanhassen','MN','55410','2007-1-1');

INSERT INTO groups (id,user_id,group_name) VALUES (11,11,'office');
INSERT INTO messages (id,user_id,subject,message,posted) VALUES (11,11,'I like pie','I really like pie','2005-6-1 1:00');
INSERT INTO messages (id,user_id,subject,message,posted) VALUES (12,11,'Reports','I need those reports.','2005-6-2 1:00');
INSERT INTO events (id,user_id,name,location,date) VALUES (11,11,'My Birthday','My Office','2005-6-8 2:00');
INSERT INTO groups_events(event_id,group_id) VALUES (11,11);

INSERT INTO groups_messages(message_id,group_id) VALUES (11,11);
INSERT INTO groups_messages(message_id,group_id) VALUES (12,11);

INSERT INTO groups_users (group_id,user_id) VALUES (11,10);

INSERT INTO users
(id,username,hashed_password, first_name,last_name,email,city,state,zip_code,last_activity)
VALUES
(12,'gkeenan','a94a8fe5ccb19ba61c4c0873d391e987982fbbd3','Gareth','Keenan','gareth@wernhamhogg.com','Chanhassen','MN','55410','2007-1-1');

INSERT INTO groups (id,user_id,group_name) VALUES (12,12,'office');
INSERT INTO messages (id,user_id,subject,message,posted) VALUES (13,12,'My Office','Its not a workplace, its my office.','2005-6-1 1:00');
INSERT INTO groups_messages(message_id,group_id) VALUES (13,12);
INSERT INTO invitations (user_id,group_id) VALUES(10,12);

INSERT INTO users
(id,username,hashed_password, first_name,last_name,email,city,state,zip_code,last_activity)
VALUES
(13,'tcanterbury','a94a8fe5ccb19ba61c4c0873d391e987982fbbd3','Tim','Canterbury','tim@wernhamhogg.com','Chanhassen','MN','55410','2004-1-1');

INSERT INTO groups (id,user_id,group_name) VALUES (13,13,'office');

INSERT INTO users
(id,username,hashed_password, first_name,last_name,email,city,state,zip_code,last_activity)
VALUES
(14,'dtinsley','a94a8fe5ccb19ba61c4c0873d391e987982fbbd3','Dawn','Tinsley','dawn@wernhamhogg.com','Chanhassen','MN','55410','2004-1-1');

INSERT INTO groups (id,user_id,group_name) VALUES (14,14,'office');

