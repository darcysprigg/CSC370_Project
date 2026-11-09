USE project_database;

-- Queries

-- Gets list of all emails attached to user accounts
SELECT email
From User;

-- Get list of all comments on a post, sorted by time
SELECT commenter_id, date_time, text_contents
FROM Comment
WHERE post_id = 000001
ORDER BY date_time ASC;

-- Determine how many people are attending each non-empty event
SELECT Event.event_id, Event.event_name, COUNT(user_id) AS Attendee_Count
FROM Event
Join Is_Attending On Event.event_id = Is_Attending.event_id
AND Is_Attending.rsvp_status = 'Attending'
GROUP BY Event.event_id, Event.event_name;


/* Query: Find how many groups each user is in (Single-relation Aggregation ex.)
 * Relations: Member_Of(user_id, group_id)
 */
SELECT user_id, COUNT(group_id) AS GroupCounts
FROM Member_Of
GROUP BY user_id;


/* Finds how many events each group has created. (Multi-relation Aggregation ex.)
 * Relations: Group(group_id, group_name), Event(event_id, group_id)
 */
SELECT group_table.group_name, COUNT(event_id) AS EventCounts
From group_table
LEFT JOIN Event ON (group_table.group_id = Event.group_id)
GROUP BY group_table.group_name;


/* Query: Among users who are not members of any group, 
 * retrieve the user information of the three with the highest number of posts 
 * (alphabetical username in case of a tie), in descending order of number of posts. (Subquery ex.)
 * Relations: User(user_id, username, email), Member_Of(user_id), Post(post_id, user_id) 
 */
SELECT User.user_id, User.username, User.email, COUNT(Post.post_id) AS PostCounts
FROM User
JOIN Post ON (User.user_id = Post.user_id)
WHERE User.user_id NOT IN (
    SELECT Member_Of.user_id
    FROM Member_Of
)
GROUP BY User.user_id
ORDER BY PostCounts DESC, User.username
LIMIT 3;