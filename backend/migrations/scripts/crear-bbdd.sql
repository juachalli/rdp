CREATE USER 'db_user'@'%' IDENTIFIED BY 'db_password';
CREATE DATABASE db_name;
GRANT ALL PRIVILEGES ON db_name.* TO 'db_user'@'%';
FLUSH PRIVILEGES;
