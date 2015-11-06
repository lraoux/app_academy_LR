# Schema Information

## newsfeed item
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
text        | string    | not null
date        | datetime  | not null
author_id   | integer   | foreign key (references user or doctor), indexed

## profile item
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
user_id     | integer   | not null, foreign key (references user), indexed

## users
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
first_name      | string    | not null
last_name       | string    | not null
username        | string    | not null, indexed, unique
password_digest | string    | not null
session_token   | string    | not null, indexed, unique
profile_item    | id        |