USE project_database;

-- Values for testing event_creation_constraint
INSERT INTO group_table (group_id, group_name)
VALUES (470001, 'Study Group');

INSERT INTO User (user_id, username, email)
VALUES (000001, 'confused_student', 'confused_student@uvic.ca'),
       (000002, 'best_tutor', 'best_tutor@uvic.ca'),
       (000003, 'Harry Potter', 'harry_potter@uvic.ca'),
       (000004, 'Ronald Weasley', 'ron@uvic.ca'),
       (000005, 'Luke Skywalker', 'Lukey@uvic.ca');

INSERT INTO Member_Of (user_id, group_id, role_type)
VALUES (000001, 470001, 'Regular Group Member'),
       (000002, 470001, 'Group Admin');

-- insert fails b/c user's role type is regular group member
-- INSERT INTO Event (event_id, event_name, event_date_time, created_by, event_details, group_id)
-- VALUES (450001, 'Study Session', '2026-10-30 14:00:00', 
--        000001, 'Come join us at Wally 150 for a study session!', 470001);

-- insert passes b/c user's role type is group admin
-- insert passes b/c user's role type is group admin
INSERT INTO Event (event_id, event_name, event_date_time, created_by, event_details, group_id)
VALUES
    (450002, 'Study Cafe', '2026-11-01 12:00:00',
     000002, 'Visit the RUG for a relaxing place to study!', 470001),

    (450003, 'Midterm Study Session', '2026-11-03 14:00:00',
     000002, 'Come study together for upcoming midterms!', 470001),

    (450004, 'Group Project Meeting', '2026-11-05 16:00:00',
     000002, 'Meet to discuss project progress and divide responsibilities.', 470001),

    (450005, 'Board Game Night', '2026-11-07 18:00:00',
     000002, 'Take a break from studying and enjoy some board games!', 470001),

    (450006, 'Final Exam Preparation', '2026-11-10 13:00:00',
     000002, 'Review important course material together before finals.', 470001),

    (450007, 'Coffee and Coding', '2026-11-12 10:00:00',
     000002, 'Work on programming assignments together over coffee.', 470001),

    (450008, 'Group Social', '2026-11-15 17:00:00',
     000002, 'Get to know other members of the study group!', 470001);


INSERT INTO POST (post_id, post_name, text_contents, user_id)
VALUES (000001, "What is your favorite food at the Cove?", "Looking for some suggestions", 000001),
        (000002, "Who stole my bike?", "Please return it!!!", 000002);


INSERT INTO COMMENT (comment_id, post_id, commenter_id, text_contents)
VALUES (000001, 000001, 000005, "It's all terrible, try the Mystic Market Instead!"),
        (000002, 000001, 000003, "I have had decent luck with the Pizza"),
        (000003, 000002, 000003, "Stop looking, its mine now");


INSERT INTO Is_Attending (user_id, event_id, rsvp_status)
VALUES
    -- Study Cafe (3 attending, 1 interested)
    (000001, 450002, 'Attending'),
    (000003, 450002, 'Attending'),
    (000004, 450002, 'Attending'),
    (000005, 450002, 'Interested'),

    -- Midterm Study Session (2 attending, 1 RSVP No)
    (000001, 450003, 'Attending'),
    (000002, 450003, 'Attending'),
    (000004, 450003, 'RSVP No'),

    -- Group Project Meeting (1 attending, 1 interested)
    (000003, 450004, 'Attending'),
    (000005, 450004, 'Interested'),

    -- Board Game Night (3 attending)
    (000001, 450005, 'Attending'),
    (000002, 450005, 'Attending'),
    (000005, 450005, 'Attending'),

    -- Final Exam Preparation (2 interested, nobody attending)
    (000003, 450006, 'Interested'),
    (000004, 450006, 'Interested');

-- Events 450007 and 450008 intentionally have no RSVP records.