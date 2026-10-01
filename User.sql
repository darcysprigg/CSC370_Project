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
