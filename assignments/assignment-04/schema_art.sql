/* 
Draw the dependency diagram of the table and normalize the table to ensure all generated tables are
in 3NF. Present all tables generated from the normalization. You have to present the results step by
step from 1NF to 3NF.


				Customer Table
			name | address | phone
					|
			    Purchases(One to Many relationship because assumption is that a customer can buy many paintings but only one painting can be owned by one customer at a time)
			    	|
			    	v
		Artist | Title | Purchase Date | Sales Price

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				Customer Table
		customer_id(P.K) | name | address | phone

			   Purchase Table
	Title(P.K) | Purchase Date(P.K) | customer_id(F.K) | Artist | Sales Price   (Title and purchase date are composite primary key because a painting can be owned by only one person so if its sold and then bought again and again sold so date will be different)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			       1NF(Each record must be unique i.e no duplicate rows and each cell must hold one value)
			    
			    Customer Table
		customer_id(P.K) | name | address | phone   (Customer info should be entered only once )
		
			   Purchase Table
	Title(P.K) | Purchase Date(P.K) | customer_id(F.K) | Artist | Sales Price 	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
				2NF(Must satisfy 1NF and if there is a composite primary key then each non-key column must be dependent on all keys)

			    Customer Table
		customer_id(P.K) | name | address | phone   
		
			   Purchase Table
	Title(P.K) | Purchase Date(P.K) | customer_id(F.K) | Sales Price   (customer_id is dependent on both keys,Artist is not dependent on Purchase Date,Sales Price is dependent on both keys as it is sales price of that title on that specific date) 	

		Artist Table
	Artist | Title(P.K)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				3NF(Satisfies 2NF and no transitive dependencies:non-key columns can't depend on othen non-key columns)

			    Customer Table
		customer_id(P.K) | name 

				Customer_details Table
		customer_id(F.K) | address | phone(P.K)   (We made two tables because if we change name then we may need to change address and phone number too so they are dependent on name)			

			   Purchase Table
	Title(P.K) | Purchase Date(P.K) | customer_id(F.K) | Sales Price   (As customer_id is a key too)

				Artist Table
			  Artist | Title(P.K)

*/
CREATE DATABASE art;

USE art;

CREATE TABLE customer_name(
	customer_id INT PRIMARY KEY,
	name char(50)
);

CREATE TABLE customer_details(
	phone VARCHAR(13) PRIMARY KEY,
	customer_id INT,
	address VARCHAR(300),
	CONSTRAINT cus_det_fk FOREIGN KEY(customer_id) REFERENCES customer_name(customer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE purchase_details(
	title VARCHAR(100),
	purchase_date DATE,
	customer_id INT,
	sales_price DOUBLE,
	PRIMARY KEY(title, purchase_date),
	CONSTRAINT purch_fk FOREIGN KEY(customer_id) REFERENCES customer_name(customer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE artist_paintings(
	artist VARCHAR(50),
	title VARCHAR(100),
	PRIMARY KEY(title),
	CONSTRAINT art_paint_fk FOREIGN KEY(title) REFERENCES purchase_details(title) ON DELETE CASCADE ON UPDATE CASCADE
);