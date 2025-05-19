-- Add new post by user with ID 4 to the platform:
INSERT INTO Posts (user_id, post_text, media_url, post_date)
    VALUES (4, 'This is a new post!', 'https://picsum.photos/200', NOW());


-- Add comment by user with ID 28 to post with ID 31:
INSERT INTO Comments (post_id, user_id, comment_text, comment_date)
    VALUES (31, 28, 'This is a comment on the post!', NOW());|


-- Update profile information of user with ID 12:
UPDATE Users
    SET
    username = 'new_username1',
    email = 'new_email@gmail.com',
    password = 'newP4$$wrd',
    profile_picture_url = 'https://example.com/new_profile.jpg'
WHERE user_id = 12;


-- Remove like by user with ID 81 from post with ID 90:
DELETE FROM Likes
WHERE post_id = 90 AND user_id = 81;