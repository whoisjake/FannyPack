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
