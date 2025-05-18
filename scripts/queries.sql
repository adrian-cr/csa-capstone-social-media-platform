-- Retrieve the posts and activity timeline of user with ID 50:
SELECT
    p.post_id,
    p.user_id,
    u.username,
    p.post_text,
    p.post_date,
    p.media_url
FROM Posts p JOIN Users u
	ON p.user_id = u.user_id
WHERE
	p.user_id = 50
    OR
    p.user_id IN (
       SELECT following_id
       FROM Follows
       WHERE follower_id = 50
   )
ORDER BY p.post_date DESC;


-- Retrieve the comments and likes for post with ID 68:
SELECT
	'comment' AS activity,
    c.comment_text AS content,
    c.comment_date AS activity_date,
    u.username AS sender
FROM Comments c JOIN Users u
	ON c.user_id = u.user_id
WHERE c.post_id = 68

UNION   

SELECT 
    'like' AS activity,
    NULL AS content,
    l.like_date AS activity_date,
    u.username AS sender
FROM Likes l JOIN Users u
	ON l.user_id = u.user_id
WHERE l.post_id = 68

ORDER BY activity_date DESC;


-- Retrieve the list of followers for user with ID 86:
SELECT u.user_id, u.username, f.follow_date
FROM Follows f JOIN Users u
	ON f.follower_id = u.user_id
WHERE f.following_id = 86
ORDER BY 3 DESC;


-- Retrieve unread messages for user with ID 8:
SELECT 
    m.message_id,
    m.sender_id,
    u.username AS sender,
    m.message_text,
    m.message_date
FROM Messages m JOIN Users u
    ON m.sender_id = u.user_id
WHERE m.receiver_id = 8 AND NOT m.is_read
ORDER BY 5 DESC;


-- Retrieve most liked posts:
SELECT 
    p.post_id,
    p.user_id,
    u.username,
    COUNT(*) AS like_count,
    p.post_text,
    p.post_date
FROM Posts p
	JOIN Likes l ON p.post_id = l.post_id
	JOIN Users u ON p.user_id = u.user_id
GROUP BY 1
ORDER BY 4 DESC, 6 DESC
LIMIT 10;


--  Retrieve the latest notifications for user withID 96:
SELECT 
    notification_id,
    notification_text,
    notification_date,
    CASE WHEN is_read THEN 'read' ELSE 'unread' END AS status
FROM Notifications
WHERE user_id = 96
ORDER BY 4 DESC, 3 DESC;