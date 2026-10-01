CREATE TABLE Post (
    post_id INT PRIMARY KEY,
    post_name VARCHAR(150),
    date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    post_type ENUM('Post', 'Event') DEFAULT 'Post',
    text_contents VARCHAR(2000)
);

CREATE TABLE Uploads (
    user INT, post INT,
    FOREIGN KEY(user) REFERENCES User(user_id),
    FOREIGN KEY(post) REFERENCES Post(post_id),
    PRIMARY KEY('user_id', 'post_id')
);