-- Identify users with the most followers:
SELECT 
    u.username,
    COUNT(*) AS follower_count
FROM Users u LEFT JOIN Follows f
    ON u.user_id = f.following_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;


-- Find the most active users based on post count and interaction:
SELECT 
    u.username,
    (COUNT(DISTINCT p.post_id) + COUNT(DISTINCT c.comment_id) + COUNT(DISTINCT l.like_id)) AS total_activity,
    COUNT(DISTINCT p.post_id) AS post_count,
    COUNT(DISTINCT c.comment_id) AS comment_count,
    COUNT(DISTINCT l.like_id) AS like_count
FROM Users u LEFT JOIN Posts p
	ON u.user_id = p.user_id LEFT JOIN Comments c
		ON u.user_id = c.user_id LEFT JOIN Likes l
			ON u.user_id = l.user_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;


-- Calculate the average number of comments per post (100 comments / 100 posts = 1cpp):
SELECT ROUND(COUNT(*) / (SELECT COUNT(*) FROM Posts), 0) AS avg_comments_per_post
FROM Comments;