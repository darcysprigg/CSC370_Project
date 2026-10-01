
CREATE TABLE event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(50),
    event_date date,
    event_time time,
    event_group_id INT,
    event_details VARCHAR(200)
);