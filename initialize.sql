CREATE DATABASE project_database;
USE project_database;

CREATE TABLE User (
    user_id INT PRIMARY KEY,
    username VARCHAR(20) NOT NULL,
    email VARCHAR(40) NOT NULL
    CONSTRAINT chk_uvic_email
        CHECK (email LIKE '%@uvic.ca')
);

# In BCNF with functional dependencies:
# group_id -> group_name
CREATE TABLE group_table (group_id INT PRIMARY KEY,
                        group_name VARCHAR(50));

CREATE TABLE Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(50) NOT NULL,
    event_date_time TIMESTAMP,
    created_by INT NOT NULL,
    event_details VARCHAR(200),
    FOREIGN KEY(group_id) REFERENCES group_table(group_id) ON DELETE CASCADE,
    FOREIGN KEY(created_by) REFERENCES User(user_id) -- for implementing constraint that only group admin can create event
);

CREATE TABLE Post (
    post_id INT PRIMARY KEY,
    post_name VARCHAR(150),
    date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    text_contents VARCHAR(2000),
    user_id INT,
    FOREIGN KEY(user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY(created_by) REFERENCES User(user_id), -- for implementing constraint that only group admin can create event
);

CREATE TABLE Event_Post (
    post_id INT PRIMARY KEY,          -- same key as the superclass
    event_id INT NOT NULL,
    FOREIGN KEY (post_id) REFERENCES Post(post_id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES Event(event_id) ON DELETE CASCADE
);

CREATE TABLE Member_Of (
    user_id INT,
    group_id INT,
    role_type ENUM('Regular Group Member', 'Group Admin') DEFAULT 'Regular Group Member',
    PRIMARY KEY(user_id, group_id)
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES group_table(group_id) ON DELETE CASCADE
);

# In BCNF with functional dependencies:
# post_id -> group_id
CREATE TABLE post_table (group_id INT PRIMARY KEY
                    ,post_id INT);

/* Contraint: No regular group member can create an event for their group
 * Relations: Member_of(user_id, group_id, role_type), Event(event_id, event_name, event_date_time, created_by, text:details)
 * There does not exist an event in which the creator is a 'Regular Group Member' of the group hosting the event
 */
DELIMITER //

CREATE TRIGGER event_creation_constraint
BEFORE INSERT ON Event
FOR EACH ROW
BEGIN 
    IF NOT EXISTS (
        SELECT 1
        FROM Member_of
        WHERE user_id = NEW.created_by AND group_id = NEW.group_id AND role_type = 'Group Admin' -- checks the user is apart of the group and is group admin
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Does not have admin privileges to create an event';
    END IF;
END //

DELIMITER ;
