
CREATE TABLE Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(50) NOT NULL,
    event_date_time TIMESTAMP
    group_id INT,
    event_details VARCHAR(200)
);

CREATE TABLE Post (
    post_id INT PRIMARY KEY,
    post_owner_id INT,
    post_name VARCHAR(150),
    date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    post_type ENUM('Post', 'Event') DEFAULT 'Post',
    text_contents VARCHAR(2000),
    FOREIGN KEY(post_owner) REFERENCES User(user_id)
);

CREATE TABLE Uploads (
    user INT, post INT,
    FOREIGN KEY(user) REFERENCES User(user_id),
    FOREIGN KEY(post) REFERENCES Post(post_id),
    PRIMARY KEY('user_id', 'post_id')
);

CREATE TABLE User (
    user_id INT PRIMARY KEY,
    username VARCHAR(20) NOT NULL,
    email VARCHAR(40) NOT NULL, -- validate uvic email?
);


CREATE TABLE Follows (
    user_id INT,
    group_id INT,
);

ALTER TABLE Follows
ADD CONSTRAINT fk_follow_group
FOREIGN KEY (user_id) REFERENCES User(user_id);
FOREIGN KEY (group_id) REFERENCES Group(group_id);


# In BCNF with functional dependencies:
# group_id -> group_name
CREATE TABLE group_table (group_id INT PRIMARY KEY
                    ,group_name VARCHAR(50));

# In BCNF with functional dependencies:
# (group_id, user_id) -> is_admin
CREATE TABLE admin_table (group_id INT
                        ,user_id INT
                        ,is_admin BOOLEAN
                        ,PRIMARY KEY (group_id, user_id));

# In BCNF with functional dependencies:
# post_id -> group_id
CREATE TABLE post_table (group_id INT PRIMARY KEY
                    ,post_id INT);

# In BCNF with functional dependencies:
# post_id -> group_id, event_id
# event_id -> group_id, post_id
CREATE TABLE event_table (group_id INT PRIMARY KEY
                    ,post_id INT
                    ,event_id INT);
