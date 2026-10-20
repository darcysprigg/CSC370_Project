CREATE DATABASE project_database;
USE project_database;

CREATE TABLE User (
    user_id INT PRIMARY KEY,
    username VARCHAR(20) NOT NULL,
    email VARCHAR(40) NOT NULL,
    CONSTRAINT chk_uvic_email
        CHECK (email LIKE '%@uvic.ca')
);

CREATE TABLE group_table (group_id INT PRIMARY KEY,
                        group_name VARCHAR(50) NOT NULL);

CREATE TABLE Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(50) NOT NULL,
    event_date_time DATETIME NOT NULL,
    created_by INT NOT NULL,
    event_details VARCHAR(200) NOT NULL,
    group_id INT NOT NULL,  -- hosts
    FOREIGN KEY(group_id) REFERENCES group_table(group_id) ON DELETE CASCADE,  -- hosts
    FOREIGN KEY(created_by) REFERENCES User(user_id) ON DELETE CASCADE -- for implementing constraint that only group admin can create event
);

CREATE TABLE Post (
    post_id INT PRIMARY KEY,
    post_name VARCHAR(150),
    date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    text_contents VARCHAR(2000) NOT NULL,
    user_id INT NOT NULL,  -- uploads
    FOREIGN KEY(user_id) REFERENCES User(user_id) ON DELETE CASCADE  -- uploads
);

CREATE TABLE Event_Post (
    post_id INT PRIMARY KEY,          -- same key as the superclass
    event_id INT NOT NULL,  -- advertises
    FOREIGN KEY (post_id) REFERENCES Post(post_id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES Event(event_id) ON DELETE CASCADE  -- advertises
);

CREATE TABLE Comment (
    comment_id INT,
    post_id INT,
    commenter_id INT, -- user who posts comment
    date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    text_contents VARCHAR(2000) NOT NULL,
    PRIMARY KEY (comment_id, post_id, commenter_id),
    FOREIGN KEY (post_id) REFERENCES Post(post_id) ON DELETE CASCADE,  -- replies to
    FOREIGN KEY (commenter_id) REFERENCES User(user_id) ON DELETE CASCADE  -- writes
);

CREATE TABLE Member_Of (
    user_id INT NOT NULL,
    group_id INT NOT NULL,
    role_type ENUM('Regular Group Member', 'Group Admin') DEFAULT 'Regular Group Member',
    PRIMARY KEY(user_id, group_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES group_table(group_id) ON DELETE CASCADE
);

/* Contraint: No regular group member can create an event for their group
 * Relations: Member_Of(user_id, group_id, role_type), Event(event_id, created_by, group_id)
 * There does not exist an event in which the creator is a 'Regular Group Member' of the group hosting the event
 */
DELIMITER //

CREATE TRIGGER event_creation_constraint
BEFORE INSERT ON Event
FOR EACH ROW
BEGIN 
    IF NOT EXISTS (
        SELECT 1
        FROM Member_Of
        WHERE user_id = NEW.created_by AND group_id = NEW.group_id AND role_type = 'Group Admin' -- checks the user is apart of the group and is group admin
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Does not have admin privileges to create an event';
    END IF;
END //

DELIMITER ;
