CREATE DATABASE project_database;

USE project_database;

--Queries

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