DELIMITER $$

-- Automatically notify users of new messages:
CREATE TRIGGER notify_new_message
AFTER INSERT ON Messages
FOR EACH ROW
BEGIN
	DECLARE sender_username VARCHAR(255);
    SELECT username INTO sender_username
    FROM Users
    WHERE user_id = NEW.sender_id;
    INSERT INTO Notifications (user_id, notification_text, notification_date)
		VALUES (NEW.receiver_id, CONCAT('New message from @', sender_username, ': "', NEW.message_text, '".'), NOW());
END$$


-- Update post counts and follower counts for users:
CREATE TRIGGER increase_post_count
AFTER INSERT ON Posts
FOR EACH ROW
BEGIN
    UPDATE Users
    SET post_count = post_count + 1
    WHERE user_id = NEW.user_id;
END$$

CREATE TRIGGER increase_follower_count
AFTER INSERT ON Follows
FOR EACH ROW
BEGIN
    UPDATE Users
    SET follower_count = follower_count + 1
    WHERE user_id = NEW.following_id;
END$$


-- Generate personalized recommendations for friends of users' friends:
CREATE PROCEDURE friendsOfFriends(IN current_user_id INT)
BEGIN
    SELECT DISTINCT  u.username
    FROM Follows f1 JOIN Follows f2
        ON f1.following_id = f2.follower_id JOIN Users u
            ON f2.following_id = u.user_id
    WHERE f1.follower_id = current_user_id
        AND f2.following_id != current_user_id
        AND f2.following_id NOT IN (
            SELECT following_id
            FROM Follows
            WHERE follower_id = current_user_id
        )
    LIMIT 10;
END$$

DELIMITER ;

-- Example of procedure call for user with ID 67:
-- CALL friendsOfFriends(86);