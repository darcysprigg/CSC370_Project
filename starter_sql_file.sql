CREATE TABLE Post (
    post_id INT PRIMARY KEY,
    post_name VARCHAR(150),
    date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    post_type ENUM('Post', 'Event') DEFAULT 'Post',
    text_contents VARCHAR(2000)
);