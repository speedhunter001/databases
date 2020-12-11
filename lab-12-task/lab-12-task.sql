USE person;

#Create a single-column index using attribute email
CREATE INDEX email_index 
ON Users(email);

#Create a composite-column index using attributes username and password
CREATE INDEX username_password_index
ON Users(username, password);

#Display the list of indexes for table users
SHOW INDEX 
FROM Users/G;

