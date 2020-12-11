#Create a database name person and create the tables

CREATE DATABASE person;

USE person;

CREATE TABLE Users(
	user_id INT PRIMARY KEY,
	username VARCHAR(15),
	password VARCHAR(15),
	email VARCHAR(20)
);

CREATE TABLE Summary(
	id INT PRIMARY KEY,
	total_users INT,
	Yahoo INT,
	Hotmail INT,
	Gmail INT
);


#1. Write a procedure that take id, total_user, Yahoo, Hotmail, Gmail values as an input and insert the data into the table summary. 
DELIMITER //
CREATE PROCEDURE insert_data_into_summary(IN id INT, IN total_users INT, IN Yahoo INT, IN Hotmail INT, IN Gmail INT)
BEGIN
	INSERT INTO Summary VALUES (id, total_users, Yahoo, Hotmail, Gmail);
END //
DELIMITER ;


#2. Write a procedure that take user_id, username, password, email values as an input and insert the data into the table Users.
DELIMITER //
CREATE PROCEDURE insert_data_into_users(IN user_id INT, IN username VARCHAR(15), IN password VARCHAR(15), IN email VARCHAR(20) )
BEGIN
	INSERT INTO Users VALUES (user_id, username, password, email);
END //
DELIMITER ;


#3. Write a procedure that output the average value of yahoo
DELIMITER //
CREATE PROCEDURE avg_value_of_yahoo(OUT avg_val INT)
BEGIN
	SELECT AVG(Yahoo) INTO avg_val 
	FROM Summary;
END //
DELIMITER ;


#4. Write a procedure that output the min value of Gmail.
DELIMITER //
CREATE PROCEDURE min_value_of_gmail(OUT min_val INT)
BEGIN
	SELECT MIN(Gmail) INTO min_val 
	FROM Summary;
END //
DELIMITER ;


#5. Write a procedure that output the max value of Hotmail.
DELIMITER //
CREATE PROCEDURE max_value_of_hotmail(OUT max_val INT)
BEGIN
	SELECT MAX(hotmail) INTO max_val 
	FROM Summary;
END //
DELIMITER ;


#6. Write a procedure that update the total user by 1 when yahoo value is less than equal to Hotmail.
DELIMITER //
CREATE PROCEDURE increment_total_user_on_condition()
BEGIN
	UPDATE Summary
	SET total_users = total_users + 1
	WHERE Yahoo <= Hotmail;
END //
DELIMITER ;