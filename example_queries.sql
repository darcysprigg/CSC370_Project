CREATE DATABASE project_database;

USE project_database;


--Queries


-- Given a set of table instances and a plain-English description of a query objective, you can correctly describe the schema of the output table


-- Given a set of table instances and a plain-English description of a query objective, you can write a SQL query that correctly retrieves the desired data


-- Given a SQL query that involves aggregation and grouping, you can describe its effect in natural language


-- Simple SQL Query
-- Gets list of all user emails

SELECT email
From User;


-- Determine how many people are attending a event


SELECT Event.event_id, Event.event_name, COUNT(user_id) AS Attendee_Count
FROM Event
Join Is_Attending On Event.event_id = Is_Attending.event_id
AND Is_Attending.rsvp_status = 'Attending'
GROUP BY Event.event_id, Event.event_name;