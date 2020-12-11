#a) Create a stored procedure to insert data into the users table. The values to be stored must be passed as parameters to the stored procedure.
DELIMITER //
CREATE PROCEDURE insert_data_into_users(IN user_id INT, IN username VARCHAR(15), IN password VARCHAR(15), IN email VARCHAR(20) )
BEGIN
	INSERT INTO Users VALUES (user_id, username, password, email);
END //
DELIMITER ;

#b) Create trigger(s) to update the records in the summary table. The summary table will
#contain only one record and will be updated each time a new entry is made to the
#users table, or an email address is updated in the users table or a user is deleted from
#the users table. 
DELIMITER //
CREATE TRIGGER update_summary_after_insert
AFTER INSERT 
ON person.Users
FOR EACH ROW
BEGIN
	SET @total_users = (SELECT COUNT(user_id) FROM Users);
	SET @yahoo = (SELECT COUNT(*) FROM Users WHERE email LIKE '%yahoo.com');
	SET @hotmail = (SELECT COUNT(*) FROM Users WHERE email LIKE '%hotmail.com');
	SET @gmail = (SELECT COUNT(*) FROM Users WHERE email LIKE '%gmail.com');

	UPDATE Summary 
	SET total_users = @total_users,yahoo = @yahoo,hotmail = @hotmail,gmail = @gmail;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER update_summary_after_update
AFTER UPDATE
ON person.Users
FOR EACH ROW
BEGIN
	SET @total_users = (SELECT COUNT(user_id) FROM Users);
	SET @yahoo = (SELECT COUNT(*) FROM Users WHERE email LIKE '%yahoo.com');
	SET @hotmail = (SELECT COUNT(*) FROM Users WHERE email LIKE '%hotmail.com');
	SET @gmail = (SELECT COUNT(*) FROM Users WHERE email LIKE '%gmail.com');

	UPDATE Summary 
	SET total_users = @total_users,yahoo = @yahoo,hotmail = @hotmail,gmail = @gmail;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER update_summary_after_delete
AFTER DELETE
ON person.Users
FOR EACH ROW
BEGIN
	SET @total_users = (SELECT COUNT(user_id) FROM Users);
	SET @yahoo = (SELECT COUNT(*) FROM Users WHERE email LIKE '%yahoo.com');
	SET @hotmail = (SELECT COUNT(*) FROM Users WHERE email LIKE '%hotmail.com');
	SET @gmail = (SELECT COUNT(*) FROM Users WHERE email LIKE '%gmail.com');

	UPDATE Summary 
	SET total_users = @total_users,yahoo = @yahoo,hotmail = @hotmail,gmail = @gmail;
END //
DELIMITER ;
