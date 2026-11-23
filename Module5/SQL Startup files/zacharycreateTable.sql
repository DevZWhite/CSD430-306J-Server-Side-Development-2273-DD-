-- zacharycreateTable.sql
-- Creates the CSD430 database, the student1 user, and the zachary_library_data table.
CREATE DATABASE IF NOT EXISTS CSD430;
CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON CSD430.* TO 'student1'@'localhost';
FLUSH PRIVILEGES;

USE CSD430;

CREATE TABLE zachary_library_data (
    book_id          INT AUTO_INCREMENT PRIMARY KEY,
    title            VARCHAR(120) NOT NULL,
    author           VARCHAR(80)  NOT NULL,
    genre            VARCHAR(40)  NOT NULL,
    publication_year INT          NOT NULL,
    my_rating        DECIMAL(2,1) NOT NULL
);
