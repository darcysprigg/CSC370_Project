USE project_database;

-- Values for testing event_creation_constraint
INSERT INTO group_table (group_id, group_name)
VALUES (470001, 'Study Group');

INSERT INTO User (user_id, username, email)
VALUES (000001, 'confused_student', 'confused_student@uvic.ca'),
       (000002, 'best_tutor', 'best_tutor@uvic.ca');

INSERT INTO Member_Of (user_id, group_id, role_type)
VALUES (000001, 470001, 'Regular Group Member'),
       (000002, 470001, 'Group Admin');

-- insert fails b/c user's role type is regular group member
INSERT INTO Event (event_id, event_name, event_date_time, created_by, event_details, group_id)
VALUES (450001, 'Study Session', '2026-10-30 14:00:00', 
        000001, 'Come join us at Wally 150 for a study session!', 470001);

-- insert passes b/c user's role type is group admin
INSERT INTO Event (event_id, event_name, event_date_time, created_by, event_details, group_id)
VALUES (450002, 'Study Cafe', '2026-11-01 12:00:00', 
        000002, 'Visit the RUG for a relaxing place to study!', 470001);

-- only event with id 450002 should appear
SELECT event_id, event_name, created_by, group_id
FROM Event;