
CREATE TABLE Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(50) NOT NULL,
    date_time TIMESTAMP
    group_id INT,
    event_details VARCHAR(200)
);