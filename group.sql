CREATE DATABASE group_database;

USE group_database;

# In BCNF with functional dependencies:
# group_id -> group_name
CREATE TABLE group_table (group_id INT
                    ,group_name VARCHAR(30));

# In BCNF with functional dependencies:
# No non-trivial FDs
CREATE TABLE follower_table (group_id INT
                        ,user_id VARCHAR(30));

# In BCNF with functional dependencies:
# (group_id, user_id) -> is_admin
CREATE TABLE admin_table (group_id INT
                        ,user_id VARCHAR(30)
                        ,is_admin BOOLEAN);

# In BCNF with functional dependencies:
# post_id -> group_id
CREATE TABLE post_table (group_id INT
                    ,post_id INT);

# In BCNF with functional dependencies:
# post_id -> group_id, event_id
# event_id -> group_id, post_id
CREATE TABLE event_table (group_id INT
                    ,post_id INT
                    ,event_id INT);