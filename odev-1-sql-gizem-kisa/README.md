
#SQL HOMEWORKS
##Goal
After creating a simple archive and adding our data, creating queries and practicing by repeating what we have learned. 

----

### ABOUT THE CONTENTS

> Homework content
The main assignment file is BlogVeritabanı.sql.
users(2).sql,
comments.sql,
posts.sql,
and categories.sql files contain the data of the relevant table processed to the Database.
> 
A simple blog database is designed in this assignment. In this database users, posts, categories
and comments tables. Field information of the tables are as follows.


| users  | posts | categories | comments
| ------------- | ------------- | ------------- | ------------- |
| user_id  | post_id  | category_id  | comment_id  |
| username  | user_id | name | post_id  |
| email  | category_id  | creation_date  | user_id  |
| creation_date | title |  | comment  |
| is_active  | content |  | creation_date  |
|  | view_count |  | is_confirmed  |
|  | creation_date |   |   |
|  |is_published |  |   |



###Criteria

- [x] A PRIMARY KEY field containing the id information of the table name was created in all of the specified tables. Relationships were established between the tables by referencing the FOREIGN KEY.
- [x] In all tables, if the creation_date information is not specified in the INSERT query, it automatically adds the date and time information at the time the data was added.
- [x] Care has been taken to ensure that the username and email information of the users are UNIQUE, and that NULL content cannot be entered at the same time.
- [x] All posts have title and content information. The title information is not longer than 50 characters.
- [x] If a post is registered without any view_count information, it will have an initial value of 0.
( [Click for Github profile ](https://github.com/Gizot))
