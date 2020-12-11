source ~/Desktop/U/semester-4/database-systems-lab/scripts/employees.sql
USE employees;

INSERT INTO employees VALUES 
	(1, '1990-1-1', 'Clark', 'Kent', 'M', '2010-3-5'),
	(2, '1991-10-10', 'John', 'Khan', 'M', '2011-7-1'),
	(3, '1980-8-8', 'Bruce', 'Wayne', 'M', '2000-8-5'),
	(4, '1995-9-15', 'Maria', 'Strange', 'F', '2010-10-28'),
	(5, '1992-7-25', 'Peter', 'Afridi', 'M', '2012-12-30'),
	(6, '1997-5-9', 'Candice', 'Franklin', 'F', '2015-6-9');

INSERT INTO departments VALUES 
	('0001', 'Humanities'),
	('0002', 'Workers'),
	('0003', 'Quality Control'),
	('0004', 'Data Scientists');

INSERT INTO dept_emp VALUES 
	(1, '0001', '2010-3-5', '2010-4-5'),
	(2, '0002', '2011-7-1', '2011-8-1'),
	(3, '0003', '2000-8-5', '2000-9-5'),
	(4, '0004', '2010-10-28', '2010-11-28'),
	(5, '0002', '2012-12-30', '2013-1-30'),
	(6, '0004', '2015-6-9', '2015-7-9');

INSERT INTO salaries VALUES 
	(1, 40500, '2010-3-5', '2010-4-5'),
	(2, 20500, '2011-7-1', '2011-8-1'),
	(3, 20500, '2000-8-5', '2000-9-5'),
	(4, 670500, '2010-10-28', '2010-11-28'),
	(5, 40500, '2012-12-30', '2013-1-30'),
	(6, 670500, '2015-6-9', '2015-7-9');

INSERT INTO dept_manager VALUES 
	('0001', 1, '2010-3-5', '2019-4-5'),
	('0002', 5, '2012-12-30', '2019-1-30'),
	('0004', 6, '2015-6-9', '2019-7-9'),
	('0003', 3, '2000-8-5', '2019-9-5');

INSERT INTO titles VALUES 
	(1, 'Assistant Director', '2010-3-5', '2019-4-5'),
	(2, 'Cleaner', '2011-7-1', '2019-8-1'),
	(3, 'Quality Control Manager', '2000-8-5', '2019-9-5'),
	(4, 'Machine Learning Scientist', '2010-10-28', '2019-11-28'),
	(5, 'Zahoor Baba', '2012-12-30', '2019-1-30'),
	(6, 'Senior Data Scientist', '2015-6-9', '2019-7-9');


UPDATE dept_emp SET dept_no='0003' WHERE emp_no=2;

UPDATE salaries SET salary=30500 WHERE emp_no=2;

UPDATE titles SET title='Quality Control Sweeper' WHERE emp_no=2;

UPDATE employees SET hire_date='2015-1-3' WHERE emp_no=2;


DELETE FROM employees WHERE MONTH(hire_date)=2 AND YEAR(hire_date)=2016;

DELETE FROM departments;



CREATE DATABASE pharma;
USE pharma;

CREATE TABLE suppliers(
	s_id INT(3) NOT NULL PRIMARY KEY,
	s_name CHAR(30) NOT NULL,
	contact CHAR(12),
	city CHAR(20),
	CHECK (contact LIKE '____-_______')
);

CREATE TABLE products(
	p_id INT(4) NOT NULL PRIMARY KEY,
	p_name CHAR(20) NOT NULL,
	units INT(4),
	unit_price INT(2),
	type CHAR(15),
	s_id INT(3),
	CONSTRAINT FOREIGN KEY(s_id) REFERENCES suppliers(s_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE orders(
	order_id INT(2) NOT NULL PRIMARY KEY,
	customer_name CHAR(20) NOT NULL,
	order_date DATE
);

CREATE TABLE order_detail(
	p_id INT(4) NOT NULL,
	order_id INT(2) NOT NULL,
	units_purchased INT(1), 
	PRIMARY KEY(p_id, order_id)
);


INSERT INTO suppliers VALUES 
	(320,'Munir Brothers',0321-1234567,'Karachi'),
	(312,'Alliance Pharmaceuticals',0313-7654321,'Peshawar'),
	(478,'Abbot Pharmaceuticals',0300-9876543,'Lahore'),
	(657,'Sanofi Aventis',0333-5632476,'Islamabad'),
	(987,'Ferozsons laboratories',0301-1934257,'Peshawar');

INSERT INTO products VALUES 
	(1005,'Ponstan',100,15,'Tablets',312),
	(1421,'Brufen',25,35,'Syrup',657),
	(3215,'Avil',122,26,'Syrup',478),
	(1215,'Flagyl',42,30,'Tablets',987),
	(7513,'Avil',140,20,'Injection',478),
	(1216,'Flagyl',10,35,'Syrup',987),
	(1007,'Disprin',98,15,'Tablets',320);

INSERT INTO orders VALUES
	(22,'Waleed Ali','2014-11-25'),
	(23,'Azhar Akbar','2014-12-02'),
	(24,'Shahzeb Khan','2014-12-05'),
	(25,'Javed Iqbal','2015-01-15'),
	(26,'Tariq Khan','2015-06-23');

INSERT INTO order_detail VALUES
	(1007,22,5),
	(1216,22,1),
	(1005,22,4),
	(1421,23,1),
	(1005,23,1),
	(3215,23,2),
	(7513,23,3),
	(1421,24,2),
	(1215,24,1),
	(1005,25,5),
	(1215,26,1),
	(1421,26,3);


UPDATE suppliers SET s_name='Muneer Brothers' WHERE s_name='Munir Brothers';


DELETE FROM products WHERE p_name='Avil' AND type='Syrup'; #It doesn't affect order_detail because order_detail is not a child i.e order_detail doesn't have a foreign key referencing to products


UPDATE products SET unit_price=40 WHERE type="Tablets";


DELETE FROM orders WHERE order_id=22; #It doesn't affect order_detail because because order_detail is not a child i.e order_detail doesn't have a foreign key referencing to orders


DELETE FROM products;
DELETE FROM suppliers;
DELETE FROM orders;
DELETE FROM order_detail;

DROP TABLE products;
DROP TABLE suppliers;
DROP TABLE orders;
DROP TABLE order_detail;