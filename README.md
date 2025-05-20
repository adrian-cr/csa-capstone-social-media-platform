# Social Networking Database Project
This project outlines the SQL schema design and core operations to build a social networking platform database—including tables, logic, triggers,and stored procedures to manage users, content, and interactions.


## Schema Overview
Below is a breakdown for each of the seven tables that compose the `SocialMediaPlatform` database, which can be found in the `db_table_creation` script:
### 1. `Users`
Stores personal and profile information for each user, including `username`, `email`, `date_of_birth`, `profile_picture_url`, `post_count`, and `follower_counts`.

### 2. `Posts`
Contains user-generated posts, their `post_text`, `media_url`, and `post_date`.

### 3. `Comments`
Keeps track of user comments on posts, including the author's `user_id`, the `comment_text`, and the `comment_date`.

### 4. `Likes`
Tracks which users have liked which posts and when the like occurred. It stores information such as `like_date`s and the sender's `user_id`.

### 5. `Follows`
Records user relationships, indicating which users are following others and the date of follow. It includes fields like `follower_id`, `following_id`, and `follow_date`.

### 6. `Messages`
Handles private messages between users, including `sender_id`, `receiver_id`, `message_text`, `message_date`, and read status.

### 7. `Notifications`
Manages notifications sent to users, including recipients' `user_id` `notification_text`, `notification_date`, and whether it has been read.


## Queries
The SQL queries that can be performed on the `SocialMediaPlatform` database (once  previously populated with data by running the `data_insertion` script) are divided into three separate SQL scripts:
### `queries_1.sql`
This script runs simple SQL queries to:
* Fetch recent `posts` from `users` that the given (`user_id = 50`) user follows, ordered by the `post_date` to simulate a timeline or feed.
* Retrieve interactions for a `Post` by combining all the `comments` and `likes` on a given `post` (`user_id = 68`) into one result set and listing each activity in chronological order.
* Retrieve the list of all `users` who are currently following a given user (`user_id = 86`).
* Return all `messages` sent to a given user (`user_id = 8`) that have not yet been marked as `read`.
* Rank posts by the number of `likes` and return the top liked ones.
* Retrieve the most recent `notifications` received by a user (`user_id = 96`).

### `queries_2.sql`
This script performs data modification queries—namely queries to:
* Insert a new post into the database with associated user (`user_id = 4`), content, optional media, and timestamp.
* Add a comment to a specific post (`post_id = 31`) by a user (`user_id = 28`), recording the time it was made.
* Update the profile information of a user (`user_id = 12`).
* Delete a like record, essentially unliking an interaction between a post (`user_id = 90`) and a particular user (`user_id = 81`).

### `queries_3.sql`
This script contains more complex SQl queries which use strategies like nested selections and multiple-table joining to:
* Find and list `users` who have the highest number of `followers`.
* Identify `users` who have the most interactions—i.e., the highest combined count of `posts`, `comments`, and `likes`, giving insight into user engagement.
* Compute the average number of `comments` across all `posts` in the system.


## Triggers and Stored Procedures
Finally, this project includes the SQL commands necessary to create the triggers and stored procedures necessary to:
* Automatically insert a `notification` entry when a message is sent, thus automatically informing the receiver.
* Update the number of `posts` and `followers` for a given user based on current data.
* Suggest `users` for a given user to follow, based on existing `follows`.