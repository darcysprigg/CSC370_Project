CREATE DATABASE project_database;

USE project_database;

CREATE TABLE User (
    user_id INT PRIMARY KEY,
    username VARCHAR(20) NOT NULL,
    email VARCHAR(40) NOT NULL -- validate uvic email?
);

CREATE TABLE Post (
    post_id INT PRIMARY KEY,
    post_owner_id INT NOT NULL,
    post_name VARCHAR(150),
    date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    post_type ENUM('Post', 'Event') DEFAULT 'Post',
    text_contents VARCHAR(2000),
    FOREIGN KEY(post_owner_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE Uploads (
    user INT NOT NULL, post INT NOT NULL,
    FOREIGN KEY(user) REFERENCES User(user_id),
    FOREIGN KEY(post) REFERENCES Post(post_id),
    PRIMARY KEY(user, post)
);

CREATE TABLE Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(50) NOT NULL,
    event_date_time TIMESTAMP,
    group_id INT NOT NULL,
    event_details VARCHAR(200),
    FOREIGN KEY(group_id) REFERENCES group_table(group_id) ON DELETE CASCADE
);

CREATE TABLE Follows (
    user_id INT NOT NULL,
    group_id INT NOT NULL,
    PRIMARY KEY (user_id, group_id)
);

CREATE TABLE group_table (group_id INT PRIMARY KEY
                    ,group_name VARCHAR(50) NOT NULL);

ALTER TABLE Follows
ADD CONSTRAINT fk_follow_user
    FOREIGN KEY (user_id) REFERENCES User(user_id),
ADD CONSTRAINT fk_follow_group
    FOREIGN KEY (group_id) REFERENCES group_table(group_id);

CREATE TABLE admin_table (group_id INT NOT NULL,
                        user_id INT NOT NULL,
                        is_admin BOOLEAN NOT NULL DEFAULT FALSE,
                        ,PRIMARY KEY (group_id, user_id)
                        ,FOREIGN KEY (group_id) REFERENCES group_table(group_id)
                        ,FOREIGN KEY (user_id) REFERENCES User(user_id));

CREATE TABLE post_table (group_id INT NOT NULL
                    , post_id INT PRIMARY KEY
                    , FOREIGN KEY (group_id) REFERENCES group_table(group_id)
                    , FOREIGN KEY (post_id) REFERENCES Post(post_id));

CREATE TABLE event_table (group_id INT NOT NULL
                    ,post_id INT PRIMARY KEY
                    ,event_id INT UNIQUE
                    , FOREIGN KEY (group_id) REFERENCES group_table(group_id)
                    , FOREIGN KEY (post_id) REFERENCES Post(post_id)
                    , FOREIGN KEY (event_id) REFERENCES Event(event_id));
